Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1939F1F463
	for <e@80x24.org>; Fri, 27 Sep 2019 13:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfI0N0b (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 09:26:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40519 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfI0N0a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 09:26:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so2732527wru.7
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cwc548Q+n/ayD0FJD03MDPGQ/iyvyoW0eieoGdSgUJk=;
        b=Okyj2C01fEKRpxKTClajCs7u00TDa0ZZNNrTw0mJA86VT1XvjqPmzVrFNEdAdxKS36
         zQvuiotttYasNMj9bpC44on3pscDoZ75ZODd+k5lXbyzWNz7k0DbRPqK3PAk1q/GLyi+
         JNgNIYfzfVcrHLa1qBB+Fq0kfwAUYbH1uF3Ya+MYqkFL4tlQoxG/o2fMoQcqzuqG5apD
         iFQK6hqJfRqeAe44v1J6FNkfR+gpR8WUY0sbExeLZCwdHrcrn8Dpo+Kwx4VaaSLadnvp
         N3mZTMenx1ucdK5FbuyJ2+3IgUU6aS5eGP/n5uLLJ1zihdmnTtLs5/sBnHqeIpQRlANH
         ggzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cwc548Q+n/ayD0FJD03MDPGQ/iyvyoW0eieoGdSgUJk=;
        b=rYxQ1PefiUvWjud6NlYH89WEOdDgwGez07dswrSHYYduleVKpeecvKa7NxFTf5/B7w
         K0d9lWKdjV/jt3l3wn6LH0WFqTiQSXA5njqp++GAl2dDHse8opoYNN1DBxfS+0inwMTI
         74ui3ozMJ51xZPRL9iKEE9g8LxNOHWnfqlgr50ywEbWuEnRp5G6uz6b6hBK1+qnvz0Sm
         kXP+VtmFi7B2YIqdzkrQppR4r6CGXJTDIiYi6lS68kni1gBHIPUZ3zHWpOP+YMwLDxXK
         UtQuRAOMSxZndMcnihkvREm+mScDj+FgbrkSyq3DlBxPmDOomqqBY85aiNLGfDCvZXbr
         1hVw==
X-Gm-Message-State: APjAAAXhSZ4lEZrhz4Zs3NWM9cF0h9o8jnl+UEvogKin8ZuC9a6K5o4h
        dIvQD5nHdcTTKSqRYgVYxoQ=
X-Google-Smtp-Source: APXvYqxBbdclTdkejFjcAfdoRT2/HdBGzBjYHYEWr41i6GWtQ/lTbG4sNry3XzHebMc1vFlUIixI6g==
X-Received: by 2002:adf:e791:: with SMTP id n17mr3284442wrm.388.1569590788668;
        Fri, 27 Sep 2019 06:26:28 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-10-31.as13285.net. [92.22.10.31])
        by smtp.gmail.com with ESMTPSA id d193sm12602516wmd.0.2019.09.27.06.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 06:26:27 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 5/5] sequencer: directly call pick_commits() from
 complete_action()
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
 <20190925201315.19722-6-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <212cdc0d-8cf3-9172-d405-39b3868e6ca4@gmail.com>
Date:   Fri, 27 Sep 2019 14:26:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925201315.19722-6-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

Thanks for removing some more unnecessary work reloading the the todo list.

On 25/09/2019 21:13, Alban Gruin wrote:
> Currently, complete_action() calls sequencer_continue() to do the
> rebase.  Even though the former already has the todo list, the latter
> loads it from the disk and parses it.  Calling directly pick_commits()
> from complete_action() avoids this unnecessary round trip.
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   sequencer.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index ec7ea8d9e5..b395dd6e11 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5140,15 +5140,17 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   		return error_errno(_("could not write '%s'"), todo_file);
>   	}
>   
> -	todo_list_release(&new_todo);
> -
>   	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
>   		return -1;
>   
>   	if (require_clean_work_tree(r, "rebase", "", 1, 1))
>   		return -1;
>   
> -	return sequencer_continue(r, opts);

sequencer_continue does a number of things before calling pick_commits(). It
  - calls read_and_refresh_cache() - this is unnecessary here as we've 
just called require_clean_work_tree()
  - calls read_populate_opts() - this is unnecessary as we're staring a 
new rebase so opts is fully populated
  - loads the todo list - this is unnecessary as we've just populated 
the todo list
  - commits any staged changes - this is unnecessary as we're staring a 
new rebase so there are no staged changes
  - calls record_in_rewritten() - this is unnecessary as we're starting 
a new rebase

So I agree that this patch is correct.

Thanks

Phillip

> +	todo_list_write_total_nr(&new_todo);
> +	res = pick_commits(r, &new_todo, opts);
> +	todo_list_release(&new_todo);
> +
> +	return res;
>   }
>   
>   struct subject2item_entry {
> 
