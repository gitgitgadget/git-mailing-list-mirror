Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10A9A203C1
	for <e@80x24.org>; Thu, 21 Jul 2016 01:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559AbcGUBAq (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 21:00:46 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36001 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525AbcGUBAi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 21:00:38 -0400
Received: by mail-pf0-f195.google.com with SMTP id y134so4375560pfg.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 18:00:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=us3qkOpIxTxKqqxRx8m5rGLVd1f2gXn4iFfzOxfWx9o=;
        b=An+M+ZjWfnjKd5c4zPlPwyBvurwnJj0KtokHkBvPYavdggBW+trXh6QqCZcOBYFtDM
         ELdaChY223wrnulYhqYMmwdsRVgDUnNfDVnpN2M5usoLxTncoJpVW9slajzr+kyaxSXe
         e9Jw/EttvbMA8sCsLIftwUm+PeR4adRQI5jVxjr37CKs/f41flnEo4240kG4rC78vX2I
         8/FuR8jOnaUzSqtbHpBsyVDs8jot8ncwRUYsH3x8WcJiJa1/ZpZAt2JqxrtcJeiqbkBn
         IDJogfpf2eg9Gx0+NZ98ApRINzZ+jU56SA79D5qFU/cijb3AwfXYZ5WL84pex3bNCiwu
         PX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=us3qkOpIxTxKqqxRx8m5rGLVd1f2gXn4iFfzOxfWx9o=;
        b=HRYztlkZ9p5C6FlCY9So1l1itG81cw+cMzmjadDMyonwffpRe6CLLdm57BM7bhKxdr
         nWfzeDVSjvKabcTCcn/pEMytVDPufwSfvPQ0lBo7AnZoBQksuRZVaEe6619zO0wqV79K
         OqJgRkI5ktrf4snlgh9EXiQBK42GSZiiPwfE+8MDW8+WgGOlFvXUbum7jNNNrQqTHm6/
         T8nv6II2mfmP7D7fB4VGdSAc2XUkCRNZ1I+VpOVfGscIFsYEiBREV57CgW3+ae9i1+qc
         aDaJqRCnS706Vc6YDShR71k+UNA5yYRnxjLbglOKeovhCS14Z2iZSPS77MQceW0f6LBz
         DalA==
X-Gm-Message-State: ALyK8tKMNSF0HmU1Vm4PhZrml5WiTtJfHI5vp/vojW1xKR5i5n8TzcAriAZKSQGilKzjsg==
X-Received: by 10.98.12.200 with SMTP id 69mr68920511pfm.15.1469062832176;
        Wed, 20 Jul 2016 18:00:32 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:adf0:372e:ec4a:3478])
        by smtp.gmail.com with ESMTPSA id z10sm7189760pff.95.2016.07.20.18.00.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Jul 2016 18:00:31 -0700 (PDT)
Date:	Wed, 20 Jul 2016 18:00:29 -0700
From:	Jonathan Nieder <jrnieder@gmail.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de
Subject: Re: [PATCH] submodule: do no re-read name in shell script
Message-ID: <20160721010029.GG29326@google.com>
References: <20160721005122.15966-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160721005122.15966-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller wrote:

> Instead of making another call to a submodule helper (name), just
> propagate the value when we know it (in the update-clone helper) already.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 4 ++--
>  git-submodule.sh            | 3 +--
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b22352b..494e088 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -683,9 +683,9 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>  	needs_cloning = !file_exists(sb.buf);
> 
>  	strbuf_reset(&sb);
> -	strbuf_addf(&sb, "%06o %s %d %d\t%s\n", ce->ce_mode,
> +	strbuf_addf(&sb, "%06o %s %d %d %s\t%s\n", ce->ce_mode,
>  			sha1_to_hex(ce->sha1), ce_stage(ce),
> -			needs_cloning, ce->name);
> +			needs_cloning, sub->name, sub->path);

Are there any restrictions on what characters a submodule name can
contain?  Does this need e.g. to be quoted with sq_quote?

Thanks,
Jonathan
