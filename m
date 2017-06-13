Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 640191FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbdFMVzF (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:55:05 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34735 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbdFMVzE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:55:04 -0400
Received: by mail-io0-f179.google.com with SMTP id i7so82149466ioe.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+bfrJ1At4N7ToJ0qKbFmu1N2UOEr/KIEFY/9/j2H6So=;
        b=Jj5zt4DoumfJFoKISfk8tak3vbvoWtdZ2Srw39Zy06oq8QzOzYwFT/KgEu4UQz7Shg
         inUfOGOL5xuwj/ogG1ODo7yO7GNDDClXQMlkpXH4aGezhPKLZ0fm97TMdq0GLLLGrz+B
         cnkTTCBYPdHVNRUTZ31PGXL6Mpu+nH3kLbWgP0kspr78YchmDmXhTLejRdyWetiOf9mK
         bC16rOul5gMyLvhufrbjO/yOCcuud15owuLj8vSv1zbZmjQVe7P3MM65qKvff8qOZgvk
         d9A7uRZIeSW8h+Lhg4aN+rGc9cALa27jcRNE/bc3zqVpTvek8aN/noqMl/mIaRXaJ72A
         Y5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+bfrJ1At4N7ToJ0qKbFmu1N2UOEr/KIEFY/9/j2H6So=;
        b=ClLJUVfH87Qamdam8M+kFUpM6+qbXz+oCcmaUcsHx7yy28GUMk83l9gP3fmPSrJnDA
         UZFtAZQ/jASwVTKwiYjZXkz6bNar33o+kyVWns+jDPUYBDyMEZ6HYEhkikzJ510jqpUv
         gGjw2Wt/LIgMBDvQGi9ZKfKJWcLc3LEKvK3v84BQSSCEY5byrBPn5K/CMJyHvYCmv9rT
         popZ9AAkVPm8hcdAqkLxYOHdNPUHeY2/CWhn2G1SOufS61b6OW/KdaaYixR8xVzfqnvs
         m6odTkN/Fn9x8QTdBogC9jNXFARGTADlVqYOl15tB2pKBJ+cpiBTSbtX2EI9jZCE9+Xv
         fWFw==
X-Gm-Message-State: AKS2vOynG/4p+iSVeegYmZUDitPOKWvpgczycd62X3f0wGQygoXrCzY+
        df/GgLgEIeCfnobmCC+tjA==
X-Received: by 10.107.41.12 with SMTP id p12mr2794715iop.126.1497390903033;
        Tue, 13 Jun 2017 14:55:03 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:85a0:52c1:8d73:eb63])
        by smtp.gmail.com with ESMTPSA id b69sm2484035itb.23.2017.06.13.14.55.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:55:02 -0700 (PDT)
Date:   Tue, 13 Jun 2017 14:54:57 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, bmwill@google.com,
        jrnieder@gmail.com, peff@peff.net, mhagger@alum.mit.edu
Subject: Re: [PATCHv5 04/17] diff: introduce more flexible emit function
Message-ID: <20170613145457.2e888c27@twelve2.svl.corp.google.com>
In-Reply-To: <20170524214036.29623-5-sbeller@google.com>
References: <20170523024048.16879-1-sbeller@google.com/>
        <20170524214036.29623-1-sbeller@google.com>
        <20170524214036.29623-5-sbeller@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 24 May 2017 14:40:23 -0700
Stefan Beller <sbeller@google.com> wrote:

> Currently, diff output is written either through the emit_line_0
> function or through the FILE * in struct diff_options directly. To
> make it easier to teach diff to buffer its output (which will be done
> in a subsequent commit), introduce a more flexible emit_line() function.
> In this commit, direct usages of emit_line_0() are replaced with
> emit_line(); subsequent commits will also replace usages of the
> FILE * with emit().

Check the names of the functions in this paragraph.

> diff --git a/diff.c b/diff.c
> index 2f9722b382..3569857818 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -516,36 +516,30 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
>  	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
>  }
>  
> -static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
> -			int first, const char *line, int len)
> +static void emit_line(struct diff_options *o, const char *set, const char *reset,
> +		      int add_line_prefix, int sign, const char *line, int len)

In the future, this function is going to be used even to emit partial
lines - could this be called emit() instead?
