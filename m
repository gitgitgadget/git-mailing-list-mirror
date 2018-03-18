Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4A91FAE2
	for <e@80x24.org>; Sun, 18 Mar 2018 00:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeCRAQj (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 20:16:39 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37708 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeCRAQj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 20:16:39 -0400
Received: by mail-wr0-f195.google.com with SMTP id z12so15127772wrg.4
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 17:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=e8r5jDeJjN8LbmB194DTcYhyJMQDzg7ajiq0Yy1xfek=;
        b=phyXYiPhlM2CRado8Zt2grjmnCnCuIfzE3OIfs4RYdEkj8m485sr3JMn6nZYR9YLp5
         EnaAEileF4r/pTfh587XU5K03p2Wi3Ig8iwKWr1089rtzWJrlSRO0MghHSuCy5m3EJu3
         4f4s+jC/jFK2A87s3YWStSbbfM8TqepgCWgILBURekfG9bdu0PWhXwJHJjbTPFoWfXbr
         WoiIcqPNBjBRU9a5thaNF4mO/SaI2OO0vBSTrdigMDOZqyyvKDjdHB+uZvOPawQ/u3AP
         +mrw2MkB8p70wApgBxlSmz9qFUkq4UIlR0csn1umMuDsHSEm9JQVeT2puP/PKVC6/D/b
         lCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=e8r5jDeJjN8LbmB194DTcYhyJMQDzg7ajiq0Yy1xfek=;
        b=WGJGGNydU01N7XQuFn+/OTvEZWbmyA2nphB6poveqpYjorUhI7MPyB+RcbcVSLDlkC
         Nb4bVia4WFjKSDRPiTeTw162LqUBZXWYy0qSD53haNj+/4DB64qh33Da7CwBU7lg/2p1
         s++JcadJG9I2d+VYejMDfwioo+Fy8YS8Z1kM0jEebwjSq3nrlXlqJK2jAyFZWISuylTS
         QrDhE++mRq1jQlEKl6PWBDOu2Jlj1uQp4rVN3rC2+xRepp8VtEsOFg53dUmIbYyOrS4H
         4e+gcTtqN1WVMd9rZZ1P0+qFSktbvefJqyM1+MFYBCfa9JNhvzGi423dP3ddnFw1kF1d
         wpAg==
X-Gm-Message-State: AElRT7FOFeBzVyGKw7RYQColav5/n+ytiVktfYmLbob2/w96FtpSV+EG
        Qsflsv4hE6IHIzdLsVwKOFI=
X-Google-Smtp-Source: AG47ELt7tRbJ0IxyB4q05qbHnwOMIU7CYRJFT2pXTINhk0XP52QbELEhbcmyln9NGy5S/ZqdkyZR2A==
X-Received: by 10.223.133.197 with SMTP id 5mr4513519wru.130.1521332197786;
        Sat, 17 Mar 2018 17:16:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u62sm11239056wma.15.2018.03.17.17.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 17:16:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Clemens Buchacher <drizzd@gmx.net>
Cc:     git@vger.kernel.org, manlio.perillo@gmail.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH 2/2] completion: simplify ls-files filter
References: <1521274624-1370-1-git-send-email-drizzd@gmx.net>
        <1521274624-1370-2-git-send-email-drizzd@gmx.net>
Date:   Sat, 17 Mar 2018 17:16:36 -0700
In-Reply-To: <1521274624-1370-2-git-send-email-drizzd@gmx.net> (Clemens
        Buchacher's message of "Sat, 17 Mar 2018 09:17:04 +0100")
Message-ID: <xmqqk1uaxmor.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clemens Buchacher <drizzd@gmx.net> writes:

> When filtering the ls-files output we take care not to touch absolute
> paths. This is redundant, because ls-files will never output absolute
> paths. Furthermore, sorting the output is also redundant, because the
> output of ls-files is already sorted.
>
> Remove the unnecessary operations.
>
> Signed-off-by: Clemens Buchacher <drizzd@gmx.net>
> ---

Makes sense, and I think you can and should just directly jump to
this concluding state without having an intermediate "sed" version.
The fact that the code does not have to worry about absolute paths
and unsorted input is shared with the original version, too, so the
proposed log message for this one applies equally well to such a
squashed patch.



>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index e3ddf27..394c3df 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -384,7 +384,7 @@ __git_index_files ()
>  	local root="${2-.}" file
>  
>  	__git_ls_files_helper "$root" "$1" |
> -	sed -e '/^\//! s#/.*##' | sort | uniq
> +	cut -f1 -d/ | uniq
>  }
>  
>  # Lists branches from the local repository.
