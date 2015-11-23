From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v2] blame: add support for --[no-]progress option
Date: Sun, 22 Nov 2015 20:47:57 -0600
Message-ID: <CAOc6etY2+OkHhn1rt=y8ekjzcA8ngu0zvX_MZ5Pk6utYj09vPg@mail.gmail.com>
References: <1448208133-29430-1-git-send-email-eantoranz@gmail.com>
	<xmqq610to4bl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	"Max A.K." <max@max630.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 03:48:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0hAg-0005I5-Uh
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 03:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbbKWCr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2015 21:47:59 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33493 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbbKWCr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2015 21:47:58 -0500
Received: by pabfh17 with SMTP id fh17so181563414pab.0
        for <git@vger.kernel.org>; Sun, 22 Nov 2015 18:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CS1aNfVDT9wT3ZKUVP7RYjM3owtQRSAKzPtxPQ7bW0Q=;
        b=ryDgXuHp23ZyyaCZUS2IjXCfcWrpc3xDHzpt1ProX7HL+BQv+pyJUYUDFYOd0AXx6M
         Q5NXmKXhp6t9kSRTMhNur/+S607Hs5Hw2tRVVhhvBiKNBWT3s47VjnZ2w1xFrk+eGiUf
         Co7WLa6DgHhEnbmK/lqVjADlXrHSULdSUx9w7fH1u1Fy1vXn+ULKdA7fB+JAKrFUATM4
         JILnNH7TFaDw5HiJwtTxebsKVjqdshkfRfpHeoXPYDXdDCH1gRWQ277kMfJZ4cswRwxm
         T8IiPMosxgT65ewqy20+ZGBrbwrJAfil+VO9yd65QtJ4AcK34Oz4v6METSy+3f8yhCvD
         0Wow==
X-Received: by 10.68.69.81 with SMTP id c17mr33457383pbu.132.1448246878053;
 Sun, 22 Nov 2015 18:47:58 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Sun, 22 Nov 2015 18:47:57 -0800 (PST)
In-Reply-To: <xmqq610to4bl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281571>

Nice to see you back, Junio!


On Sun, Nov 22, 2015 at 8:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:
>
>> Will also affect annotate
>
> Is that a good thing?  In any case, make it understandable without
> the title line (i.e. make it a full sentence, ending with a full
> stop).
>

Will make the explanation a little more verbose. About being a bad
thing, I don't see how, it's just the same functionality. You think I
should turn it off if using annotate?

>> +                             if (progress) {
>> +                                     for (next = suspect->suspects; next != NULL;
>> +                                          next = next->next)
>> +                                             blamed_lines += next->num_lines;
>> +                                     display_progress(progress, blamed_lines);
>> +                             }
>
> Is this math and the placement of the code correct?  It would
> probably be more obvious if this hunk is in found_guilty_entry(),
> which is already the dedicated function in which we report about a
> group of lines whose ultimate origin has become clear.
>

I'll see what I can do about it.

>
> Two comments.
>
>  * How does this interact with incremental or porcelain blame?
>    Shouldn't progress be turned off when these modes are in use?

Given that they are supposed to be for machine consumption, I'll turn
progress off is using one of them.

>
>  * Shouldn't progress be turned off if the result comes very
>    quickly, using start_progress_delay()?
>

Ok. Default values as in checkout? 50, 1?
