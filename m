Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30F1C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbhLMQWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240691AbhLMQV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:21:58 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D3BC06173F
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:21:57 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w1so53737627edc.6
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=qYWpnicN4PZ/9KucZLWkdzBU0XlwTAGyXUekqK08OxA=;
        b=o7pSPBFJF1mPPQ4MTrWznhcRzbwuoPOP3LxA4TQAWAxPQWJakpPX2golQyn3NmW2ng
         /uUs0XBEIqhOSzxqkqq2PF3FvMlooazAOjpYdpZ7IHPJdJ2S9wpMlQgx7oYaATUoKyFM
         t3YDZ+QdJrAsvHTW6/KTET2mO8Lvoi5ZFJcPaVdRvdJO7ino5osYzqoOHIZ0WJyB+2t2
         lwNp+1/2B8vKL8ALpfsKSDwW3tacDvo/9P+lXSZWKp9pkqABADBsH70L9MiaxnZEp00r
         P8tPGz5FVkKM1jjSPROLLeV9oTgK2cLzwrDoM18iUawZWVPXmtEhNvbD1nDQSnO1uxww
         RWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=qYWpnicN4PZ/9KucZLWkdzBU0XlwTAGyXUekqK08OxA=;
        b=v4ioOsi5ep9CyuEAGni1jkqDn1Q7QA7cXDlTiUGZU0oYBP+VP5o49r+jqRznT5eZIT
         BT0O83fzpUhIFP+YrmpJhZFxUx6PQXObMPY6wVupFsg+qlLxJOOjpkVFgM/Noom0nMjD
         ukBddUZTeV36uxlElGk0DbcCUNwUqA4EEfLT4R3EzgnOLeGOp5wX8HBjo4vfgGqpDiQg
         fPXJBalhnP5Fs3fLp8cAbK3wGzmUE4THjS2JhJm1+zOhsr3efNlIyCXSrsTEYYDY+h45
         NqGzMrS22p5GdoaVYRnj9GBD+Le2Qtesq6Mz6eb8DpRoBdTyYb+i1NY+KtVMhw9pJUpl
         ytMw==
X-Gm-Message-State: AOAM532t3PxyAQ63W64crt4jkfwepDqF75WXo1V6O37bAe0PWaYb7ijo
        2g1NamBA3nVpJLhLKDXpeKx+ImDQI2rxVw==
X-Google-Smtp-Source: ABdhPJzfahWXAUN6KS84xPQgeOMG1az64shXhTFO/24+KrNQLp4sMwHxOcJlOw+ipELfekn91RnMpg==
X-Received: by 2002:a05:6402:50c7:: with SMTP id h7mr66732373edb.277.1639412515864;
        Mon, 13 Dec 2021 08:21:55 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z6sm304496ejl.153.2021.12.13.08.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:21:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwo5K-000u4E-5p;
        Mon, 13 Dec 2021 17:21:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 02/11] reftable: fix resource leak in error path
Date:   Mon, 13 Dec 2021 17:19:29 +0100
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
 <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
 <975a570d388fca79546987f4683fcd33419aad98.1639411309.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <975a570d388fca79546987f4683fcd33419aad98.1639411309.git.gitgitgadget@gmail.com>
Message-ID: <211213.86pmq08ogt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 13 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
> [...]
> -	return 0;
> +done:
> +	if (uncompressed) {
> +		reftable_free(uncompressed);
> +	}
> +	return err;
>  }

Other things in the codebase don't check for NULL before feeding things
to reftable_free(), and our own free() has a coccicheck rule to catch
this sort of code, we should probably add reftable_free to that list...

>  
>  static uint32_t block_reader_restart_offset(struct block_reader *br, int i)
> diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
> index 5f6bcc2f775..42caf0bde4c 100644
> --- a/reftable/readwrite_test.c
> +++ b/reftable/readwrite_test.c
> @@ -254,6 +254,72 @@ static void test_log_write_read(void)
>  	reader_close(&rd);
>  }
>  
> +static void test_log_zlib_corruption(void)
> +{
> +	struct reftable_write_options opts = {
> +		.block_size = 256,
> +	};
> +	struct reftable_iterator it = { NULL };
> +	struct reftable_reader rd = { NULL };
> +	struct reftable_block_source source = { NULL };

Nit: It doesn't matter for semantics, but usually we use "{ 0 }", and
your 1/11 does too. Would be better to do that here for consistency.

> +	for (i = 0; i < sizeof(message)-1; i++) {
> +		message[i] = (uint8_t)(rand() % 64 + ' ');
> +	}

style: braces not needede.
