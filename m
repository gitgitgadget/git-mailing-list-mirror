Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8A6C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJQNdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJQNda (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:33:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3BB5283D
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:33:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so10967949pjf.5
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apPE3IDmhkRVb0GsCoViVt34VCJuGvPloYG3JXVSD0o=;
        b=cTn0k3qMQtlzCQty6dVAm2T7lwuvWsJykzf7TQX6uKrWbAwZmczsYnfbmi6ByzoBw5
         e/0WfNxrj5LZdRg5o59rlmHx4TcefeKyiySTit+DUdNHqpeSNP2AeqxBZDJWON+V5GFd
         c0PROiZbJ9vQ9r78QDvs9AQvbyzSaWRsZWm0/RgGBIidugtJPhzooApsaCW3vAwIA4sg
         lXSnyiBTX3qMvhbAiO+YwUwJBiHdb7z5tK1SgknVLGCXRQQBMfnqZAkmlOZOkiHaVyoA
         c7kR0S63EqrW2QcqbfFq+gWQD4guXCoiWZEDgJNrp4hVNQ/enRCeKIeOr1bHK/tH3My5
         LhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apPE3IDmhkRVb0GsCoViVt34VCJuGvPloYG3JXVSD0o=;
        b=cCdrqPKN8EtkT76cbApyZjsXMvgt7C8H4sSqGu+1rY2hWVA1+6Wc5wKZwwwvnhXYID
         9JEzKHiwHnGR9inCSAq7L77ebau1gBbfJAaljYivXG3MiDvDesmv3Yu4xrrjy3/JmwR1
         gTcivKVuWGb9ayc1WQsYNsngZcDlFJmcowPdCXG5A+kloxNEEilyCq9bIHuXKBjCRO1r
         ARDTmgbKnlpc43jfm2rShiJZTkHWzqJ3tQHbebV7kQvBNY83G+mjaTlVHlbMiRbSaMIm
         gy36d6y5aq3mLFLBD81uZK4b42WU1877cmnA9lBT+Lsl4E1wGyzP4K4Ri+eOwLchbtaH
         aAxg==
X-Gm-Message-State: ACrzQf03nJAMGSCflPmPpUyj5yHBy6F6chtJT5opwNwNhu7xd5+8lzMp
        aZgerlptwrgFUSqbjne0Vcc=
X-Google-Smtp-Source: AMsMyM6tjZVL7AGiepM62iN8k+PWX+gvtYBKQSfHQLt7n3/+EEASgAgkvNltkeB0DCtmM2V9pPxvaQ==
X-Received: by 2002:a17:902:e790:b0:183:88dd:1d30 with SMTP id cp16-20020a170902e79000b0018388dd1d30mr11941466plb.62.1666013609521;
        Mon, 17 Oct 2022 06:33:29 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.55])
        by smtp.gmail.com with ESMTPSA id x184-20020a6286c1000000b005622f99579esm7098736pfd.160.2022.10.17.06.33.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Oct 2022 06:33:29 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     avarab@gmail.com
Cc:     --cc=avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 1/2] notes.c: introduce "--no-blankline" option
Date:   Mon, 17 Oct 2022 21:33:23 +0800
Message-Id: <20221017133323.63330-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.0.rc0.2.gc581cb24b65.dirty
In-Reply-To: <221013.861qrcm5kx.gmgdl@evledraar.gmail.com>
References: <221013.861qrcm5kx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ævar Arnfjörð Bjarmason" <avarab@gmail.com> writes:

> Use <<-\EOF here.

As do not escape the heredoc, will apply.

> We usually indent the "EOF" body the same as the "cat", but...
> ... I see this test might be an odd one out, so this is fine.

Yes, the indent sometimes make a little confusion unless you want
to keep it as "<<\EOF".

Thanks for your meticulous reading!
