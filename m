Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F6C1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 18:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933936AbcHaSiA (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 14:38:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36211 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbcHaSh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 14:37:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so8832796wmf.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=KxtO6RMMLmRQBnDtzs5hN6olobgy2n2yPz5ou/72K7A=;
        b=ORk0b5DXxYJkcsonBleUQ7XDMIgtDdow3TbeA3yc5Ajks+Xm1/XLbKse19Rz0ZJGPL
         YaQjbzGUgOpXB8eOj2Irl11FUcc0gVdyS1qjrBh59tZGgQ19JRJF7KmKGSYfz0wGVgwy
         aUyg7nQInzd9+musd2sJeWrFrOt+zYrbF2Hk+lNJ3ZnF/ChSykd6Ngr54/H57S6tlftk
         e2jJFjiqstplyB+lDvkTs6yAMvLZS3k6H74ghGkQV1EAh2fwvoNND5QdEiRryl7PVlIT
         0Yc+bZ6ze+um8veCcQIOOtV7IHC/YNW1rZv0FWDixH8PhZtjnvqnXSNRT8ylK6YEZjEB
         +ThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=KxtO6RMMLmRQBnDtzs5hN6olobgy2n2yPz5ou/72K7A=;
        b=XOePqEmOYB+iLTQ+5zumAIX0EDUF7Yeg7cE4Sd0TiNkopU3VkiuRYN0VabDzWsYgl5
         BdZBTduhkRW3i4PfQeu4sagtzDCKZwTWDiqdbiKruUba1BgMMFFh8m62o+gZ4q0guRmY
         M8TpL7WOGZ7GdA3Gg2emhoWxxeUIlDzTUhWHsQP6kUktQUFUe6ZANAbGp9PhdVfjd6Mn
         5oDqBwU+vsSv9Lx++9SMcspIb5/eBVceypAeWQr3NW8uht+UE54eF+UM5ohXW0ZYBCrQ
         MQ0Xe14mH07bpMoF8GvYC0LvR1nlRT8JAZVFLQFlB2rMocViXjaAQexd0uqDCg2B0a+T
         RFag==
X-Gm-Message-State: AE9vXwOrhi2IhseJpX26ChY5gOFposXSN3ROoXj8WNXDwdrGDyJvttsv9zdinJ4NPLUO9g==
X-Received: by 10.28.175.16 with SMTP id y16mr23600340wme.64.1472668678287;
        Wed, 31 Aug 2016 11:37:58 -0700 (PDT)
Received: from [192.168.1.26] (enu134.neoplus.adsl.tpnet.pl. [83.20.10.134])
        by smtp.googlemail.com with ESMTPSA id w129sm10237060wmd.9.2016.08.31.11.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 11:37:57 -0700 (PDT)
Subject: Re: [PATCH 13/22] sequencer: remember the onelines when parsing the
 todo file
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com>
Date:   Wed, 31 Aug 2016 20:37:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 10:05, Johannes Schindelin pisze:

> The `git-rebase-todo` file contains a list of commands. Most of those
> commands have the form
> 
> 	<verb> <sha1> <oneline>
> 
> The <oneline> is displayed primarily for the user's convenience, as
> rebase -i really interprets only the <verb> <sha1> part. However, there
> are *some* places in interactive rebase where the <oneline> is used to
> display messages, e.g. for reporting at which commit we stopped.
> 
> So let's just remember it when parsing the todo file; we keep a copy of
> the entire todo file anyway (to write out the new `done` and
> `git-rebase-todo` file just before processing each command), so all we
> need to do is remember the begin and end offsets.

Actually what we remember is pointer and length, or begin offset and length,
not offset and offset.

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Nice, I'll see how it is used later (and in which commit in series).

> ---
>  sequencer.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 06759d4..3398774 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -709,6 +709,8 @@ static int read_and_refresh_cache(struct replay_opts *opts)
>  struct todo_item {
>  	enum todo_command command;
>  	struct commit *commit;
> +	const char *arg;
> +	int arg_len;

Why 'arg', and not 'oneline', or 'subject'?
I'm not saying it is bad name.

>  	size_t offset_in_buf;
>  };
>  
> @@ -760,6 +762,9 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>  	status = get_sha1(bol, commit_sha1);
>  	*end_of_object_name = saved;
>  
> +	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
> +	item->arg_len = (int)(eol - item->arg);
> +

Does it work correctly for line without <oneline>, that is

  	<verb> <sha1>

I think it does, but I not entirely sure.

>  	if (status < 0)
>  		return -1;
>  
> @@ -880,6 +885,8 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
>  
>  		item->command = command;
>  		item->commit = commit;
> +		item->arg = NULL;
> +		item->arg_len = 0;
>  		item->offset_in_buf = todo_list->buf.len;
>  		subject_len = find_commit_subject(commit_buffer, &subject);
>  		strbuf_addf(&todo_list->buf, "%s %s %.*s\n",
> 

