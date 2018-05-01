Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 932B121841
	for <e@80x24.org>; Tue,  1 May 2018 09:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeEAJgJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 05:36:09 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45006 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbeEAJgI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 05:36:08 -0400
Received: by mail-lf0-f65.google.com with SMTP id h197-v6so15600663lfg.11
        for <git@vger.kernel.org>; Tue, 01 May 2018 02:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ALMSseFrhooH47+sLQ1cof6u5yRDDCN8XHq5YwRCMAo=;
        b=XUj/S7grZlHIY7kss0kLR4xKNXKNrLw+8uV7Mh/YpDRacmZwMfBdE8EwG048jeh2uI
         JeCBC6uiHvlSU0K0+VFOOFwNQq5uUG4f3huAjkApNILaDyzAk4tIqIhRBojhrqAVLvSJ
         d7K4OgykQZXBoEasfTLAyWztducCj4E/SJwGFmIkW/Jq7Rcclw2iXtcPdu5+kkkzgtB/
         IeXGwukSAtTSKyyTRmkjvnMm0QqIMvOrDWszcWe51n0SucuQ8P3EXqpaEc8Vz8c8v5JL
         5ka9WtMokw2uVYSuKSr+CGQqBKiDrxtRSl8kF1k5Xi9qqGe289XzdrDO8iRp6Oi1Ma99
         RYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ALMSseFrhooH47+sLQ1cof6u5yRDDCN8XHq5YwRCMAo=;
        b=bW0FA7vlswwOZj4LYvcLHIywcDcMLbXDpBvaYwinDcU3uSRKHP80YWJPQTD9w/eu2S
         LKNsrnQYscbzlgRC4Rpfqzx+yKLyysnAotxAeBh7B+b5pI5w314TgWUVsM28yFDzI71E
         asoYYnC7mryn2wtcsVKGxLg2UZGmdEEkoHaxDT9K8+xsra7C9OqbfDv9ucM4ed3X9dQS
         Qsf9zfDBwNpD67l1kyAr+f7N/FjC2JRaXiZ32yMC4aqxj0Ur7og+fye5xYvIGnY8xCUK
         YcAYwVUjzCpv+rch0IhDqryie5txSH8C7KxUf0si9dkyfrsqF40Vo2e6UItOOLbFJJP/
         9TFg==
X-Gm-Message-State: ALQs6tCzZZdrWIs89uXwdpYG0moSgf6GZh6vDQdzgpKd9FGM28nURl88
        pQ1I4PY2WiKiybnsAAjSIho=
X-Google-Smtp-Source: AB8JxZroJ6ajUYfScJA4GO3O/PAS+8VCuVl0MyIYyOzzJMogp3qbGCtERcTVgxJqjDTgI+RCm83pMw==
X-Received: by 2002:a2e:8693:: with SMTP id l19-v6mr3879863lji.91.1525167366892;
        Tue, 01 May 2018 02:36:06 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x24-v6sm1880814ljj.54.2018.05.01.02.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 02:36:05 -0700 (PDT)
Date:   Tue, 1 May 2018 11:36:03 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 01/41] cache: add a function to read an object ID from a
 buffer
Message-ID: <20180501093603.GA15820@duynguyen.home>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423233951.276447-2-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 11:39:11PM +0000, brian m. carlson wrote:
> diff --git a/cache.h b/cache.h
> index bbaf5c349a..4bca177cf3 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1008,6 +1008,11 @@ static inline void oidclr(struct object_id *oid)
>  	memset(oid->hash, 0, GIT_MAX_RAWSZ);
>  }
>  
> +static inline void oidread(struct object_id *oid, const unsigned char *hash)
> +{
> +	memcpy(oid->hash, hash, the_hash_algo->rawsz);

If performance is a concern, should we go with GIT_MAX_RAWSZ instead
of the_hash_algo->rawsz which gives the compiler some more to bypass
actual memcpy function and generate copy code directly?

If it is not a performance problem, should we avoid inline and move
the implementation somewhere?

> +}
> +
>  
