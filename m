Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6CB1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbcG3RjK (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:39:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33743 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbcG3RjH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:39:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so20072020wme.0
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:39:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LUuhzhNv3nqUAK6EQSAySmkFZ1dbbjhJptqLdhyTs50=;
        b=nR4nYxgAOxtcSEM8BJm6Tgw8UMhXqbDuZiobq/1WybTk6/msWd0YIPVrLLvWZbGwGw
         xWCayw3xKoJu8DNI10McK3FLmnpVwZGStFc3jya9B732jCZ5FSaLqqVJA+U9+DEvDADq
         sAPGCFWRCKiBmqmR+SSVlrpvauChTa2KWE/FwYBnHxpIRPiNYuPHEoGJAQdsey4d60NY
         ewq2uxqSLbfVArgU5RiqZyZqJYdCzjdFltlbr5URxAVSPEww8P8KKh3g67CMSis+EICq
         xmFD/34qTgEuhXY8KISG/YQbT5PyyJKGnYjob+iB6g70rmMQhVsUGqc28yTSCIt+nymU
         dZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LUuhzhNv3nqUAK6EQSAySmkFZ1dbbjhJptqLdhyTs50=;
        b=iWLVtg7HiQOTEMm6GbKoyiYCDNL4HhsqkUTl7LYBeMaiNNfbdN16OYwKlw5EAEcek7
         J8m7wEcUGnNTNoKsX4o4DiRwWgXllFy7tMs2MWgzFxxhEBJjbTRgohgY2Myjqxgy7s/G
         FLC3LMdtiaBVt15mSldNPIE3SWdZo5wM+BEotn6Nkirp+k86V8FSmmAO+uboPw/x5QDP
         MHumVrKps5FvNU6pvGUkYUX9gprRus8xbQwvXd4OBjHd1ntn3qc+9Qa1aPFzJu3xgA6t
         cfz1bKn5kJKitwpLdzHUKTEFkL8qmlIXXhEdqUPBZkYi3POX0kRLOGasx9k5lvv3jeE0
         BAJg==
X-Gm-Message-State: AEkoousNHDf1Gyv9rrhrXHPa0CGLWuCSdD43yJUew2gjAWez6v0pj5r39eV4XeIuyHY+0mHPMTAlHcaVx8HLuQ==
X-Received: by 10.28.167.80 with SMTP id q77mr6736838wme.62.1469900345981;
 Sat, 30 Jul 2016 10:39:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Sat, 30 Jul 2016 10:39:05 -0700 (PDT)
In-Reply-To: <xmqqa8h3xd4a.fsf@gitster.mtv.corp.google.com>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
 <xmqqzip4xfmz.fsf@gitster.mtv.corp.google.com> <CAP8UFD0tcPnqBcxC5-4tnGMT4W5b7L=C_riwpTvDfeMUjQzpjA@mail.gmail.com>
 <xmqqa8h3xd4a.fsf@gitster.mtv.corp.google.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Sat, 30 Jul 2016 19:39:05 +0200
Message-ID: <CAP8UFD3ivJNjn0dG_JGRdTNdX6R+L2UZnyQqcrbohthNA9RGbQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/41] libify apply and use lib in am, part 2
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 6:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>>> The early part up to and including "apply: make some parsing
>>> functions static again" looked good and we could treat them as a
>>> continuation of the earlier cc/apply-introduce-state topic, which
>>> has been merged to the 'master' already.
>>
>> Ok, is it ok for you to just pick up this early part, or do you prefer
>> me to resend it (maybe with the last patch on top of it)?
>
> Either would be fine for _me_, but as the original thread is now
> about a month old, a final reroll to give people the last chance to
> comment on them would not hurt.

Ok, everything that was in v8 has just been rerolled in v9.
