Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 151971F404
	for <e@80x24.org>; Thu, 15 Feb 2018 18:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166562AbeBOSgW (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 13:36:22 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40160 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162888AbeBOSgU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 13:36:20 -0500
Received: by mail-wm0-f67.google.com with SMTP id v123so2594167wmd.5
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 10:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WKlplYGF+1gbaWnslmAtNZSXjFzhPZyohgKu4WG0dw0=;
        b=V9SfbHJGiXj4SJRRBTN/DWALgUGi1FBk8M4yCatrt6Z3OJp33D7Edx4WRrtZSZM4sW
         2UtKRX+CQpqjjN412bwrLA1ypwrCF7D0UdzAmlPbYpQIGaXfQxtz+SoecL3G0y2dCxUO
         foptfAvOaXN2sGL9RCl4O8S0uA7+O1Qi8bqOuhL/snI20hZSPBJJNbLJTS+t4Tnrh51u
         YJAZ49usu/daxN/7h+PxBtPMG9dL26ycRYiIxKyFtKIcr9dRnIymABRIVATvg/DRqKuD
         AjEqrplmjqozhLQJlsScbu6tfofFzXyWM9zatdqKX8A87NwPKD1vy4fRbkOQOaFMc4qk
         gClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WKlplYGF+1gbaWnslmAtNZSXjFzhPZyohgKu4WG0dw0=;
        b=eZEmc/PArBibsnnJkDW0Kx71jt9AU0afTAQ8nvHeVGvmx/4mqa7SuGQZQZm+2ZHlbM
         2XTzrUDL9jQHM6sxXO7pZog+hf8hHNLfCPquv85N9O0Z/5sWaaLVrBNt3F2iaKDawYsY
         w3IQE8G33Unbcs7TSqYrv8W/N8g9wwxzvtx1fIWBQut0sO6EAKpAcRuCuG3uMyni3NvO
         w38zBbqlTyNVMANQVDH/bvlnef5ef1KbQKjBEgE/L7dFYqoG2yJ121cAKBDhJQb+gtXW
         TNpZR4lXp1Fln//moPMdAtpGScLMNKhm1ShQYrwE1G6Ld5/6PQ+0Vs6gqgIQg0GJs/mb
         KL/Q==
X-Gm-Message-State: APf1xPAZbf/vaBKeMgCth0BD+c122myYZ9DeJEGLmF5lLeEu6Zh7EyBw
        k0qn56FFgD9ai/ewYmRyNWSgi3g/
X-Google-Smtp-Source: AH8x224VBm8WV19zbT2cOCVHHkUJ+h+YFGURkf0T0vVzuJrFXTCfCzmu2Gz3ytaGXHdrDZqFTzC8tA==
X-Received: by 10.28.28.139 with SMTP id c133mr2674705wmc.144.1518719779012;
        Thu, 15 Feb 2018 10:36:19 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d9sm2938934wra.16.2018.02.15.10.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 10:36:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, doron.behar@gmail.com
Subject: Re: [PATCH 1/2] parse-options: expand $HOME on filename options
References: <20180214101019.gaenosifgq3wx2nm@NUC.localdomain>
        <20180214105149.28896-1-pclouds@gmail.com>
        <87wozffavp.fsf@evledraar.gmail.com>
Date:   Thu, 15 Feb 2018 10:36:17 -0800
In-Reply-To: <87wozffavp.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 14 Feb 2018 23:46:02 +0100")
Message-ID: <xmqq4lmi9k2m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> In general I'm mildly negative on adding this, for every user like Doron
> who'll be less confused by a hack like this, you'll have other users
> who'll be confused about git inexplicably working with ~ in the middle
> of strings, even though;
>
>     $ echo git init --template ~/path
>     git init --template /home/avar/path
>     $ echo git init --template=~/path
>     git init --template=~/path
>
> I think it makes more sense to just leave such expansion to the shell,
> and not try to magically expand it after the fact, since it's both
> confusing (user: why does this work with git and not this other
> program?), and as shown above changes existing semantics.

The above certainly is a reasonable argument.

> I think this way lies madness, and it's better to just avoid it.
