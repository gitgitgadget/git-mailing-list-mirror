From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Can I remove stg sync --undo ?
Date: Fri, 4 Jul 2008 23:05:11 +0100
Message-ID: <b0943d9e0807041505oc15660bpcd62a62100e517b9@mail.gmail.com>
References: <20080702072524.GA26805@diana.vm.bytemark.co.uk>
	 <b0943d9e0807031502x5f7c4babtd65511d7966c69f6@mail.gmail.com>
	 <20080704020918.GA30669@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 00:06:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEtPx-0005xk-0K
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 00:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbYGDWFN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jul 2008 18:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752597AbYGDWFN
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 18:05:13 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:19546 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbYGDWFL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jul 2008 18:05:11 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1731633rvb.1
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 15:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=38mojeKxVCmcQ3fO6JPdm1UobEJBRll5H+9sEzUjpDo=;
        b=NTe1DSzoPv5OcYjwCaZvCud/Zycgqgdkia0/POEtW8SgbOlHvK8We1qp3CuNnYPASr
         43/lJEvi2AKET1nec4PNUNylf4e1mPCtAPhEUuGm2Y/m6/97hb6NsQVA+DRs6Bag3OrJ
         +gnbw4oJMzvjG7td0jpaU/XOezRHLHtqeoQL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Dx7pci5hA1e3ks9UklHBVSKDT/OEKvKqlQQtPrTOoKaDcWNL5wB4lv+NRzm5QxUpdZ
         2KlFtKkORDfHkidwWlpJDN+wnvRmj2o1yeW6vSnBW9HBVYw6WC22cACorLtwIbeL177V
         wacH3MNhvVWrS/85ugxhMzvy63quQXPWHDTQk=
Received: by 10.114.73.1 with SMTP id v1mr166478waa.166.1215209111329;
        Fri, 04 Jul 2008 15:05:11 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Fri, 4 Jul 2008 15:05:11 -0700 (PDT)
In-Reply-To: <20080704020918.GA30669@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87420>

2008/7/4 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-07-03 23:02:28 +0100, Catalin Marinas wrote:
>> The sync performs three operations - push, merge and refresh (if the
>> refresh is automatic after merge, it doesn't update the backup
>> information since it was done by merge).
>>
>> If merge fails, the refresh is manual after solving the conflicts. I
>> suspect this will be recorded as a separate step for undo
>
> Yeah, the new undo stuff will currently handle sync just like e.g.
> push and pop: write one log entry when the command's all done, plus
> one extra just before the conflicting push if there is one. So you ca=
n
> always undo the entire command; and in case of conflicts, you also
> have the option of undoing just the conflicting push. Is this enough
> for sync?

There are two operations that can conflict for sync - pushing a patch
and the actual sync'ing, i.e. a three-way merge with the patch to be
synchronised with (kind of fold).

>> (BTW, is resolved take into account for undo?).
>
> Hmmm, what do you mean by "resolved"?

The current resolved command - the clearing of the conflicting entries
in the index.

--=20
Catalin
