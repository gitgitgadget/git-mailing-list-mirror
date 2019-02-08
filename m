Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83A1211B5
	for <e@80x24.org>; Fri,  8 Feb 2019 23:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfBHXi7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 18:38:59 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:38071 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBHXi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 18:38:59 -0500
Received: by mail-wm1-f47.google.com with SMTP id v26so6043293wmh.3
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 15:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=te6mvbvgKRUzpQfP2ATAEZvvCEkJshhMGZsOhMBGbQU=;
        b=Bj8cnM2NaUsZkgTNonA6Eag1HBNiaQO3NyIJ5SoABMVZSNZjTXLsxdu4HqXsVcUT8a
         5tB9AfQj4GCmcNc0GMgQEmjydrliOQwts3zopzfkr9QtJL0+Cuwao5GeCcMmZdCwKLA7
         MXpn/QXup1tb5ssF98II8+ilkFBaUfNzkv3XLsVff9eLcrTHJfsJYtQs2OuBkwNv8CN/
         YMPG6n60mS/B9UCCmUlCII9Js22LGLLGNH2YspoXNK7wQyzltfJyyrneWXTDAkT96RZ1
         eJyBOJKUfH3TFRY/lfnqkmJ+wJUwcA3+4HEEJrPbpKdGmDvdA2dfq3STvXsAlQeHAHTw
         XHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=te6mvbvgKRUzpQfP2ATAEZvvCEkJshhMGZsOhMBGbQU=;
        b=KyybhfvCRS/WmWrxhFO7iAYQdQu1SwrBhudock2dS/XGYt8IKCLVwifLJtZ5vvxsbS
         JQ1ZlU4UUAXQz0DusU1MX8teq//gH3mj5wOyiTyV6PRpG0sE3ih8TndhxJaQNZo5XC+6
         OfyewFzbjT+hdvnFbSp7D5YDtzcWtvQBIw8rMbtJuE6h2TGnAfyR9ksfp+u8NaAoF9Mm
         ZHIqEvlPpzv7EGvt0bruwxIFVJlCyHCS2Y+yTVfpG0dw3G71lcXO28mcd0T77W6zbqoV
         QBJN3j1wTJUI0cdbdU7AMHfgfs4DMLxL9TPIW8AT/vmFBbPRNXMIUsL9+SfBnjCU53fw
         hITw==
X-Gm-Message-State: AHQUAuZscVWX0h9J7evEVnPcoNtpn0efc+Yev22vDoXVM619UuaFh9o1
        7bagt+O0rMyu/ghx0Uyrgys=
X-Google-Smtp-Source: AHgI3IYAvjuu/7+CwnsTQihnagsftgD2dkpFieCupPTdYMfvoAiQ05I6cPH8hRj4CRK+ScJrszndtw==
X-Received: by 2002:adf:f4d0:: with SMTP id h16mr4755178wrp.103.1549669136867;
        Fri, 08 Feb 2019 15:38:56 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 129sm4870242wmd.18.2019.02.08.15.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 15:38:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Fix v2] t5562: remove dependency on /dev/zero
References: <20190208220751.9936-1-randall.s.becker@rogers.com>
Date:   Fri, 08 Feb 2019 15:38:55 -0800
In-Reply-To: <20190208220751.9936-1-randall.s.becker@rogers.com> (randall
        s. becker's message of "Fri, 8 Feb 2019 17:07:51 -0500")
Message-ID: <xmqq8sypkfzk.fsf@gitster-ct.c.googlers.com>
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
> Replaced subtest 15 (CONTENT_LENGTH overflow ssite_t) use of /dev/zero
> with yes and a translation of its result to a stream of NULL. This is
> a more portable solution.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  t/t5562-http-backend-content-length.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
> index 90d890d02..b8d1913e5 100755
> --- a/t/t5562-http-backend-content-length.sh
> +++ b/t/t5562-http-backend-content-length.sh
> @@ -143,14 +143,14 @@ test_expect_success GZIP 'push gzipped empty' '
>  
>  test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
>  	NOT_FIT_IN_SSIZE=$(ssize_b100dots) &&
> -	env \
> +	yes | tr "y" "\\0" | env \

I do not quite get this use of tr.  The original feeds a stream of
NULs out of /dev/zero to the command; the yes-to-tr pipe instead
feeds a stream of alternating NUL and LF.

Does the actual bytes fed to the consumer make any difference?  If
not, perhaps we can use 'yes' as-is?

>  		CONTENT_TYPE=application/x-git-upload-pack-request \
>  		QUERY_STRING=/repo.git/git-upload-pack \
>  		PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
>  		GIT_HTTP_EXPORT_ALL=TRUE \
>  		REQUEST_METHOD=POST \
>  		CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
> -		git http-backend </dev/zero >/dev/null 2>err &&
> +		git http-backend >/dev/null 2>err &&
>  	grep "fatal:.*CONTENT_LENGTH" err
>  '
