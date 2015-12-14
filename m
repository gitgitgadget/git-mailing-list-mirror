From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 0/2] git-p4: fix for handling of multiple depot paths
Date: Mon, 14 Dec 2015 23:09:21 +0000
Message-ID: <CAE5ih7_qY5oF+UWs4gE2eHUu17pBg6TVGTUyRRRcBe12ybkw+Q@mail.gmail.com>
References: <1450037234-15344-1-git-send-email-luke@diamand.org>
	<CAE5ih7_T1xC9AyO41T4ktJmj6tENaEGbAG556WLyfsYz-jawsw@mail.gmail.com>
	<xmqqio40kfhl.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7_9m8kw=sVj8Sv5mAfT_22-g0vdTb78FvLTrNUkJO0M0g@mail.gmail.com>
	<xmqqtwnkhegw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>,
	James Farwell <jfarwell@vmware.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Sam Hocevar <sam@hocevar.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 00:09:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8cFD-0004Ln-Lc
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 00:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbbLNXJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 18:09:23 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:35351 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbbLNXJW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 18:09:22 -0500
Received: by mail-io0-f178.google.com with SMTP id q126so620743iof.2
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 15:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=duOKYT9Hnb6n3kOtX/K1odqo/HCdj2r6dy/u3OidI4U=;
        b=cmOtxX2jfC10sRKMQs9cZ700GQPAQJiU04DHaSDjC2I5LSUw/0kH2UVy7fbT/WsNl4
         TcgfSpjfo022FIIqyay1+hdX3uUzlSmkgd2XK7cy/BSZRBLoLoXV/nTs1Xu6M0m++yrO
         jsKZJXVWFEBfkdYUuavuBhy6Bkg0tpolvS2Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=duOKYT9Hnb6n3kOtX/K1odqo/HCdj2r6dy/u3OidI4U=;
        b=cCjiCYe3fMZZbIx9gt3AzCCctyWA8S7I+Xr5yOETYMZtu+690vZXtoL3m/bc41l/Tv
         sFy/EEVqD78WnFKHOM+wQViUbqkmPsfy04V2M8ggjksF0/pzcWttOVOJagQRRrtXqI0d
         jlHvo0VJiWjmIbSytkyNtrHjCk+RyB5IWIREkI8i3LZ1ziWzX/UCJXumTrrWB9qvKyYJ
         cIGHwGZJQljeUEQ8KnSTRr6Rl4dnSnQSqRgWzeUcUhiC1REGiHRqZ07MNb8j1QpKQ9WN
         KdMCXo9Rotpo2pL3nyueL3B+t7E8dAPmbuhr5wfa14qwhf0xjrmjRXmdvoDmsshkqXl4
         nMfw==
X-Gm-Message-State: ALoCoQljBMbOgo9m+hqHVGanTj34vkP8MWoLKCjfAIwmJYhKfWT1rROZAJJw9wFUxok3d7ZaQCE2EG/vPYQf81Rqa1VjflOG2A==
X-Received: by 10.107.170.194 with SMTP id g63mr15701593ioj.178.1450134561902;
 Mon, 14 Dec 2015 15:09:21 -0800 (PST)
Received: by 10.79.94.194 with HTTP; Mon, 14 Dec 2015 15:09:21 -0800 (PST)
In-Reply-To: <xmqqtwnkhegw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282447>

Sorry - I've just run the tests, and this change causes one of the
test cases in t9800-git-p4-basic.sh to fail.

It looks like the test case makes an assumption about who wins if two
P4 depots have changes to files that end up in the same place, and
this change reverses the order. It may actually be fine, but it needs
to be thought about a bit.

Sam - do you have any thoughts on this?

Thanks
Luke






On 14 December 2015 at 22:06, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>> On 14 December 2015 at 19:16, Junio C Hamano <gitster@pobox.com> wrote:
>>> Luke Diamand <luke@diamand.org> writes:
>>>
>>>> Having just fixed this, I've now just spotted that Sam Hocevar's fix
>>>> to reduce the number of P4 transactions also fixes it:
>>>>
>>>> https://www.mail-archive.com/git%40vger.kernel.org/msg81880.html
>>>>
>>>> That seems like a cleaner fix.
>>>
>>> Hmm, do you mean I should ignore this series and take the other one,
>>> take only 1/2 from this for tests and then both patches in the other
>>> one, or something else?
>>
>> The second of those (take only 1/2 from this for tests, and then both
>> from the other) seems like the way to go.
>
> OK.  Should I consider the two patches from Sam "Reviewed-by" you?
