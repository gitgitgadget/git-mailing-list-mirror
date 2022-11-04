Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6957FC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 22:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKDWNQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 18:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiKDWNP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 18:13:15 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B630A24BFE
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 15:13:14 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id m15so3294028ilq.2
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 15:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFMVknhkIegliqgO+RLq7Ge8cXdEfA8fIRbLODyTKU0=;
        b=5x+kFq9myvs5hZhrPk4/c0YIJPkYp0uqVEfKLjOIutRrSK4xcYa9RjX2U/FpB0w3Q5
         FFZe1ZyDvbI2Et/cVvmQuqkFJdNr2lGYlaI4rQda+x0UJ3FU7vnPeXSLfh12Tx9D0vso
         BO7yXiWcXnvvLha4Rvc4MevRjdDODA9MRGosoqE1MmVWP2p2/l101wt148Y8DVeIImAz
         xkWenazw1GdRe0l1R5liLQZYlOxx7flkA57Ve1EYoFoOkVW4mbGkcHvYv7BeM1hDMUKp
         MQNCA8mWSui/LMl1gLwZ+IYp+fqwAFDnwy/6UwMdqQzzmUdBL0DeDDNX3gdQmTWOZq9g
         xBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFMVknhkIegliqgO+RLq7Ge8cXdEfA8fIRbLODyTKU0=;
        b=y0ssmidC9VXP7+EZUDvduDv3u+7Tsh4DSz1XysHpW7Y3kIhAVZ9B5/XXfnjicvfbAu
         le/gl9/UvY0nUv7YrXZK1wgnxYivyUahj5j25lqYsJmbctxaZPPkCi+eqimMO1tvYvYH
         DYoB/RH16M863T9JqPYvCQbxWFMA9x3RL4PXGO69m0bBFa/DjPJaFoALm6MxvuWL8mAM
         rw9MD+cRqcppxy7M5oL6SqI+pwbaslz9su+h3TvgxTozbzeCDYBV6CYZc2ljkLuEzQ3X
         awG3Cy/F8ExtjLv1RH3Wep0E+I7oEmjA9X8CywLEjjRwIBpcJw1uXlpnhuOIvgel2Sek
         +pcA==
X-Gm-Message-State: ACrzQf33UFog2h7C6ReampK/Q88J489kjHYlD4qWU1M5Li5jlrxDyl1T
        vgTnKmzWo+t2GQNhTGDrfzOr+A==
X-Google-Smtp-Source: AMsMyM7O/tHoJXeIdG0sGkv95xg65Rznixt5SlwzqnPOJ9AZALZbyWF2jqwzeMr/cNlg5MMLYH+Q9g==
X-Received: by 2002:a05:6e02:4c7:b0:300:8d6d:286a with SMTP id f7-20020a056e0204c700b003008d6d286amr22040997ils.164.1667599994038;
        Fri, 04 Nov 2022 15:13:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p6-20020a022906000000b003585ff0233asm55262jap.150.2022.11.04.15.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 15:13:13 -0700 (PDT)
Date:   Fri, 4 Nov 2022 18:13:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 0/2] pack-bitmap.c: avoid exposing absolute paths
Message-ID: <Y2WOeClE+E8C0hiP@nand.local>
References: <cover.1667393419.git.dyroneteng@gmail.com>
 <cover.1667470481.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1667470481.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 11:17:08AM +0800, Teng Long wrote:
> From: Teng Long <dyroneteng@gmail.com>
>
> Diff since v2:
>
> 1. trace2 log will include the path info of pack. not only "basename".
> 2. A new commit which removes unnecessary "open_pack_index()" calls in
> "open_midx_bitmap_1()".
> 3. The patch v2 still base on 2.37, rebase on 'master' to prevent conflicts.
>
> Thanks.

This version is looking pretty good, and I very much appreciate the
rebase onto 'master' in the meantime.

I left a couple of notes throughout which I think merit a small reroll.
Otherwise, this is looking just about ready to go.


Thanks,
Taylor
