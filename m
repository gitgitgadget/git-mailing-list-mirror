Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F1F620281
	for <e@80x24.org>; Mon,  2 Oct 2017 23:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750936AbdJBX0k (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 19:26:40 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:52135 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdJBX0i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 19:26:38 -0400
Received: by mail-pg0-f53.google.com with SMTP id u144so1077558pgb.8
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 16:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N1aRqIYVc03riyA6MXzPAgMFUynuY4WUHzS3eIx6Ko0=;
        b=Zcj/sbetjSHKeYJQemggJhlex3ypLMApmtQRXu/D27noNRtQ+tx0QW+YnH0iAlHBFl
         2IpZjrPnkej95kPqpxITm+6ENlpygx0VjRLNFczLvLj2FrFjU7M2/6EOdQlOia8bG1h3
         boW+UTSy5MNzvQ7GxBLVB0NfrgRJdKwdavmQRr5/eSuPQvbxalFJDrlNzrI1QMYJhAOo
         c55NeE+p0HzxPYPDsrvhUqPJOfQ1jO9ZIf7OqG2dRRhw6ofwEYFPqzddqhTyCHgGvZJX
         NxrpFyw3gAkjnHd9MFO9qQcP90661RmumrztGNRD/WPsZQUK0IjRMZ6BT7no7tIbo40N
         phVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N1aRqIYVc03riyA6MXzPAgMFUynuY4WUHzS3eIx6Ko0=;
        b=tToVP07deic+QnkE28+RKpRQwO+QVGlRLoEO1oAZNxRhns+t8mPFuKCi2nFddZxDxd
         WLdQ0eiwDDCToMWXCTXbMnGurqCynFoF304MJK/guPeHEjE36QJT3da3jWzQvYagVYYX
         gOowVw1yq9plZdZgqNhpcLbQ1STQXwEm5yPA9JokUG3bRO7wGWylsQ02zaUEdZim8LUe
         xOKjNQqibyTBfZh3aEGkjcSsZCm4kEQxV/rWZDcdv/OzegnMD2ULl2rWqln8lkSFDHRW
         CHEcexmvSR5Pgp7F79OQCTHJAYqVk3nmhmOiMXaZoyuHEgnX32yl7I+UZtFF9g3TUGFj
         lvKQ==
X-Gm-Message-State: AMCzsaUOgXoC8i60b5gIFaHosB3aoYVdWG/45MZdUfpZ98OwQLj5douo
        /U3HdfUDp2n9liuU2/8KLRNG2w==
X-Google-Smtp-Source: AOwi7QC1n6iR9jc4oApx2DC8pnAR9b9nZSo4dhRosxkryM/LpEuWQ3IudSN1rFtLt8RFNP64n21EFA==
X-Received: by 10.98.103.143 with SMTP id t15mr2441854pfj.270.1506986798088;
        Mon, 02 Oct 2017 16:26:38 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:585e:6aa2:d831:b9e9])
        by smtp.gmail.com with ESMTPSA id h125sm3935175pfg.84.2017.10.02.16.26.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 Oct 2017 16:26:37 -0700 (PDT)
Date:   Mon, 2 Oct 2017 16:26:35 -0700
From:   Brandon Williams <bmwill@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 15/24] refs: convert read_ref_at to struct object_id
Message-ID: <20171002232635.GD5189@google.com>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
 <20171001220831.214705-16-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171001220831.214705-16-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/01, brian m. carlson wrote:
> Convert the callers and internals, including struct read_ref_at_cb, of
> read_ref_at to use struct object_id.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/show-branch.c |  5 ++---
>  refs.c                | 34 +++++++++++++++++-----------------
>  refs.h                |  2 +-
>  sha1_name.c           |  3 +--
>  4 files changed, 21 insertions(+), 23 deletions(-)
> 
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index 722a7f4bec..8ef8ad10c5 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -731,7 +731,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
>  				/* Ah, that is a date spec... */
>  				timestamp_t at;
>  				at = approxidate(reflog_base);
> -				read_ref_at(ref, flags, at, -1, oid.hash, NULL,
> +				read_ref_at(ref, flags, at, -1, &oid, NULL,
>  					    NULL, NULL, &base);
>  			}
>  		}
> @@ -743,8 +743,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
>  			timestamp_t timestamp;
>  			int tz;
>  
> -			if (read_ref_at(ref, flags, 0, base+i, oid.hash, &logmsg,
> -					&timestamp, &tz, NULL)) {
> +			if (read_ref_at(ref, flags, 0, base + i, &oid, &logmsg, &timestamp, &tz, NULL)) {

This line maybe got too long?

> diff --git a/sha1_name.c b/sha1_name.c
> index 7de12743f3..f0ec3f0454 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -697,8 +697,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
>  				return -1;
>  			}
>  		}
> -		if (read_ref_at(real_ref, flags, at_time, nth, oid->hash, NULL,
> -				&co_time, &co_tz, &co_cnt)) {
> +		if (read_ref_at(real_ref, flags, at_time, nth, oid, NULL, &co_time, &co_tz, &co_cnt)) {
>  			if (!len) {
>  				if (starts_with(real_ref, "refs/heads/")) {
>  					str = real_ref + 11;

This one too.

-- 
Brandon Williams
