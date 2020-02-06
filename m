Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F54FC35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 01:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71281214AF
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 01:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+k57FC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgBFBfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 20:35:37 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39383 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgBFBfh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 20:35:37 -0500
Received: by mail-pj1-f68.google.com with SMTP id e9so1774218pjr.4
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 17:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=svjPBq0vHfnigY0beRXmgM6GVtQOp9ulRfAiwuCyi7Q=;
        b=F+k57FC8K8bfu1J3X6PDNZu1oMuVSf6KGFIZX9eeaAocVJpVSQsuqDQJDPc/TWvsdN
         twnp/mdRtsBUe5OW7qUlekZOJjNJ7N/tbkmmbjqUSSso+u9HQc0ZurcTpSrgxeWFjbN/
         TUeFPh3hj/6cF9h8ihWpexH1BOMvEpVKydQGA5xy6qpkF4FhAfefWwlZ61De1e3pWOhv
         dJBhk5KDVGSCp4QJvHLl2VONEe0Xc2/7OEKC4HhC4KV1CsTq+DTcCcxyE64Fn+yqIzGy
         j/X99/tmw92CsP1IlgbXRRw5ihu9Gz0x3DtLf2xDkmnXk45pK7vYjR4xcPHrjPaBGD/4
         d58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=svjPBq0vHfnigY0beRXmgM6GVtQOp9ulRfAiwuCyi7Q=;
        b=JK98ZFllzHeHBTVAx7q65iMGywXZQgZHhQXG4daTnQzOTcIb2NgbicxUvmIGrsFRYh
         Lgk1wgIkQrIODwnL7GXIaDDgNEr6L9GiMx/RYgEYCXKrS1ZwYm+thV75Hi/rFX9ET0Pj
         I6pWHz3yxeiCKA//CowQmTHZrRSBcMOfqaW1BYRp1MHCJDVe4XmrTnnmcCuLqDzZCmgk
         ZeOF9JWV4BjfWWXFWVglfqot0rvW/hqdaDbaaDS/YPSxd8ZxfXI8eDaCNDYiPU3NpsWh
         pfWDMGC5AgEeTBb11y/MsMpBJvCu4udisiQiB3RiUQPKL/OZg8wTFzLTcDD5Yw1b1lkU
         3PKg==
X-Gm-Message-State: APjAAAXPbfgsLMH5i/A7dkKDpoATD6viOIjV3ZpHTH+otzq00+bvbJt3
        ej/1D1VnBfvXcNNmoEnxYJI=
X-Google-Smtp-Source: APXvYqzd4GCl7Gjzic6u4kTu3b5815Gq6iX2vftp8t9SNfLDKcboWNnFCeS29Em6IvVcnx2MeRB9Ow==
X-Received: by 2002:a17:90a:3745:: with SMTP id u63mr1196468pjb.123.1580952936831;
        Wed, 05 Feb 2020 17:35:36 -0800 (PST)
Received: from localhost ([2402:800:6374:7754:86a8:b650:771:4d56])
        by smtp.gmail.com with ESMTPSA id 23sm768087pfh.28.2020.02.05.17.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 17:35:36 -0800 (PST)
Date:   Thu, 6 Feb 2020 08:35:33 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 01/15] help: move list_config_help to builtin/help
Message-ID: <20200206013533.GA3993@danh.dev>
References: <20200206004108.261317-1-emilyshaffer@google.com>
 <20200206004108.261317-2-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206004108.261317-2-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-02-05 16:40:54-0800, Emily Shaffer <emilyshaffer@google.com> wrote:
> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> index 71158f7d8b..45fecf8bdf 100755
> --- a/generate-cmdlist.sh
> +++ b/generate-cmdlist.sh
> @@ -76,23 +76,6 @@ print_command_list () {
>  	echo "};"
>  }
>  
> -print_config_list () {
> -	cat <<EOF
> -static const char *config_name_list[] = {
> -EOF
> -	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
> -	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
> -	sort |
> -	while read line
> -	do
> -		echo "	\"$line\","
> -	done
> -	cat <<EOF
> -	NULL,
> -};
> -EOF
> -}
> -
>  exclude_programs=
>  while test "--exclude-program" = "$1"
>  do
> @@ -113,5 +96,3 @@ echo
>  define_category_names "$1"
>  echo
>  print_command_list "$1"
> -echo
> -print_config_list
> diff --git a/generate-configlist.sh b/generate-configlist.sh
> new file mode 100755
> index 0000000000..eca6a00c30
> --- /dev/null
> +++ b/generate-configlist.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +
> +echo "/* Automatically generated by generate-configlist.sh */"
> +echo
> +
> +print_config_list () {
> +	cat <<EOF
> +static const char *config_name_list[] = {
> +EOF
> +	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
> +	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
> +	sort |
> +	while read line
> +	do
> +		echo "	\"$line\","
> +	done

This while-read-echo was moved from generate-cmdlist.sh,
which has some logic to work with read-variable.

We're moving it out, I think apply this diff on top of it will make the code easier to read.

diff --git a/generate-configlist.sh b/generate-configlist.sh
index eca6a00c30..163dbf30bb 100755
--- a/generate-configlist.sh
+++ b/generate-configlist.sh
@@ -10,10 +10,7 @@ EOF
 	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
 	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
 	sort |
-	while read line
-	do
-		echo "	\"$line\","
-	done
+	sed 's/^/	"/; s/$/",/'
 	cat <<EOF
 	NULL,
 };



-- 
Danh
