From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 4/6] transport-helper: warn when refspec is not used
Date: Thu, 18 Apr 2013 14:12:09 -0500
Message-ID: <CAMP44s3329nhkpekg4szbYZBuKUNmVScx1uFWaNm+Xg_0=s86w@mail.gmail.com>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
	<1366258473-12841-5-git-send-email-felipe.contreras@gmail.com>
	<7vvc7j6917.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 21:12:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USuFk-000781-K8
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 21:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434Ab3DRTMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 15:12:12 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:41235 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab3DRTML (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 15:12:11 -0400
Received: by mail-la0-f45.google.com with SMTP id gw10so2911110lab.32
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 12:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=o2UOoVHR/kG7Oj6YZbJf7fpq7XIFTFDwTXyYeTtyiKQ=;
        b=gKoTzMCKwcvqtK74L1WSadsL46KrUmkAWbrTfK1DbZJU/mUNcGm0OZXtwLlUL+aNfi
         kIKsMhG5MyL3t9E699v72SS7ic9ENTDbJTGLvWdHb+nsK/G0ozKSLEgMPbzbMJZE6PpG
         L7cdKFn98kg9EJ8ug/Tlhm9UvMaNhHfZ8QdWqxlrd/GE21mjk4Zl/OvXbbWEDsWGbbq5
         FTENXdxdYyKyZk4tV/eHSttyn99tlmbctVZx0A7HImEyL9mKR7lWLunY8GXumlsw+eFU
         U6MsRAnR68u+JXUp4LTupEdzgLQcAvq1bq3gXCpHaVxZvBiRgDy2hREv+1L/wtZ1VPRq
         lygA==
X-Received: by 10.152.5.134 with SMTP id s6mr6565549las.24.1366312329536; Thu,
 18 Apr 2013 12:12:09 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 12:12:09 -0700 (PDT)
In-Reply-To: <7vvc7j6917.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221684>

On Thu, Apr 18, 2013 at 12:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> For the modes that need it. In the future we should probably error out,
>> instead of providing half-assed support.
>>
>> The reason we want to do this is because if it's not present, the remote
>> helper might be updating refs/heads/*, or refs/remotes/origin/*,
>> directly, and in the process fetch will get confused trying to update
>> refs that are already updated, or older than what they should be. We
>> shouldn't be messing with the rest of git.
>
> So that answers my question in the response to an earlier one in
> this series.  We expect the ref updates to be done by the fetch or
> push that drives the helper, and do not want the helper to interfere
> with its ref updates.
>
> So it is not just 'refspec' _allows_ the refs to be constrained to a
> private namespace, like the earlier updates made the documentation
> say; it _is_ mandatory to use refspecs to constrain them to avoid
> touching refs/heads and refs/remotes namespace.

Yeah, it was not stated that it was mandatory, but I think it's in
everybody's best interest that it is.

-- 
Felipe Contreras
