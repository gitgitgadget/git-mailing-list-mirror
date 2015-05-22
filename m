From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 14/14] pull --rebase: error on no merge candidate cases
Date: Fri, 22 May 2015 10:12:57 -0700
Message-ID: <CAGZ79kad1aunDXkg8K3HQrOkG31-FJ51k04O=S1mk_JLbpsjKw@mail.gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
	<1431961571-20370-15-git-send-email-pyokagan@gmail.com>
	<CAGZ79kbhA2+AJ1Vtz6khX5uEBCCUBUuXhpBezZApZsC_txhewA@mail.gmail.com>
	<5fcd2fa185fab4c64939ad09eb10e6d5@www.dscho.org>
	<xmqqoalg8re2.fsf@gitster.dls.corp.google.com>
	<CACRoPnR=ajnzvX42jwSpaYE1fgd2J-Ph7+_s=ch=OQJf5FRpQQ@mail.gmail.com>
	<632335d05ab160ea935c920249f62970@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Stephen Robin <stephen.robin@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 22 19:13:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvqVL-0005ux-GZ
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 19:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbbEVRM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 13:12:59 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34743 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964802AbbEVRM6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 13:12:58 -0400
Received: by qkgx75 with SMTP id x75so16634599qkg.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 10:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=uX5y8F5h+nHXEGGAVk31zIvVYjpHmEXoAzpHSqBMpFs=;
        b=eumPf6eTWi+gROohgqTZHer/rMPMMuBoks6st9LfJ63C8uIJi+yuChr3VM5WHF0SLC
         /GW7EajjIJDUhOBqaujLIisF3eji0bMciPE2yyz4Rf8deQ8Os250U3QFwwN+9S526t+h
         tNjzrQcJM/D/rf0R9ej//ETYjvOOLhsVoDFpvmBTXv36ONRgfLN1S5TjuDP/yHASRtHC
         ca7lzML+PZTlCFom7HwcFY1UX44KwnoBpDMMBbeDZAV4i9gJbVDrfkQleq1YoMRBLKuN
         F0jHM9428sIYLRNWiXw1/0T9aZbN5S8sW9YjjjTYgYeMHzdRga2/zEKxykLua5BS+Kam
         ZN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uX5y8F5h+nHXEGGAVk31zIvVYjpHmEXoAzpHSqBMpFs=;
        b=hrwX7hUKC46WxggoIaG+i81qYkQV90gOOFlT3hGSH4+siZxHnUlTaXUpn3pXR2nlAv
         D90Q6mZOKbiKKOewHVUFbjv5Vht899wAO9ihYkaWMVmiIo4u/qzqLl1bdbdG/eKhwyHD
         CdmkRBsrMlt7Q3W3J5HfiyyRVvcBhWANyWy6dL4mo+671L6SjM9z/i5mjWUJq99TK0aG
         z3lKF9pC/DELh0+TGwGf762u8I0QEZ5U9HNdFN4I2lhVNKrJs46TwwPYhlXzLQIH9BbR
         Sgzq19X0wTLseGiLuxqIsBKPRWDiGFdbb96c24/RdvzKjM27fbc0uvc6WunPGTZeRBcV
         +lEg==
X-Gm-Message-State: ALoCoQkc4J6NPoAtGygYjZkykguttl0Ik8YuF89SBhjTZVXJ3vGewI5pPkEVM28v2f8cxZi0V963
X-Received: by 10.55.19.197 with SMTP id 66mr20388266qkt.24.1432314777258;
 Fri, 22 May 2015 10:12:57 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Fri, 22 May 2015 10:12:57 -0700 (PDT)
In-Reply-To: <632335d05ab160ea935c920249f62970@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269738>

On Fri, May 22, 2015 at 7:14 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Paul,
>
> On 2015-05-22 15:48, Paul Tan wrote:
>> On Wed, May 20, 2015 at 12:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>>
>>>>>> -               fprintf(stderr,
>>>>>> -                       _("There are no candidates for merging among the refs that you just fetched.\n"
>>>>>> -                       "Generally this means that you provided a wildcard refspec which had no\n"
>>>>>> -                       "matches on the remote end.\n"));
>>>>>> +               if (opt_rebase)
>>>>>> +                       fputs(_("There is no candidate for rebasing against among the refs that you just fetched."), stderr);
>>>>>
>>>>     The puts() function appends a <newline> while fputs() does not.
>>>
>>> Yup, so this update makes the command spew unterminated lines, which
>>> not something intended...
>>
>> Ugh >< Will put the "\n" back.
>>
>> And yes, I used fputs() because it seems wasteful to use fprintf()
>> which will scan the string looking for any '%' formatting units, when
>> we know there aren't.
>>
>> I will also update 05/14 to use fputs() as well where appropriate.
>
> I believe the common thinking is that consistency beats speed in error messages, so it would be easier to read and maintain the code if all of those error messages were just using `fprintf(stderr, ...);`. It's not as if we spit out hundreds of thousands of error messages per second where that `%s` parsing would hurt ;-)
>
> Ciao,
> Dscho

As soon as we spit out one error message,
the speed game is over anyway. (IO is slow,
and I believe in the error case correctness
is the most critical thing to get right, so no
need to pay attention to performance).
Though I don't mind having a fputs/fprintf
mixture. I just happened to work on parts
of code without any fputs before, that's why
I brought up this discussion.

Actually I think I'd prefer fputs when there is no %.
