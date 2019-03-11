Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2980520248
	for <e@80x24.org>; Mon, 11 Mar 2019 01:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfCKBkh (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 21:40:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53527 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfCKBkh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 21:40:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id e74so2731376wmg.3
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 18:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=L2uj2qVY+UqIsqcQFCVWqSuIy+sOF4Epf8Q/PnJC4BU=;
        b=SOZqgvn0pqa/C2Gmm3taEe12xX50qgyy52RfRTMapeYoWAcbgmhSqP+cwmi5LGusKL
         HnyufprHryBM9UuH+pzmPUS/cHq+Xb2nEzhMa7sYu0Rvpb8SudmbrOzf2810SK6Yh5xc
         TH8P2vZJ5aQB9hyxaBA9FavcTXZGtaCGMNYStAkfD+HFqJez8t6z3D/HiwTCFJE9AhTU
         aBIQnC8TBdVC6A1jwRauTAWVX0xUbDbgwX84HA0sLfZmT9Rznn9OHfCHUlpVq4gzISO/
         MZDcBwRtUWcFpAP3973X8v/TnbnGRZNp4gXiLu0nsFAeQ7YQ2Tg+IZDRltTEROGym0jy
         TyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=L2uj2qVY+UqIsqcQFCVWqSuIy+sOF4Epf8Q/PnJC4BU=;
        b=KFD3lrcMcEYkv9b3zbUYJpZnG6/d2uipQXZY3YF0pXW7ShvQvfI2m3wwktNtAiU6Qr
         n6DmByuScNzysjOmSwwqjLvY1U0v+xZFy9hjaFCgrcd1yFLzJQL6DBsLOr63pPU6oM18
         EOjNOEHt6GxtPTXzckDebLRzBLGIzxpy2MqIR3iRNHrdC3nkVjVTan6H12Ldg6iaUBcs
         9FGc6lMZL6OeoOYijChyHGlmuj2ZQzfsVsH3kUFcMBFMDDbXsEYKKPksOKgS3oynsoQn
         USTRcJ6j9SHq/7epl2HdrjQOQ9u8FZwjTh4nXwmEZb379iyBTgIuTAKcI2YhalReVdPz
         bkMA==
X-Gm-Message-State: APjAAAW4taeRIf8zoey56nARDPqjIBJg8+OWS0kyHnV4umKfyBkqtWWs
        rCujOwTSPQhDT47VS2H46HM=
X-Google-Smtp-Source: APXvYqzsSG6xw/kJkRZbONvOxfyyQiXpxM+5fAJPAzfBei1UitgPzMbsqs1XUb870te2U1Bf/sKiiQ==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr14777588wmb.48.1552268435028;
        Sun, 10 Mar 2019 18:40:35 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c1sm9289283wrw.7.2019.03.10.18.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 18:40:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>
Subject: Re: [PATCH v13 12/27] stash: convert drop and clear to builtin
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
        <20190225231631.30507-1-t.gummerer@gmail.com>
        <20190225231631.30507-13-t.gummerer@gmail.com>
        <20190307191533.GA29221@sigill.intra.peff.net>
        <20190309183021.GE31533@hank.intra.tgummerer.com>
Date:   Mon, 11 Mar 2019 10:40:31 +0900
In-Reply-To: <20190309183021.GE31533@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Sat, 9 Mar 2019 18:30:21 +0000")
Message-ID: <xmqqmum2mbn4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Agreed, I'd be happy to keep the parameter there.  Looking at your
> fork, you seem to have some WIP patches to introduce a UNUSED macro
> for parameters like this, which I don't think I've seen on the list
> yet (though I may have just missed them).
>
> I guess it's probably best for you to mark this parameter as UNUSED as
> part of your series, but if you have a different preference on how to
> handle it, let me know.

I agree that the uniformity among near-toplevel helpers like
create_stash() is a good thing to have.

In the meantime, you want the patch you sent (below) on top of the
stash-in-c topic to address do_drop_stash()?

Thanks for working well together.

> --- >8 ---
> Subject: [PATCH 2/2] stash: drop unused parameter
>
> Drop the unused prefix parameter in do_drop_stash.
>
> We also have an unused "prefix" parameter in the 'create_stash'
> function, however we leave that in place for symmetry with the other
> top-level functions.
>
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  builtin/stash.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 6eb67c75c3..069bf14846 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -527,7 +527,7 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
>  	return ret;
>  }
>  
> -static int do_drop_stash(const char *prefix, struct stash_info *info, int quiet)
> +static int do_drop_stash(struct stash_info *info, int quiet)
>  {
>  	int ret;
>  	struct child_process cp_reflog = CHILD_PROCESS_INIT;
> @@ -597,7 +597,7 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
>  
>  	assert_stash_ref(&info);
>  
> -	ret = do_drop_stash(prefix, &info, quiet);
> +	ret = do_drop_stash(&info, quiet);
>  	free_stash_info(&info);
>  	return ret;
>  }
> @@ -626,7 +626,7 @@ static int pop_stash(int argc, const char **argv, const char *prefix)
>  		printf_ln(_("The stash entry is kept in case "
>  			    "you need it again."));
>  	else
> -		ret = do_drop_stash(prefix, &info, quiet);
> +		ret = do_drop_stash(&info, quiet);
>  
>  	free_stash_info(&info);
>  	return ret;
> @@ -663,7 +663,7 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
>  	if (!ret)
>  		ret = do_apply_stash(prefix, &info, 1, 0);
>  	if (!ret && info.is_stash_ref)
> -		ret = do_drop_stash(prefix, &info, 0);
> +		ret = do_drop_stash(&info, 0);
>  
>  	free_stash_info(&info);
