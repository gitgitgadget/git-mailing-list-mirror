From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v8 1/2] parse-options.c: make OPTION__COUNTUP consider
 negative values
Date: Sat, 19 Mar 2016 10:25:09 +0530
Message-ID: <CAFZEwPNkWYC4nj6bjQd+HYxSVjm_UQwGF5UQwOxziA8K6iuszg@mail.gmail.com>
References: <010201537710be08-f31428b3-5df3-4694-8c4a-0e8f058131b3-000000@eu-west-1.amazonses.com>
	<010201538b98a7e5-ee604368-5a27-4884-b01e-027fa02bf1c6-000000@eu-west-1.amazonses.com>
	<xmqq4mc3pf3y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 05:55:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah8vR-0002Ov-JH
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 05:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbcCSEzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 00:55:21 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35440 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbcCSEzK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 00:55:10 -0400
Received: by mail-yw0-f195.google.com with SMTP id d21so1572193ywe.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 21:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=xjpdHf9nA96VrOQ7naK26b9fucDbwCFzRCeVkVPV4bE=;
        b=QcV95eWibq/fEwlsIiQvaIyp807KlV6p8Rzj3m0dE/ATzmzNi74uYe2tfdCLuCtfOJ
         HkpRy0YoIWiIH4VlMm/2S7WoAWJ/5xpUaeMn9TNftXZ8Gto6qIj3oGZQgaIEn27Xrakp
         XmW0ZgHLIWXKDXPvm83+NupjpOFak141Ev/i75fsCeU8S3tiBzUgANM0bLtO2mU91qaT
         itmBHTVgHCC8NeBTxHv4Q76PWLEqI234eTwil0ESQ3E5F/b67GDo7rECtV4U/bvB5ePr
         dpPZNnOuvGFUcpHRcOvFCIVo9ChDvvlRnbPhUsNbseT1qECb37tehzlNCZod8GgJrtRn
         ejFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xjpdHf9nA96VrOQ7naK26b9fucDbwCFzRCeVkVPV4bE=;
        b=dIR78fvZzrSgD8rtlSxKLb2vFqGBqFtlk2Smzuld6kl2Y1Uvw6GRaf76xyUh+99pXN
         9nehfMiM3BKDo37ZAmJ5p0RZq4+1WkreCelxmALQ9Cy7NSLOOJKxVj86H2RXHW3q4c5O
         0x2wDAI9Abzsb/tbWsxhke/zvR273HkqAA+acbOIjeO1pryrYgOlJM5/4ajHvc7wytiT
         AKBSMWIccYNfPhyC1vCgxbUaOpZOs/InMLTZbUjlo4/dklrMbnFU65NvFYW5Kh/06tbE
         b91nHHXz4MHWCFWGzrlfQ85A+A0JSGc1k80k5qfwmtbiMXTcIbb1FE6Y0b+eHXrnSFOD
         Oqqg==
X-Gm-Message-State: AD7BkJInf+DWGLtKYHzPc08qJDufhlhUDwgqbBuVh76sS7JgIy3YrU4QKwCnDSuLfyAKL7GRbw0nl7Xou3UXAQ==
X-Received: by 10.129.94.7 with SMTP id s7mr9360335ywb.93.1458363309388; Fri,
 18 Mar 2016 21:55:09 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Fri, 18 Mar 2016 21:55:09 -0700 (PDT)
In-Reply-To: <xmqq4mc3pf3y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289286>

On Sat, Mar 19, 2016 at 4:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> The reason to make it consider negative values or more specifically
>> "unspecified" values is to give the ability to differentiate between
>> once, multiple time or with --no-option.
>>
>> Eg. :
>> initialize verbose = -1
>> `git commit` => verbose = -1
>> `git commit -v` => verbose = 1
>> `git commit -v -v` => verbose = 2
>> `git commit --no-verbose` => verbose = 0
>
> A few more things I noticed about this are:
>
>  - Many uses of COUNTUP has now been replaced with BOOL and what
>    remains are verbose/quiet/force.
>
>  - This change will not affect existing users of COUNTUP at all, as
>    long as they use the initial value of 0 (or more), as there is no
>    mechanism to decrement.  The only thing the command line can do
>    is to reset it to zero with "--no-foo".
>
> So it seems a safe and sensible change.  Even though I suspect that
> the justification can be written more clearly, I am not sure if it
> worth the extra effort.

I can include this paragraph. Some people might have a bit difficulty
in knowing the importance as they might not have followed my earlier
patches. To bridge this gap, I can include your paragraph in the
commit message. Any other particular things you want me to justify? I
will be glad to send another re-roll of this.

Regards,
Pranit Bauva
