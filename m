Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04F471F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 14:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeJLVmY (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 17:42:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50269 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeJLVmY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 17:42:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id i8-v6so12381196wmg.0
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 07:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TkGNFgHRe9OGbZa81ZYmJl7HkGK0pVNMIm1qvMOMuvE=;
        b=CcM5ME+asHMIaq97uP+YFjEJle4dF6ZLBXz9DZxlBp2hpUehHYVPm3BkHalizIW3Rd
         9/b843mQLcDoGdN7jqYOUESoxGYDQQPUamTRB0qoNqrinGzNTmvnUPKNkKu3UMtTExX1
         upN9sHaFpPvw/Wvtans2SsYQkrJOMcbQV7jGD5SBsTAAN6WsI2F4aGMCok21SLZh7x3M
         zphBPyMXcj6ofHfxH9hx+9DhvXRo3PLLk2rdTuWtijKiLUWC6VDV1bXOnvLprp/jH9et
         SRQdbnOujZxb2MrsuDLr8svJI/wcNldEB8AMgThCtozowIqjpz2g2wjiyT63vaOle8tW
         IrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TkGNFgHRe9OGbZa81ZYmJl7HkGK0pVNMIm1qvMOMuvE=;
        b=q6B7AEpjnfmJkJXW6BetsgN7jou1jzMTZZO626shkDGozIsv20l6/KheCE3BXY7Z8n
         zO+tBRAgUedxtWP1YQm/Fc9NvH1fpk+zWrcs3G/V3JNmf8ifv08vRTtw+zWimUwzTNns
         zFEME8Rbo29gyzHbtuRyrjfrV7zbyUoFkFPNHvPz/f00qu9QDzyvHwS9lJToBGoEFI73
         D50LsEmfoMxdhAAtV8QzWTAwPOfaRV5BFnhqH63hDqjSthRR6CW4+IT7yxZnoYJaM+Ar
         ceY2hYWcawHNGBm8DshNTJc+RtJIU9F9gwyBvILumIfu+59au5VD/EwI0apyTR9rhN5J
         R9nA==
X-Gm-Message-State: ABuFfojgehppFFsEgZUmgowrtGKRq/5GOVvYWQpjb6UNSBiGu4/7BThd
        zd4f9swGgq11ZSjkoLM3MfE=
X-Google-Smtp-Source: ACcGV62OdGcUeHuGx/KPlJP7PVHKAUN2tla5hAggVI7nXEJARun+YkiycyMTrD7EYtIcL07Pa+u8Kg==
X-Received: by 2002:a1c:a1c6:: with SMTP id k189-v6mr5645543wme.0.1539353385518;
        Fri, 12 Oct 2018 07:09:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y76-v6sm1095361wmd.37.2018.10.12.07.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 07:09:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] rebase -i: introduce the 'break' command
References: <pull.43.v2.git.gitgitgadget@gmail.com>
        <pull.43.v3.git.gitgitgadget@gmail.com>
        <d44b425709d11eed833558c8bedfe4aeaa230e24.1539350061.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Oct 2018 23:09:42 +0900
In-Reply-To: <d44b425709d11eed833558c8bedfe4aeaa230e24.1539350061.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 12 Oct 2018
        06:14:26 -0700 (PDT)")
Message-ID: <xmqqr2gv9ryx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -3293,6 +3312,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  			unlink(rebase_path_stopped_sha());
>  			unlink(rebase_path_amend());
>  			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
> +
> +			if (item->command == TODO_BREAK)
> +				return stopped_at_head();
>  		}

The earlier one had "break;" here, which broke out of the while()
loop, let the control reach "if (is_reabse_i(opts)) {" block after
the loop, and the block would have noticed that current < nr and
returned 0.  So from the point of view of the overall control flow
of the caller of this function, there is no change relative to v2.
The only difference in v3 is that stopped_at_head() gives a useful
message.

Good.

