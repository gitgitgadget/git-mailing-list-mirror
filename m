Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7B861F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfAXVzB (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:55:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36903 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfAXVzB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:55:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so4685679wmd.2
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 13:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=y2Nguczt5aV+l45PF9tcu1wq9MwmzwWx3YyNF1HGnoE=;
        b=i9+wwlAGBsKGqb4OM9HtyNuq7Xzr/P91kDxqjIdvuXKJ815nlMFh/tAwtPpceX9r+t
         mP8FjIdLSHUID1zrtW7fPGDL/s21oWv436l8i9oZZWCbmYx1qJiC03SCiiaKvRqWFAHv
         sPMT1nOPqAwWScYauxNnEaKig/LvU1SM7bY468kVCN8aD0VC7oDmeMRkRblwb3fIxZFS
         TWag3arUy8H8BqR6x6sBO7GOnEHj0qWTxdKIMJvr/4adyiPSaoBIc9SiEfwko+cmFzj9
         lmdlpqdiaBa2UbPbuhNNDOidZJC15fuZywuaxe0jwXNM8+ZGhJCdAmXONMvwSEEKIuCS
         GM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=y2Nguczt5aV+l45PF9tcu1wq9MwmzwWx3YyNF1HGnoE=;
        b=gWr7iDEsa4jP7OhaPArhhG9JU/0J0JBe0YsjTTEQ0Wb4g6waC78/naHpttKPZTqVJx
         8E9qCFoLtSxSdKobSbwzE1SKkLbOl5o59RueoNiyeDAJcJ+1FL3GJtET0MlIIwK9Ojmy
         fM+pSn7h+EAoinaM7AZak6rbZdFyPQ0bF4VwsoLTYNfK+KJiA1DZtnp2WpTZUWEaCBHV
         ZAOYilxjJ1Aua99W1XjlMGwFq32+UgSORJSWEyF6WXiQV0QPz+Ny0APUG4D4S8iIeRzK
         1xEyvTR2BxslXWzLxyVQu4v4wDTDasnqRpbMr/LDYMXsnmS1XwDG2ZXWwixNxu6fjxwS
         up1A==
X-Gm-Message-State: AJcUukeRaCeqSRKUjbmHDPkM6EtpPp1HZPZGOKdRdJaNG00WyngFOi4z
        y9kBJeb8DJC/oL6q8A/YC2p/Gj33
X-Google-Smtp-Source: ALg8bN6v+GZEPS0aFMQup9DL0yHpkDSJ1Q6HIyNRo2gNuAfCjKJ5p74/NLaaodMRa68ne4ckhvuI2A==
X-Received: by 2002:a1c:ca15:: with SMTP id a21mr4071912wmg.132.1548366898989;
        Thu, 24 Jan 2019 13:54:58 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w80sm90119524wme.38.2019.01.24.13.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 13:54:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 00/16] sequencer: refactor functions working on a todo_list
References: <20181229160413.19333-1-alban.gruin@gmail.com>
        <20190123205821.27459-1-alban.gruin@gmail.com>
Date:   Thu, 24 Jan 2019 13:54:57 -0800
In-Reply-To: <20190123205821.27459-1-alban.gruin@gmail.com> (Alban Gruin's
        message of "Wed, 23 Jan 2019 21:58:05 +0100")
Message-ID: <xmqqd0olhgb2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

Before I comment on anything else.

> This is based on nd/the-index (36e7ed69de, "rebase-interactive.c: remove
> the_repository references").

My attempt to apply these in order on top of that commit seems to
stop at step 5/16.  Are you sure you based them on it?

Thanks.
