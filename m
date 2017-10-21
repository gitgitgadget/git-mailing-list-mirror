Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A45202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 05:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750983AbdJUE6h (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 00:58:37 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:48531 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdJUE6g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 00:58:36 -0400
Received: by mail-pf0-f194.google.com with SMTP id b79so13524825pfk.5
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 21:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:in-reply-to:references:date:mime-version
         :content-transfer-encoding;
        bh=vRqPLaGHxapd/F+LLOTWodJyT++LAv9zwMGw/cgdpM4=;
        b=vdjdIhR127xYgAYccJbf9vV6ac138CC4vTEi2jWmvXMU7k6K2tmeDLcF4cPns0kl+J
         MlepJARZSSBcPbp8HiotH5zaDEzruZRiWw9e2ybSGt/AQDTNm5iGPZV7YU0oDFvjPxIx
         /wwPFV0i6Libe5DRxWgcZhjNyvRr73bENSdpvDzdGd2a0YGLOzxnnFc+nOdcy7zkgX8d
         0bdhrMP2vxI+BWgDArvl/soHzqZquDbFp2wMHe6udAlSosQMvt8f1K9osmr33TgmGPuI
         vVANRfbPeqpspsDXTarhFB8JvFrisceArO9FOrcR+gR7xnvZEcYzH170dNeMEV4joMVk
         eW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=vRqPLaGHxapd/F+LLOTWodJyT++LAv9zwMGw/cgdpM4=;
        b=Ly+A2BCEal//Hjs5PNG+EmVrZypR/8r1aLwVGoNmHYlvRCeGNRzbC9H5MxkGfVPz4K
         TBW/lBJhGq3vDm/o5Q+MbrRIdc+Y0/YlLvOGgB3Z5hm+xGrun5EGt7HY7k3PjCFSAe5v
         OTPByGxLkb21R1MVqdzvO71mf7tSa9AXuxcqIm89f75+hq111r4PncYtR+SY2Il79BAc
         tODuxSJEhHD71/4V4mO+S6qjp6siyztCJplTOUSUWrSntDoC/KgiEu9fOfXLJnnnupFH
         yJpaQcNMu+RPtFGlNICbKW9UVCamY+ugJZIFbC5VcyVd5BA7E0kQ4G4pisMmTevgLRBz
         7S+Q==
X-Gm-Message-State: AMCzsaXDo8Y6PdTPQ4KF0NoL12fjOkC+lVZb4l1gN59bVm25bqXkPdVK
        ud4ipog82a+uhjBY04IkBAk=
X-Google-Smtp-Source: ABhQp+Q8Xb6ZMT7FxIx3jr28wfRcSMwFKMpNSbZ4Ta5mHt62rviX8BXu5z0ecgoOE9In8WzSkvKwmg==
X-Received: by 10.98.245.21 with SMTP id n21mr6951652pfh.68.1508561915489;
        Fri, 20 Oct 2017 21:58:35 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.gmail.com with ESMTPSA id z7sm3046796pgp.36.2017.10.20.21.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Oct 2017 21:58:34 -0700 (PDT)
Message-ID: <1508561910.2516.22.camel@gmail.com>
Subject: Re: [PATCH 2/3] branch: split validate_new_branchname() into two
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
In-Reply-To: <20171013051132.3973-3-gitster@pobox.com>
References: <20171013051132.3973-1-gitster@pobox.com>
         <20171013051132.3973-3-gitster@pobox.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 21 Oct 2017 10:28:30 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-10-13 at 14:11 +0900, Junio C Hamano wrote:
> 
> diff --git a/branch.c b/branch.c
> index 7404597678..2c3a364a0b 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -178,19 +178,31 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
>  	return 0;
>  }
>  
> -int validate_new_branchname(const char *name, struct strbuf *ref,
> -			    int force, int attr_only)
> +/*
> + * Check if 'name' can be a valid name for a branch; die otherwise.
> + * Return 1 if the named branch already exists; return 0 otherwise.
> + * Fill ref with the full refname for the branch.
> + */
> +int validate_branchname(const char *name, struct strbuf *ref)
>  {
> -	const char *head;
> -
>  	if (strbuf_check_branch_ref(ref, name))
>  		die(_("'%s' is not a valid branch name."), name);
>  
> -	if (!ref_exists(ref->buf))
> -		return 0;
> +	return ref_exists(ref->buf);
> +}
>  
> -	if (attr_only)
> -		return 1;
> +/*
> + * Check if a branch 'name' can be created as a new branch; die otherwise.
> + * 'force' can be used when it is OK for the named branch already exists.
> + * Return 1 if the named branch already exists; return 0 otherwise.
> + * Fill ref with the full refname for the branch.
> + */

I guess it's better to avoid repeating the comments in both the .h and
.c file as they might quite easily become stale. I would prefer keeping
it in the header file alone.

> +int validate_new_branchname(const char *name, struct strbuf *ref, int force)
> +{
> +	const char *head;
> +
> +	if (!validate_branchname(name, ref))
> +		return 0;
>  
>  	if (!force)
>  		die(_("A branch named '%s' already exists."),
> @@ -246,9 +258,9 @@ void create_branch(const char *name, const char *start_name,
>  	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
>  		explicit_tracking = 1;
>  
> -	if (validate_new_branchname(name, &ref, force,
> -				    track == BRANCH_TRACK_OVERRIDE ||
> -				    clobber_head)) {
> +	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head)
> +	    ? validate_branchname(name, &ref)
> +	    : validate_new_branchname(name, &ref, force)) {
>  		if (!force)
>  			dont_change_ref = 1;
> 

The change was simple by splitting the function into two and calling
the right function as required at every call site! As far as I could
see this doesn't seem to be reducing the confusion that the 'attr_only'
parameter caused. That's because the new validate_branchname function
seems to be called in some cases when the 'force' parameter is true and
in other cases the 'force' parameter is sent to the
'validate_new_branchname' function. So, I think consistency is lacking
in this change. That's just my opinion, of course.

-- 
Kaartic
