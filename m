Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19B2EB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 16:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjGRQlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 12:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjGRQkr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 12:40:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237A0173A
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 09:40:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c850943cf9aso5075594276.1
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689698437; x=1690303237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R7wMF/hSCLnv/bts1hodY1iqsPIllefmFtXVh/AmACE=;
        b=EU657MioB4C4ZqTaFX3/1wkW39UJQ93XaqTBvPxgc2z6UERSFStyUPIKuwLjxA/RnV
         ZpWm1SpOA9Q8HdXayKOTjLuj7TlV9hs/FFqibj83JQF1JoeILr3zgpFBw70/xN9rqBmH
         eTQOpQRao+hHbFCA+2ZjAyhmFfGGLvDJ+6iipHnG+aIXhD2QqYBr4sYGpV3b3B9hcGHP
         16WD9yBywlSgK9UQG0ZDfs9NtQKk4nnaAjeyXZCnQFC10hQo8kV7sYQ2xLpu0/OIBHup
         zAgO2rwvUyToNAZ0ykeE7wBQGylG3WjWQqcmDfx7OZ75EDUnuiqbficsgj5Egwp0bGs9
         wP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689698437; x=1690303237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7wMF/hSCLnv/bts1hodY1iqsPIllefmFtXVh/AmACE=;
        b=DwhEPUU1gZks4aVyadcFyWU0aR6hfXAOE3jcIQzr77N7Ae+6bo8mhYcwseXSfTxqRk
         cSRtNydYR3WdrauRop01fFkHuu95HuO4WGUHCo1cif49JoyjHhn1tY6ylTeSdNwfD1MC
         6Dqyo0BQewwmFpH/C5aKVaVoPtXTX/tlOlx+G+izGW/4roAeG9SRhHBut3Dex1QM5tVH
         PyXrmzpMTwi6DgDUcjlIKh73J1OOttQjTgrRpcnbSrFJeD++YAN3lQzS9+LBhALi/Kpe
         ThVZuHpIYnZ3VXvMDAz+sdzfTK1vNMeF84tsiirONQ1TSmanBpomoZ0q6Kjn4hHjhve2
         nGjw==
X-Gm-Message-State: ABy/qLZtUTvz3TDQEjGtVudIMxSqO+Pw4sE3QZuSAx6UkVvx7Dr6b5OK
        tjVpk6HptgTuy8N+KMc0WCnP6jsgzZWNfEq5+VNNbiyaNQEW+I233iQlLCTw+W8eF4tbEwnJPwS
        fXCAx3gv8kbfeTznidZLp/xTBipM6fNUFSIEVnz7w/HQQelQ3praahAJs1Z7hVX4=
X-Google-Smtp-Source: APBJJlGFb6MuQqmt28M/kt5bQEGcPUIFuthNe8+ND1ZmEiedOynQRBYCsK9FZ9X9veGyG9ywrcRG6XMZ4iFTcw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:ca41:0:b0:c73:9cb6:3cb4 with SMTP id
 a62-20020a25ca41000000b00c739cb63cb4mr4098ybg.10.1689698437064; Tue, 18 Jul
 2023 09:40:37 -0700 (PDT)
Date:   Tue, 18 Jul 2023 09:40:35 -0700
In-Reply-To: <kl6lilai18zu.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lilai18zu.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <kl6lfs5l18cc.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: Join us for Review Club!
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Andy Koppe <andy.koppe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Review Club is happening this Wednesday, 17 Jul, 16:30 UTC. You can find

Correction: Wednesday, 19 Jul.

Sorry for the mistake, thanks everyone who pointed it out :)
