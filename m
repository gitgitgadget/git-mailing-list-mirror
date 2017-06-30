Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 309F8201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 15:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbdF3PGT (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 11:06:19 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34194 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdF3PGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 11:06:16 -0400
Received: by mail-pf0-f196.google.com with SMTP id c24so2800380pfe.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7ic3FGvX9DJAHTyI728BH9BG070a41/NwQzyZ3nc0kg=;
        b=VLVzlrN9EjeqYJFCOCmqUlXT9+Vn+IVHwMuS3D1pX1O0/rMAwogXxmdVhY6XSHVQjH
         78oNkyNah/aUnscxCwmdQybMoTQ7mLphQu4mY5EsKgwQ2Kf7wAc6mn62zBtokv+UY63v
         1CGM3x9XXo4YMeuAxP9nzJzHVv0WQCePiuHWWNGG3rlkf5s2dlhuFma0mjEgT4r5Rw1f
         Tc5zB4EcpmsNKfta0pYbFjda0XMJORNfzyIlH9ji6/V0RaJdAY8ok5gjj/vI32APqgo+
         O2UYEJPEpG/aQpJb1j8f0szXJKcfezTQs2+xrD9tfv/Puoo+P6PnNH6sSTP3yCks83jF
         27vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7ic3FGvX9DJAHTyI728BH9BG070a41/NwQzyZ3nc0kg=;
        b=TWGXoCqrC9i6beD7tEoRFpXVJkUObVxBRO3rywqfPNJzy2Tvfs8gKY8vQ6PgOI1aL/
         J6DBcqgCIBhEWMD05Z8XCbqqfaZdtl0oUnfMgdOc6nmWXcrSgCm1+X6oNYNNZt7jywau
         s3/drbH+ZjDtaUXrXIDrT56xBXz9vuRKJFfY3FsUpiOKOLMoI0/n9WvF1dPMyDKK/4+c
         F9004/nZf9ZbSSXS8Ao+lm6GzB+TcZRT5A0FzveVLFXJ18clMlzgX0HFDUP7VHMUZ2pp
         LcR6bbUlQmR/z7rF74R3cQczkK9nKubcHaV5UmXS9mxbdVvRgA7Mp1GaJBlHNsQRY39V
         0IVA==
X-Gm-Message-State: AKS2vOxszAomY/jkKErE0b2P0+EbRwiohoWEWEiEO/ur8eDd6brC1CiN
        QYUvSp+m2OspP8EaZrA=
X-Received: by 10.84.233.204 with SMTP id m12mr24855966pln.292.1498835176057;
        Fri, 30 Jun 2017 08:06:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id 10sm18369737pfj.61.2017.06.30.08.06.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 08:06:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/4] Move unquote_path from git-add--interactive.perl to Git.pm
References: <20170622102622.26147-1-phillip.wood@talktalk.net>
        <20170630094912.8653-1-phillip.wood@talktalk.net>
Date:   Fri, 30 Jun 2017 08:06:14 -0700
In-Reply-To: <20170630094912.8653-1-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Fri, 30 Jun 2017 10:49:08 +0100")
Message-ID: <xmqq60fdtt09.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks good.  Will queue.

Thanks.
