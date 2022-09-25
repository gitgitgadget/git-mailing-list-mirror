Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E44C32771
	for <git@archiver.kernel.org>; Sun, 25 Sep 2022 00:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiIYA7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 20:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiIYA7f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 20:59:35 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96557F5F
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 17:59:32 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id u69so3567609pgd.2
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 17:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=g5cQPe33sVaSO8E7cUzoNCFH8yJuH5IOVbbuIF0d1+Y=;
        b=g6O/QtqQW2AkR8I4J7qheqFLFMsk4MXBO74Eu5WIS4L6FnXxypiS1LtIDTX1ns3Hfa
         gYVHIPonAK4tBYyyWpKtRLmDnIexHFrWQ1UbMiPtc89JRu5k5SlT2w813YDopT1EJgAm
         N6b+bW1aPuZEP3ccpi0G3DuAVtK24152yK4jjoFn3TE192u1wk+b0Gk/U5Iv9N1VX9oW
         7MDZPa4SjIJ9b8naxLWDWsBW1By+N69omeTriO5HrAcU0tBgJ7YNbZAGjd41VW/Cg69k
         33sDnTAa7tA9/lPo6rVF28X6fYuGhGAtGP+MdO43/PqmwyeyEQJ8IvvtxTfXJxcAsfrl
         oE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=g5cQPe33sVaSO8E7cUzoNCFH8yJuH5IOVbbuIF0d1+Y=;
        b=sVtNftynQ2xfWI2Gx8+5ubX9+deQadMr1g25r4Edx6fzSpzmIBgi80Y3cHAUor2TML
         a1UzBWF6KjOm0TLEaYlE2bvgjAsw3iWzDS667/oVYllelvnzlPQrRGtRR2oPTuET/LPx
         R8gj8clAnCPaWD1OIErpWjDGC/pZ8zPsC8PNbJ3421zskIu1tonnbpSIsYFGCDEcn/JU
         WSFL+hZQQ4OocB9yTpXqoHlV6LxzXOgYYuO40n6GzsL3gBJBd2vtDS9vKt6eGD+NmX/2
         Nvy/CS2hRyxHgzzcpqyfuGZNaA96hlZjlk/qj8dBveVj2LjhRik/gB0TA80E1BkUC2uf
         Vbag==
X-Gm-Message-State: ACrzQf1523+jzPk5sSywZcTlwzjikc5mbjZ8sIGIkxbfYjafvezHYcac
        qXy8sChTgTncbGcUYZUOabE=
X-Google-Smtp-Source: AMsMyM6efXerWsoDUCWDJYYPzLg70RHdwifnBixfcEcG8jcom0AqKPH8mPqv0kMCypfkfLA0fQzdhw==
X-Received: by 2002:a63:f918:0:b0:438:766e:e57a with SMTP id h24-20020a63f918000000b00438766ee57amr13542813pgi.584.1664067571968;
        Sat, 24 Sep 2022 17:59:31 -0700 (PDT)
Received: from localhost ([2001:ee0:5008:db00:ddb6:aa04:656c:8163])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c08600b00172b87d9770sm8340517pld.81.2022.09.24.17.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 17:59:31 -0700 (PDT)
Date:   Sun, 25 Sep 2022 07:59:27 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Claus Fischer <claus.fischer@clausfischer.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Scriptable mode for git bisect
Message-ID: <Yy+n7/NolP5rCpwX@danh.dev>
References: <Yy4c6/jHupgThj7j@clausfischer.com>
 <Yy5g80OtVG4op8L1@danh.dev>
 <xmqqwn9srb9e.fsf@gitster.g>
 <69B998A9-0E3E-45F0-8733-F2A3F11625A5@clausfischer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69B998A9-0E3E-45F0-8733-F2A3F11625A5@clausfischer.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-09-25 01:46:13+0200, Claus Fischer <claus.fischer@clausfischer.com> wrote:
> Well since I usually don’t have many revisions backwards, typically
> no more than 50, I can just traverse the tree backwards from main.
> I remember the last ‘bad’ revision before the good one.
> So there’s a solution for me.
> 
> Yes the bisect command puts the correct ‘first bad’ revision in its
> output but it’s surrounded by a large amount of useless text. It
> would be nice to have a ‘quiet’ flag that lets it output just the
> bad revision. Alternatively, that it ends by checking out just that
> bad revision before revert.
> 
> My problem is solved by stepping backwards to HEAD~1 each time, but
> you might consider making bisect more scriptable.

No, you don't need to parse "git bisect" output to get the "first bad"
revision. The "first bad" revision is stored in refs/bisect/bad.

And you can take the "first bad" revision in a scriptable way with:

	FIRST_BAD=$(git rev-parse --verify refs/bisect/bad)

Of course, after finishing bisecting.

-- 
Danh
