Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 930781F404
	for <e@80x24.org>; Sat, 17 Mar 2018 21:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeCQV00 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 17:26:26 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:44765 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbeCQV0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 17:26:25 -0400
Received: by mail-wr0-f178.google.com with SMTP id u46so885094wrc.11
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CsEa2dgk0omDtNYzQyAfk0R7mO89P2k2ydmaJ4JeHAs=;
        b=WXQHVYA9OOTvEV9YeQO+rBESY+spujwWyuLCKYHr59QWzC6Rfu1Sq0vr7eNlCh259r
         PNwNsCO3h8eryLr+yRJysvTv+rWs52ZvtFpALYvsYLrnKfSeoJHrriKiYDkY0EwauKvT
         2T1LRO5Kku3xxof8wHMSgYVRngP3h7EPX4UOtdxRFwORCeti81UMy0Og3px4MNvLeNVM
         W2+HUyDh2L8N2ph50wRTph3hCQ/rXcZ9Q0bgWxZJco52Uzf+HDiFxRXfEGKJzhHfhvFE
         /FUPToWm5ctRXLXYwZ0yttHJ+eLBBPzfhNU7yuv3wWCX3TqZrD0YmrBNzPIh51l/BMSn
         7ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=CsEa2dgk0omDtNYzQyAfk0R7mO89P2k2ydmaJ4JeHAs=;
        b=Zr5lwnuhMKP8QoYb49FSdrLgFOPGmlyBJNWXX1BU5U2dWrGUem1vDcXT/ksEUIJSLK
         jBqblnjzRbzSem64c7abZgvURWK+0cNZeMFv8RmuSzl8QGWoSbwd/Eqblw1ZkHn2gB+X
         a4ks4561ia+mN/Wa3Qic6XiJxCRmHAXgW18pZE0Xj/M63aWXXYmSDEIdPE6/CoC9+8Fq
         bMlXE/T2M3q3uXZAj1gzRLMYgGnTj1Ry+LLLQh5ZuM3o13azLmSlc/ljyXZZ0udb8iZP
         uP0tpHmxAea2q3r9rgOCYPtkF2LkxdqwXYi/JeSNJnaggZOOot4N/6gMrnqwim9+l7q9
         Fc3w==
X-Gm-Message-State: AElRT7GuZhbKaPJ7bSiAlcuBCPYP6zJ+cCJA7llrvU5RXV/E9zPu2P0x
        drhTdp6ZYg4UPBBLCceP76Q=
X-Google-Smtp-Source: AG47ELvZk+n5imDELr1wqHiNyPev1/z31z6wkOUKqbOihNVxMjMPerwir3dbcD6ZLfJNswOEBJd/fQ==
X-Received: by 10.223.131.37 with SMTP id 34mr5438994wrd.169.1521321984296;
        Sat, 17 Mar 2018 14:26:24 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 67sm10206943wmw.17.2018.03.17.14.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 14:26:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v5 04/11] pack-objects: use bitfield for object_entry::depth
References: <20180316183200.31014-1-pclouds@gmail.com> <20180317141033.21545-1-pclouds@gmail.com> <20180317141033.21545-5-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180317141033.21545-5-pclouds@gmail.com>
Date:   Sat, 17 Mar 2018 22:26:21 +0100
Message-ID: <87h8pecs1u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 17 2018, Nguyễn Thái Ngọc Duy jotted:

> Because of struct packing from now on we can only handle max depth
> 4095
> [...]
> +	if (depth >= (1 << OE_DEPTH_BITS))
> +		die(_("delta chain depth %d is greater than maximum limit %d"),
> +		    depth, (1 << OE_DEPTH_BITS));
> +

This has a off-by-one error:

    $ git repack --depth=4096
    fatal: delta chain depth 4096 is greater than maximum limit 4096

Per the check we should be feeding `(1 << OE_DEPTH_BITS) - 1` to die().
