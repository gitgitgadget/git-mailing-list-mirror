From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/3] string_list: Remove string_list_insert_at_index from
 its API
Date: Mon, 24 Nov 2014 17:16:16 -0800
Message-ID: <CAGZ79kb-QhbQksaOR4+fwyyzkbWege86nqH63T28RH2UKeN7Mg@mail.gmail.com>
References: <1416864124-15231-1-git-send-email-sbeller@google.com>
	<1416864124-15231-3-git-send-email-sbeller@google.com>
	<xmqq7fykunvs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 02:16:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt4ju-0005fu-PG
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 02:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbaKYBQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 20:16:18 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:32841 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbaKYBQR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 20:16:17 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so6029775igi.3
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 17:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SygSXKy8d4To59iPFZSytbOMQbv0JQAvTq8O2Wvtu20=;
        b=pWqhNKigmeZgXas00YWZHed+feq+RKXzvKRgZGkTYlg/OD9B8kgiod5MTb9U451gbg
         jdVUerKyH419K5kw24tYu0+uYL4PzsOirTHGftFeltJDK91BsyiQ1uJT9SKuqXaakI18
         hD6UaRAoTcpfSsYfIVVdowMY9YTeW0oo2Dezj82v4DQ0OrPczXD50fJn9vKnefAJEH9a
         NtkQSF+uDULvJQsNj6o6/r9xN/EUHLPSMIcTOairQ8oSQ8dAwMH8vtAvlqAwVVr1kKjI
         6YiDFQ3HS8PG0Xv15iNruaBWZNMsSqxLX7u/AHNrLGtekBmHFrZsRKmCTzfk7/yXJE86
         uVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SygSXKy8d4To59iPFZSytbOMQbv0JQAvTq8O2Wvtu20=;
        b=f8TcvFvzAhg43n6+E8u4S+wRrIYk2hMAwjYGqJw+CmcYaf41XBVvRV9RNiQoJwxQcf
         DGheItXfbkm3MORJgb9Gwe/PHzN9pwQZtpXjl33jy5k2BcRi5eEQL68fhSc44VjSmvMA
         1p74eAlAIoqdzCy2GsBs8ivC4XH+Opk1y2ScOMuBktfAb/ZQF/xJ9GHzC2OCOM+ixlA2
         cWR8q4d5uUKON4bNfszRc4jmxuKXMK1xCRbhTXkm+PSqidGy3pTojxiTDP6hOQ40IG9A
         XPkinNnVNlbE6axpHR9WIFBqVoq4WKcDMNtcd3p91s7DnHBb03ZC30TqJDrMrjMX7OQ1
         A1pQ==
X-Gm-Message-State: ALoCoQknIX4n8SfBX/D8F9OjwkVRm/etB4K/VE7/vMH2x6/tjF8uHTmk4d5qQpya8qI9Qrb1P0mI
X-Received: by 10.43.82.72 with SMTP id ab8mr6709828icc.76.1416878176807; Mon,
 24 Nov 2014 17:16:16 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Mon, 24 Nov 2014 17:16:16 -0800 (PST)
In-Reply-To: <xmqq7fykunvs.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260178>

On Mon, Nov 24, 2014 at 4:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This function behaves the same as string_list_insert, just the
>> starting indexes for searching, where to insert into the list is also
>> a parameter. So if you have knowledge on where to search for the string
>> to be inserted, you may have a speed up version of string_list_insert.
>
> The last half-sentence I am having trouble parsing.  If you have
> that knowledge where the item should go, you can insert it at the
> right location faster than calling string_list_insert()?
>
> That sounds like a useful feature to me.
>
> But if nobody uses that feature, there is no point keeping it, no
> matter how useful it may sound.  So,... I am not sure.
>
> The function would be error prone if used on a string-list that is
> accessed via string_list_insert() API, which makes it only useful if
> the user of the API is in full control of the sort order, so I do
> not mind removing it and won't be saying "that is useful, we should
> keep it and use it more."
>
> But your log message confuses me....
>

Well, I'm sorry for the confusion, here is what I was trying to say:

We do not remove functionality from the API, but rather remove a
a highly optimized version of a function, which we are not using
after patch 2 of the series anyway.

We should keep it around only iff we strongly believe there will be
a use case later again. But for now I do have the opinion, we're
better off removing the function as a smaller API / header file
serves us better. Specially new comers may appreciate a smaller
API but documented there.

Maybe we can drop the commit message altogether if my thoughts
are still confusing?
