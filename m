From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Sat, 12 Jul 2008 11:09:18 +0100
Message-ID: <b0943d9e0807120309jb01aa09se5749a19bc526240@mail.gmail.com>
References: <20080617123138.GA6932@diana.vm.bytemark.co.uk>
	 <20080617153247.GA12520@diana.vm.bytemark.co.uk>
	 <b0943d9e0806180603h59187f7epc5014f36d070cec7@mail.gmail.com>
	 <20080618143633.GB30540@diana.vm.bytemark.co.uk>
	 <b0943d9e0806180916m4af3970ck347408661e95663@mail.gmail.com>
	 <20080618173246.GA1155@diana.vm.bytemark.co.uk>
	 <b0943d9e0806190224v1b6434fesd3a54443422edaeb@mail.gmail.com>
	 <20080619100722.GB14415@diana.vm.bytemark.co.uk>
	 <b0943d9e0806200214j77aef272sc5cfb98b002cae22@mail.gmail.com>
	 <20080623123631.GA18347@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 12:10:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHc3W-00017J-TY
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 12:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbYGLKJU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jul 2008 06:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbYGLKJU
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 06:09:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:34835 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbYGLKJT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jul 2008 06:09:19 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2492170waf.23
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 03:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2MFKR3WbuLs0Fcxv5kMC3JXF5v4eKu/C4gQr0dci/aI=;
        b=qhd58bW9avhB9G15xD7ZvkUxKhNTY4ZjJc5U8gUSFsk1xrvNaWkBN1yE7toq15JJ/S
         qynA0bZHB5mrD02BnjMceZvDfrdyXUyem6hSXzbxvqtIunLuMsL+1aaJiuHfBBE+8KJm
         VrSrCOQKp7iv+ctHAah8sir+TcqjbOJJYiyK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=N7HLMtKTHfPSX0ru6cwZ3/RCf1vW69I29ChYcT21kS0Jo6Dbyb1lDnIGU/W9N+Zs8b
         Qc9F1iJ6pjBvFcV2YNXYEuXiAsUqaGCcktXz5K9YEQtt3xQriJIuKgB+qSdE+ehGrz4R
         nalhMfy/ud2xlTAZG3eYizqneXfDfa3o84TQo=
Received: by 10.115.75.14 with SMTP id c14mr15451373wal.45.1215857358731;
        Sat, 12 Jul 2008 03:09:18 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Sat, 12 Jul 2008 03:09:18 -0700 (PDT)
In-Reply-To: <20080623123631.GA18347@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88230>

2008/6/23 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-20 10:14:29 +0100, Catalin Marinas wrote:
>
>> 2008/6/19 Karl Hasselstr=F6m <kha@treskal.com>:
>> > I'd actually say the opposite: until we have a good visualizer
>> > that doesn't need the simplified log, we need to have the
>> > simplified log. If I actually have to look at the diffs in the
>> > log, I find gitk indispensible.
>>
>> And what would the simplified log contain if we decide to go with a
>> new scheme? In your proposal, it points to the tree of main log and
>> you get the diff of diffs (which also means that the diffs must be
>> generated for every modification of a patch). Would this be the
>> same? Again, I worry a bit about the overhead to generate the patch
>> diff for every push (with refresh I'm OK). It can be optimised as in
>> the stable branch where we try git-apply followed by a three-way
>> merge (which, BTW, I'd like added before 0.15). If git-apply
>> succeeds, there is no need to re-generate the diff.
>
> Yes, I was imagining a simplified log precisely like the one I've
> currently implemented (a tree with one blob per patch, which contains
> the message, the diff, and some other odds and ends such as the
> author).

At a first look, I'm OK with a simplified log.

> Two optimizations would hopefully make it fast:
>
>  1. If the patch's sha1 hasn't changed, we don't have to regenerate
>     the diff.
>
>  2. If the patch's sha1 has changed, but git apply was sufficient
>     during the merge stage, we can just reuse that patch. We do have
>     to write it to a blob, but we have already generated the diff and
>     don't need to do so again. (I've shamelessly stolen your idea
>     here.)

It can be optimised a bit more to actually apply the diff in the blob
directly rather than the current way of generating the diff (since we
don't store the diff).

> In most cases, (1) would make sure that only a small handful of
> patches would need to be considered. In the cases where a lot of
> patches are touched, such as rebase, (2) would provide a good speedup
> (except for the cases where we had to call merge-recursive, and those
> are slow anyway).

I think it should work. Rebase is indeed my worry but it might be even
faster for most of the patches to apply the blob than computing the
diff. In my experience with the Linux kernel, full merge is rarely
needed.

--=20
Catalin
