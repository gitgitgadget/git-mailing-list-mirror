Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBA2C61DA4
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 20:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCKUeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Mar 2023 15:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCKUeN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2023 15:34:13 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF3D34028
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 12:33:38 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y11so9058320plg.1
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 12:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678566813;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+OE/S534jIoMhAeywkwFyrmAl2uNj8JlFziW30yQWw=;
        b=Y19AH2dD7HagJhDn6tqSarD1/jIU2plFZ82AvcrzBRvzG5slrtSImPmzWTYMbKONX1
         3LfF0aVDDbKCZmcCa4YJ7Irh64L5loAZs8sjRISZisrmfDBCtfiNUn+kN05HccmKVr/Z
         MgOe26w0T471N29RzJ3DfHIcxkL9afL8DKpR1cbc6qUpizDCQCXr+fHSAOi7VwUfg3S+
         xm3lvyhRG/5BU4piE+lsXoooeRiU6xmo5n8cNXa9soNVREVBrJHfBEmpCPcSfWWH46lv
         0FMiqbIj40PQlI2FclcAd6Z0mL9KWmg7yyEGHgB3v7BN6lyQFup9GAEkZZSGI81oCYt/
         V19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678566813;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s+OE/S534jIoMhAeywkwFyrmAl2uNj8JlFziW30yQWw=;
        b=DZCVabKsJE0bfhF1ycxnnP8xGj5moQ0TQQSsFDiVHuhcfd1ZaZr/xPz4zEVwqATe9W
         Y4icGnQR2GwfNURklVSuy2AYjo0THG05R+uzdydKrc8GvzFvrXZ7rF9PsB58wVgseZKB
         xC9vHPqd4wRdYAHsFwMQ7GcAkNywLKjuueo6HQl06Zs4n6y45vFkiauyQssWl/fc6IlX
         3UYcGIfcPB1JFPq/McEG/Mw6gX+dpdmR6IxsxEwF/RddF/NPa5+iT/jwE6J/AqovBAxB
         SIG6flGbGqoBSuHSB0X/Y7na5+5lvlkdfjvp4frBk99+Q7SxISXd1qXyn75qLk6wC+ry
         GuyA==
X-Gm-Message-State: AO0yUKVvJFSXlTgjYwBOHHjH+3/pnUW2Nzdzf839rsiAx4/1mqByj6oV
        zAr4gc+wz+jkw5K1ss0V97s=
X-Google-Smtp-Source: AK7set/Usw2THRmOjMzYqIye0Da624GRIjHQVDZEsN9ODoS2ZQq+gR9LoiBaoXAswb+LnXIr+4d/Fw==
X-Received: by 2002:a17:902:ef91:b0:19e:898f:8813 with SMTP id iz17-20020a170902ef9100b0019e898f8813mr25147972plb.13.1678566812962;
        Sat, 11 Mar 2023 12:33:32 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id m3-20020a1709026bc300b0019a83f2c99bsm1940504plt.28.2023.03.11.12.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 12:33:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Adam Johnson <me@adamj.eu>
Subject: Re: [PATCH] ls-files: document that pathspecs are supported
References: <pull.1466.git.git.1678526355280.gitgitgadget@gmail.com>
Date:   Sat, 11 Mar 2023 12:33:32 -0800
In-Reply-To: <pull.1466.git.git.1678526355280.gitgitgadget@gmail.com> (Adam
        Johnson via GitGitGadget's message of "Sat, 11 Mar 2023 09:19:15
        +0000")
Message-ID: <xmqqzg8jxc2r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Adam Johnson <me@adamj.eu>
>
> The command has taken pathspecs, not just filenames, since f0096c06bcd
> (Convert read_tree{,_recursive} to support struct pathspec, 2011-03-25).

Isn't that commit about ls-tree?  The commit does change how the
tree overlay (i.e. the --with-tree=<tree-ish> option) interacts with
the given pathspec arguments but that is only because that commit
changes how read_tree_recursive() has to be called.  The support of
pathspec matching in ls-files dates back to 56fc5108 ([PATCH]
git-ls-files: generalized pathspecs, 2005-08-21), arguably even
before the commit "generalized" the already existing path pattern
match feature.

> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 1abdd3c21c5..2f62374062c 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -21,7 +21,7 @@ SYNOPSIS
>  		[--exclude-standard]
>  		[--error-unmatch] [--with-tree=<tree-ish>]
>  		[--full-name] [--recurse-submodules]
> -		[--abbrev[=<n>]] [--format=<format>] [--] [<file>...]
> +		[--abbrev[=<n>]] [--format=<format>] [--] [<pathspec>...]

Good.

>  DESCRIPTION
>  -----------
> @@ -127,12 +127,12 @@ OPTIONS
>  	in each directory, and the user's global exclusion file.
>  
>  --error-unmatch::
> -	If any <file> does not appear in the index, treat this as an
> +	If any <pathspec> does not appear in the index, treat this as an
>  	error (return 1).

This is no longer correct.  "If no path that matches <pathspec>
appears in the index".  When we are given <pathspec>, say '*.txt',
a path whose string is literally '*.txt' may not appear in the index,
but as long as there is a path that matches the pattern exists,
this option does not lead to an error.

> -<file>::
> +<pathspec>::
>  	Files to show. If no files are given all files which match the other

The description also needs to be updated.  "Limits the files to show
to only those that match the given pathspec" or something along that
line.

Thanks.
