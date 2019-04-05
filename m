Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C60A320248
	for <e@80x24.org>; Fri,  5 Apr 2019 12:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbfDEMBb (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 08:01:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44511 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEMBb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 08:01:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so7636276wrn.11
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 05:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Rkg5zXLogJYLCtaMiqSF7rn0O7Nuvs1ulTqbcBejGY=;
        b=cks/ZZDwdK4sZMSC0OKYSfbcELo2tkGx+Hw2xkfUJImlZb0nLvf4vCkJih1m6R2hYk
         WgVJLUuq+Lyye+3G7JTN6xF8WP31myrAHqjQiAJlxnBfL+x1nfivJ7ifQ8YR8W/qBjL6
         wIz9i/oYw+6kU18RPe+02qG6rt+wxU+DfIxUxDnCddQ6ZkmEx1myXIRDl7DSutuPLazH
         st8AFmbXUGYMkq4jzvDhp7E/Oaeho+25+xkLvWbieCoXgva+waBMhl6fZ0rBwQeSdyQo
         olFiMt45xg0VGaVXx56FF7VVy4wgSTx3XvUtWzEXA2q5W+taff/4XFcxEUIEGg8PYe1f
         JzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Rkg5zXLogJYLCtaMiqSF7rn0O7Nuvs1ulTqbcBejGY=;
        b=pWKI0UTLvcYUsH7XVOakEDZmi4CGMSpDGKqWbL1y7cL60jBfCI5AI1+HJH0vlFNgdl
         E3K+WuLvhirb0VIYovNTGL0KeeGqE7+eotSEy51d/AcHkvwoGBRS9g4psfYLu4yBjfWh
         6ZfYtTC71xpzS1lhyWe5nKQpLAP+eoZCoCgFXllk1TDDOWKzi9aeW2VEyOHghwrXidpP
         dUKWJ8tZgK+kmDZB4Nc0ov2Z8v87nx3nGxeOTvFDVqEZiYQa/UMFJmn4IqkjP1qwR4ea
         j02uIUpw/aGZ1g3SYLvVMBP6sbIi+R2+q7sao3HctoZEAnTsI11J536cUuQOdtMnyNle
         mCVg==
X-Gm-Message-State: APjAAAXU3CFN89mJC+dFtCdv6+htF4KEHwDPqwpRVgDPNrK7KIzdOdUi
        mvoR1oe5yPgQm9v17J06QENokwRw
X-Google-Smtp-Source: APXvYqxq2bXYd5kAKidWlxlTqvl69CbTDlHPzyYCMXI9xukAd98z08B7LMBx8n2faS+9uvl8zwAORQ==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr8316907wrr.190.1554465688118;
        Fri, 05 Apr 2019 05:01:28 -0700 (PDT)
Received: from szeder.dev (x4d0c3c70.dyn.telefonica.de. [77.12.60.112])
        by smtp.gmail.com with ESMTPSA id 7sm76923361wrc.81.2019.04.05.05.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 05:01:27 -0700 (PDT)
Date:   Fri, 5 Apr 2019 14:01:20 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/12] packfile: check midx coverage with .idx rather
 than .pack
Message-ID: <20190405120120.GA8796@szeder.dev>
References: <20190404232104.GA27770@sigill.intra.peff.net>
 <20190404232546.GD21839@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404232546.GD21839@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 04, 2019 at 07:25:46PM -0400, Jeff King wrote:
> When we have a .midx that covers many packfiles, we try to avoid opening
> the .idx for those packfiles. However, there are a few problems with the
> filename comparison we use:
> 
>   - we ask midx_contains_pack() about the .pack name, not the .idx name.
>     But it compares to the latter.
> 
>   - we compute the basename of the pack using strrchr() to find the
>     final slash. But that leaves an extra "/" at the start of our
>     string; we need to advance past it.
> 
>     That also raises the question of what to do when the name does not
>     have a slash at all. This should generally not happen (we always
>     find files in "pack/"), but it doesn't hurt to be defensive here.
> 
> The tests don't notice because there's nothing about opening those .idx
> files that would cause us to give incorrect output. It's just a little
> slower. The new test checks this case by corrupting the covered .idx,
> and then making sure we don't complain about it.

When the test suite is run with GIT_TEST_MULTI_PACK_INDEX=1, the
following tests fail with this patch:

  t1006-cat-file.sh                                (Wstat: 256 Tests: 111 Failed: 1)
    Failed test:  87
    Non-zero exit status: 1
  t5320-delta-islands.sh                           (Wstat: 256 Tests: 15 Failed: 10)
    Failed tests:  2-4, 6-10, 12-13
    Non-zero exit status: 1
  t5310-pack-bitmaps.sh                            (Wstat: 256 Tests: 46 Failed: 1)
    Failed test:  44
    Non-zero exit status: 1
  t5570-git-daemon.sh                              (Wstat: 256 Tests: 21 Failed: 1)
    Failed test:  10
    Non-zero exit status: 1


> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  packfile.c                  | 17 ++++++++++++++---
>  t/t5319-multi-pack-index.sh | 14 ++++++++++++++
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/packfile.c b/packfile.c
> index 054269ae5d..e7ca135ed5 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -472,6 +472,16 @@ static unsigned int get_max_fd_limit(void)
>  #endif
>  }
>  
> +static const char *pack_basename(struct packed_git *p)
> +{
> +	const char *ret = strrchr(p->pack_name, '/');
> +	if (ret)
> +		ret = ret + 1; /* skip past slash */
> +	else
> +		ret = p->pack_name; /* we only have a base */
> +	return ret;
> +}
> +
>  /*
>   * Do not call this directly as this leaks p->pack_fd on error return;
>   * call open_packed_git() instead.
> @@ -486,15 +496,16 @@ static int open_packed_git_1(struct packed_git *p)
>  	ssize_t read_result;
>  	const unsigned hashsz = the_hash_algo->rawsz;
>  
> -	if (!p->index_data) {
> +	if (!p->index_data && the_repository->objects->multi_pack_index) {
>  		struct multi_pack_index *m;
> -		const char *pack_name = strrchr(p->pack_name, '/');
> +		char *idx_name = pack_name_to_idx(pack_basename(p));
>  
>  		for (m = the_repository->objects->multi_pack_index;
>  		     m; m = m->next) {
> -			if (midx_contains_pack(m, pack_name))
> +			if (midx_contains_pack(m, idx_name))
>  				break;
>  		}
> +		free(idx_name);
>  
>  		if (!m && open_pack_index(p))
>  			return error("packfile %s index unavailable", p->pack_name);
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 8c4d2bd849..1ebf19ec3c 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -117,6 +117,20 @@ test_expect_success 'write midx with one v2 pack' '
>  
>  compare_results_with_midx "one v2 pack"
>  
> +test_expect_success 'corrupt idx not opened' '
> +	idx=$(test-tool read-midx $objdir | grep "\.idx\$") &&
> +	mv $objdir/pack/$idx backup-$idx &&
> +	test_when_finished "mv backup-\$idx \$objdir/pack/\$idx" &&
> +
> +	# This is the minimum size for a sha-1 based .idx; this lets
> +	# us pass perfunctory tests, but anything that actually opens and reads
> +	# the idx file will complain.
> +	test_copy_bytes 1064 <backup-$idx >$objdir/pack/$idx &&
> +
> +	git -c core.multiPackIndex=true rev-list --objects --all 2>err &&
> +	test_must_be_empty err
> +'
> +
>  test_expect_success 'add more objects' '
>  	for i in $(test_seq 6 10)
>  	do
> -- 
> 2.21.0.714.gd1be1d035b
> 
