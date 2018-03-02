Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB991F576
	for <e@80x24.org>; Fri,  2 Mar 2018 10:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426264AbeCBKTV (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 05:19:21 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:40368 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424224AbeCBKTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 05:19:16 -0500
Received: by mail-oi0-f54.google.com with SMTP id c12so6681322oic.7
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 02:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YgrdX+Tuw+HeEQjDOyLa2SBnSL0+v5kKBc/V1PAQsZg=;
        b=CKYS77bR+MhrDyRJHMQBwexo5gN6Iz4YL6rsctCWows2fk0QLT2T1rztpP8xSA6GEB
         7jhewY8LwaWunwoYQSXrxuEZXUjc3N5Ewb8S6Xso+B1cxn/n0SAWd2QdKlbqemo/pdKn
         vF/G/trH2KpTvoxADTEi+4Z8SxbnckDA7v/eYcHsv2x4DL2opPJW/S6lt4kVl+zcBgqH
         0pDwSpZTZZRn4pZIy0Hnrbs/berbCd6pgJYohWV91408gSAEKE034YR17NTxoWm3QaUH
         zI6WvA5dS1sDIXDTRl0gXBRayriSq9Cb1CM1dHJslBB0MZiF1c/NeOZfhz5LwMOakvze
         jokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YgrdX+Tuw+HeEQjDOyLa2SBnSL0+v5kKBc/V1PAQsZg=;
        b=UeFv7ZeFco6uioYmPooXVaI7wg23Ve5jp/6sNXUU9ukd55dBEn/HRu8EJ2JWiuZWT7
         4G7lBR6bw+mQ1MlObP7EJmInNkV7Pd58/fSSK1Wh7uEuQg0JNfb7q9uNJUb8UknSU3Cr
         rZCLy17ibW6gJLacPX2laWHJo8WfH0SEbwYS/ZHS8R8etHbe/7Y5XGmUJV0UckIFPi7o
         9vq0azYNZgXee6tZod03h3t7iXULXS6kDuMreNtj30aCNF6hGBKcs1T3Cw9K+Ku2BEuJ
         jDfjf7PdMKvDCaxWoVj7PWD4JncOTAR7SuKT6r67cZI/7exMawjGOBCw0KMSeoe4ZRAJ
         eJnA==
X-Gm-Message-State: AElRT7ELZeH8APF15pTC+7G6oLPa1aNTS9VpJ/aeWFGW/2JPV+YYqXwu
        X38yY0kOWXee334ETOzLkiF5sNQis3IBBubU1gcy0Q==
X-Google-Smtp-Source: AG47ELtWbRqJ+AgjwBNXqpTrhojZzCclevQPmux38VU5RpauG35dJZPMSbFLqOZZtOJtbU/cHJn4+qR4iwjaVIiixsk=
X-Received: by 10.202.212.147 with SMTP id l141mr3454366oig.32.1519985956049;
 Fri, 02 Mar 2018 02:19:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 2 Mar 2018 02:18:45 -0800 (PST)
In-Reply-To: <20180228092722.GA25627@ash>
References: <20180228092722.GA25627@ash>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 2 Mar 2018 17:18:45 +0700
Message-ID: <CACsJy8AzP9HLc02LbSxBvNM6Dg4FsgRt57SgaNFyT5TBPRq-Zw@mail.gmail.com>
Subject: Re: Reduce pack-objects memory footprint?
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 4:27 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> linux-2.6.git current has 6483999 objects. "git gc" on my poor laptop
> consumes 1.7G out of 4G RAM, pushing lots of data to swap and making
> all apps nearly unusuable (granted the problem is partly Linux I/O
> scheduler too). So I wonder if we can reduce pack-objects memory
> footprint a bit.

Next low hanging fruit item:

struct revindex_entry {
        off_t offset;
        unsigned int nr;
};

We need on entry per object, so 6.5M objects * 16 bytes = 104 MB. If
we break this struct apart and store two arrays of offset and nr in
struct packed_git, we save 4 bytes per struct, 26 MB total.

It's getting low but every megabyte counts for me, and it does not
look like breaking this struct will make horrible code (we recreate
the struct at find_pack_revindex()) so I'm going to do this too unless
someone objects. There will be slight performance regression due to
cache effects, but hopefully it's ok.
-- 
Duy
