Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24E2C433E6
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD47225AB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgLUSk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgLUSk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:40:58 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3BEC061285
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:40:18 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 9so12253021oiq.3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=GZwy8P+Y0c9OBD3bew8eDRxdpTvK4CEhUIF8IHQTr+I=;
        b=e9yjS4XcunqFNmWtUf80ay5lWF+i6TifHbbkVSgeEwyLnux1iQu1bDQZFc2thC6xpu
         vbMPN4/14dQ0zgpiSkmmIlM2NeJlULlBuaxxOW0XRiKkCOth1B6FpvU1rf/zJtD18d4s
         LUixV1LbFfGQp55ayvWDKjakbh3kyTA2j9fL0M0jmtCbZ9gmV8KUWucVeMvk6nZHYtki
         0YeqqVpAB/p0S3suZv57wbViymSmy+baJGjG7wwLPTXE/28998E+Q+YOOowaG179ytDo
         Sh2/ekRh07cZoOC97gav9Hhak714w1HUecVilEFtRPwq/SEbRTi3nQW8t8xI6aDijDGa
         gXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=GZwy8P+Y0c9OBD3bew8eDRxdpTvK4CEhUIF8IHQTr+I=;
        b=pk1tsCW8iOIozKRt3sayeAy2IQ16vndOow1XofNIGvrQStsdqcsOVv/MJcS6K41k1W
         kAxb11X1jmY66KXPtm9mWdZVzoSBOxCt4Zvp0+l1A82+OnqtKryNRsYfTfv3Frst1GD1
         DLf/pkVFnZfraXSpDscjwlTcBmac29z925xfSoWdkxlnAq8kRCmJhuiiXl8RlJx9xCM2
         0s/2kf1NWPu6xBJ8nqjKnM5IXB1ePua8D2Conpca9ABpRufv+oRKSKD8MOflcQm34Mhq
         9woeWD66z3xxWye7MDtjntIXj0eKg2rS4MILEdBAi3FMKaMHdGLBW6U+ufZDLJJAfS03
         or6Q==
X-Gm-Message-State: AOAM533lW3y/ZjnFpW87KeGGaJUJ44rD5SgEz4CMqwiRPTVFtAHsQ8pU
        DZQUOJlg4KhbOJk6YF8Zvc8=
X-Google-Smtp-Source: ABdhPJzXtzEytoFC+X3cGgvgzfHfoFb+nhe2agSN2gFZHD9jCsovDnGSwayYQAb8GeV9fS/00oIqww==
X-Received: by 2002:aca:f109:: with SMTP id p9mr6910439oih.8.1608576018125;
        Mon, 21 Dec 2020 10:40:18 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id g5sm4043592otq.43.2020.12.21.10.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:40:17 -0800 (PST)
Date:   Mon, 21 Dec 2020 12:40:16 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Message-ID: <5fe0ec103ad4f_e6ff208f5@natae.notmuch>
In-Reply-To: <20201221152000.13134-26-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
 <20201221152000.13134-26-sorganov@gmail.com>
Subject: RE: [PATCH v3 25/32] diff-merges: let new options enable diff without
 -p
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> diff --git a/log-tree.c b/log-tree.c
> index f9385b1dae6f..9f50a81e537e 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -899,15 +899,21 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>  	int showed_log;
>  	struct commit_list *parents;
>  	struct object_id *oid;
> +	int is_merge;
> +	int all_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
>  
> -	if (!opt->diff && !opt->diffopt.flags.exit_with_status)
> +	if (!all_need_diff && !opt->merges_need_diff)
>  		return 0;
>  
>  	parse_commit_or_die(commit);
>  	oid = get_commit_tree_oid(commit);
>  
> -	/* Root commit? */
>  	parents = get_saved_parents(opt, commit);
> +	is_merge = parents && parents->next;
> +	if (!is_merge && !all_need_diff)
> +		return 0;
> +
> +	/* Root commit? */
>  	if (!parents) {
>  		if (opt->show_root_diff) {
>  			diff_root_tree_oid(oid, "", &opt->diffopt);

FWIW this logic does make sense to me.

-- 
Felipe Contreras
