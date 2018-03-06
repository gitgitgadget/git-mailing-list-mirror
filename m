Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B64DE1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 20:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932182AbeCFUW4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 15:22:56 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44536 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeCFUWz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 15:22:55 -0500
Received: by mail-pl0-f66.google.com with SMTP id 9-v6so7013789ple.11
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 12:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=koZjXEdHc0OWHRizysuSih1UTkje1ejKf1WhxSz9nso=;
        b=O7G2xPYzXzD9cJGyTJxiU9RanUyRkC7k7ChEMcXLbfg2GNq8MJtBlb2ABTV+bpItPb
         DsrAjLnIamThNSDHOzJOP/VSgc2z1ENcpLuDu5KerljHJPPVZL5PVxd067xVaOqEdSk+
         kcXbEeos89K4SX3KiE0c2K8AsuJ2rcFjIv584SOXbeYRridt7b+7px33t+WKppFgDD3S
         l/IQli4tUns0s75JNzLxD4Ta7XmwLFoQ9wkUZAJoYbAT5vpNulHqnLnw6+xHdZ21yqiS
         W6LB5+ozBtMYMXRit1oHN8XbZAjM293v+YhClPUIDxjiAJQkwq6j31eLozmPv2dR5Imo
         u8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=koZjXEdHc0OWHRizysuSih1UTkje1ejKf1WhxSz9nso=;
        b=frhRT2IfEBJmKAAEpZNShBRbJQBu3nkhZR2hKc748dMOONd0LICurUAqHxFLJB9a1X
         1zGo/thdR26pcOYDayzNAty0S4ZCmyylNCdDCqlshbmwhYG3hnpRP8D2Z63f4IvFb4rn
         lirWZqtRGQ2w5PRR5qbzDaf39eUmThorEhZWKO/rVhGFhABher7aS5vWLpjoCe1OENNQ
         QwiIhdn2G/z3N2a0wcUS3VDBJl8YkNQ+FZ50uyfg4F5UOA1spaeqYXpF8JUsFtd7KK56
         b4ptpFmt+/vlJ/NJJ4O82yOWNmsXXTnENEh5LmzhVFE/HE1F3hY0z5jWCrosdX5Hwh7t
         fYFQ==
X-Gm-Message-State: APf1xPA6mCvsddQu6485KBSjbvOmUUAmx+0p6I6ekaf7Wbru7wRtBP6H
        Q7Qb2QSFiHLn0JWH8ihBOyeUZpcs
X-Google-Smtp-Source: AG47ELvK3Wd7x29b686eXQaqCvKLGAAA/QNhMWptnQnTpIytgi8LaXKFbOa+gV4/LF9KEnvIFAggSQ==
X-Received: by 2002:a17:902:be02:: with SMTP id r2-v6mr18112743pls.234.1520367774769;
        Tue, 06 Mar 2018 12:22:54 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d70sm31454417pfl.119.2018.03.06.12.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 12:22:54 -0800 (PST)
Date:   Tue, 6 Mar 2018 12:21:49 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eddy =?utf-8?B?UGV0cmnImW9y?= <eddy.petrisor@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH] git-submodule.sh:cmd_update: if submodule branch
 exists, fetch that instead of default
Message-ID: <20180306202149.GA160269@aiede.svl.corp.google.com>
References: <1520366804-28233-1-git-send-email-eddy.petrisor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520366804-28233-1-git-send-email-eddy.petrisor@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc list snipped)
Hi,

Eddy Petrișor wrote:

> Cc: [a lot of people]

Can you say a little about how this cc list was created?  E.g. should
"git send-email" get a feature to warn about long cc lists?

> Signed-off-by: Eddy Petrișor <eddy.petrisor@gmail.com>
> ---
>
> There are projects such as llvm/clang which use several repositories, and they
> might be forked for providing support for various features such as adding Redox
> awareness to the toolchain. This typically means the superproject will use
> another branch than master, occasionally even use an old commit from that
> non-master branch.
>
> Combined with the fact that when incorporating such a hierachy of repositories
> usually the user is interested in just the exact commit specified in the
> submodule info, it follows that a desireable usecase is to be also able to
> provide '--depth 1' to avoid waiting for ages for the clone operation to
> finish.

Some previous discussion is at
https://public-inbox.org/git/CAGZ79ka6UXKyVLmdLg_M5-sB1x96g8FRzRZy=ENy5aJBQf9_QA@mail.gmail.com/.

In theory this should be straightforward: Git protocol allows fetching
an arbitrary commit, so "git submodule update" and similar commands
could fetch the submodule commit by SHA-1 instead of by refname.  Poof!
Problem gone.

In practice, some complications:

 - some servers do not permit fetch-by-sha1.  For example, github does
   not permit it.  This is governed by the
   uploadpack.allowReachableSHA1InWant / uploadpack.allowAnySHA1InWant
   configuration items.

   That should be surmountable by making the behavior conditional, but
   it's a complication.

 - When the user passes --depth=<num>, do they mean that to apply to
   the superproject, to the submodules, or both?  Documentation should
   make the behavior clear.

   Fortunately I believe this complication has been takencare of using
   the --shallow-submodules option.

> Git submodule seems to be very stubborn and cloning master, although the
> wrapper script and the gitmodules-helper could work together to clone directly
> the branch specified in the .gitmodules file, if specified.

This could make sense.  For the same reason as --depth in the
superproject gives ambiguous signals about what should happen in
submodules, --single-branch in the superproject gives ambiguous
signals about what branch to fetch in submodules.

> Another wrinkle is that when the commit is not the tip of the branch, the depth
> parameter should somehow be stored in the .gitmodules info, but any change in
> the submodule will break the supermodule submodule depth info sooner or later,
> which is definitly frigile.

Hm, this seems to go in another direction.  I don't think we should
store the depth parameter in the .gitmodules file, since different
users are likely to have different preferences about what to make
shallow.  If we make --depth easy enough to use at the superproject
level then the user can specify what they want there.

> I tried digging into this section of the code and debugging with bashdb to see
> where --depth might fit, but I got stuck on the shell-to-helper interaction and
> the details of the submodule implementation, so I want to lay out this first
> patch as starting point for the discussion in the hope somebody else picks it
> up or can provide some inputs. I have the feeling there are multiple code paths
> that are being ran, depending on the moment (initial clone, submodule
> recursive, post-clone update etc.) and I have a gut feeling there shouldn't be
> any code duplication just because the operation is different.
>
> This first patch is only trying to use a non-master branch, I have some changes
> for the --depth part, but I stopped working on it due to the "default depth"
> issue above.
>
> Does any of this sound reasonable?
> Is this patch idea usable or did I managed to touch the part of the code that
> should not be touched?

I agree with the goal.  As mentioned above, I'm not confident about
the particular mechanism --- e.g. something using fetch-by-sha1 seems
likely to be more intuitive.

Today, the 'branch' setting in .gitmodules is only for "git submodule
update --remote".  This patch would be a significant expansion in
scope for it.  Hopefully others on the list can talk more about how
that fits into various workflows and whether it would work out well.

Thanks and hope that helps,
Jonathan

>  git-submodule.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2491496..370f19e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -589,8 +589,11 @@ cmd_update()
>  			branch=$(git submodule--helper remote-branch "$sm_path")
>  			if test -z "$nofetch"
>  			then
> +				# non-default branch
> +				rbranch=$(git config -f .gitmodules submodule.$sm_path.branch)
> +				br_refspec=${rbanch:+"refs/heads/$rbranch:refs/heads/$rbranch"}
>  				# Fetch remote before determining tracking $sha1
> -				fetch_in_submodule "$sm_path" $depth ||
> +				fetch_in_submodule "$sm_path" $depth $br_refspec ||
>  				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
>  			fi
>  			remote_name=$(sanitize_submodule_env; cd "$sm_path" && get_default_remote)
