Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DEF421841
	for <e@80x24.org>; Tue,  1 May 2018 10:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeEAKWs (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 06:22:48 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:39374 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeEAKWr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 06:22:47 -0400
Received: by mail-lf0-f46.google.com with SMTP id j193-v6so15737990lfg.6
        for <git@vger.kernel.org>; Tue, 01 May 2018 03:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DuLqy4hO4XczB+UwV9AYy0oZ1aPlty10MUiq9mkOUWo=;
        b=Pgs3bM7kpWuiDJ6RjE/bWpJcisOr4dxttWwCp41Li8zPC0AWIkLzHXfGMJqnwMuG2m
         M64cN0cuJ8Uf8uQS/d515CxUBiVPvtFG56nTnjJPcDLa0+mLfL7NFvEa076aWVf2Fi21
         2utBBbrRdQipcOQ8Qx7ieRWBRl37tpcud9LemUS/qqf5r4kQx7/dbDhxlS1lMuMimvvg
         U0DtJ2TO2v7zg8XSCa7NrrprFz6KDisHiTJdSlqn+qyIb/hjLTetG7StKII+nfakMBy2
         hwQSTnf9JDjlTZEU0NKo+6ebXEc1nDnmF6hvEVMAKtePy6NMTVEdz9n4ek8F2GpMO0t9
         WO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DuLqy4hO4XczB+UwV9AYy0oZ1aPlty10MUiq9mkOUWo=;
        b=Q6WMm/dwqFJSgarGAGEmpjaOIzFNMEeVMK07OxfuznpHwP+PvAgfuj5tTu9eC2ee1g
         eMOu6HcKtAT/0xSGHOw0+mrtRJMhzznF4DHcu+uPBJPo4wS9DAmMxH8AeEYOhkeN99aE
         ogcBpWblVPnIRC3jy2wfD4+RsddBtXRVeOo++w/ElJ08CVGX4mzHhlDRhkpCsTSAwOqW
         8RBkYD9G7gf9sWWR2LB/tI79aN4F+hn8g3zVjxxZV+/4mvknBksx1c1Z5MtqeAD6eqWZ
         coKimcjEvHGGu5kfti1PNjI9rd1Kut18y8Eiy3uQr0DYNJ7elc6hQ+NHXOe2H/n+fnER
         MmrQ==
X-Gm-Message-State: ALQs6tCOtQKziauwXj58XrvQVK5bZxysDIih3JInqh7AEY8eqFQQT5XM
        EuUt83V+6Noh4NEqmZsosmxs3g==
X-Google-Smtp-Source: AB8JxZq6xvZNVuJL7okaTF9i9IJpmLUpB50eZSTrABDv3g2IqOsfCQzV15xhLp39Fei/mF7JxOapIQ==
X-Received: by 2002:a2e:8759:: with SMTP id q25-v6mr9972210ljj.66.1525170166337;
        Tue, 01 May 2018 03:22:46 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s9-v6sm1965153lfk.28.2018.05.01.03.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 03:22:45 -0700 (PDT)
Date:   Tue, 1 May 2018 12:22:43 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 08/41] packfile: abstract away hash constant values
Message-ID: <20180501102243.GE15820@duynguyen.home>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-9-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423233951.276447-9-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 11:39:18PM +0000, brian m. carlson wrote:
> There are several instances of the constant 20 and 20-based values in
> the packfile code.  Abstract away dependence on SHA-1 by using the
> values from the_hash_algo instead.

While we're abstracting away 20. There's the only 20 left in
sha1_file.c that should also be gone. But I guess you could do that
later since you need to rename fill_sha1_path to
fill_loose_object_path or something.


> @@ -507,15 +509,15 @@ static int open_packed_git_1(struct packed_git *p)
>  			     " while index indicates %"PRIu32" objects",
>  			     p->pack_name, ntohl(hdr.hdr_entries),
>  			     p->num_objects);
> -	if (lseek(p->pack_fd, p->pack_size - sizeof(sha1), SEEK_SET) == -1)
> +	if (lseek(p->pack_fd, p->pack_size - hashsz, SEEK_SET) == -1)
>  		return error("end of packfile %s is unavailable", p->pack_name);
> -	read_result = read_in_full(p->pack_fd, sha1, sizeof(sha1));
> +	read_result = read_in_full(p->pack_fd, hash, hashsz);
>  	if (read_result < 0)
>  		return error_errno("error reading from %s", p->pack_name);
> -	if (read_result != sizeof(sha1))
> +	if (read_result != hashsz)
>  		return error("packfile %s signature is unavailable", p->pack_name);
> -	idx_sha1 = ((unsigned char *)p->index_data) + p->index_size - 40;
> -	if (hashcmp(sha1, idx_sha1))
> +	idx_hash = ((unsigned char *)p->index_data) + p->index_size - hashsz * 2;
> +	if (hashcmp(hash, idx_hash))

Since the hash size is abstracted away, shouldn't this hashcmp become
oidcmp? (which still does not do the right thing, but at least it's
one less place to worry about)

Same comment for other hashcmp in this patch.

> @@ -675,7 +677,8 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
>  	p->pack_size = st.st_size;
>  	p->pack_local = local;
>  	p->mtime = st.st_mtime;
> -	if (path_len < 40 || get_sha1_hex(path + path_len - 40, p->sha1))
> +	if (path_len < the_hash_algo->hexsz ||
> +	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->sha1))

get_sha1_hex looks out of place when we start going with
the_hash_algo. Maybe change to get_oid_hex() too.

> @@ -1678,10 +1683,10 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
>  
>  	index_lookup = index_fanout + 4 * 256;
>  	if (p->index_version == 1) {
> -		index_lookup_width = 24;
> +		index_lookup_width = hashsz + 4;

You did good research to spot this 24 constant ;-)

--
Duy
