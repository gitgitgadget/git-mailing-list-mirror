Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D14F20248
	for <e@80x24.org>; Mon,  1 Apr 2019 09:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfDAJ3W (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 05:29:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33169 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDAJ3W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 05:29:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so11038417wrp.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 02:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=/v1Z4uCNnSkaApqfLIM/lqmhpT/g7dTOL6TXjIC0BRA=;
        b=c2d+pj819ewqFwWUB+9T096QGzP/MnvaTjFhQAE76hw5saiv815XI2gI5aTJviwZKt
         PUsNrFkfggwDmW7M5FxYsKspfeY1Pse3SK1fDwWx+UKK+Wz57Be8b4alfi8lIxWwnrOx
         RgpEsBUSTI/2dXL1E+prlQvpz8ziNwTF+oOjwe/yDXvDuNJKKyX8epSbScw/aWE6OqbM
         oPvN28nKW65yZQqpdPnBzN2NcYiISuTDQFatUZHJXVVga2exthwKAIbdOJoggQPJsRp5
         GB6D5fDt7fxFaxlyuRguMNMREb6BnAsk35XdWT/shetTPNnkw0jCQ/9tu9zgcHxVoI2D
         0hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=/v1Z4uCNnSkaApqfLIM/lqmhpT/g7dTOL6TXjIC0BRA=;
        b=sa1bBZPQHjlRUb0dBHqs96cM0309hzhYDBeXOI/x3dGA2lMfs82I5zfvEhR1vFW/Cy
         tW2a+yrFIWExhdsCL+mSiCBG5Iaj04iMrofWwnXxR6D+Y3GZGhvQHKgLm9SL52bS8aY2
         pYyI4KyGk3BdJRlJ1xQQsXpg9CaCDpcfGsggBsNZL2qjaF9HNuQizRKRV70xPCNg0xLb
         OVUF9C0i+wGFVyOCXO23PluV/BqIpvz6d4sp1wZWftYNmF+QBd7YNW31y5vn93ES7prU
         zRm/Cb3Q0RuD+nCErn9Nlj5Iqol8+tFY1wTG6XghoyRJbWSTigpjZMCy5Kh6hT1vBqrk
         Dc7g==
X-Gm-Message-State: APjAAAUU3AHV04dCKCMY0W/Go2UME6w+PxmCUZrPVIbQdCyMikceRUi3
        EwDcGJPvLzOIgjwrsrBC9Vs=
X-Google-Smtp-Source: APXvYqxyVFPEU/X9Brqmo558XrSxXpH/6H3JMLDuFuGkHLtE3A/RmxVc883W2ni8DaoinKv8HuXqpQ==
X-Received: by 2002:a5d:660c:: with SMTP id n12mr4513635wru.160.1554110960041;
        Mon, 01 Apr 2019 02:29:20 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id d7sm9839931wmf.31.2019.04.01.02.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 02:29:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Fix v1] builtin/ls-files.c: add error check on lstat for modified files
References: <20190217163456.17560-1-randall.s.becker@rogers.com>
Date:   Mon, 01 Apr 2019 18:29:19 +0900
Message-ID: <xmqq4l7ixeds.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

randall.s.becker@rogers.com writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> The result from lstat, checking whether a file has been deleted, is now
> included priot to calling id_modified when showing modified files. Prior

s/priot/prior/

> to this fix, it is possible that files that were deleted could show up
> as being modified because the lstat error was unchecked.
>
> Reported-by: Joe Ranieri <jranieri@grammatech.com>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  builtin/ls-files.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The justification for the change reads quite convincing.  Is it
merely "it is _possible_ ... _could_ show up", though?  The code is
iterating over the in-core index, so if you add a blob at path F in
the index then remove that regular file F from the working tree,
when it is the cache entry for "F"'s turn to get inspected, lstat()
would say ENOENT, (show_deleted && err) would show tag_removed, and
ie_modified() gets a garbage &st and ie_match_stat() would say
"modified", no?  

> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 29a8762d4..fc21f4795 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -348,7 +348,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
>  			err = lstat(fullname.buf, &st);
>  			if (show_deleted && err)
>  				show_ce(repo, dir, ce, fullname.buf, tag_removed);
> -			if (show_modified && ie_modified(repo->index, ce, &st, 0))
> +			if (show_modified && !err && ie_modified(repo->index, ce, &st, 0))
>  				show_ce(repo, dir, ce, fullname.buf, tag_modified);
>  		}
>  	}

And the implementation of the change looks OK.

I wonder if there is an easy way to cover this with a test or two.
Wouldn't it be just the matter of doing something like this

	test_expect_success 'allow telling modified and deleted ones apart' '
		>testfile &&
		git add testfile &&
		rm testfile &&
		echo C testfile >expect &&
		git ls-files -m -d -t testfile >actual &&
		test_cmp expect actual
	'

in some existing test file for ls-files, perhaps in t3004 (ls-files-basic)?

I went back to the original discussion of the "BUG" around mid Feb
2019, and didn't find anybody worried about backward compatibility.
As "ls-files -[dm...t]" is marked semi-deprecated, perhaps breaking
the current users does not matter that much ;-)
