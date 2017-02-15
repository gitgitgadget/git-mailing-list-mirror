Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30D9C2013C
	for <e@80x24.org>; Wed, 15 Feb 2017 01:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750902AbdBOBQ7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 20:16:59 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:36118 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbdBOBQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 20:16:58 -0500
Received: by mail-it0-f67.google.com with SMTP id f200so8374638itf.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 17:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cG8Vd8mJ6wWwOrAFlofZONaewrWCMXNA3SKME7J3a6g=;
        b=TXjoSF52hgq7E6izuLs0Dw7jELGO9gVPqFQJOaZKoGd6fC8IJRbDB/2EbegCvjCqp6
         gGbuiSx+e0INv62Mfd/dkYCzNsTth9/8PMytioSSEGDGhYA5yy19Tg32k13oTBAyHEF4
         neVSteH1ZJPUSZy/pJv9kKnTDGkIm4L0VoxAM6VQqoNPPeUDMiBijWr9pbkSg2qum9gT
         8JIMHAYnSzXjdoM5V0uV4Ar846HH0NcEUHhhv5QsNqK3/d/hPKXThThOg/mQOKtnFSzg
         gUOwl0jo/TeNq5dMjLBmJsEw3aqBOnLnQr4ho6lHZiTT7w3ZxizK4SuqhGjthxPnCKBU
         V83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cG8Vd8mJ6wWwOrAFlofZONaewrWCMXNA3SKME7J3a6g=;
        b=CrWR6x7bVuJF/JzIp7BE4zo1qCodfJIAheoWQpMM5eqYEANmsJsFr0zahAuvjEIX2t
         18s6hDQDY15D9/SMg1if5vvBFXJrv/GpzZEadDQH3/nLxr0DmxdhS3XvZxW7+1sqStzw
         zwhN6aiOiO+V58UO5YcDuYZFJZDtQP+0KjwuOoHgcj57wASqz3vulFiRaTlcjDxqqQFY
         JUZHaLtF6FzYaOCM+SFsglupk6mTGTiTmGmoINxZe5Xe85LG0ArLzyScDoA1d/7Fyodr
         HYb36XL9fiZYE+6Dgre/AB8399J/xpClbXsz0oiJOaqqxWIafF/SfSafzo4uWPJ8JrKx
         sfAQ==
X-Gm-Message-State: AMke39lfrtgSwCwi06ISs+n2smAlPRasMnSLyjTIskgZBpBjXKw+CoJ3HMITIHOh8n8Ghw==
X-Received: by 10.99.247.83 with SMTP id f19mr35310125pgk.158.1487121417610;
        Tue, 14 Feb 2017 17:16:57 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id e13sm3384525pgf.48.2017.02.14.17.16.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 17:16:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH 11/11] refs: split and make get_*_ref_store() public API
References: <20170213152011.12050-1-pclouds@gmail.com>
        <20170213152011.12050-12-pclouds@gmail.com>
        <CAGZ79kZC6TntQrW7MF6-h5z5En-u6rwNX=zuaHRNDpbO80ALHA@mail.gmail.com>
        <CACsJy8ChQqUd4poeeKQruQSwdys=ydzxGDC8fU6ZgfrFEEm7NQ@mail.gmail.com>
        <xmqq8tp8aawb.fsf@gitster.mtv.corp.google.com>
        <CACsJy8AfwGK_Y8vH-mF4NXWts_4_CPZamO0L_rWD-1WR3=36Yg@mail.gmail.com>
Date:   Tue, 14 Feb 2017 17:16:54 -0800
In-Reply-To: <CACsJy8AfwGK_Y8vH-mF4NXWts_4_CPZamO0L_rWD-1WR3=36Yg@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 15 Feb 2017 07:44:14 +0700")
Message-ID: <xmqqo9y45k3d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Long term, I think that's what Mike wants. Though the filter_ref_store
> might return an (opaque) iterator instead of a ref store and
> for_each_refstore() becomes a thin wrapper around the iterator
> interface.

Ah, yes, an iterator would be a lot more suitable abstraction there.

Thanks.
