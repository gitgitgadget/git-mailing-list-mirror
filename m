From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 53/83] builtin/apply: make find_header() return -1 instead
 of die()ing
Date: Wed, 27 Apr 2016 14:10:41 -0400
Message-ID: <CAPig+cSdRL3hc81pXXFKAZWisGYPHcd47Z4BBhkeSWZ=5_FT9A@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-54-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8B7g8WgWbr4M4LHFyBshN2gi30pL1bCcZcTPB7qtmnWdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 20:10:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avTvL-0002ez-Kl
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 20:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721AbcD0SKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 14:10:43 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35579 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641AbcD0SKm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 14:10:42 -0400
Received: by mail-io0-f194.google.com with SMTP id u185so8575767iod.2
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 11:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=kriNxyWJZMiDf0yOFi2bG3vHVTTYg9taBHX8PmxMt4I=;
        b=pnCbZjFb4BLG2ixTm3P8e31+MSoL15OMjRE4apakW4xn/kuD4EFkMW19/ltwX7nZD/
         114hGOavBFJOGemsx4aeep1XTP0ohse01ZLY9NyJ6w9yZoUrlzX6/JDQObrHrUD5OWK6
         HstHdc5nEPtRvgzILNKTwIg+0s0wTM3i+BBqHjiMM5AS6xzUfRow9Bzq1vZPbETNnJyi
         Sxca4iOnE5NyQ2c9WVNkLnpjD7SXRvYqur/BQeXCIv93q+DrtmoK6fdIdLRSLRtlbwtF
         jrjEzwXfv9xDrCA9v+9eqf1Y3rlqvXqwRjqfQTKQw0CZDRW8Nyf3+1aFL3xWpz9HxXy2
         v+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kriNxyWJZMiDf0yOFi2bG3vHVTTYg9taBHX8PmxMt4I=;
        b=OCbfqEgU9KL4FdqP2knihUT3oRHovy5yEju4D6DqWMIJEWbAwqjOjE/p8A/1DRds++
         2IA+u9GvZXQ47Lv/xSMB+NEQBHocgR9Gie5R2oU48nE5FzHxTWkVAJOsDU7pm63sSJmu
         +NHfh5p9BVZtWinhPmv/TEDoD/egh3SNP1gcbd34kXs77PTrWK2Y3gv0ngJsu7mLYIw4
         /N8Yve+imbBmhAEFEvHcYy+k1S2lr5YELDJk/8JIwObHs8cYrnBhHYYxYums0uJTQE3L
         NDayT0vLULCGSxYDlkKdgTmdwkKrU8Be6PEI4KTscsicFhO5orp/7uiYh/yLX4EQWFUp
         3s5w==
X-Gm-Message-State: AOPr4FX1eGwGuttKBcPefTJ4orsEIIom3TTzvDp65/AXFCAGHrIo0ZLuQ/lzOsLutFzxudCCWxvLkKcn6YIKww==
X-Received: by 10.107.9.102 with SMTP id j99mr12068011ioi.104.1461780641406;
 Wed, 27 Apr 2016 11:10:41 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Wed, 27 Apr 2016 11:10:41 -0700 (PDT)
In-Reply-To: <CACsJy8B7g8WgWbr4M4LHFyBshN2gi30pL1bCcZcTPB7qtmnWdQ@mail.gmail.com>
X-Google-Sender-Auth: dZdA9kA0szfhGOeHPXobECz3ZVc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292781>

On Mon, Apr 25, 2016 at 9:18 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Apr 24, 2016 at 8:33 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> To be compatible with the rest of the error handling in builtin/apply.c,
>> find_header() should return -1 instead of calling die().
>>
>> Unfortunately find_header() already returns -1 when no header is found,
>> so let's make it return -2 instead in this case.
>
> I don't think this is a good way to go. Too many magic numbers. I
> don't have a better option though. Maybe returning names instead of
> numbers would help a bit.

I suppose 'hdrsize' could signal this extra condition. For instance,
always return -1 on error, and set hdrsize to 0 for header not found
(unless 0 is a valid size?), and -1 for any other error.

But perhaps that's getting too clever...
