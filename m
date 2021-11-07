Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD89C433F5
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 13:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 016F26120D
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 13:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhKGNZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 08:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhKGNZq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 08:25:46 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F323CC061570
        for <git@vger.kernel.org>; Sun,  7 Nov 2021 05:23:02 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s13so21997852wrb.3
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 05:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3f+Cn3GJDVfcgG0vEWB8OuafMt+xwzo8g38WqaHw1lo=;
        b=opwXjmLho2181VbtmfSr/e8Q6EvbQ4e0J/gLHoRwIGnEjKDZ2nj9u76WbtmKq7yC9M
         +g9gyDtlnrxto4dKKuYGCmja2bI/Wu5ZY9x3DuQrzSiP//nJjbOTmVFGVT9aHgSIJPT2
         9PjKh3bh7jGsCTubG52nf7XE6AigJiVPMuVe1ITycKmtCS4xIh6QpSjtJvUF/l12O2kT
         F1T+Rd96OoNs5Rp0STBeQ/Zt2TI23zZTGrpfHXW5KE9NWuJC13OrzjlJqrHfjelG0Bpo
         EFK0ipgGpVtHRQGAQeoTd6ZfXVVzhmmSM+hkDe0AK7OnWkupih1v1j5LwQx7zMSGTQj6
         gE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3f+Cn3GJDVfcgG0vEWB8OuafMt+xwzo8g38WqaHw1lo=;
        b=GWbkR5KhM4beeuHCgKGnLSuXZcw3CxVNcvYoSTVfv14W7wv+YSllVWlLyIyPrdqe2U
         lsP5MAjR/bKq/C6LY3oFuWfsthkXIv5YbDrtydnFq20qYV2qxvvNcc7++iDM4xYJh2ON
         ZzS9qLE3wxV89TRned46V9/XuaaF5jpwKUNkkssF2J3Gg0+Sx59jo/9vvwMjlPn6nxKV
         ecsZrHQGB1ntsKtuZk4/wsPky5jpW6aCekc2ujDY9zv5N0YlMgb1JMlpLjCzR1HA1QvB
         cpDPh87VFShnGZUOU9S+EeJ9z4YN8nfcwtAvB2MGPt4i0E4bTvi5b1r5HBQc2tKvozSm
         CQsg==
X-Gm-Message-State: AOAM5324bDTN/Mu08ruPnWUCUxld0Kzn/mFv0Zncyr5CRAklnYCX/me4
        UrXSFGphvqTOQROsiS0r5gGdJe3JY2o=
X-Google-Smtp-Source: ABdhPJwC3Y0hxoy46jqcbdU1yfbLiEonBVY4ti+yOkub2i5zaxMXc/uSr6Gp+g0Ub0oeVAMXZDAEQw==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr86336863wrr.385.1636291381614;
        Sun, 07 Nov 2021 05:23:01 -0800 (PST)
Received: from gmail.com (193-81-63-211.adsl.highway.telekom.at. [193.81.63.211])
        by smtp.gmail.com with ESMTPSA id a134sm14010627wmd.9.2021.11.07.05.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 05:23:01 -0800 (PST)
Date:   Sun, 7 Nov 2021 14:22:59 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 10/10] init doc: --shared=0xxx does not give umask but
 perm bits
Message-ID: <20211107132259.jntrqxu5jn5v3vcw@gmail.com>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <20211106184858.11500-1-jn.avila@free.fr>
 <20211106184858.11500-11-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211106184858.11500-11-jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 06, 2021 at 07:48:58PM +0100, Jean-Noël Avila wrote:
> From: Junio C Hamano <gitster@pobox.com>
> 
> The description that 0640 makes sure that the group members can read
> the repository is correct, but calling that octal number a <umask>
> is wrong.  Let's call it <perm>, as the value is used to set the
> permission bits.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-init.txt | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index af0d2ee182..42268ada22 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -79,7 +79,7 @@ repository.  If not specified, fall back to the default name (currently
>  `master`, but this is subject to change in the future; the name can be
>  customized via the `init.defaultBranch` configuration variable).
>  
> ---shared[=(false|true|umask|group|all|world|everybody|<umask>)]::
> +--shared[=(false|true|umask|group|all|world|everybody|<perm>)]::
>  
>  Specify that the Git repository is to be shared amongst several users.  This
>  allows users belonging to the same group to push into that
> @@ -110,15 +110,16 @@ the repository permissions.
>  
>  Same as 'group', but make the repository readable by all users.
>  
> -'<umask>'::
> +'<perm>'::
>  
> -'<umask>' is an 3-digit octal number prefixed with `0` and each file
> -will have mode '<umask>'. '<umask>' will override users' umask(2)
> +'<perm>' is an 3-digit octal number prefixed with `0` and each file
> +will have mode '<perm>'. '<perm>' will override users' umask(2)
>  value (and not only loosen permissions as 'group' and 'all'
>  does). '0640' will create a repository which is group-readable, but
>  not group-writable or accessible to others. '0660' will create a repo
>  that is readable and writable to the current user and group, but
> -inaccessible to others.
> +inaccessible to others (directories and executable files get their
> +`x` bit from the `r` bit for corresponding classes of uses).

This confused me until I realized that "classes of uses" should be "classes of users".

Other than that the whole series looks great.
