Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70A9EE4993
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 07:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjHVHyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 03:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjHVHyu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 03:54:50 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C307712C
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 00:54:47 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a7f4f7a8easo2047160b6e.2
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 00:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692690884; x=1693295684;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=axTiLWTtM+BKGTabhUmiRk1cDjiEldd8a7TRLNlnl1I=;
        b=T9sKXvtfHaSDBWeEceuE6zJ6PeXNOAjKJLXyBnotLYz6V8KK+7lVAP+SJIV+rekiaR
         S3lebcmitnddNXUVy236i80iQtXR9+9Y8MIEkYF0arr34ddy488r6yjlpT2dvFvb/h7/
         Pw1EQ/ZAGJtySiehTBhh8L+bsQ6vwK0WT1jZq/lYhPEFwIgVgZ1AA3/tm4apWq6pK/h6
         9PyCJ+pQxJiaVH56w/0cyAL4E4OVJdWGbD6TppSH+uj2GhY3Wb7xIBYb3TDfoMFiQtp+
         KESiofiuaTG9Q+vz2tjl4T7gA/CRYsWWNi2Ir2p6Lj9jmAo6qT5FuPB8By3OPEOZ66jP
         OuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692690884; x=1693295684;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axTiLWTtM+BKGTabhUmiRk1cDjiEldd8a7TRLNlnl1I=;
        b=ebGxMF7yROeBElcg+LhaGUlITJtP9vwhGYJM13ZRWYJE/pKfjBR6g+h2XVyxpQ5gsr
         JqjpEMIQbJh7d4VGz50vMpoIxYz7uLN78e1Q3hRLNV29UeEXVtNFdEk0gQlMr4D+sOzc
         VxR1iR33UjNRSb7hkckE7pUwEN1I1505Oa+aN3uR8j2LntDoCy97X+tikzgeKHIP2oRS
         sqDWyumXCYHxaSdnwBUZ8742J81Q6NFTiKnMTzIdOjvVYLDTC3UdH3ZEGnEB/tUSNB6r
         8VXOHXX5XRxXGky9cOUnmLo9WDGSn2sux4IciTL1IWmE0gK3lsQgzTUh043b9yLUDdyY
         LZYg==
X-Gm-Message-State: AOJu0YxoAnCBJy53zd0dAKuRKOp8TimezDOqhaRxT4TD+pTBPM0pe0SC
        v7c9m+w/nOuyqKwvq9pR1KQ=
X-Google-Smtp-Source: AGHT+IEf9wzvqlQ9OFq/bIA7V+63oDF1QOUH1cACCMIbUJCGraOZBgMbAHeVi+/SmR/uGBFXWQcNFA==
X-Received: by 2002:a05:6358:94a4:b0:134:d128:9f5f with SMTP id i36-20020a05635894a400b00134d1289f5fmr7222853rwb.9.1692690883850;
        Tue, 22 Aug 2023 00:54:43 -0700 (PDT)
Received: from five231003 ([49.37.156.142])
        by smtp.gmail.com with ESMTPSA id 23-20020a631857000000b0055c178a8df1sm7239149pgy.94.2023.08.22.00.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 00:54:42 -0700 (PDT)
Date:   Tue, 22 Aug 2023 13:24:33 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     Christian Hesse <list@eworm.de>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] t6300: fix match with insecure memory
Message-ID: <ZORpucPcjzm-dhjP@five231003>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821202606.49067-1-list@eworm.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Hesse <list@eworm.de> wrote:

> From: Christian Hesse <mail@eworm.de>
> 
> Running the tests in a build environment makes gnupg print a warning:
> 
> gpg: Warning: using insecure memory!
>
> This warning breaks the match, as `head` misses one line. Let's strip
> the line, make `head` return what is expected and fix the match.
>
> Signed-off-by: Christian Hesse <mail@eworm.de>

I think a bit of an explanation about why this warning is showing up in the
commit message would be good.

"man gpg" gives me

	On older systems this program should be installed as setuid(root).
	This is necessary to lock memory  pages.  Locking  memory
	pages prevents the operating system from writing memory pages (which
	may contain passphrases or other sensitive material) to disk. If you
	get no warning message about insecure memory your operating system
	supports locking  without  being  root.  The program drops root
	privileges as soon as locked memory is allocated.

	Note  also  that  some systems (especially laptops) have the ability to
	``suspend to disk'' (also known as ``safe sleep'' or ``hibernate'').
	This writes all memory to disk before going into a low power or even
	powered off mode.  Unless measures are taken  in  the operating system
	to protect the saved memory, passphrases or other sensitive material
	may be recoverable from it later.

So it seems that this warning will pop up if gpg is writing memory pages to disk
which is bad because as stated above we don't want these pages written to disk
which is a security risk.

> ---
>  t/t6300-for-each-ref.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 5b434ab451..0f9981798e 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -1764,12 +1764,13 @@ test_expect_success GPGSSH 'setup for signature atom using ssh' '
>  
>  test_expect_success GPG2 'bare signature atom' '
>  	git verify-commit first-signed 2>out.raw &&
> -	grep -Ev "checking the trustdb|PGP trust model" out.raw >out &&
> +	grep -Ev "checking the trustdb|PGP trust model|using insecure memory" out.raw >out &&
>  	head -3 out >expect &&
>  	tail -1 out >>expect &&
>  	echo  >>expect &&
>  	git for-each-ref refs/tags/first-signed \
> -		--format="%(signature)" >actual &&
> +		--format="%(signature)" >out.raw &&
> +	grep -Ev "using insecure memory" out.raw >actual &&
>  	test_cmp expect actual
>  '
>  
> -- 
> 2.41.0

We skip "checking the trustdb" and "PGP trust model" lines (which are not
warnings) here because we don't really need those from the output that GPG
produces here but skipping a warning too seems kind of a question mark.

It also seems that one could use "--no-secmem-warning" to suppress such a
warning. So a better place to make a change would not be in t/t6300 but in
t/lib-gpg from where the prereq GPG2 comes from. Although I'm against this,
because we don't really want to suppress any warnings.

I think it is a good thing this test is breaking because it informs us about
the security risk. I have Cc'ed people who might have a thought on this. So
it's better to wait for their response.

Thanks
