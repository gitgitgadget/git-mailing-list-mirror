Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E50C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 10:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiESKxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 06:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbiESKxI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 06:53:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06738AF1C3
        for <git@vger.kernel.org>; Thu, 19 May 2022 03:53:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id tk15so9153992ejc.6
        for <git@vger.kernel.org>; Thu, 19 May 2022 03:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=HFU8YrheDrh89bUOcZIUwhmh+YSSZkBOFMYowq7w550=;
        b=gb13/4UONuQ3gvyEvtUV7/DhPMSFFTeR64DKVypY2ySRTEsyzAG/ovL+D4nOzgcu1e
         aAHR5Ra0zUpb1E3dOtPcw5xdU5QQDGDVOCj/RSs4RfgLgpvrOrk4QTU2cQKVj0lJpsf6
         pjKKdS0ymZeItTTAc54aGa+BiNfi4sha9sAPkaKV8Yu1ajbELcgncRQyzBZt8u0zed6K
         KNLw9dIGp2QEEtkup+DTGfDW3GkHdqRNXCHvUiKJX5g8AMAqGvV7yZZx4xgQ6SHY7sDL
         Ky1Rt/Yec32cnQXDbvD1DEWvGOzGFrv6UdmhClrvWbg4r6fHn9RSkcrkyNUJewagdbkX
         IKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=HFU8YrheDrh89bUOcZIUwhmh+YSSZkBOFMYowq7w550=;
        b=Mj3fga7gdlW8acTj5d2gcgc5nMf7DwsXuqU8Zdjt291Bz5MaeWkLz77G071Aig1IV+
         aI5adNmWOehcblWV16pFKTvj+suCuZSkuAEB2SPNl+WVINu8Fbk6yyFTV5xzv9sxadln
         k82yw1KQp/eq3RsMTap+uBWfs4tJCGwtTRc9VSvXgyUZuS9k4IABdQVwzLu74u1kIRkG
         MztTfNlFZ5oP4FP5AgVGmAWGLUE5uqMTs4/rUM6YQkAPnRBNM/tZQerCwAKiXBgo7EuU
         MCI4K5C4UfoKg6KbrLO2cDdclhw14BUst+AGB2NhMj60NhOWx6zcuX+R1xCs1ZHLHhw7
         ee0A==
X-Gm-Message-State: AOAM531+owh4HJrZYc8HWmFdjsmEfG80YBCpNHAj/ainH5URiljKtxyF
        PllF8vbcpYX5ys+V+PW0JN3xf61ok72Nuw==
X-Google-Smtp-Source: ABdhPJwre0n3+q4Br93upGN2I1virQ4iEQakcXffEktxCweR/tLo6DFrZxP9HEyioPwhEQ6upT68zA==
X-Received: by 2002:a17:907:96a8:b0:6f4:45f1:6e76 with SMTP id hd40-20020a17090796a800b006f445f16e76mr3945221ejc.186.1652957585600;
        Thu, 19 May 2022 03:53:05 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id s10-20020a170906778a00b006f3ef214dfesm1970686ejm.100.2022.05.19.03.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 03:53:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrdmB-0024QX-HT;
        Thu, 19 May 2022 12:53:03 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v4 02/17] pack-mtimes: support reading .mtimes files
Date:   Thu, 19 May 2022 12:40:56 +0200
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
 <8f9fd21be9fcdda5c73d800fc66d1087d61a6888.1652915424.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <8f9fd21be9fcdda5c73d800fc66d1087d61a6888.1652915424.git.me@ttaylorr.com>
Message-ID: <220519.86zgjd4wvk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 18 2022, Taylor Blau wrote:

Nit:

> +  - A 4-byte magic number '0x4d544d45' ('MTME').
> +
> +  - A 4-byte version identifier (= 1).
> +
> +  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256).

Here we let it suffice that later we'll say "All 4-byte numbers are in
network order".

> +  - A table of 4-byte unsigned integers in network order. The ith

But here we call out "network order" explicitly, shouldn't this just be
s/ in network order//?

> +    value is the modification time (mtime) of the ith object in the
> +    corresponding pack by lexicographic (index) order. The mtimes
> +    count standard epoch seconds.
> +
> +  - A trailer, containing a checksum of the corresponding packfile,
> +    and a checksum of all of the above (each having length according
> +    to the specified hash function).
> +
> +All 4-byte numbers are in network order.

I.e. this is sufficient.
