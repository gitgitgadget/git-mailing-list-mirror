Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3BD31F453
	for <e@80x24.org>; Wed, 31 Oct 2018 05:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeJaODl (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 10:03:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51547 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbeJaODl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 10:03:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id w7-v6so2771548wmc.1
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 22:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=46gG1pqnLQwzR6rwTjIkOs7c4nh6nonl0UbU2mfpqfY=;
        b=E4bBj7LoxRNeAIWBXVmY6w4OfiFzscKzB/RCAoMNMdxn77KlW+xC1atERC8qHT7Rt9
         M0H9BCWkM423pt3FFwO6ox/aTN93gU09IA2DJdiBs7sLPF20pG5zFQE9kLHnG09h0Rqj
         XUdbI5bogWVwXWKyaDbzIO/tF/3utLkQTkSmIHFFYQv0FG52To/vE7pRQlgEKdUVGePw
         Hue8sWboiCn+jUn/jKFuvUSoTojjUjbYXL1la1meYmv79B7Dy537EmNMiGTUDX9lwUPc
         BNPOmK/B4B+ZcxwZnn10N63wuByAiV++GLxiIXjEd+bIbuS2qFxHuJzKO3Hus4D3fCIR
         eb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=46gG1pqnLQwzR6rwTjIkOs7c4nh6nonl0UbU2mfpqfY=;
        b=WhcfIhNCOXUCiI9bqcHjPNbZABi7y/g83zbQDYr0fyYxPWLFsAknMmXMJA+sdcG9pU
         LL6mvxKOVdclC53VluXXGyP6fyeBjedQbi8oKNjC2x2y3V3lH0Zz3cPzuh59LulKDHRM
         2rDFfE30ZNk3nrMXS+vERJ5M/ojeULG/xSU4Ktohbu7no54O14Utham+I1twt7JkCEIQ
         AAxeRxLCO6gcB/IgAEc5Pez226Qyvo6PDFI8t6t3xS3yW4gXgQisZpnWExFwGCPCUcnb
         Y8h28onE42whSm1QdOdbCdlAJDCwjdS7HxdH9gunvh+QgrzuKOmCnQcTE5WNuKLZEYbA
         OyiQ==
X-Gm-Message-State: AGRZ1gLfeCaGRniiUl+mj4Ql6upX8tiQKtC3rHJcgulX7ElGtBOf+KLa
        yR20gu/Vi1zcfCvNPBG2jEM=
X-Google-Smtp-Source: AJdET5dOzN45PhFesURNG3DGgn+2J0j2YYtPk2WzCvdn8AFaCHd+0gm9HxcTlUeQicYBgzdtNz+l/A==
X-Received: by 2002:a1c:e03:: with SMTP id 3-v6mr1017342wmo.13.1540962430850;
        Tue, 30 Oct 2018 22:07:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o9-v6sm35719902wra.42.2018.10.30.22.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 22:07:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "chris via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, chris <chris@webstech.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] Use correct /dev/null for UNIX and Windows
References: <pull.59.git.gitgitgadget@gmail.com>
        <8159cbd1b8025f33fb9d0e254db1a3c2a066f853.1540923993.git.gitgitgadget@gmail.com>
Date:   Wed, 31 Oct 2018 14:07:08 +0900
In-Reply-To: <8159cbd1b8025f33fb9d0e254db1a3c2a066f853.1540923993.git.gitgitgadget@gmail.com>
        (chris via GitGitGadget's message of "Tue, 30 Oct 2018 11:26:36 -0700
        (PDT)")
Message-ID: <xmqqo9bawvpf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: Re: [PATCH 1/1] Use correct /dev/null for UNIX and Windows

As this is only about contrib/diff-highlight, please make it clear
that it is the area the patch affects on its title, i.e.

	Subject: diff-highlight: use File::Spec->devnull(), not /dev/null

or something like that.

> From: chris <chris@webstech.net>

Please make this line read like

	From: Chris Webster <chris@webstech.net>

i.e. the author should be the person who is signing off that patch.

> Use File::Spec->devnull() for output redirection to avoid messages
> when Windows version of Perl is first in path.  The message 'The
> system cannot find the path specified.' is displayed each time git is
> run to get colors.
>
> Signed-off-by: Chris. Webster <chris@webstech.net>
> ---
>  contrib/diff-highlight/DiffHighlight.pm | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

There are a handful more instances of /dev/null found if you do

	$ git grep /dev/null -- \*.pl \*.pm

The one in perl/Git.pm must be shared by scripts written in Perl, so
it may be worth giving the same tweak to it, like this patch does to
the highlight script.

> diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
> index 536754583..7440aa1c4 100644
> --- a/contrib/diff-highlight/DiffHighlight.pm
> +++ b/contrib/diff-highlight/DiffHighlight.pm
> @@ -4,6 +4,11 @@ use 5.008;
>  use warnings FATAL => 'all';
>  use strict;
>  
> +# Use the correct value for both UNIX and Windows (/dev/null vs nul)
> +use File::Spec;
> +
> +my $NULL = File::Spec->devnull();
> +
>  # Highlight by reversing foreground and background. You could do
>  # other things like bold or underline if you prefer.
>  my @OLD_HIGHLIGHT = (
> @@ -134,7 +139,7 @@ sub highlight_stdin {
>  # fallback, which means we will work even if git can't be run.
>  sub color_config {
>  	my ($key, $default) = @_;
> -	my $s = `git config --get-color $key 2>/dev/null`;
> +	my $s = `git config --get-color $key 2>$NULL`;
>  	return length($s) ? $s : $default;
>  }
