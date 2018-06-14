Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957941F403
	for <e@80x24.org>; Thu, 14 Jun 2018 19:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755204AbeFNTnK (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 15:43:10 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:40976 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754783AbeFNTnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 15:43:09 -0400
Received: by mail-yw0-f179.google.com with SMTP id s201-v6so2553510ywg.8
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0cqGNAUPH1f4EmNNwMACQkVrN+AjhBL0goPlD09HjQ=;
        b=qDwsLtz1lI3HQSAZcBeQkxShyGCbbrEYhoCsd/ZvuxafyzQICCcsdNiJQiOqLWo5ss
         2pBW7oIgC1lrYVglTgjoDwEsVTik7dyzTY+MQfYDRgL8cXXhNEjGDxng9K5+AmUBEve2
         UiadPNqQ0iBEFfhAG2Avalmn4aDOLiEl0P03077gu+wyBlHqeRPReglHuv5TCoKqe6TP
         6ETRGCgrYAKORpL+TZev+PyKQkFl4L1sporl2njnNMhTm1R4vZ+6SZwG8uioPMgwB38R
         PQrtgaEu3DPsmFsGcbfjK0k3wd3VyFyqTTE9shKDDKZFl47p23b242l01bQYGXkh+R9l
         F5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0cqGNAUPH1f4EmNNwMACQkVrN+AjhBL0goPlD09HjQ=;
        b=IFpJGVJb+OAWlRddSwy1ATofbmJcEKJvsiY2hK7pK9MdkJwmhgiFj+r4+9zccz5jvE
         0N+g3i0fjM3lpgO71tOzxykmstvUrJ9l5QU/Gyb33kmMueM4P+RhjtDNlx40lFjVShIK
         jz/ybP6ZA/c+39uS9Go6iNFUygHiMSlf1oGXGv4QHDs9FdPzf3U0WgHs++E9hxSLItNU
         L2n4E9WpCziyEcaAIHVKwOSlW0I5FWiN/EjEyQGKUnM1dseHN+gE3mDCp9U0vK3oAONh
         OiWmuNTUGrJ+tTUqij1cCTXiZwLfBZwh3u0PKEUXqR6u0WZk7OrF/r9I2TaJf5svQrFo
         Gm3g==
X-Gm-Message-State: APt69E1AlmlNkC3ZI5Ug48yyKHk6DqGXJaIRvpwPUkUUpJA/TVkO7SSB
        8IN3t+KLWajNcsCtdsPoiSKKud2akJ+mhXBzFOwzOFJy
X-Google-Smtp-Source: ADUXVKJIOtTEwBVmr5hIJ770WFbD0dE+i7+ktmMD5TgHuupz8fRigCVozn3Nm0C8XoKRpK0kxByMQPj0iL7RPNxZ4U0=
X-Received: by 2002:a0d:f442:: with SMTP id d63-v6mr2190645ywf.238.1529005388967;
 Thu, 14 Jun 2018 12:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180605175144.4225-1-bmwill@google.com> <20180613213925.10560-1-bmwill@google.com>
 <20180613213925.10560-8-bmwill@google.com>
In-Reply-To: <20180613213925.10560-8-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 14 Jun 2018 12:42:57 -0700
Message-ID: <CAGZ79kajvWONYio58ZjADfSNScO2BUek_5J=+WFDbR9X5chEBA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] fetch-pack: put shallow info in output parameter
To:     bmwill@google.com
Cc:     git@vger.kernel.org, avarab@gmail.com, ramsay@ramsayjones.plus.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +                   !oidcmp(&rm->peer_ref->old_oid, &rm->old_oid)) {
> +                       /*
> +                        * These need to be reported as fetched, but we don not

do not or don't; there is no middle way. ;)
