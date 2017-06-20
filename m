Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFA3520282
	for <e@80x24.org>; Tue, 20 Jun 2017 22:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbdFTWXQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 18:23:16 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36752 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752477AbdFTWXP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 18:23:15 -0400
Received: by mail-pf0-f180.google.com with SMTP id x63so75574923pff.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 15:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+haqOBTZVwE6LsrsRqAyL9xJItGbxt8qLv+pEqXx/0=;
        b=M5N4EISSa62YZt7q6/98TioDEKwTK6Xtb+o7MvoWPgaswY11XMpo9sKm+8wbMHAtv6
         d5I1F1CiRIJejOjbeNv1qoNPyjGxvr7lMfukF5WdirUQK2CGsgXu8gcYyuQg5FwOFZhV
         O/zRdB9H/fZnE5l17Xl/mOVAUHGoQi+dtr3doucFivwsK++6RomZPDoVMj5tHhSuGB1R
         a6LQdb8iD+nsACD69kcfA7Vi/9NK8ZHlfp62uwjOaFa3fuGVHCye9/60/AMZd4yYUK1S
         5fTGQtdzR+koOlxFQsh51Uo/Z9M+V4vtsyeOMV85ekbu4Zd2iTsvQdzHWIWjHASdlk4c
         vnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+haqOBTZVwE6LsrsRqAyL9xJItGbxt8qLv+pEqXx/0=;
        b=VAvs71cLYwnPjTVmonJooVFUIgR9MYEGEFf4YnfAHUHUX06OPQQK5gEPgyQ8E1yxt0
         KAjbtTK0UN5BdZihkVteXkLC21RQfEaKfE27ZI+wJ9Kx4kwQRpyqizBTQXpfElAP86+o
         7aHPh26fanrGnEZlBafA4lOxq99iXSGEIgbesTszmT5drsfJD8RAu4pD2XO7CT/uNVsI
         Cdb4Ca4CLnIS9eVO0ZmgoZjMC1vq/gfdUWzuLpR1lPP+Ys7lE05J8O+3icUGCOpVRLMC
         pB3TOWb0ObO+AtUlHOAmIfGcn3OPnuwIAzu+KBCAEM8EVs/uxhLGOCA+C69YIkk52t6h
         cNpw==
X-Gm-Message-State: AKS2vOyt4TBaA+PW3rymgJ9QBd1S2bGxpKSqMoHomSq+WJ4TKLTxk58q
        sr2DBkUX0fNR4avi
X-Received: by 10.98.150.157 with SMTP id s29mr32742159pfk.172.1497997395008;
        Tue, 20 Jun 2017 15:23:15 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:6c40:b92c:899d:9917])
        by smtp.gmail.com with ESMTPSA id u1sm28155164pgq.53.2017.06.20.15.23.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 15:23:13 -0700 (PDT)
Date:   Tue, 20 Jun 2017 15:23:08 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, peartben@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v3 10/20] path: convert do_git_path to take a 'struct
 repository'
Message-ID: <20170620152308.42984ee7@twelve2.svl.corp.google.com>
In-Reply-To: <20170620191951.84791-11-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
        <20170620191951.84791-1-bmwill@google.com>
        <20170620191951.84791-11-bmwill@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Jun 2017 12:19:41 -0700
Brandon Williams <bmwill@google.com> wrote:

> +static void do_git_path(const struct repository *repo,
> +			const struct worktree *wt, struct strbuf *buf,
>  			const char *fmt, va_list args)
>  {
>  	int gitdir_len;
> -	strbuf_addstr(buf, get_worktree_git_dir(wt));

With this change, the get_worktree_git_dir() function no longer seems to
be used from outside - could it be marked static?

> +	strbuf_worktree_gitdir(buf, repo, wt);
>  	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
>  		strbuf_addch(buf, '/');
>  	gitdir_len = buf->len;
>  	strbuf_vaddf(buf, fmt, args);
> -	adjust_git_path(buf, gitdir_len);
> +	adjust_git_path(repo, buf, gitdir_len);
>  	strbuf_cleanup_path(buf);
>  }
