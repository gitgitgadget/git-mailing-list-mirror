Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 170EC1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 02:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeBECSx (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 21:18:53 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46603 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeBECSo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 21:18:44 -0500
Received: by mail-pl0-f65.google.com with SMTP id 36so10790535ple.13
        for <git@vger.kernel.org>; Sun, 04 Feb 2018 18:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ejJdXcb34pHLc1hHX+FsKAmwcuFCGdaDADcuhVFckKo=;
        b=g2fy0QdXighgJ6CaB26JZOyEsYOCyLYxtGex7os05j2xGMs9C+zn6+Kfu88YQaCwss
         G5b37ncjXjhbIjO2nIWuSgc71uRTZwKeLhnQ37YQW9OhsO2ddM4ElRoioYgJvXqT5Y5z
         1q8K+FXXNSIqxkbPFloOL+m/yPMgRIaAFKh/C1fof2qKg9FIfdkeSmdVGQ5fySnA4qtl
         BtBcBf8zzp9jwW4B4YJG0sKPN1RMqcYbEOD7hxoerYlPBl60JFb2rL0IPecuKjXPf8hc
         p8Z8okEGo7OWvLiD8UJGaFdgoCwEX2HgraKKI4MUKZajVs7Mnq67Bo60gv6PIqJRFmSV
         nFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ejJdXcb34pHLc1hHX+FsKAmwcuFCGdaDADcuhVFckKo=;
        b=W6EAhJkPA2IK8f7zE8C0QPUqC7ljfi/wDn09Kjuktsc0/GlLtyodJmzXKDRuuejnT+
         61fnjcYewdayuTewF2tS74nezZ2bfQM7oArxhpnjqKZQpzqTwdkNv6yqxDyjra7T8FaQ
         fYkM8MrW2r+Uw7Bg5O8xAjc4BAMv2hByh2hzWWB4QwVEmHK9WWk9Gcr18kX7XkKf8BT5
         kbNfV0JSu8sJBtND0eZgOB+/MHdUCZnVgT1UzXpuopgjooqouq+Q0PygeSlU0bvdrAxt
         U3lOLnhcxZGhC0N4d9MRD5s0MqxRgQ574ybwSYYr0b96ylRhIN2i4sNMxu0lE8WNbE6p
         xbmQ==
X-Gm-Message-State: AKwxytdX7JmsMOa0SLuI+JFEoGpyMrY0WKZvLej25/IIEhBZOeOVWm0t
        zxCEioqY7XWrANmtPPhuw6qJ3g==
X-Google-Smtp-Source: AH8x227CRRw/ZULBieIoBm41ftvAgq9drgYyi5bT54GBn5ci/EdkwvXEr5GWwSIPo2nE8pxj6Gbw2w==
X-Received: by 2002:a17:902:a607:: with SMTP id u7-v6mr26609232plq.71.1517797124463;
        Sun, 04 Feb 2018 18:18:44 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id y18sm15675996pfa.175.2018.02.04.18.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Feb 2018 18:18:43 -0800 (PST)
Date:   Mon, 5 Feb 2018 09:18:33 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/3] worktree: teach "add" to check out existing
 branches
Message-ID: <20180205021833.GB17847@duynguyen.dek-tpc.internal>
References: <20180121120208.12760-1-t.gummerer@gmail.com>
 <20180204221305.28300-1-t.gummerer@gmail.com>
 <20180204221305.28300-4-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180204221305.28300-4-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 04, 2018 at 10:13:05PM +0000, Thomas Gummerer wrote:
> -	if (opts->new_branch)
> +	if (opts->checkout_existing_branch)
> +		fprintf(stderr, _(", checking out existing branch '%s'"),
> +			refname);
> +	else if (opts->new_branch)
>  		fprintf(stderr, _(", creating new branch '%s'"), opts->new_branch);

I wonder if "creating branch" and "checkout out branch" are enough.

> @@ -423,14 +427,25 @@ static int add(int ac, const char **av, const char *prefix)
>  	if (ac < 2 && !opts.new_branch && !opts.detach) {
>  		int n;
>  		const char *s = worktree_basename(path, &n);
> -		opts.new_branch = xstrndup(s, n);
> -		if (guess_remote) {
> -			struct object_id oid;
> -			const char *remote =
> -				unique_tracking_name(opts.new_branch, &oid);
> -			if (remote)
> -				branch = remote;
> +		const char *branchname = xstrndup(s, n);
> +		struct strbuf ref = STRBUF_INIT;
> +
> +		if (!strbuf_check_branch_ref(&ref, branchname) &&
> +		    ref_exists(ref.buf)) {
> +			branch = branchname;
> +			opts.checkout_existing_branch = 1;
> +			UNLEAK(branch);
> +		} else {
> +			opts.new_branch = branchname;
> +			if (guess_remote) {
> +				struct object_id oid;
> +				const char *remote =
> +					unique_tracking_name(opts.new_branch, &oid);

Deep indentation may be a sign that it's time to move all this code to
a separate function, maybe dwim_branch() or something.

> +				if (remote)
> +					branch = remote;
> +			}
>  		}
> +		strbuf_release(&ref);
>  	}
>  
>  	if (ac == 2 && !opts.new_branch && !opts.detach) {
