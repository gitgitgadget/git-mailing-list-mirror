Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843221F424
	for <e@80x24.org>; Tue, 24 Apr 2018 01:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932769AbeDXBQE (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 21:16:04 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41222 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932633AbeDXBQA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 21:16:00 -0400
Received: by mail-wr0-f194.google.com with SMTP id g21-v6so18563375wrb.8
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 18:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZAVblS0GWm90JKTGRFOjDwNEf3RTTaT5c8R0zLhg2Js=;
        b=fJbWmPshRiWI9tFVDQV4WQwbOIAya6RQTAPzXZyJ3omhJNnNXji2/9KYxbCHQHuH/M
         lifPx7q+eHdccqWQMqb/AclRyhPJLBcYPhvaF6n8XkOAweUDf7ViD0cX6Ye41MmGId1m
         D/jQ4GbuC2mEt0a51968IuMgtaizy6kb93qqDY3q5UOdSs+Hfd+g+NuNayU7X7kZG6Or
         gu5zAa40AE6ON8HQ44W3FOpoJ/Ve+iHvJd1eLoDbLQisbPkxCDSIO2Lf7lWwF0IOl1EJ
         1xZefYTga/3US0vKBDTug5o5fiYeNMKnw4QI8qUEeTzVh2gge+z7BSzgMrKjlkuKbaaC
         kt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZAVblS0GWm90JKTGRFOjDwNEf3RTTaT5c8R0zLhg2Js=;
        b=Ubl/20cVyptYSGBslyCIhSLil7Ppe6/l2wqMH7Jc6Z0bbnUIMM2bDBlSdfSLmFMshr
         1hqvKSG59hwxNFrguIm/MhW7xd/sLJBTak77EPxaTTBJaVvaFxhz1FqS445qUtd+fXZM
         Y33coalG93BdU6a7C28hPCzbU3kphRk3bvO+DwRWp4Ueac3DCNIU8TR8ZGLXT5K5v0xm
         E0DZolhxb5Z304KBaTEdYWpS8VPe+7ih9ttE0YZ+HdnX50OHl3q8Sbg8IsJCQszRbnM4
         8FCHsh1vkJbQBMBBppMKB3WcujYa4OJqHSiZtV/Q/f8RnHCLP3pLHsXAUXorL8XeGnsO
         Xw2w==
X-Gm-Message-State: ALQs6tDzbHwyeP+pqGYmsv0GtrrZGTFxi59ozyX+podzzRdnyY3EOdaU
        nMSw7K5Z0SbShaYZnDpsjhM=
X-Google-Smtp-Source: AIpwx4/UnOQk6ZX7b0PxjLDSKBHef/zBtQ7mwppEBandwPhDNY1gP0+zWmFHaFiM5BsqcteGbJZSgQ==
X-Received: by 10.28.13.201 with SMTP id 192mr11285388wmn.117.1524532559272;
        Mon, 23 Apr 2018 18:15:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j76sm24390770wmf.33.2018.04.23.18.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 18:15:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 01/11] argv_array: offer to split a string by whitespace
References: <cover.1524262793.git.johannes.schindelin@gmx.de>
        <cover.1524303776.git.johannes.schindelin@gmx.de>
        <6ec155b834768f38765c63907a48b1bd7ab6bafc.1524303776.git.johannes.schindelin@gmx.de>
Date:   Tue, 24 Apr 2018 10:15:57 +0900
In-Reply-To: <6ec155b834768f38765c63907a48b1bd7ab6bafc.1524303776.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sat, 21 Apr 2018 11:46:12 +0200
        (DST)")
Message-ID: <xmqq8t9d8kvm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +void argv_array_split(struct argv_array *array, const char *to_split)
> +{
> +	while (isspace(*to_split))
> +		to_split++;
> +	for (;;) {
> +		const char *p = to_split;
> +
> +		if (!*p)
> +			break;
> +
> +		while (*p && !isspace(*p))
> +			p++;
> +		argv_array_push_nodup(array, xstrndup(to_split, p - to_split));

Can *p be '\0' at this point?  If isspace('\0') behaves sensibly,
then we wouldn't have had to check "*p &&" in the previous while()
loop.  If not, then while() on the next line needs the same "*p &&"
check.  I think ou r isspace('\0') is reliably false, so we could
drop "*p &&" but I do not mind spelling it out that we care about
end of string explicitly.  I however think we would want to be
consistent inside a single loop which stance we take.

> +		while (isspace(*p))
> +			p++;
> +		to_split = p;
> +	}
> +}

I wonder if the initial "skip spaces" can come inside the main loop,
perhaps like so:

	for (;;) {
		const char *p = to_split;

		while (*p && isspace(*p++))
			;
		if (!*p)
			break;
		for (to_split = p; *p && !isspace(*p); p++)
			;
		argv_array_push_nodup(array, xstrdup(to_split, p - to_split));
	}

or something.

Duplicated "skip over spaces" loop is not a big deal, though.

