From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] mingw: make mingw_signal return the correct handler
Date: Mon, 10 Jun 2013 13:37:21 +0200
Message-ID: <CABPQNSZYuXWCOXYD=v_0axsj95bPQdVznUcC9usnT=FU2-j6tQ@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <51AEE1C3.9020507@viscovery.net>
 <20130605071206.GC14427@sigill.intra.peff.net> <51B02D81.3000700@viscovery.net>
 <20130606063754.GA20050@sigill.intra.peff.net> <CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com>
 <20130606064409.GA20334@sigill.intra.peff.net> <7vy5anyx1w.fsf@alter.siamese.dyndns.org>
 <20130606174032.GB32174@sigill.intra.peff.net> <CABPQNSYLmFWkdgph6W7MwaSTe+zrU0AaJpj_v9z=cmvWu64HNA@mail.gmail.com>
 <51B1B4DF.90705@viscovery.net> <CABPQNSYE=Mvrmc44dZmKnB14KLh4A=HxWo2-xgnJRyj1Q+BJLg@mail.gmail.com>
 <51B1CFD4.3030908@viscovery.net> <CABPQNSasTdkmpeGWb7_wZK2cQhiOyF7bX5ObcBg5kHm0KBGS5w@mail.gmail.com>
 <51B1DB2A.2060306@viscovery.net> <CABPQNSa1-dna_b+q-U6jgYy7p6zeiT7dAwu1Mw47QAezSNYKqA@mail.gmail.com>
 <51B568A1.9090409@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 10 13:38:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um0QK-0001ri-1v
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 13:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab3FJLiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 07:38:04 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36431 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab3FJLiC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 07:38:02 -0400
Received: by mail-ie0-f181.google.com with SMTP id x14so15497534ief.26
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 04:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=SMSXN50l9dP6up8KYAkFQFCdZiI1Do3bPAICs6Uqm1Q=;
        b=LysEu5J/qb/ygdyyOmDvcNOkrCotUrVTzBOuqNXMnDtAz1VSpJr5vEE2LIVAouvKcp
         DUGqkkaxU/CxlZEs5WdM5VO567O8EwThc+nhZDn76tlnCcuH3Bbyei7Gu/b/XWn9H0lk
         rH5P/6+LipjInpCazL3EZr5ObXrQLy2lA+j4v6qnfFBMA+yQolaZIthqRJpMRmxqIp+A
         E2tIahZ/43w5PraNKCdXxdUZaw1nIbheLDEOURbt3B8pzZEpZwvvGL8k+RBASLeju1Bg
         WdYwkP6TbFm/KJwYYRTi5DqgqHt59MEMhtCy00/8bB9MGpSvcxpfQUkKX5xXn4vmReBL
         aAQA==
X-Received: by 10.42.148.5 with SMTP id p5mr460130icv.19.1370864281784; Mon,
 10 Jun 2013 04:38:01 -0700 (PDT)
Received: by 10.64.23.199 with HTTP; Mon, 10 Jun 2013 04:37:21 -0700 (PDT)
In-Reply-To: <51B568A1.9090409@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227273>

On Mon, Jun 10, 2013 at 7:48 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> From: Erik Faye-Lund <kusmabite@gmail.com>
>
> Returning the SIGALRM handler for SIGINT is not very useful.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> Am 6/7/2013 16:20, schrieb Erik Faye-Lund:
>> On Fri, Jun 7, 2013 at 3:07 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> BTW, isn't mingw_signal() bogus in that it returns the SIGALRM handler
>>> even if a SIGINT handler is installed?
>>
>> Yep, that's a bug. Thanks for noticing.
>
> This is your patch to address it.
>
>> I've pushed out a branch here that tries to address these issues, but
>> I haven't had time to test them. I'll post the series when I have. In
>> the mean time:
>>
>> https://github.com/kusma/git/tree/win32-signal-raise
>
> Concerning the other two patches:
>
> * SIGINT: perhaps handle only the SIG_DFL case (for the exit code) and
> forward all other cases to MSVCRT?

Perhaps. I'll have to think a bit about it, but it might very well be
the sanest approach, as long as it doesn't break git_terminal_prompt
(which was the reason for the change in the first place). I can't of
the top of my head understand why it should, though.

> * SIGTERM: it papers only over a general issue and should be dropped.

Fair enough.
