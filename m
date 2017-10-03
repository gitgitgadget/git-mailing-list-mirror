Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B78C2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 21:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbdJCVqw (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 17:46:52 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36875 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdJCVqu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 17:46:50 -0400
Received: by mail-pf0-f195.google.com with SMTP id e69so10385842pfg.4
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 14:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=42ERWePhFKi+IOyIHqmxwQnA/bRT/MkhKPOlSBTWziE=;
        b=KaX3AFoKVbibxcwI/zooelAvL6vweDfONZG01S0SZPSTJV7DRegxxrFrg5bzcdrapC
         XhPT0PPDkQux6wo4Ype2wkwIQSVgzlyhYxE66GMXNO+caK8N4eAa1rOZRVPJZ2zPEVIC
         SgtXA63+gr2vgsrLvg2wGMOx+bQ8A2zs9gmDdCUiJAZDDmBSLVtCmpyJJkPXcRH1M17D
         iCVSe3sE3SDrBPIv5taji6AzAwkD64g919kkx4ZQSP3F6WnXCcGV15hFk78HJfTthGoy
         AvjdePTtcjSm1QVXD8VPO8Xw9h7PafGOCW9h8FY9LYNGWw3KAsIAv4/1EdplOqUwUQsl
         fhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=42ERWePhFKi+IOyIHqmxwQnA/bRT/MkhKPOlSBTWziE=;
        b=gntR4LkA6M0YfDmB4SE3MkUNkbv0qTnjoMwLVTuYX+YrUUwXoLD5o+28jPkclDjTCP
         yRm0XBu2qeYi6B4Uf3XdG+SQrIOGncbCcAMHRVY5b1FXAE2W7ML+cn0Tmdt+lquGMBvX
         1EkCn248uQU0LX0cjwI/zuOCnGVqwmsIZh8sgxjIHWLFe5kFWoFH3RbPyLL0Xuwj0SSY
         8JREtvHuYsDisV/8jlQK2+QqDMLF1YzXID7oAxMrYf9FjcWa28mj6KrCXCC5VtPX8PIN
         aNy5IwpYVdJD9wz2/oPdwkmrSNhxG0i80YnniZQZBbpDlTD1/DXYBbS0QiZXIKrAIqj3
         21Pg==
X-Gm-Message-State: AMCzsaWo2lBg5L4fEzgYpFZXhpE++9ZfEq5OlYXq0M6Ue74lz3h+9/c6
        DJngWsY9RCCj6jMUa9lJae/zBqJ2
X-Google-Smtp-Source: AOwi7QArZeVKCtsEAn+lyaRyvqAVu0bu+qc7Z0A2LeB3z58UKisleO+XRUrzv3DQSMH2SudK5UcSbA==
X-Received: by 10.99.128.195 with SMTP id j186mr1831880pgd.70.1507067209227;
        Tue, 03 Oct 2017 14:46:49 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:3463:ab6b:5863:927c])
        by smtp.gmail.com with ESMTPSA id k10sm19564881pgq.92.2017.10.03.14.46.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 14:46:48 -0700 (PDT)
Date:   Tue, 3 Oct 2017 14:46:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: reset instead of release a strbuf
Message-ID: <20171003214646.GZ19555@aiede.mtv.corp.google.com>
References: <20171003211409.16037-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171003211409.16037-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> Our documentation advises to not re-use a strbuf, after strbuf_release
> has been called on it. Use the proper reset instead.

I'm super surprised at this documentation.  strbuf_release maintains
the invariant that a strbuf is always usable (i.e., that we do not have
to fear use-after-free problems).

On second thought, though, strbuf_release is a more expensive operation
than strbuf_reset --- constantly free()-ing and re-malloc()ing is
unnecessary churn in malloc data structures.  So maybe that is the
motivation here?

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Maybe one of the #leftoverbits is to remove the re-init call in release
> and see what breaks? (And then fixing up more of such cases as presented
> in this patch)

As mentioned above: please no.  That would be problematic both for
ease of development and for the risk of security bugs.

>  builtin/branch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index b998e16d0c..9758012390 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -217,7 +217,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  		if (!head_rev)
>  			die(_("Couldn't look up commit object for HEAD"));
>  	}
> -	for (i = 0; i < argc; i++, strbuf_release(&bname)) {
> +	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
>  		char *target = NULL;
>  		int flags = 0;

Should there be a strbuf_release (or UNLEAK if you are very very sure)
call at the end of the function to replace this?

With that change (but not without it),
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
