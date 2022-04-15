Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D74C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 05:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbiDOF0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 01:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiDOF0M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 01:26:12 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28A45DA69
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 22:23:45 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 22so133133pfu.1
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 22:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lr60c839D2nsz95vV7ZIulfhFACAklhEGACwqKfvE4A=;
        b=VayPxV4o6CCYbGqzo2ZqwCGRYcrVuUkYVWx8aDbQJKpYevS2kpHsP3xIAeYnA915FH
         VmaawK83IN80kGN7ps1LXSfg8lG1XO4HOpJvtnLG0K6ZVAJz2pNPKmWBhmmv5WsQcHyq
         k1nnEmSFev1yAd3EghCcxG8n/LOjWyVy2KvXHkZG5Ih7VJIqGAV1EaSP7oG7bFWED2tH
         0GaRdv6fqBUuoRqmwfdUisaZpx5XJbjCNPFV9ldZV7XEmGxS20O4hEuMe7QovGHedA7g
         xgi4v/DFBXXz50/EEgqL/NLrAVlCOfpFMjwGBLFYoTFGZIf80FRQ6O1ts41KOxpLsomB
         NUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lr60c839D2nsz95vV7ZIulfhFACAklhEGACwqKfvE4A=;
        b=OlcGY4g454ZZlCfGYtDuIczwJmsZI9D/ODm5fNAi+QvZ+oux/RDkrA4sof4PqBrF0y
         4VioTfF5/C5k4ZOUi/oi5z0hH+wkOPqYAvcByiJkOlLjaXccWcEiyGhsFX/akpctJ4/4
         y2MEllwsnABfCF6hzbUqiQCmP6abxNdFiqeO2CMyO4RMJ5mbRREBCqgaqPsWNhy9OtYP
         dCoqaKY4HxTT/dlvACryPXrEgXNfr7wycixdlgSxtgejP0/G/2l2DmYcF5ryiuaRvR/7
         t7yAvJQiYYGS7PzQ8M2xXIQzrwpB9G993hX8AyNZjonGZw/Csz917QJRIc03MYtxbcr1
         VjHQ==
X-Gm-Message-State: AOAM5338zssGwqccLNVrZw5ziO2hMKOkV/y4jDy5O0jJaLiqADsFKkJ6
        rsTMe5cK1H7/3956A8U7kpsuJA3zS2g=
X-Google-Smtp-Source: ABdhPJw1NfkP29oQtV+V+2Wl7QuF5OqYVqpqE6qOelwLVEr++PWccRGMt4VFC9u/DE4FupM4T1CvfA==
X-Received: by 2002:a63:a61:0:b0:39c:b654:b753 with SMTP id z33-20020a630a61000000b0039cb654b753mr4973916pgk.117.1650000225192;
        Thu, 14 Apr 2022 22:23:45 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.156])
        by smtp.gmail.com with ESMTPSA id r32-20020a17090a43a300b001cdbda883ccsm3773283pjg.38.2022.04.14.22.23.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 Apr 2022 22:23:44 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [GSoC][RFC][PROPOSAL] Reachability bitmap improvements
Date:   Fri, 15 Apr 2022 10:53:19 +0530
Message-Id: <20220415052319.49380-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <0179a76a-182a-0501-a4ae-800ddb53b8cd@gmail.com>
References: <0179a76a-182a-0501-a4ae-800ddb53b8cd@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:

> Rather than deciding the plan in haste, I would recommend that you put 
> some more thought into deciding the plan for your proposal. Take some 
> time to reflect on the different parts required for the project, 
> potential things that might interfere with the project etc. This would 
> help you come up with a more refined plan.
>
> This might need some deeper understanding of the project that you would 
> be working on. Do feel to ask us in case you face any issues with this.
>
> Also, you could use Taylor's suggestion as a possible starting point for
> the plan:
>
>  > If you end up working on this, I would suggest budgeting a week or so
>  > to try out a couple of different sub-projects, and then decide where
>  > to spend your time from there.

Got it! thanks! Will do as you suggested.

Thanks :)
