From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] merge-file: consider core.crlf when writing merge markers
Date: Fri, 22 Jan 2016 14:52:41 -0500
Message-ID: <CAPig+cSf_Hac=4+F1bRaFeYdFrjo6SH=vApdUDkhep5BUve+Kw@mail.gmail.com>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
	<c0c775ea7a9ba3244748b784241de685cefc73b1.1453482052.git.johannes.schindelin@gmx.de>
	<20160122195015.GA5897@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 22 20:52:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMhlH-0003TT-T2
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 20:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbcAVTwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 14:52:44 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34083 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbcAVTwm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 14:52:42 -0500
Received: by mail-vk0-f67.google.com with SMTP id e6so3396233vkh.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 11:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=eODhtJUTnU190IDX0SYb5qDQPkK4CobrXCP7d7CZdhk=;
        b=EQeJYU2IMVKys7grD6QZQYIJPl+F2Ll2D9bysuDWBMn8qHu6WJQpuw6VLlCXDtoeyY
         9URYFPf57wt3XBGRjw291ncoN7ffo+YMq/L5drqIJpGQgytPojK0jLcVPNsFG3OXvdIU
         3fSuz3UhNpwFVQrpFN4TFjXSAQz+EP1RU18mz9bCRvsoCvuxoywmj8ltIYL/xgAW56nO
         qKOxAbP4tB4bgkDJt8TgWhP0saUBcyiyUB8/lJxFrddUJ9AMCBl9Af1HtV2u6V6xfEDW
         JlRRW5XhLhn/V2+UMmVYPFQnE3cK9NLoG5sVBKCJg923kZjctZnHYOkM/QI57MKmKVai
         Ab8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=eODhtJUTnU190IDX0SYb5qDQPkK4CobrXCP7d7CZdhk=;
        b=GOyHTDY0P3uf+GHpLEPw5qF16C6ZPCHgMlm4eKImEgdSyhKr5J4g2HPl1kzCvDFMra
         NZVCsjFjb1fLzmHACsCsLnwVZIV6YvOkyPjWXhR/HwLlF+451oWkINZgr/8KDHAYlWJM
         rEBgmLrl6hYb+kIk1B6UFimpEtO+pTkm2+kJhvTIHxq0tdCuCOrUoMyhzQykspgfUV9e
         w0gu4S+X8UEC0gYSWrYCH82yl0kM6cskVbd1Lpi5YvhCxmDmW5VAD+cUrkOuVPB8wKnj
         +mKSkoEa2QOKyyqshXPcwqI/pTIkTKWWuivZ5COVguyCmrvgevNOoopwutxTQHXTyKmw
         NngQ==
X-Gm-Message-State: AG10YOSYpqmjBDNyTfzVmZFzEllWc0a2xHb2XKd6gkqzCBhQatwVP/kR8nBxqzSe7Uut8hSKAuZeHlKv5HVfcw==
X-Received: by 10.31.141.2 with SMTP id p2mr3189418vkd.37.1453492361982; Fri,
 22 Jan 2016 11:52:41 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Fri, 22 Jan 2016 11:52:41 -0800 (PST)
In-Reply-To: <20160122195015.GA5897@flurp.local>
X-Google-Sender-Auth: OcIGLxRyKATcOigqfmlCBiij3Z8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284588>

On Fri, Jan 22, 2016 at 2:50 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Jan 22, 2016 at 06:01:25PM +0100, Johannes Schindelin wrote:
>> +test_expect_success 'conflict markers contain CRLF when core.eol=crlf' '
>> +     test_must_fail git -c core.eol=crlf merge-file -p \
>> +             nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
>> +     test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 3
>
> The "\r" isn't recognized by 'sed' on Mac OS X or BSD. Perhaps use
> instead:
>
>     test $(cat output.txt | tr "\015" Q | sed -n "/\.txtQ$/p" | wc -l) = 3

Or the 'sed' could even become at 'grep' at this point.
