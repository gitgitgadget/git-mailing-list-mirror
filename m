From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] format-patch: introduce format.outputDirectory configuration
Date: Sun, 10 Jan 2016 23:00:59 -0500
Message-ID: <CAPig+cRjBockaXKacYA-pxWQe_gzAAvjAwonQKn1kSANHORt1A@mail.gmail.com>
References: <CAPig+cQ9kObgd5-OGRZH-YuZVnBX72ukS=kKD8OfTN51dQ0SRA@mail.gmail.com>
	<1452472227-9684-1-git-send-email-ischis2@cox.net>
	<CAPig+cSoEYof0quiG=P4SRiOb7FeNDnVsGdzGoxO=oLcgfGBUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 11 05:01:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aITfG-0002Pr-3p
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 05:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758224AbcAKEBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2016 23:01:01 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34650 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758096AbcAKEBA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2016 23:01:00 -0500
Received: by mail-vk0-f67.google.com with SMTP id a123so5419154vkh.1
        for <git@vger.kernel.org>; Sun, 10 Jan 2016 20:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RfH9Tm75Hy+Aej4YDeSdN3z7Iv8JogD8jSS4kumG2TY=;
        b=yUWDgvoBOHhkcUwNqEEd7M5qJdC8H/dcBfbJ483dupuXlPUwZr62c/AJ5Cd7/VCEho
         yDY7FwCqxC6JQiy1jxrKzO3w7joJ9b+9k4fvjihVe2RmIrrqSiMdm+eHRBnhHGrOD0gl
         +fvekg017qtU+ZNutMw4lv7S2LVxpxWal8n9u2ps5rexloadQQWtnA+5okjkzi7Z3vUw
         lusykNC7BQz4uMJ6KnfBxinaui33w0MOZylEnJQoMk2FmnUHXSQPebytMjMyICD7r83b
         3LJzyq+jJJ1rfezaUoury40CbCT6UHitEvjDwAgG/SwvfEbWgnuZZoqm7aKNng74onvd
         dgpA==
X-Received: by 10.31.182.143 with SMTP id g137mr54326733vkf.45.1452484859668;
 Sun, 10 Jan 2016 20:00:59 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 10 Jan 2016 20:00:59 -0800 (PST)
In-Reply-To: <CAPig+cSoEYof0quiG=P4SRiOb7FeNDnVsGdzGoxO=oLcgfGBUA@mail.gmail.com>
X-Google-Sender-Auth: BZ2kiZ5BpTzOp929EpwRLTgeAOc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283632>

On Sun, Jan 10, 2016 at 10:55 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Jan 10, 2016 at 7:30 PM, Stephen P. Smith <ischis2@cox.net> wrote:
>> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>> @@ -1445,4 +1445,20 @@ test_expect_success 'From line has expected format' '
>> +test_expect_success 'format-patch format.outputDirectory option' '
>> +       test_config format.outputDirectory patches &&
>> +       rm -fr patches &&
>> +       git format-patch master..side &&
>> +       ls patches >actual &&
>> +       test_line_count = 3 actual
>> +'
>
> Now that you've moved the new tests to the bottom of the script, this
> test fails. This is because, at this point, there are 18 commits in
> the range 'master..side', not 3 as when the test was at the top of the
> script. You could change the 3 to an 18, however, that would be
> fragile: if someone inserts or modifies tests above this one, then a
> hard-coded 18 might become stale. One possible fix would be:
>
>     test $(git rev-list master..side | wc -l) -eq $(ls patches)

That would be $(ls patches | wc -l), of course.
