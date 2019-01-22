Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4F2A1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 19:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfAVTrH (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 14:47:07 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52949 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfAVTrH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 14:47:07 -0500
Received: by mail-wm1-f47.google.com with SMTP id m1so15421294wml.2
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 11:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=aAvyx0ANzGvDhfSuTYn+UQ83SukP3sfJolJIZtUCC0k=;
        b=B9JxUcGdERgI9K0Wtpr009EUzjVaaxB5hNvhcPJLgnqEvGfvLF6rMmvVa59MQ6q27+
         GmnEKFq/ExKPXpXyCemAirRx/duHhbQi6ARQiMnWI3q5/MUerarb5aYStTq6JmGU3tEt
         iqwFtH1GzB8aYEmLwu35woXYmDexXMI/z3YzMobB2NDuNQkn/jJ1BMIlT1oSNngNN+a6
         jweNi+/VGNg4P8SAz666iL92J2nEB6qbJJtNEI//McpEIwRhePaEVxzwRFCEYCi8tR5m
         gkTv5BrXU8X5P6kZMKgd+pV1ay0Mw184PX0542xJFzMmBdZaMfbpGpvsiZoEKGpUckpu
         /77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=aAvyx0ANzGvDhfSuTYn+UQ83SukP3sfJolJIZtUCC0k=;
        b=pCIYeAVa/AYhiK5qxEVXxvhQkLvXimOQTjslJ9KklAKlDF3eG0txMFnKGlEWf+WZhp
         iGsgtSvEzhhy1eRwrIADJ5SvM1xbnd16NnJtWgKqrj1S9zYmVSLF4rpUgVueUleijj80
         fVWRdt+OV8JTASJlruoO2l/8yeaIlSlfrUcWXD5XHS8FoxWQ+JqRdAjgCBa+yy/+9Sut
         T/ot+HejN3bx1P4Zuhycr/BT7Op7FeRcANdh/oV4op1l5i8iE6jlNsBY60awlEUW8CVv
         FHrlpGhLRh73FOTYbDQI841WOX4logSKZ7n6X970boKIDupyVu5R11Tb4p0X1uq/OVKI
         kfzQ==
X-Gm-Message-State: AJcUukf7mNG1itLVgHvP5u1zViXtEa0s4v13Lp9gA2wGxCxORVOzRxkP
        a5BWNGIdCz33sJT2qUAoi7OUvjD3
X-Google-Smtp-Source: ALg8bN5WRcm6YtRARSCWYZzBM+MyPtJ5PDKi54KQxe/dbjU+RpIEqltASqJl+xHB+vqOcCRc9iB28Q==
X-Received: by 2002:a1c:ab87:: with SMTP id u129mr5135982wme.104.1548186424916;
        Tue, 22 Jan 2019 11:47:04 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w6sm54179755wme.46.2019.01.22.11.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 11:47:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        zhiyou.jx@alibaba-inc.com, sunshine@sunshineco.com,
        avarab@gmail.com
Subject: Re: [PATCH/RFC v2 1/1] test-lint: Only use only sed [-n] [-e command] [-f command_file]
References: <20190110115704.GL4673@szeder.dev>
        <20190120075350.5950-1-tboegi@web.de>
Date:   Tue, 22 Jan 2019 11:47:03 -0800
In-Reply-To: <20190120075350.5950-1-tboegi@web.de> (tboegi's message of "Sun,
        20 Jan 2019 08:53:50 +0100")
Message-ID: <xmqqo988fpag.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
> From `man sed` (on a Mac OS X box):
> The -E, -a and -i options are non-standard FreeBSD extensions and may not be available
> on other operating systems.
>
> -	/\bsed\s+-i/ and err 'sed -i is not portable';
> +	/\bsed\s+-[^efn]\s+/ and err 'Not portable option with sed (use only [-n] [-e command] [-f command_file])';

"sed -n -i -E -e 's/foo/bar/p'" won't be caught with this as an
error, but that's OK ;-).

Is this still an RFC patch?
