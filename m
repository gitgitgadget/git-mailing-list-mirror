Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDDEC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 09:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJMJcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 05:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJMJcu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 05:32:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01E3105645
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 02:32:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fy4so2634945ejc.5
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PFEL8CbJDwMS1EjSgndeBVJCL642E2vkMEWo6+ByFu0=;
        b=h9Q+DneU+SqB9NsHYcgtgCwna/fmtrdV0gXrnj/0zyjp9qFDq/pC1aoM0Jg3vowXjG
         Ps0CoThxxvVqXJMqCOSs37zhd5CwzO8onJllDCr5HyPeVV7XVM6GVzw7NM7ukNgbUmJ+
         TJk70208yFqaWV7yn0LL+RjlYDLzWT8cE9zPJq46mL2xdRtypB/Qt96IrH+p+EnDinas
         luhkMp5Kdw/zo5iP0MZz8yYtBOnOcR2DZihazyJfRic/hrnnK3AgOaNq+X//gSphaDN8
         BLHMxVZbZmZpm6Rlci99zXsLTkQobq58zaaZKOGRki/jYCw7czYIgiB35TFVpbagKNlI
         I6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFEL8CbJDwMS1EjSgndeBVJCL642E2vkMEWo6+ByFu0=;
        b=MfGsAqa9B7p9gHgi6Xw3KbFr5mfqmvfnqIyEa9B+3luFGnDbik2+YKEdYA0OcUkki+
         0BGN0Sq0U63Hn0ebnOdhsM6g3nx8YLJymms2F1ORK7chOUONzSvn1th5h7TRumT3sr8N
         Y4szLo49hvU0ilZBGhmt7mmw46H09h097rJjz03yByHmYP0LQ+6Wg+JK5U7zRSW+XccV
         ikBmYx2d0smAx4TviOXp9kw+MOmWEu/s3I+xx4SRoOX+bwIoRTIz4nlg9btQJA3WC0xX
         yHAkLbOS0gZYsOALdWbT52HTRK6l1jaqsAs0F/OnoMZmcxM8m4d2GxTySIYwjckGX7qX
         CFSQ==
X-Gm-Message-State: ACrzQf2PzfjXt/PbGffrJE7iXWhbdUDgRm7ReVv5Ox6sC4y5lrVnqeot
        9BwzkDb++ETfpXn01e/Z/1O1DKi19KnoEg==
X-Google-Smtp-Source: AMsMyM6OoOktSTD1Fw23uTsgUrH0PmFTXNilTVufefPQPf/jlinvlZY+xyLFaHyjsIAy/Bnsj+EEDQ==
X-Received: by 2002:a17:907:6297:b0:72f:9aad:fcb with SMTP id nd23-20020a170907629700b0072f9aad0fcbmr25180217ejc.161.1665653567810;
        Thu, 13 Oct 2022 02:32:47 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w21-20020aa7da55000000b0044e01e2533asm12892979eds.43.2022.10.13.02.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 02:32:47 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiua6-004fgF-0j;
        Thu, 13 Oct 2022 11:32:46 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, --cc=avarab@gmail.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 1/2] notes.c: introduce "--no-blankline" option
Date:   Thu, 13 Oct 2022 11:31:49 +0200
References: <20221013055654.39628-1-tenglong.tl@alibaba-inc.com>
 <20221013055654.39628-2-tenglong.tl@alibaba-inc.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221013055654.39628-2-tenglong.tl@alibaba-inc.com>
Message-ID: <221013.861qrcm5kx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 13 2022, Teng Long wrote:

> From: Teng Long <dyroneteng@gmail.com>
> [...]
> +test_expect_success 'append to existing note without a beginning blank line' '
> +	cat >expect <<-EOF &&

Use <<-\EOF here.

> +		Initial set of notes
> +		Appended notes

We usually indent the "EOF" body the same as the "cat", but...

> +	EOF
> +	git notes add -m "Initial set of notes" &&
> +	git notes append --no-blankline -m "Appended notes" &&
> +	git notes show >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'append to existing note with "git notes append"' '
>  	cat >expect <<-EOF &&
>  		Initial set of notes
>  
>  		More notes appended with git notes append
>  	EOF

... I see this test might be an odd one out, so this is fine.
