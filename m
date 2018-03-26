Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB80E1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 23:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeCZXHH (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 19:07:07 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:44819 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeCZXHG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 19:07:06 -0400
Received: by mail-yb0-f175.google.com with SMTP id v8-v6so6971701ybm.11
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 16:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M39QHrkfEP4R+8LsI+C6b8Wp4IiG7dNv7/NOiARItz0=;
        b=Rxmrz0QPYPPxGZ+gOUe4gB/ckxw9yQGOIUtLfyFqaQb6AlmhjPj86aQU8Ip9mm3Wwf
         8+92kbWVu03/yQr6jcvyIMf5HnURLlyArtsMzCf88po8oHbjncUgko0qquTtelDchMnR
         xibLVFlrNNg5Xuda3SAi43Vvdo6Gmr08BGSp1FxnDinCvqMKnyjOCs35Lg0qUE2DUZ+5
         rvkXb2XqkTuMz/LqcaY59SvorVFcHVcRCfz1ytHp/Qh90cGPDbyAHug7CKVZKPC5tDZp
         vFInTJsUAxTxBf7qmcDzUmTNF0sEmVJu9NqNtBT2BtohJWSnNbim0zZ1ifdQ9Dobf20B
         HpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M39QHrkfEP4R+8LsI+C6b8Wp4IiG7dNv7/NOiARItz0=;
        b=ZjLzlxjuBGW5NA1NCJnrn0sK1zGM8nXMlxAl/lvVZiUOU2vSZ/v9bwbfBp0/QJbtT+
         xn/aKWhlQxjNI05OJ7/GiJX6oeOCrZ2085skTXpVvy4zGm9SR9V5UrdjuZ+DrZCIT207
         3Hll4h0U0EItjCl8jx0dRmSXiao3vGGK8tLUN2Ms6wJYUftfXTodLFYPCyscR4hEqDbM
         zUzY982ufVivy2V/1lJjTUUzKIlaSAIPtADp/5ES3XgiumO494FZ4jL+Tm60JEBL9SwR
         FrV7TJ1sTRcsKG8T+bRoq6H1BE4f9q6gv5Tz0cFxNmrrmiOFk5ShOsENuJDKAgMvd3zm
         ig9w==
X-Gm-Message-State: AElRT7EuAKTI9/OmdEEmYvE8VzkC5GTL8AM1V/7ZYyTvoWUaR8Jx01ah
        6eW69J6soVfPNMMyIPontEaZevWNAPgmfEJz0wLndKCsXBw=
X-Google-Smtp-Source: AG47ELt8UppIewjhUKgESMUrdRfSGmJXd/PzPyQKnAri+Irwjo+Jz4nhxsgDkqJVlacVBzo57fGFCBzZtW5jcHHrn6g=
X-Received: by 2002:a25:5605:: with SMTP id k5-v6mr24906566ybb.292.1522105625228;
 Mon, 26 Mar 2018 16:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <1520366804-28233-1-git-send-email-eddy.petrisor@gmail.com>
In-Reply-To: <1520366804-28233-1-git-send-email-eddy.petrisor@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Mar 2018 23:06:54 +0000
Message-ID: <CAGZ79kb4Ea7t5j9XA0key1f99w5xRDwyRhMder1FMgdiZot3Tg@mail.gmail.com>
Subject: Re: [RFC PATCH] git-submodule.sh:cmd_update: if submodule branch
 exists, fetch that instead of default
To:     eddy.petrisor@gmail.com
Cc:     git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[snipped the cc list as well]

On Tue, Mar 6, 2018 at 12:06 PM Eddy Petri=C8=99or <eddy.petrisor@gmail.com=
>
wrote:

> Signed-off-by: Eddy Petri=C8=99or <eddy.petrisor@gmail.com>
> ---

Did this go anywhere?
(I just came back from a longer vacation, sorry for the delay on my site)

> There are projects such as llvm/clang which use several repositories, and
they
> might be forked for providing support for various features such as adding
Redox
> awareness to the toolchain. This typically means the superproject will us=
e
> another branch than master, occasionally even use an old commit from that
> non-master branch.

> Combined with the fact that when incorporating such a hierachy of
repositories
> usually the user is interested in just the exact commit specified in the
> submodule info, it follows that a desireable usecase is to be also able t=
o
> provide '--depth 1' to avoid waiting for ages for the clone operation to
> finish.

Very sensible.

> Git submodule seems to be very stubborn and cloning master, although the
> wrapper script and the gitmodules-helper could work together to clone
directly
> the branch specified in the .gitmodules file, if specified.

Also very sensible.

So far so good, could you move these paragraphs before the triple dashed
line
and sign off so we record it as the commit message?

> Another wrinkle is that when the commit is not the tip of the branch, the
depth
> parameter should somehow be stored in the .gitmodules info, but any
change in
> the submodule will break the supermodule submodule depth info sooner or
later,
> which is definitly frigile.

... which is why I would not include that.

git-fetch knows about --shallow-since or even better
shallow-exclude which could be set to the (depth+1)-th commit
(the boundary commit) recorded in the shallow information.

> I tried digging into this section of the code and debugging with bashdb
to see
> where --depth might fit, but I got stuck on the shell-to-helper
interaction and
> the details of the submodule implementation, so I want to lay out this
first
> patch as starting point for the discussion in the hope somebody else
picks it
> up or can provide some inputs. I have the feeling there are multiple code
paths
> that are being ran, depending on the moment (initial clone, submodule
> recursive, post-clone update etc.) and I have a gut feeling there
shouldn't be
> any code duplication just because the operation is different.

> This first patch is only trying to use a non-master branch, I have some
changes
> for the --depth part, but I stopped working on it due to the "default
depth"
> issue above.

> Does any of this sound reasonable?
> Is this patch idea usable or did I managed to touch the part of the code
that
> should not be touched?

This sounds reasonable. Thanks for writing the patch!

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2491496..370f19e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -589,8 +589,11 @@ cmd_update()
>                          branch=3D$(git submodule--helper remote-branch
"$sm_path")
>                          if test -z "$nofetch"
>                          then
> +                               # non-default branch
> +                               rbranch=3D$(git config -f .gitmodules
submodule.$sm_path.branch)
> +
br_refspec=3D${rbanch:+"refs/heads/$rbranch:refs/heads/$rbranch"}

Wouldn't we want to fetch into a remote tracking branch instead?
Instead of computing all this by yourself, these two lines could be

     br_refspec=3D$(git submodule--helper remote-branch $sm_path)

I would think.

>                                  # Fetch remote before determining
tracking $sha1
> -                               fetch_in_submodule "$sm_path" $depth ||
> +                               fetch_in_submodule "$sm_path" $depth
$br_refspec ||
>                                  die "$(eval_gettext "Unable to fetch in
submodule path '\$sm_path'")"
>                          fi
>                          remote_name=3D$(sanitize_submodule_env; cd
"$sm_path" && get_default_remote)

It would be awesome if you could write a little test for this feature, too.
Look for the tests in regarding --remote in t7406 (in the t/ directory) as
a starting point, please.

Thanks!
Stefan
