Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D0D920248
	for <e@80x24.org>; Thu, 21 Mar 2019 05:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfCUFtz (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 01:49:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38693 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfCUFtz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 01:49:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id g12so5208040wrm.5
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 22:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=oy3Cl9M/JPa3KVI/bF38dLLh9GIZX4vSOy7Pj9IsD+0=;
        b=JwN7GyEQDRacsyRIr20IY/kU/oPIBj/Ab+Xgesrz/WslU2gaVxGgCdyCA/moLIj+5D
         IJ1AiF/y/ewnH2SjxvVNey3akPqZnXiYMsp4/8dTkhwRKp6lmyTuOvDBnH0WFuxtVcx6
         uVRIMBfmf+Vo4X3y6yTs2VRqIs4mWueUwkB5BZX/kVkxzUcNDuJ5IsFVOuxe/NepTTYU
         Y7Fh2gye3N2qBI7+DioiC2BxXb6vxMrSvGAk/G80bSjBUuwix34mGWjWNIyXK+Zvu1P9
         Ei5PBrDtabcyNkSOlT29Vue4yVK40Ff1FkdFRfTaOOj2UkkVZQql5M9qsjNNDIl5nnds
         bRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=oy3Cl9M/JPa3KVI/bF38dLLh9GIZX4vSOy7Pj9IsD+0=;
        b=drOLCjgmK+oBWH7hbxlua6Isut1d50kwcpPQ5ngxJrzLhp3BJa+d5xpeDQ/9up6PxA
         pTPG++3sY8aEHWc2AAR7KeucdQGh8HYdtxV4OT5cULut+c0yxdywxkL7Zis9ZXQYp4h6
         z+okQOuA6cX9/KbwRM8z+zBoQteyGpoOyt88UupUdJByuo/yl5alasW3dUaQVbGIUABv
         zwjOnHVLSWLsqBqFtsGFZZbSuai+GSWegOC+Sec7qL3ZXSq2HNdPcSBz1M+i+2I/kh7K
         9ijpngIHdIKZh7Y8znPAkJfIAtGhPRNqOcimDa0CdWLvN5s4OAzjV4EXBs5CK89EbFJq
         ddXA==
X-Gm-Message-State: APjAAAVxMoeMdWrbKLA/ijaRT23ZADfJKMVSi9QXzldGbd4+K+iOlBCu
        JPBGl4Pm7z6ToJVvZXffrpE=
X-Google-Smtp-Source: APXvYqwIzTRpmRi+lhSWqV9Cc+9243y5qgDduHjWoSH8doNGE2IzoYIMDsKuQGn2yb/Cl0YpVhGNaQ==
X-Received: by 2002:adf:e6cc:: with SMTP id y12mr1240433wrm.82.1553147393600;
        Wed, 20 Mar 2019 22:49:53 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c126sm4033554wma.0.2019.03.20.22.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 22:49:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit: improve error message in "-a <paths>" case
References: <20190320102906.12917-1-pclouds@gmail.com>
Date:   Thu, 21 Mar 2019 14:49:52 +0900
In-Reply-To: <20190320102906.12917-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 20 Mar 2019 17:29:06 +0700")
Message-ID: <xmqqh8bwsrnj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> I did something stupid today and got
>
>     $ git commit -a --fixup= @^
>     fatal: Paths with -a does not make sense.
>
> which didn't make any sense (at least for the first few seconds).
>
> Include the first path(spec) in the error message to help spot the
> problem quicker. Now it shows
>
>     fatal: paths '@^ ...' with -a does not make sense
>
> which should ring some bell because @^ should clearly not be considered
> a path.

Makes sort of sense.  Would it break to blindly use argv[0] if the
user had an explicit double-dash "--" disambiguator?

>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/commit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index f17537474a..7f9aa032b6 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1194,7 +1194,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  	handle_untracked_files_arg(s);
>  
>  	if (all && argc > 0)
> -		die(_("Paths with -a does not make sense."));
> +		die(_("paths '%s ...' with -a does not make sense"),
> +		    argv[0]);
>  
>  	if (status_format != STATUS_FORMAT_NONE)
>  		dry_run = 1;
