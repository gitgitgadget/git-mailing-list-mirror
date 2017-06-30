Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E31201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 23:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbdF3XIq (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 19:08:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34427 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751322AbdF3XIp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 19:08:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id c24so3918918pfe.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 16:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=T3aIh4/mMNX31qVoOmwET8liAVBCYVnLvyebBJy1aO8=;
        b=gD6ONnSA1IiBuCHoetjn1JX7kvxw+s3/Iv2wz32Z18mdBJDCrrBV5xTyhKulnN4H+U
         v5H9iMogEDxgQGUtSXdtK79GMoS/M69Om3hTRt09KUyMbdN5EPpX0dC5elHF8ddMIKmN
         mwpn+oyuxM40BEOOEJeteux/otZEo3/uinlSBZ0mCd4T2/pa7zoiTO5yru0wlCMTtmu6
         lQAxI5vl6sif8HZ9StZO4WHa4j5xpsrXjLiku+MEZN3TG6RM4ptTfrPz2fip4AAHxOMl
         0+tfGTAnXfvXrHVUH44L4QKgaNeiN8TFIcLhzQfsLE7wvcY2q4FULbWNJf7qAwt46XMY
         bpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=T3aIh4/mMNX31qVoOmwET8liAVBCYVnLvyebBJy1aO8=;
        b=IhZ5VgYxCG6DoSxt3DbNslxT7BcDtw8ZqMcBNjvm09GaOpfH1Cb7KuQlwjTBYhjPz4
         BbgNlKCnJkqeo2LaqnvXJau9pckK9focXB4y6aG1dAzynhTghQ+RSyK6JzzAYQ+8d/4m
         VDo9q8xAxT4fzx0BGWwHB+l5u8aKwhlnf/VHpEhYcx/ioWeBqqTXlGKDipzN5G4Kc/dZ
         8wJTXYWa4THepyDV8mfC151lTMSvCSgsNMbKWWRjAfzJxWnctaaSfX+0AeC+S/ND8j5V
         wYJ4fSd9o3MkQwHigrpnvdCndPn9+/8+jTNzGYPkoRx2eGjxJ1869SvYCnR68rTTNxR3
         nDRA==
X-Gm-Message-State: AKS2vOyWvZTOnfEq9dDpiUMFPAwwn76RTxPoLtblsU5ZhWWRGBHa0lpg
        yKVHYuZebXuitg==
X-Received: by 10.99.112.13 with SMTP id l13mr23169324pgc.199.1498864124785;
        Fri, 30 Jun 2017 16:08:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id t67sm18861245pfj.98.2017.06.30.16.08.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 16:08:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH 4/5 v3] submodule: port submodule subcommand 'status' from shell to C
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
        <20170630194727.29787-1-pc44800@gmail.com>
        <20170630194727.29787-4-pc44800@gmail.com>
Date:   Fri, 30 Jun 2017 16:08:42 -0700
In-Reply-To: <20170630194727.29787-4-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Sat, 1 Jul 2017 01:17:26 +0530")
Message-ID: <xmqq60fdoyyt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> +	argv_array_pushl(&diff_files_args, "diff-files",
> +			 "--ignore-submodules=dirty", "--quiet", "--",
> +			 list_item->name, NULL);
> +
> +	if (!cmd_diff_files(diff_files_args.argc, diff_files_args.argv,
> +			    info->prefix)) {

Essentially we'd only want to run ce_match_stat() on list_item and
the current on-filesystem submodule.  We not just know which path we
are interested in, but we already have the cache entry for it, so it
feels quite wasteful to go over the_index.cache[] once again to find
the cache entry that matches list_item->name.  Yes, that is how the
scripted Porcelain did it, but it feels way overkill now we have
ready access to the lower level machinery.

Having said all that, I think it is a good idea to stick to a
faithful conversion in this series.  I just think a NEEDSWORK
comment may be a good idea to indicate future optimization
opportunities.

A similar optimization is already happening in this patch, actually.
Instead of doing a stat of "$sm_path/.git" and checking test -d/-f,
the code just calls is_submodule_initialized().  Which is good ;-)

> +	} else {
> +		if (!info->cached) {
> +			struct child_process cp = CHILD_PROCESS_INIT;
> +			struct strbuf sb = STRBUF_INIT;
> +
> +			prepare_submodule_repo_env(&cp.env_array);
> +			cp.git_cmd = 1;
> +			cp.dir = list_item->name;
> +
> +			argv_array_pushl(&cp.args, "rev-parse",
> +					 "--verify", "HEAD", NULL);
> +
> +			if (capture_command(&cp, &sb, 0))
> +				die(_("could not run 'git rev-parse --verify"
> +				      "HEAD' in submodule %s"),
> +				      list_item->name);
> +
> +			strbuf_strip_suffix(&sb, "\n");

Likewise.  This is merely resolving a ref inside a submodule;
calling something like head_ref_submodule() may be sufficient
as an optimization and at least deserves to be mentioned in a
NEEDSWORK comment.

> +			print_status(info, '+', list_item->name, sb.buf,
> +				     displaypath);
> +			strbuf_release(&sb);
> +		} else {
> +			print_status(info, '+', list_item->name, sub_sha1,
> +				     displaypath);
> +		}
> +	}
