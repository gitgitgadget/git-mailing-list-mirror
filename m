Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B866EC43464
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 01:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 708BD21741
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 01:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600479883;
	bh=tbqAmanWmgz1jZOvcPbRNz5io3zja6FBugyWUbut6i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Aughq5qUw5sYp2QgJT/J8OMP5lnFAXKEKmQzmbhZ34ffGa+ACQ2qkTNpj0Tm+sMvE
	 INDJAUcyaKb2hrQ3PDG/LPZQT29vC/4QgHvTR79prhMUCfQW9P+MlBKk8F1qjS+ag4
	 HbzI0ZZkK+4LGZ6frB979ByIt9H1ou0fPkEBfh+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgISBom (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 21:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgISBom (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 21:44:42 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F9AC0613CF
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 18:44:40 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o5so8473621qke.12
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 18:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lPNxGkOrqMnzHeDoUkT/6gOpobVrxoYHAog/r/o0k/8=;
        b=I+vD+/HbziObfJAgUiU/IMW24/17NJ+Q4bbd+58dZvPPJUKC/tHB4jFWZWLGUw6Vk+
         0mJmOnINrdB2D5ckZKvosGTqIpOjmECxDccmr+mKCWcQNr9kTlu9j+DWnArKe8NJzq+p
         FHaOiuAOEM3NBbvaWUgNOa6cOgzw0NaMtOCU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lPNxGkOrqMnzHeDoUkT/6gOpobVrxoYHAog/r/o0k/8=;
        b=S68OccHc+zgmJq/vCa45pZisoAtkTVUAfnZR2fII4Fjp0bpRAPMKf2Qb7LPZdrWAfz
         4FapjBA5JOidqSXIUJgY7crZ+J4Hvo+ME4s5Tbl78+RRCMnoHP5JveBfjGNnJvbIHyVv
         DATSrv8ZsYMkg7HqLgv4Nc2BrY7eSHhCrkCorIttSjzJr0cPMDYNokWFylb7a8Qbatjk
         6eqMLvzB8BCfMiCql6RzMiSbgEmlwQ20kdDCsMEdcyc7+ofLWwX/Nzhqyss598niweWu
         TNC9gB1PBaCiaVyDVOcEc+KZ6/C+0+a8ZrnNDmbs0RUvC6kQAZz52KUWcLqMftl1pgMn
         rAnQ==
X-Gm-Message-State: AOAM5307C804+eAq3wYErQh8lcK8qjlwe/TUf5V3MkPTFPPA91EBgVNt
        OvBxpyOwbVs90PufF5AOtVAk2Q==
X-Google-Smtp-Source: ABdhPJxtOQ9ORZfdzILdh4mmw5spIyIDZLlzp/AWBy10U7zp9tIy37AhVNaEyDpKtGmxpz1grXvJug==
X-Received: by 2002:a37:a654:: with SMTP id p81mr34884191qke.255.1600479879890;
        Fri, 18 Sep 2020 18:44:39 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id k52sm3491941qtc.56.2020.09.18.18.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 18:44:39 -0700 (PDT)
Date:   Fri, 18 Sep 2020 21:44:37 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jeff King <peff@peff.net>
Cc:     Aaron Schrab <aaron@schrab.com>, postmaster@vger.kernel.org,
        "Kerry, Richard" <richard.kerry@atos.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Has there been a change in Git Mailing List settings?  From list
 as sender to originator as sender?
Message-ID: <20200919014437.73xen2g4mcbqawdl@chatter.i7.local>
Mail-Followup-To: Jeff King <peff@peff.net>,
        Aaron Schrab <aaron@schrab.com>, postmaster@vger.kernel.org,
        "Kerry, Richard" <richard.kerry@atos.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <AM0PR02MB408170D1A71FB8C0E82A14789C3E0@AM0PR02MB4081.eurprd02.prod.outlook.com>
 <20200917130139.GB3024501@coredump.intra.peff.net>
 <20200918225326.GA1367@pug.qqx.org>
 <20200918232805.GA1197580@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200918232805.GA1197580@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 07:28:05PM -0400, Jeff King wrote:
> I don't know, but we don't really admin the list ourselves. kernel.org
> folks do, so they might have input.

You cc'd postmaster@vger, which is the right set of people -- it's 
managed by a different crew than the rest of kernel.org.

Best regards,
-K
