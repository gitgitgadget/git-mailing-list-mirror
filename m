Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0EB81F42D
	for <e@80x24.org>; Sat, 19 May 2018 06:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750783AbeESGhe (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 02:37:34 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36195 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeESGhe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 02:37:34 -0400
Received: by mail-lf0-f67.google.com with SMTP id e9-v6so90441lfb.3
        for <git@vger.kernel.org>; Fri, 18 May 2018 23:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QupoYHuB1W/mkitT7eRs63qO6E7RMglz+kOwScdZnaI=;
        b=hOabgGVIzBUjPHLLiBhDlv4veXo9rG+9Jt53ffEo8CGltVNA286pVpzCKdRS1UANRb
         j5ZMqVCUpqRFH8g/amSsjVPJ1kTA35gk2/Q/VvQhckGPcvkA1n7sQ9rWApPD+qKxjzd9
         SgOVmkTH5wL1zqe8ccJy7K1Yo0sETK3xjfQf5z41DLTaW6ADfcJvAEidIe43phYgVgTf
         +hv1rGAeqfnNjSEU/rRAIRmXFW/PKnPSzfrgDglJWymOkPsGWF8WthNj/95fgu8yi1Eu
         C7eGJNm9YlWIgTooPWxeACNQpEyWxNDE1ZZlpo6ayJc2QQa+ytLlXY/JvMNaea8XxJ93
         /A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QupoYHuB1W/mkitT7eRs63qO6E7RMglz+kOwScdZnaI=;
        b=PBZiFkSCJqySPhikySLZg08KS2TWxnf0oQQST0e2oejR8+WcrpNoY7HuILdrEkAGDq
         D/FdzzN1VQKj90vmBS1GxeapyEN//YB9Qzgw0U42lqvOTRpE5qY89DvJ7Vj+0ogeXKpn
         hFF0SunuiprQxqGtyJiMy/i7vtKEL5PMmMwSHv4oz4yxx04l5qr/ZZxvXi/RZWSIVLb3
         S44wrwXrOV4HaV6zFdVYX+dongGqE7hlP4SVDgUUZgPqH+415PHDl/EuEJu2nrn1/1+E
         +uVj4trsbcHcPZZKvDjkd09jibjdhUx2DKBxpLpP5cUkf0WiTjwNojyDJ6tZg8aXdXmj
         lNNA==
X-Gm-Message-State: ALKqPwegs0sm7+AdU417hjEpt/tps6EsgduAOK1uExc4lb9vx9NRPNJC
        /fFo1fAOeWNygrmaNtbUMfc=
X-Google-Smtp-Source: AB8JxZoZVAaJpNiVMcgWcdscpfTq3utTEUHKQg60RhwvyR45z51FEbTqEF4jtokT9S3ZaXXuXDWk7w==
X-Received: by 2002:a2e:4dd6:: with SMTP id c83-v6mr7180953ljd.126.1526711852630;
        Fri, 18 May 2018 23:37:32 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q18-v6sm2248283lfi.97.2018.05.18.23.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 23:37:31 -0700 (PDT)
Date:   Sat, 19 May 2018 08:37:29 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     ao2@ao2.it, bmwill@google.com, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 02/11] repository: introduce repo_read_index_or_die
Message-ID: <20180519063729.GA14755@duynguyen.home>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
 <20180516222118.233868-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516222118.233868-3-sbeller@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 16, 2018 at 03:21:09PM -0700, Stefan Beller wrote:
> A common pattern with the repo_read_index function is to die if the return
> of repo_read_index is negative.  Move this pattern into a function.
> 
> This patch replaces the calls of repo_read_index with its _or_die version,
> if the error message is exactly the same.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/add.c               | 3 +--
>  builtin/check-ignore.c      | 7 ++++---
>  builtin/clean.c             | 4 ++--
>  builtin/mv.c                | 3 +--
>  builtin/reset.c             | 3 +--
>  builtin/rm.c                | 3 +--
>  builtin/submodule--helper.c | 3 +--

'git grep -w -A3 read_cache' tells me you're missing (*)

builtin/diff-tree.c:    if (read_cache() < 0)
builtin/diff-tree.c-            die(_("index file corrupt"));

builtin/merge-ours.c:   if (read_cache() < 0)
builtin/merge-ours.c:           die_errno("read_cache failed");

builtin/update-index.c: entries = read_cache();
builtin/update-index.c- if (entries < 0)
builtin/update-index.c-         die("cache corrupted");

merge-ours.c is interesting because it uses die_errno() version
instead. I think that might give inaccurate diagnostics because we do
not only fail when a libc/system call fails in read_cache(), so it
should be safe to just use die() here.

update-index.c is also interesting because it actually saves the
return value. I don't think it's used anywhere, so you can just drop
that 'entries' variable. But perhaps it's good to make
repo_read_index_or_die() return the number of entries too.

(*) yes yes you did mention "if the error message is exactly the
same". But these look like good candicates to convert anyway

--
Duy
