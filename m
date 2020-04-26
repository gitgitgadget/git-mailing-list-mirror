Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE28C55186
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 01:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9148206DD
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 01:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaCFB/+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDZBKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 21:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725962AbgDZBKt (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 21:10:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C7C061A0C
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 18:10:48 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fu13so5117039pjb.5
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 18:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8FWrT9mjRnpWmHJmIWk1uwWWlzhoh4N1tjXnG3Cy+tE=;
        b=IaCFB/+fjwnb0umO3yfwcE/MXjU3QXYSHgc5BG9pmcVc1Yl5TqmMqJ8zCrwgwiYIXc
         PgPqbyD1o3mCqKqwrt/q1Turd/AGdevYSB/3lWwqBeZzf+VN+aFr+zoOZ2F9SgQ5jlfr
         C1fUSxIvXVi4dyw10LRMsTfB2MLQGi+vrkUBTII1+3NJQeaYtyGOWQq981nmucFM9JKS
         Y4Vy4s6QkCAKAMUgy49vcmranlxNSbEt38DvvWJfrKUTMa7FPhziC6NzZCjxqZZALpiv
         rJOruSN8/2yr4ZZYBuJIB+B0yM7LipdZ6VL4lP6KhsFrBy9tQTXb1ej2A2HMChqFjozB
         2tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8FWrT9mjRnpWmHJmIWk1uwWWlzhoh4N1tjXnG3Cy+tE=;
        b=q28h2MID0x0BA+SOOdLJOTrHU+XatviovmsNup1CE/eXj2UHggqM781GA8EU7kk2D8
         7kN6IlLrRahKNummJ52AXf4P5CbhxzExYJCCwqfe0J8MTUHPWWt8xOcxNiag94ITqQPw
         6EwVS0A0xI5xDnMU46Pal9769R+WCZREkbGPVWEY/RMQBG/yFvhz2jvDTqZF956iZCFS
         uwgkuAirZQEQruSI4bx5xAnldgqgY4p/kKz0ooFf/pxA+NjNRA3h5pfEZyiGwNIjOwYR
         KXXvaLc1MrHxfizhCEfGpzMav87TOS6DM0mW/giGT3HBzWNEDUPB6OvH8fChp8+4dhC5
         3TJA==
X-Gm-Message-State: AGi0Puaemir8Zvt21QP+RY7oZ9QaYgV8gx/sM9/C2r/m3b9nzpkbidta
        Z+Sm6ZvZ7IGQQRlOtvLXcDE=
X-Google-Smtp-Source: APiQypIsVrwd278sRCEkqoDWP/dhuDV2fgNme2zte1XpUhNRKj7WhS0CMMo0FOCNY4jjeuOZ5rMQ5w==
X-Received: by 2002:a17:90a:204b:: with SMTP id n69mr15072747pjc.176.1587863447751;
        Sat, 25 Apr 2020 18:10:47 -0700 (PDT)
Received: from gmail.com (174.247.233.35.bc.googleusercontent.com. [35.233.247.174])
        by smtp.gmail.com with ESMTPSA id i9sm8897160pfk.199.2020.04.25.18.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 18:10:46 -0700 (PDT)
Date:   Sat, 25 Apr 2020 18:10:44 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH 2/2] fetch-pack: in protocol v2, reset in_vain upon ACK
Message-ID: <20200426011044.GF877@gmail.com>
References: <cover.1587775989.git.jonathantanmy@google.com>
 <8499d5268e49b6b823b0b9312d77e41e311d9a75.1587775989.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8499d5268e49b6b823b0b9312d77e41e311d9a75.1587775989.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -404,6 +404,36 @@ test_expect_success 'in_vain not triggered before first ACK' '
>  	test_i18ngrep "Total 3 " trace
>  '
>  
> +test_expect_success 'in_vain resetted upon ACK' '
> +	rm -rf myserver myclient trace &&
> +	git init myserver &&
> +
> +	# Linked list of commits on master. The first is common; the rest are
> +	# not.
> +	test_commit -C myserver first_master_commit &&
> +	git clone "file://$(pwd)/myserver" myclient &&
> +	test_commit_bulk -C myclient 255 &&
> +
> +	# Another linked list of commits on anotherbranch with no connection to
> +	# master. The first is common; the rest are not.
> +	git -C myserver checkout --orphan anotherbranch &&
> +	test_commit -C myserver first_anotherbranch_commit &&
> +	git -C myclient fetch origin anotherbranch:refs/heads/anotherbranch &&
> +	git -C myclient checkout anotherbranch &&
> +	test_commit_bulk -C myclient 255 &&
> +
> +	# The new commit that the client wants to fetch.
> +	git -C myserver checkout master &&
> +	test_commit -C myserver to_fetch &&
> +
> +	# The client will send (as "have"s) all 256 commits in anotherbranch
> +	# first. The 256th commit is common between the client and the server,
> +	# and should reset in_vain. This allows negotiation to continue until
> +	# the client reports that first_anotherbranch_commit is common.
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C myclient fetch --progress origin master &&
> +	test_i18ngrep "Total 3 " trace

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

As with the other patch, trace2 output from the server might be more
stable.

Do these tests pass with protocol v0 as well?  (Forgive my laziness in
not checking yet.)
