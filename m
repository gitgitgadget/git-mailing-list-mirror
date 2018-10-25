Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754A81F453
	for <e@80x24.org>; Thu, 25 Oct 2018 08:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJYRQD (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 13:16:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54809 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJYRQD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 13:16:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so642120wma.4
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 01:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=54jPoXl2dFBV2lH0qyFrrBlHE2XA1qdQpSIDu8yN/J4=;
        b=RvotfEGUEAzTVDl9TvbYwny4LO/8xcvNGTzP64ZAT16Uo5KqfYlxSxFrXnwemm71ws
         HSBqdj+7f2LcU7RkHJemSeZSgvT/cuET9MzFdPeB/QA7+frWZVc+Kws/oeh/7d6saSZ0
         Y7zS6qUmJcmv2Zn5ER0dkWfqQA8gZzxvth8DXzKbL6fZHh1yfFYbKh6v/JYOOpLQzZNx
         vW0pIJtSSb5NasHS2yDN6mGR6ACVEpGjArPPKT7OoTO4dYDpzS3SjkbczDCDPuI8rcIv
         Lkj3D7ypLi+GixZLbsnUrUgs6EKWi5wCN5g801Kvlcc0Gp35UVZ/QxRzETRZZ4+iGgbK
         iRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=54jPoXl2dFBV2lH0qyFrrBlHE2XA1qdQpSIDu8yN/J4=;
        b=TLxwrDBLmg25T6NBV5VUSI8TpOCFpXHVCNxc5TMYNF/knpMQ6AL/Ms0inDjHTvAoQ0
         DAiwRd/LKiKG6PTqRk3CXemLOpfXFxK0nlSwJo32Ok9hL0no/EywBbu33e8pd6MMwfed
         72MzekJvLLXdzm9e/Qotdv3pjEqeozJYOMzcXhTxl0KKL9HFCfu9ztJch+jGi2kza6J0
         epCT5D12nctRAdkBdS6/HL4deUkDn3WNkDcsN4YplwFbFhok9GmAoKZRRk9CxtpBMrbh
         aRHIybsE2kAaYSBNnbjfSpubga0U8G6LVEZhoMlQbAh+aockXTzBONFSexQrmG2lXp2u
         KXQg==
X-Gm-Message-State: AGRZ1gLMzaQWhHfhqquc53LIYd4ZbgLLhkrQEWp4OYJQNiXnsShdbWVe
        0OvZSBhYgXrkBUTAiSxSDeA=
X-Google-Smtp-Source: AJdET5fXDJsWreXAlqYXT6t8pxlrI/y/9bMqyMLHbxK7oW/b08uwSQyGa95mN+wAjEylts4e7GQPTQ==
X-Received: by 2002:a1c:ed07:: with SMTP id l7-v6mr857541wmh.47.1540457055375;
        Thu, 25 Oct 2018 01:44:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e142-v6sm1586291wmf.20.2018.10.25.01.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 01:44:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/5] am: don't die in read_author_script()
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
        <20181018100023.7327-1-phillip.wood@talktalk.net>
        <20181018100023.7327-2-phillip.wood@talktalk.net>
Date:   Thu, 25 Oct 2018 17:44:13 +0900
In-Reply-To: <20181018100023.7327-2-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Thu, 18 Oct 2018 11:00:19 +0100")
Message-ID: <xmqq5zxqiffm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The caller is already prepared to handle errors returned from this
> function so there is no need for it to die if it cannot read the file.
>
> Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/am.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

OK.  Having fewer die's in reusable codepath can only be a good
thing.

>
> diff --git a/builtin/am.c b/builtin/am.c
> index 5e866d17c7..b68578bc3f 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -318,7 +318,8 @@ static int read_author_script(struct am_state *state)
>  	if (fd < 0) {
>  		if (errno == ENOENT)
>  			return 0;
> -		die_errno(_("could not open '%s' for reading"), filename);
> +		return error_errno(_("could not open '%s' for reading"),
> +				   filename);
>  	}
>  	strbuf_read(&buf, fd, 0);
>  	close(fd);
