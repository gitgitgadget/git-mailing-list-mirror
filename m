Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA1CC77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 19:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjDSTh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 15:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDSThz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 15:37:55 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD255FCE
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 12:37:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a677dffb37so3214735ad.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 12:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681933074; x=1684525074;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okSQd8Fqti3ndg41f/Zr9P1sLiI3CVVoJ7bnoD5ifbE=;
        b=MW+f/EXTYqIReCjDeqp1f/QA7ENrqIN9oz66hZSoCKti09PYnUa16cBCnDTweYbv+g
         3mdQBbFhGaD4zIdEocyJaG7Cq1X4tQ2zjVomNfUtqfdTsjZLJsU3buMoW4MiVD7nsh58
         FTt2nm5NwcQ+vzVeL3Q7vwomA1tvSR94NLBpb2gCe0sERWjd8UlyTDjeDqRODLmZdfdM
         HnjnmwfIGDVv/y0Br8GjophD9uCrE/clPRhaF5MiFvfORchgl7TaORn1zv5n0d7K5d1s
         q3p5F83wz7sbgQQapY8EQUBoOgoEmee1YWjTeNvzE19IPjHfbQfa5zJGYDNNwzonsck8
         grig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681933074; x=1684525074;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=okSQd8Fqti3ndg41f/Zr9P1sLiI3CVVoJ7bnoD5ifbE=;
        b=VqsKSuhjEjSOqjmKNryiU+wLZIazI8iRnoRKtK27A3mt6FbweI8hZzlQbyoAfXqpl7
         64YsZjEKQa4OgqzU2LhvabT841OZl8WeGcUEWdKPMDkHh82iZJ/FG/QYrP70u3PJe5QJ
         lYXE3GqEXaPsFZCMIQ58MU061E7YjkeTa4/GpSTCXtpYejbX78XfXlY0Xe6030jXKhYa
         aYLMtLNmi+5z/f1ibKqFtOB3/M55cw/Kpx2hd08mB4MoGT68wtaMUYS4g/5+IFPiNt15
         yAxA+kEAHzN4tdmFlnw/Bddgy5Jz6p98MmE9QoDn6cc1KwECjaErn23eAwv4uytdPeYY
         nt3g==
X-Gm-Message-State: AAQBX9dFoGV9hQhB3LPVLg1l3JjCTUENEkhbgTcrOjLG6aKoGuNGQajq
        /jR0P2+YKneqkl6rXlDYPweUEnI2+oU=
X-Google-Smtp-Source: AKy350ZScHkF5s4+Qxl+7hkec9Sy6u/MU4p2C/ADiYgrnHOEQ6JhOvPKmyWakVg+0VZn/RmQxOuI8w==
X-Received: by 2002:a17:902:d489:b0:1a2:185d:4eef with SMTP id c9-20020a170902d48900b001a2185d4eefmr7453438plg.10.1681933074459;
        Wed, 19 Apr 2023 12:37:54 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id jw20-20020a170903279400b001a5023e7395sm11706446plb.135.2023.04.19.12.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 12:37:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] doc: git-checkout: reorganize examples
References: <20230418070048.2209469-1-felipe.contreras@gmail.com>
        <20230418070048.2209469-3-felipe.contreras@gmail.com>
Date:   Wed, 19 Apr 2023 12:37:54 -0700
In-Reply-To: <20230418070048.2209469-3-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Tue, 18 Apr 2023 01:00:48 -0600")
Message-ID: <xmqq4jpb8xyl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> To simplify things for everyone (the reader, the writer, and the parser)
> let's use subsections.

Makes sense.  Queued.  Thanks.
