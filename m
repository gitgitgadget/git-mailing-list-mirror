Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0CB20401
	for <e@80x24.org>; Wed, 21 Jun 2017 22:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbdFUWso (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 18:48:44 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34478 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdFUWsn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 18:48:43 -0400
Received: by mail-pf0-f173.google.com with SMTP id s66so91351569pfs.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 15:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m0C4UokSDfL52LGzh+1tq2pn3wWdeMzsJgIQ58Qf/GE=;
        b=hekoDs4/hRSbo1AUeW09F3DTEYBMS9eJ3JWKcPP00r1sITLW8TPif6GfXG/tLuoz+H
         3242NDj7EuwnIMVMzIapr0na6hkt3nph5DkFXON/DAvUZyN+MDpa5hgD4lT3yJMvh+Xn
         0qlutiKKsk0khNF3I1/Ell3RyGLwgMxYnCkndfcBkv7KT0iCE+b8iisN6wKYKE51wjIp
         h6EWxkyCgxP+K9kKB5PkLrAMWcPrC7G0uQNhpPX9zCh2ontbDMUce8shbzl9xyEKr334
         27wt6qpPt167AcJ7I99WfFlIUVBDbjwTQDFPAGNvl+TITxl1b2JLD+Ey7djJdUTN/u77
         ZNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0C4UokSDfL52LGzh+1tq2pn3wWdeMzsJgIQ58Qf/GE=;
        b=Mqy4lk5OlmOYy+V65MRMbhfR1ep9Byq5sBxCRLlkcSpC5fS8tu6ZWiKibrtkZ/dPe7
         4vvx2htzr6B4XmvWT536XdmR51i/g3g+MRr0jJzkFv2DC/GRD3W75wCRtqMMAJwNebXf
         tSbrdFYbhQ16ExXxqUrjmZTVp14Vcf6QzvpF5CrkOfuLdr8rC2pqkGBw4LYloxHEP5oJ
         lnajM643xRzEzb/+um07sNWPLEms9PuK995UKq2nba9YtrP/UEM2V6T8zfGnOwfC66Xm
         gvc6HzaM+qROYInULHzpJQPIHuBKNOS0+XlsCddC+sbOlulnoQaCBbLehNJrY0AoWEas
         MWfQ==
X-Gm-Message-State: AKS2vOzmQooAghsfQkmPPsD9lJLUDpFZBrVdykLdWcMLD5PCGpzy1bfw
        GXKHPSviDGVOouzgcA8wHg==
X-Received: by 10.98.147.142 with SMTP id r14mr38431363pfk.168.1498085322400;
        Wed, 21 Jun 2017 15:48:42 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a12e:c584:e29b:1036])
        by smtp.gmail.com with ESMTPSA id i186sm32858212pgd.55.2017.06.21.15.48.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 15:48:41 -0700 (PDT)
Date:   Wed, 21 Jun 2017 15:48:37 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, peartben@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v3 20/20] ls-files: use repository object
Message-ID: <20170621154837.566b67ac@twelve2.svl.corp.google.com>
In-Reply-To: <20170620191951.84791-21-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
        <20170620191951.84791-1-bmwill@google.com>
        <20170620191951.84791-21-bmwill@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Jun 2017 12:19:51 -0700
Brandon Williams <bmwill@google.com> wrote:

> -static void show_ce_entry(const struct index_state *istate,
> -			  const char *tag, const struct cache_entry *ce)
> +static void show_ce(struct repository *repo, struct dir_struct *dir,
> +		    const struct cache_entry *ce, const char *fullname,
> +		    const char *tag)

This function is getting complicated - in particular, it's getting a
"fullname" which is, in a sense, redundant with "repo" and "ce" (but
that seems necessary for efficiency). Maybe add a comment describing the
function?

[snip]

> @@ -651,8 +610,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  	if (require_work_tree && !is_inside_work_tree())
>  		setup_work_tree();
>  
> -	if (recurse_submodules)
> -		compile_submodule_options(argv, &dir, show_tag);
> +	if (recurse_submodules) {
> +		repo_read_gitmodules(the_repository);
> +	}

No need for braces.
