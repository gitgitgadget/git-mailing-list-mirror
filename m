Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392752013A
	for <e@80x24.org>; Wed, 15 Feb 2017 14:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbdBOOgz (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 09:36:55 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36789 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdBOOgy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 09:36:54 -0500
Received: by mail-lf0-f47.google.com with SMTP id z134so81945644lff.3
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 06:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6tNdzGqp8mvUHhwUsnAPxmQJNfL8xrH3c06/JKbTSrk=;
        b=iMMvhgoZCv5MR2W/DFlvPTn9dsdZLuYgUmV3WhfpuAAeOlH7M6CtFAvRIAVGCWsdXZ
         woCHrc8AZ0ThTyuJ9Cwj8qdx2Ml0PYyZvUCPgccsVTB9QWXmVZubUJfCQY4/A8fyYXWm
         qJW1skElV+CclE0JuMR1HBsQ8O9lvSL/br+4nLn3pxcx5WPx92JA1DCA1H7drShBbUoQ
         5RgC2D+RX3emBHZkJL8qvutai6Acskk1DkNnVIXnQGPwi+NwZXfYhV8rVJMYa5VJKLMt
         WfWQ8OqgXUN+dV6H8/M+gU3EEB6QCYjqsbbKix+WW2kaNBQujot7cs1AcY8HnR1jmVZD
         04WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6tNdzGqp8mvUHhwUsnAPxmQJNfL8xrH3c06/JKbTSrk=;
        b=kCcNiL5Wrq+lhIUd4jhmjcvJy/2I2hV22apX9BE2Poyvcw+IflOml/yC9LCrOZ/Yo/
         rPD3eO+TA7woWyreYIPciu9m7Kl0QJMtOrdbeGMaxWpIVOULHZDs6Y8+CzJejoimSiwL
         rIwnLQmK9qFdsmJ/vizJpqyeJ+IMO16rQFhE/vmeBISneXe3RA5kk/8NRTgQbwgUpltA
         E9W14IYo28Y5Dc4CozuAMfLHjtjv8exAkBY3/KPQzTZ0Oeta9+Wm1k3PKRo5uStBMmet
         V1GYkllAJ7E7jNS4yYcqbqYOXkPzKhRertmFEQGPx4yucf7EgUedaL8xbTvg6xJNSL52
         LNvg==
X-Gm-Message-State: AMke39m47S9eCW05QFqn3v4iEr9Zvo1FGgHjRWSgILfLn8TX6byjexrD3YSh1fcrW+Z5F2MrLTyuvvn6zipXuw==
X-Received: by 10.25.202.83 with SMTP id h19mr11472554lfj.33.1487169412708;
 Wed, 15 Feb 2017 06:36:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.223.84 with HTTP; Wed, 15 Feb 2017 06:36:32 -0800 (PST)
From:   ryenus <ryenus@gmail.com>
Date:   Wed, 15 Feb 2017 22:36:32 +0800
Message-ID: <CAKkAvawFJwAcn_360O101vvtbUL3Cwfqx_8VLQg_PjWzFVwDVw@mail.gmail.com>
Subject: enhance git-add to avoid password being staged or committed?
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This can be an optional feature, once enabled, git-add would check the
hunk(s) to stage for sensitive information, such as passwords, secret
tokens, then ask the user for confirmation.

The implementation for secret detection could be regexp pattern(s),
and/or (trusted?) commands

Alternative solutions might be hooks during commit, push or recieve,
but it should be the best to do this in the first place during git-add.

The context of this is the following HN discussion about passwords on
GitHub: https://news.ycombinator.com/item?id=13650818
