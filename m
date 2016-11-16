Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F342021E
	for <e@80x24.org>; Wed, 16 Nov 2016 00:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935546AbcKPAOH (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 19:14:07 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35235 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932822AbcKPAOF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 19:14:05 -0500
Received: by mail-pf0-f170.google.com with SMTP id i88so38715851pfk.2
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 16:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p4zUdWIK4L8Aysr68YCRzgP5Skk6Wzs59HL+x9UQB2E=;
        b=OCJpSfN2mwrRFMtXVspLPEYLQzyhTMofdJgxyx5YySqF+ovEiZl4fCConSe8l0DWLw
         wt3ViNwMTPB5gd5Hyawj4ckilckvUPjwXFQA/RP5HrPJlf/jY6P+v6P9oPqUA1ul79uc
         NXo6lk1FvH0K0GYUetLcnoF1p299/w+Po0nRvMgrwiq/k+4VBoEwCukkY1xlpXafv8N7
         BovkXwwnqO57KuneN8/CUtXZp8WC25ITdOEJQ5mzee9+4Ba+jDXaoYSUHAJROMnUZUz6
         VCqbhX/f5ZtDtLaQ41EKZpDY8zXKroKFUYJ9tyUDiLkFp6JJi8ogsNQpMfdb3iGEO65/
         ipqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p4zUdWIK4L8Aysr68YCRzgP5Skk6Wzs59HL+x9UQB2E=;
        b=P/KKAxEWZSmvb6Zo0RPsFTLqOLSxK41putqJ2++zVclO/Hy1thLTdqPyNP3zIVB3vp
         SJftxXBE3f/4+sYcmErelLVTY9LjILHPAGwUQSIWpy8Dovwj/PiWF1YVIFnZE4OFcUNn
         KnKMN4uzX50EtAX8t8AvaM1PVX8WoF18DXjPQWMDLs4vH8B0hjUP6vuPpkGHEXqT1nu+
         YMxYcpVFcwmczns6kN7ozu/5jhn7yHdPH01uU2TikSQWZeTr+cLdCra8pyFdqyQZwmbj
         Ty2aDD9L6xMsDvDGQ/DOGy57ZewmDKu2XXkxLoCRl+VnWgHeXCe0dIwtrMJtUdW0X+MM
         64FA==
X-Gm-Message-State: ABUngvfACgJPQTDzPKV+aRQkmwmabRn26hZ3Q+e1uZPuUj7NKKPPwsqFB+/tevN12AczZGIR
X-Received: by 10.99.158.18 with SMTP id s18mr1695594pgd.163.1479255244578;
        Tue, 15 Nov 2016 16:14:04 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:f0a8:aad3:5a98:9829])
        by smtp.gmail.com with ESMTPSA id j68sm46488108pfk.95.2016.11.15.16.14.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 16:14:03 -0800 (PST)
Date:   Tue, 15 Nov 2016 16:14:02 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        mogulguy10@gmail.com, David.Turner@twosigma.com
Subject: Re: [PATCH 11/16] teach unpack_trees() to remove submodule contents
Message-ID: <20161116001402.GH66382@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
 <20161115230651.23953-12-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161115230651.23953-12-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15, Stefan Beller wrote:
> Extend rmdir_or_warn() to remove the directories of those submodules which
> are scheduled for removal. Also teach verify_clean_submodule() to check
> that a submodule configured to be removed is not modified before scheduling
> it for removal.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  unpack-trees.c | 6 ++----
>  wrapper.c      | 4 ++++
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index ea6bdd2..576e1d5 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -9,6 +9,7 @@
>  #include "refs.h"
>  #include "attr.h"
>  #include "split-index.h"
> +#include "submodule.h"
>  #include "dir.h"
>  
>  /*
> @@ -1361,15 +1362,12 @@ static void invalidate_ce_path(const struct cache_entry *ce,
>  /*
>   * Check that checking out ce->sha1 in subdir ce->name is not
>   * going to overwrite any working files.
> - *
> - * Currently, git does not checkout subprojects during a superproject
> - * checkout, so it is not going to overwrite anything.
>   */
>  static int verify_clean_submodule(const struct cache_entry *ce,
>  				  enum unpack_trees_error_types error_type,
>  				  struct unpack_trees_options *o)
>  {
> -	return 0;
> +	return submodule_is_interesting(ce->name, null_sha1) && is_submodule_modified(ce->name, 0);
>  }

So what does the return value from this function meant to mean? Is '1'
mean the submodule is clean while '0' indicates it is dirty or is it the
reverse of that?  Reading this it seems to me a value of '1' means "yes
the submodule is clean!" but the way the return value is calculated
tells a different story.  Either I'm understanding it incorrectly or I
think the return should be something like this:

  return submodule_is_interesting(ce->name, null_sha1) && !is_submodule_modified(ce->name, 0);

Where we return '1' if the submodule is interesting and it hasn't been
modified.

>  
>  static int verify_clean_subdirectory(const struct cache_entry *ce,
> diff --git a/wrapper.c b/wrapper.c
> index e7f1979..17c08de 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -2,6 +2,7 @@
>   * Various trivial helper wrappers around standard functions
>   */
>  #include "cache.h"
> +#include "submodule.h"
>  
>  static void do_nothing(size_t size)
>  {
> @@ -592,6 +593,9 @@ int unlink_or_warn(const char *file)
>  
>  int rmdir_or_warn(const char *file)
>  {
> +	if (submodule_is_interesting(file, null_sha1)
> +	    && depopulate_submodule(file))
> +		return -1;
>  	return warn_if_unremovable("rmdir", file, rmdir(file));
>  }

It seems weird to me that rmdir is doing checks to see if the file being
removed is a submodule.  Shouldn't those checks have occurred before
calling rmdir?

-- 
Brandon Williams
