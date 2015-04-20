From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/3] Another approach to large transactions
Date: Mon, 20 Apr 2015 15:26:56 -0700
Message-ID: <CAGZ79kZWm=Mi6o4jMNthiDRcR9irs_5MyRuEmHdDSrn-JFpQ=g@mail.gmail.com>
References: <1429226259-21622-1-git-send-email-sbeller@google.com>
	<xmqq8udqheb5.fsf@gitster.dls.corp.google.com>
	<xmqqsibyo141.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZvE+YJeKCYXN-RD3MFmP17VkqW8WUUssk6UgK_38iWrg@mail.gmail.com>
	<CAGZ79kYEbnZvgdhjPvc2rR7QKp-CjUB3Ytqsp8JK2QBqzuUowA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 00:27:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkK9e-0007iu-GV
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 00:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbbDTW06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 18:26:58 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37535 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbbDTW05 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 18:26:57 -0400
Received: by igblo3 with SMTP id lo3so968268igb.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 15:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WLlz0Yrc9wuvgGhPXa7SthCB/W0+5X42oVwBXwmtwGk=;
        b=PrESlGYk4hIHhqz/dzjXhXmftfCpDSBIVz6Ra9a0q0rqI5X//w6Eolnmq6JCRxO5Pw
         JO7dPSYLzyBFt/dm/mOwyXXQKMsdDJ3gqb7RF6Mf5jvP4K50Z1BxyQx1aQLd9lr6Cdpq
         WMhvWSNmMLUSf0UdrhUWkBXe12TdijofS7dnwUqz54G3zg7Ai0rGgKjegaLIMclox3ol
         HL5lJ67uI5EOhFz3tVjAWLTwIN1OENqSoykNMCo3qjfTEJ7NtzQ5kODIRfTIWHQXXh/H
         DbrNjpg/u+xCkTL2BZUjcFIuZI2B5VQC3C8K4zB2UE/iQdh/sIQtQ2oQZEOQyZw/zl6w
         0c1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WLlz0Yrc9wuvgGhPXa7SthCB/W0+5X42oVwBXwmtwGk=;
        b=EOo/mWgoW+rIVCYXF2EZB2aavyLiMGXTcU/gyT0uRDM/yjvbS7z92xkSlN0H4r+wJA
         Nhos/OB+IxIZlz9GKAhyLdMorfpo++Hb2hayIQnEADW0kRRAJ2QAor3sLN7omPUI8Wzp
         +OfjcY41jx+bMKisThpMq4a7rTiwXnIatt5W4dH5L8iqLCBbsMQ0KRUPSuoE6MG0QV9h
         LoBZDwSl4XkbrSn6BJ2lYCASRUnK3iOa3H4czdHYvOJeLA3vuCpDwPWLnlyRV0pXy2Tc
         4FtFHoM9BDcaUi39oIxqQ7+O3IiXAWmzkQ6G0t+nkblo8U6Iqu285eEUTGQ1UG/8ucqQ
         nRDg==
X-Gm-Message-State: ALoCoQk5bbcQXZonvSpsbJcuLSLWCG1eCjw7bmHIhNXCwJEkfx0+C4bgplouVBR3InFoCT0oWVT8
X-Received: by 10.50.221.98 with SMTP id qd2mr56815igc.37.1429568816699; Mon,
 20 Apr 2015 15:26:56 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 20 Apr 2015 15:26:56 -0700 (PDT)
In-Reply-To: <CAGZ79kYEbnZvgdhjPvc2rR7QKp-CjUB3Ytqsp8JK2QBqzuUowA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267507>

On Fri, Apr 17, 2015 at 4:31 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Apr 17, 2015 at 3:17 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Fri, Apr 17, 2015 at 3:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> This is now pushed out and sitting at the tip of 'pu'.  It seems to
>>> break one of the tests in 1400 when merged to 'next', but I didn't
>>> look it closely.
>>>
>>> Thanks.
>>
>> ok, I'll look more closely.
>
> Apparently I screwed up even before sending the patches over the wire.

For the deleting refs test failing:
The problem comes from guessing the number of fds we're allowed to use.
At first I thought it was a fundamental issue with the code being broken, but
it turns out we just need a larger offset as we apparently have 9 files open
already, before the transaction even starts.
I did not expect the number to be that high, which is why I came up with the
arbitrary number of 8 (3 for stdin/out/err, maybe packed refs and reflog so I
guessed, 8 would do fine).

I am not sure if the 9 is a constant or if it scales to some unknown
property yet.
So to make the series work, all we need is:

- int remaining_fds = get_max_fd_limit() - 8;
+ int remaining_fds = get_max_fd_limit() - 9;

I am going to try to understand where the 9 comes from and resend the patches.

Thanks,
Stefan
