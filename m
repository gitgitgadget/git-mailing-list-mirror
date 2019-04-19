Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC33F20248
	for <e@80x24.org>; Fri, 19 Apr 2019 18:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfDSShM (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 14:37:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46719 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfDSShL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 14:37:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so7832770wrw.13
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z2vU6DebyIIfFO2E5mkm8/yZEw/q++sGvkj+PawdOm8=;
        b=MKhp+daxZsR7sMwG2v/ET0GljmmkGuffxrO37OUpiHHE51gbnxO98tW8sGYCrPMZ1Y
         jd0tsTENd0nWcghGEhGBg+M/cG+Et8XV41rymDo61L9HDFBPrJyYA8b7xbGrqS9vBpOI
         Zey2j2zHeAARW+ilwCHmSg7TJz1EwQA5JvDpYUZn0MkWZk/ZGRMzgHby8RM0V5S1UBsp
         jzZmq6T3qICTEw+H+JejlXwMksohlJXbG1d9WLyoQ8TRH2wNB/9m3pYmuyPcauuwwNlx
         uVNMzNdV+0jaraGSbEvJn886lwrVZ75y9rixWuWtvsSKZOyeZY7lOzaaFuqHNqBYBSBf
         aQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z2vU6DebyIIfFO2E5mkm8/yZEw/q++sGvkj+PawdOm8=;
        b=HcioSFIiovABEF3Ujr58PN3QkkQIVR5eocGkDLqEFSAmrRulkRrDGyDxctcU0Iqlwt
         6VeebOvUp2O6EtxqJ4IVx3d9oOEirE/KFGMdN/knSW5SJMR8N2XOl/eaNtwBW5l9iD2V
         1YWTriQ2H73vlUX2E4rLJAabfm7bZEwRvLo07mgrespxJ2pogmL5VxIsAAzV7CB50MlK
         rWVzqK83SYGzSO/AAErzFHLWhOuJJ8d5E51HbFKJeQh9pbHJunbagTOsvLqlWFxKXNQq
         HqhEqcfiuXiCo8Zix2hKEkwjuY8FvD5o5rmnuLnOT+rZ0bbb4OzxSezFnzqWx6lXSfSu
         HjVQ==
X-Gm-Message-State: APjAAAUlFRTUw1LO+Ew8sw/wZCtUqdGxmVxL5dIDMWszxZiMB3xgkRUv
        iYv3fdBOkvc1FMrMf1k2O2ta4d5gfb0=
X-Google-Smtp-Source: APXvYqyVJmFxZ8q89JFigfYsN4blhfazFBtEuq1KxVIP7mW8hf2ejelUW18CPHqEeqtvunkXeM/gZg==
X-Received: by 2002:a05:6000:1:: with SMTP id h1mr1441254wrx.263.1555651999005;
        Thu, 18 Apr 2019 22:33:19 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id s2sm2016408wrr.50.2019.04.18.22.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 22:33:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] untracked-cache: simplify parsing by dropping "next"
References: <20190418211408.GA18011@sigill.intra.peff.net>
        <20190418211738.GB18520@sigill.intra.peff.net>
Date:   Fri, 19 Apr 2019 14:33:17 +0900
In-Reply-To: <20190418211738.GB18520@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 18 Apr 2019 17:17:38 -0400")
Message-ID: <xmqq5zraeezm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When we parse an on-disk untracked cache, we have two pointers, "data"
> and "next". As we parse, we point "next" to the end of an element, and
> then later update "data" to match.
>
> But we actually don't need two pointers. Each parsing step can just
> update "data" directly from other variables we hold (and we don't have
> to worry about bailing in an intermediate state, since any parsing
> failure causes us to immediately discard "data" and return).

;-)  

My first reaction was "you can do so now you have introduced
eos--why didn't you do that in the previous step?", but losing
'next' from the varint parsing step would certainly have been
possible even before that change.  So I agree that it makes much
more sense to do this step separately from the previous one.

The code after the patch certainly reads easier and simpler.

Thanks.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  dir.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 7b0513c476..17865f44df 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2732,50 +2732,44 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
>  			struct read_data *rd)
>  {
>  	struct untracked_cache_dir ud, *untracked;
> -	const unsigned char *next, *data = rd->data, *end = rd->end;
> +	const unsigned char *data = rd->data, *end = rd->end;
>  	const unsigned char *eos;
>  	unsigned int value;
>  	int i, len;
>  
>  	memset(&ud, 0, sizeof(ud));
>  
> -	next = data;
> -	value = decode_varint(&next);
> -	if (next > end)
> +	value = decode_varint(&data);
> +	if (data > end)
>  		return -1;
>  	ud.recurse	   = 1;
>  	ud.untracked_alloc = value;
>  	ud.untracked_nr	   = value;
>  	if (ud.untracked_nr)
>  		ALLOC_ARRAY(ud.untracked, ud.untracked_nr);
> -	data = next;
>  
> -	next = data;
> -	ud.dirs_alloc = ud.dirs_nr = decode_varint(&next);
> -	if (next > end)
> +	ud.dirs_alloc = ud.dirs_nr = decode_varint(&data);
> +	if (data > end)
>  		return -1;
>  	ALLOC_ARRAY(ud.dirs, ud.dirs_nr);
> -	data = next;
>  
>  	eos = memchr(data, '\0', end - data);
>  	if (!eos || eos == end)
>  		return -1;
>  	len = eos - data;
> -	next = eos + 1;
>  
>  	*untracked_ = untracked = xmalloc(st_add3(sizeof(*untracked), len, 1));
>  	memcpy(untracked, &ud, sizeof(ud));
>  	memcpy(untracked->name, data, len + 1);
> -	data = next;
> +	data = eos + 1;
>  
>  	for (i = 0; i < untracked->untracked_nr; i++) {
>  		eos = memchr(data, '\0', end - data);
>  		if (!eos || eos == end)
>  			return -1;
>  		len = eos - data;
> -		next = eos + 1;
>  		untracked->untracked[i] = xmemdupz(data, len);
> -		data = next;
> +		data = eos + 1;
>  	}
>  
>  	rd->ucd[rd->index++] = untracked;
