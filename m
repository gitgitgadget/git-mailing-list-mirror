Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E1781F404
	for <e@80x24.org>; Wed, 21 Mar 2018 22:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbeCUWj0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 18:39:26 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40329 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753865AbeCUWjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 18:39:25 -0400
Received: by mail-pl0-f66.google.com with SMTP id x4-v6so4038888pln.7
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 15:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IC+N3PpGy7RhXdFFvwav7gHJOl+ZJtMxcxCvtstnTF8=;
        b=mxrho8hzZzpfWICzdh8dHCs9zglD2PjUcoCX7ZMDUY8bZqU2OqVjjhBD08/jF4nhKa
         3qz0AM62UBIcc4Y83dU4BszYYVvWAbSt14q67Lbklv/N4qBUSRF7ZWCfmNXYzFOoHilr
         wW26WICtY7YbStgTd8Rk4ZwhpCO2mgPlwvO7DTmuTR9L5c98iwmJVm1sjWqgdOkrGcMq
         wGvLgs0iwoyxQnzQ5TLhyX+2s6NUm0gGcmtC3qM+5yzqzD1rzFvteK4YLPGSr6uo5bk5
         ToFe/DiQxf03d3QT54gN9qiH54j6PPJyCjAzajs+cIHhrcbvwtptKkNoLcbge7XM2CN4
         XZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IC+N3PpGy7RhXdFFvwav7gHJOl+ZJtMxcxCvtstnTF8=;
        b=qcDW76YHHXj5fWwgitGzQT+tKV0qRksLYfnWOjG+QmqbKz09U/4tpxKIgnTU1D5DBo
         vrs/1zSYIm3OwzRe3NnnJvP2AeO0AE4BeMC5YFwQhmbiOPEiShrtfXlxPSV3wdXyRxW5
         VpUHTol8MHcdCcyF29bIWv1BprbzC5jKlWlDuEKAmvSPNNOcFQ4ZYMWQtiZhgmoyGDBI
         0EYqU812Gz5sr7JZeMZgFln70x4VJRWRMRymaTY1jfviURpR98XS2PHiaRas99kQXpAO
         TNA9Nsy2Zz23ZObKjNE2iLCDbo5bWrzzu5WhnfSkFSFyYpOi3jlndY//lgofrRy2U/+l
         oNqw==
X-Gm-Message-State: AElRT7Hf02sSuiQkfVuO1H0EY2OS/8pBsy25WVJBI5QGy6iR06gpL+ND
        JfmQhUAsJjUX1iuoyab7uCDYkA==
X-Google-Smtp-Source: AG47ELsWjBgOlJBG+Ih2mA0Mpfegufqul6y8iSHw5RzQuk04fmBU7NtnCYp6CNhT7VxMb1hcp+Y/dw==
X-Received: by 2002:a17:902:a610:: with SMTP id u16-v6mr22139094plq.293.1521671964900;
        Wed, 21 Mar 2018 15:39:24 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id s78sm10161448pfa.161.2018.03.21.15.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 15:39:24 -0700 (PDT)
Date:   Wed, 21 Mar 2018 15:39:23 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 40/44] packfile: allow prepare_packed_git to handle
 arbitrary repositories
Message-ID: <20180321223923.GB202156@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
 <20180303113637.26518-41-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180303113637.26518-41-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Nguyễn Thái Ngọc Duy wrote:
> From: Stefan Beller <sbeller@google.com>
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---

This is an invalid conversion.

>  packfile.c | 18 +++++++++---------
>  packfile.h |  3 +--
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/packfile.c b/packfile.c
> index 52febba932..2276e2ad26 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -882,19 +882,19 @@ static void prepare_packed_git_mru(struct repository *r)
>  		list_add_tail(&p->mru, &r->objects.packed_git_mru);
>  }
>  
> -void prepare_packed_git_the_repository(void)
> +void prepare_packed_git(struct repository *r)
>  {
>  	struct alternate_object_database *alt;
>  
> -	if (the_repository->objects.packed_git_initialized)
> +	if (r->objects.packed_git_initialized)
>  		return;
> -	prepare_packed_git_one(the_repository, get_object_directory(), 1);
> -	prepare_alt_odb(the_repository);
> -	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
> -		prepare_packed_git_one(the_repository, alt->path, 0);
> -	rearrange_packed_git(the_repository);
> -	prepare_packed_git_mru(the_repository);
> -	the_repository->objects.packed_git_initialized = 1;
> +	prepare_packed_git_one(r, get_object_directory(), 1);

Calling get_object_directory() returns the_repository's object dir,
this needs to be replaced with r->objects.objectdir.

> +	prepare_alt_odb(r);
> +	for (alt = r->objects.alt_odb_list; alt; alt = alt->next)
> +		prepare_packed_git_one(r, alt->path, 0);
> +	rearrange_packed_git(r);
> +	prepare_packed_git_mru(r);
> +	r->objects.packed_git_initialized = 1;
>  }
>  
>  void reprepare_packed_git_the_repository(void)
> diff --git a/packfile.h b/packfile.h
> index ab5046938c..3fd9092472 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -34,8 +34,7 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
>  #define PACKDIR_FILE_GARBAGE 4
>  extern void (*report_garbage)(unsigned seen_bits, const char *path);
>  
> -#define prepare_packed_git(r) prepare_packed_git_##r()
> -extern void prepare_packed_git_the_repository(void);
> +extern void prepare_packed_git(struct repository *r);
>  #define reprepare_packed_git(r) reprepare_packed_git_##r()
>  extern void reprepare_packed_git_the_repository(void);
>  extern void install_packed_git(struct repository *r, struct packed_git *pack);
> -- 
> 2.16.1.435.g8f24da2e1a
> 

-- 
Brandon Williams
