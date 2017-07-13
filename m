Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28FB220365
	for <e@80x24.org>; Thu, 13 Jul 2017 20:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753092AbdGMUwI (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 16:52:08 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35342 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbdGMUwH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 16:52:07 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so8143358pgc.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 13:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=O8lshtJ8kmu1z3Esv3/OaABFVGEWc9k2jQDSqzO7b5w=;
        b=oefi/55eVwp+8iIpgYqjRismMSUDUYUpBKhgmGpCw58MKEpYJB9fa6WMUFK1N7zrOe
         fxpd3IMwsSuHHpv+eq4LCdjDL+So7ktnFc5Sx19SnWBggrC3HsTGIwEKfgykK5oikQG6
         FcLbnolZm6vC85EJCB0KMbU1xG3LMvVNFMG6uvaXm3evqPKmjUh7lyFxQ1D5aLmwVEaq
         tOZP3kqLGD4BOmjXKfVqXoKx9SB8uuzxkPzk/w4f4ZwrWt8VjZul664pRKkLdxiC7+0Y
         brB5cAceazzxQg7T+SZP0eYnUFoZBilAX1QipHaVmInpuzjgxuLPNO57Q2VzvmoS5O9l
         JWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=O8lshtJ8kmu1z3Esv3/OaABFVGEWc9k2jQDSqzO7b5w=;
        b=kM1/BbCgCpZhGiY0aM9w85LzkTuqCMaLeAyXWHw3+PfwAYx4rl5DT4zxms5Mq8jFxz
         ucaTLTb19BFFfLwpjTkuVs3m6OK5Qv3TW/nixSOA3B7RYTbeDXVc1QtpmgM5SmxjaQ9R
         Ag1Darbi5BBDNEQMJcDBZFi7CTCuqZB+0ubm0nWLzDD+9iuTKHITo/zmFQMJJDWT6dGi
         J8zAYLozcTH47tqe5V63fcLiwwdpo8JzUUunRbJTJ+5GJ1DWhnmx1dmcnA11v98CXwUL
         3PwOy1ll5WHOlaN/nFQDKnY8v9iNx4EM5loSw52Ax/lvFJRQj9Zd4X9ytyN4W948ER00
         h/QA==
X-Gm-Message-State: AIVw111ws5ESt12QaFrycmBogmDjmQ/F57NGR0H5fPehPZV6MYQ1UHTr
        8ilIDzeFurFv4kZaT/I=
X-Received: by 10.99.186.13 with SMTP id k13mr11482933pgf.0.1499979126620;
        Thu, 13 Jul 2017 13:52:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id b8sm16023470pfd.65.2017.07.13.13.52.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 13:52:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] tag: convert gpg_verify_tag to use struct object_id
References: <20170713004415.5051-1-sbeller@google.com>
        <20170713004415.5051-2-sbeller@google.com>
Date:   Thu, 13 Jul 2017 13:52:05 -0700
In-Reply-To: <20170713004415.5051-2-sbeller@google.com> (Stefan Beller's
        message of "Wed, 12 Jul 2017 17:44:15 -0700")
Message-ID: <xmqq4lugukju.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> index f9a5f7535a..ed8329340f 100644
> --- a/builtin/verify-tag.c
> +++ b/builtin/verify-tag.c
> @@ -56,20 +56,21 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	while (i < argc) {
> -		unsigned char sha1[20];
> +		struct object_id oid;
>  		const char *name = argv[i++];
> -		if (get_sha1(name, sha1)) {
> +
> +		if (get_oid(name, &oid)) {
>  			had_error = !!error("tag '%s' not found.", name);
>  			continue;
>  		}

This part is already done, it seems, in bc/object-id topic, even
though other parts are not yet done?

>  
> -		if (gpg_verify_tag(sha1, name, flags)) {
> +		if (gpg_verify_tag(&oid, name, flags)) {
>  			had_error = 1;
>  			continue;
>  		}
>  
>  		if (fmt_pretty)
> -			pretty_print_ref(name, sha1, fmt_pretty);
> +			pretty_print_ref(name, oid.hash, fmt_pretty);
>  	}
>  	return had_error;
>  }
> diff --git a/tag.c b/tag.c
> index 47f60ae151..7e10acfb6e 100644
> --- a/tag.c
> +++ b/tag.c
> @@ -33,7 +33,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
>  	return ret;
>  }
>  
> -int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report,
> +int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
>  		unsigned flags)
>  {
>  	enum object_type type;
> @@ -41,20 +41,20 @@ int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report,
>  	unsigned long size;
>  	int ret;
>  
> -	type = sha1_object_info(sha1, NULL);
> +	type = sha1_object_info(oid->hash, NULL);
>  	if (type != OBJ_TAG)
>  		return error("%s: cannot verify a non-tag object of type %s.",
>  				name_to_report ?
>  				name_to_report :
> -				find_unique_abbrev(sha1, DEFAULT_ABBREV),
> +				find_unique_abbrev(oid->hash, DEFAULT_ABBREV),
>  				typename(type));
>  
> -	buf = read_sha1_file(sha1, &type, &size);
> +	buf = read_sha1_file(oid->hash, &type, &size);
>  	if (!buf)
>  		return error("%s: unable to read file.",
>  				name_to_report ?
>  				name_to_report :
> -				find_unique_abbrev(sha1, DEFAULT_ABBREV));
> +				find_unique_abbrev(oid->hash, DEFAULT_ABBREV));
>  
>  	ret = run_gpg_verify(buf, size, flags);
>  
> diff --git a/tag.h b/tag.h
> index fdfcb4a84a..d469534e82 100644
> --- a/tag.h
> +++ b/tag.h
> @@ -17,7 +17,7 @@ extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long si
>  extern int parse_tag(struct tag *item);
>  extern struct object *deref_tag(struct object *, const char *, int);
>  extern struct object *deref_tag_noverify(struct object *);
> -extern int gpg_verify_tag(const unsigned char *sha1,
> +extern int gpg_verify_tag(const struct object_id *oid,
>  		const char *name_to_report, unsigned flags);
>  
>  #endif /* TAG_H */
