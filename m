Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2F01F404
	for <e@80x24.org>; Fri, 30 Mar 2018 20:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeC3U0L (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 16:26:11 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33063 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbeC3U0K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 16:26:10 -0400
Received: by mail-qk0-f194.google.com with SMTP id d206so10075678qkb.0
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lpQ1SW2JywyN/my6tI4oh5XPWUBkqf5DCMgBoHjBbso=;
        b=dX8GCtFrePNosnDLa8Car9mmj1oqlrr/zh0i9MiegzqErroW/Y1uHhhAyZMQH27v4W
         JddV5x3/ZzqZ74LzF193YcxA5UpOe+n0SsgneZHWSheU48Uhc95TM05TnP2ZVv+1G0Ep
         ySXnzzbnQFqZpREyOIEQX8xAl7hkM1mRk1URBdcXk9+lz1d7coS9jrcy7pMesMGXG6ci
         QsR7EaUrY6BvqVdZfPFwgOz3v8X/o/MwpszbwWZkZ6BSpJz3n2BjpggsVwXflvlIjldd
         NPnsG5VNtf3badFlQyKnDCqSE7Z/ObQjO+HThP60Xl+6bBlKuuMNx+u6CLmjRcAkDfoA
         88+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lpQ1SW2JywyN/my6tI4oh5XPWUBkqf5DCMgBoHjBbso=;
        b=VfJlbTagwRMgQBxg42UeKD4RHDYSSqToUfCBVH6Mti1F8K8ibswc3MSmyA8tlykohE
         Ytt4hCi0YUBOkp6fLgItADmZKGVSIiwX6Z20OsWIDYLpGUl1fDWQNv1DSJC5WCSM752D
         rFks5OXGUl+KhuCK/YB5envq0rlK21JiaRg3QRfb29bf83yywxyy6kC5qVtTtiedxnsU
         tHYlYqU9VMws8+qs+iOvS+ZvQtkFBGJf2DybONHsvZBFiQC0SKzHyKue4CzeVbnSU66D
         8ry71GeYYboLjD0inoLUahdEPkaWhHUQlRvDO5KM1wR5sm2pu7IHn/mvadhCK/NMu9lG
         Txlw==
X-Gm-Message-State: ALQs6tAGypSNJ8wsQV2VP7q2BzozNP4ZSUI9U26MWpoKs6dRdm/dT2t6
        Kdu3D/NrsjOIt37HzzwHPghY/NI+NQ+5STWj1AI=
X-Google-Smtp-Source: AIpwx49WiogurMX+1JXZ2P4Pkr8upoxJCIeeF0kXdMndG9VkOLud+I02961ns+0RkBCJ2cuP1EuWNi4AgYyCXbfs+Es=
X-Received: by 10.55.22.28 with SMTP id g28mr631291qkh.152.1522441569705; Fri,
 30 Mar 2018 13:26:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 30 Mar 2018 13:26:09 -0700 (PDT)
In-Reply-To: <20180329011634.68582-3-me@ttaylorr.com>
References: <20180324005556.8145-1-me@ttaylorr.com> <20180329011634.68582-1-me@ttaylorr.com>
 <20180329011634.68582-3-me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 30 Mar 2018 16:26:09 -0400
X-Google-Sender-Auth: qeMOvBEiPih3_mBzy6PvhMQi2Kk
Message-ID: <CAPig+cRbQbFLw_qarT0rcOoEgBg-7gW_pbFpiH5yuO=miLuWfA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] config.c: introduce 'git_config_color' to parse
 ANSI colors
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 9:16 PM, Taylor Blau <me@ttaylorr.com> wrote:
> In preparation for adding `--color` to the `git-config(1)` builtin,
> let's introduce a color parsing utility, `git_config_color` in a similar
> fashion to `git_config_<type>`.

Did you mean s/--color/--type=color/ ?

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
