Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAAEC4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiLFCtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiLFCtG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:49:06 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51A225C71
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:48:45 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qk9so2997657ejc.3
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B8IySzC1qT7rYDOdjclUdzaPF20v5JhAT7cK8rdXLpg=;
        b=fd6NPJKsrPPeawvmpoTaU1d+klSBeO4AdnazSZ+0xL0bGssP8rgfNEXoqKPOcekwWW
         XPjkrUZ78Y/LKM5g2n/x4vlSR4+lUWGre6erISd+0mbY8eoxlxvSKkZEcmiyzDyiaLom
         W23D3FYgvC7HlttvrfzZPIpqwoKuW6+VC2eEoD4zMpPGFzkKM041iKue1Yy5QGOBr7a/
         2SZw6WXPcD+PXtc/m9HOcg7+VrHX5C8peLcordRTNOYL2MrnoPud/Q1ImlxEuZfUu4yt
         u1t/eaRx8gYYFZY9vYpCZWX0agYtH978GPet482VGJkZUzl/ol750rjoJLXRDORjX29O
         a6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8IySzC1qT7rYDOdjclUdzaPF20v5JhAT7cK8rdXLpg=;
        b=nCDh1CLLGzfqHU8ZS/0wdx9dfvG2D1P5yqS6FqEpZEoPnmuYhnqC1CVGeHFKMmeGzy
         x5j2ZVfZN39wJHvOq9NMPnkB4sJhXl6w7cfABeA6mb2P36JmSDzKv/6vf0nhRPEdCdv1
         ch2PoZfBEHxpjHuo8a0IJHoPz2sxGl5pAygUGEwnzYIm71Zybt/TnpnHiYaOY9o+/2u5
         N60PGrcER41qP2no1Z9cD1BZPqOb1GO/LWxQX4OaLYGY672UEzEz4DAjNcweWp3gaJsB
         pjRyMTA7KMjN+Jrqr8E44vnhCfYFt/B/WSyzJzRDV/Az2EsNNfu6tVG7p4g4zIGMk6gJ
         Yi+g==
X-Gm-Message-State: ANoB5pnFOgvor/w3bGqWmq2JPdI2gcee9wx/Lq+ieSgr7wnyqLHlr1Tz
        KoU+CKC9ald1VSa/Aaibwfg=
X-Google-Smtp-Source: AA0mqf5jjC6kTGGBS4Bibc1u5/hx14iwDIvixvKv9rDELaYNKJVBlF7rNtKz9cF9JlEVtMGVd/Uv2g==
X-Received: by 2002:a17:906:99cb:b0:7bb:7dda:7d3c with SMTP id s11-20020a17090699cb00b007bb7dda7d3cmr23353885ejn.182.1670294924042;
        Mon, 05 Dec 2022 18:48:44 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id f25-20020a056402069900b0044ef2ac2650sm442112edy.90.2022.12.05.18.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:48:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2O0h-003RGx-0I;
        Tue, 06 Dec 2022 03:48:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] t1509: facilitate repeated script invocations
Date:   Tue, 06 Dec 2022 03:42:28 +0100
References: <pull.1425.git.1668999621.gitgitgadget@gmail.com>
 <97ada2a1202190776ce3989d3841dd47e2702316.1668999621.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <97ada2a1202190776ce3989d3841dd47e2702316.1668999621.git.gitgitgadget@gmail.com>
Message-ID: <221206.86ilipckms.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 21 2022, Eric Sunshine via GitGitGadget wrote:

> From: Eric Sunshine <sunshine@sunshineco.com>
>
> t1509-root-work-tree.sh, which tests behavior of a Git repository
> located at the root `/` directory, refuses to run if it detects the
> presence of an existing repository at `/`. This safeguard ensures that
> it won't clobber a legitimate repository at that location. However,
> because t1509 does a poor job of cleaning up after itself, it runs afoul
> of its own safety check on subsequent runs, which makes it painful to
> run the script repeatedly since each run requires manual cleanup of
> detritus from the previous run.
>
> Address this shortcoming by making t1509 clean up after itself as its
> last action. This is safe since the script can only make it to this
> cleanup action if it did not find a legitimate repository at `/` in the
> first place, so the resources cleaned up here can only have been created
> by the script itself.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t1509-root-work-tree.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/t/t1509-root-work-tree.sh b/t/t1509-root-work-tree.sh
> index d0417626280..c799f5b6aca 100755
> --- a/t/t1509-root-work-tree.sh
> +++ b/t/t1509-root-work-tree.sh
> @@ -256,4 +256,9 @@ test_expect_success 'go to /foo' 'cd /foo'
>  
>  test_vars 'auto gitdir, root' "/" "" ""
>  
> +test_expect_success 'cleanup root' '
> +	rm -rf /.git /refs /objects /info /hooks /branches /foo &&
> +	rm -f /HEAD /config /description /expected /ls.expected /me /result
> +'

Perhaps it would be nice to split this into a function in an earlier
step, as this duplicates what you patched in 2/3. E.g.:
	
	cleanup_root_git_bare() {
		rm -rf /.git
	}
	cleanup_root_git() {
		rm -f /HEAD /config /description /expected /ls.expected /me /result
	}

Then all 3 resulting users could call some combination of those.

This is an existing wart, but I also wondered why the "expected",
"result" etc. was needed. Either we could make the tests creating those
do a "test_when_finished" removal of it, or better yet just create those
in the trash directory.

At this point we've cd'd to /, but there doesn't seem to be a reason we
couldn't use our original trash directory for our own state.

The "description" we could then git rid of with "git init --template=".

We could even get rid of the need to maintain "HEAD" etc. by init-ing a
repo in the trash directory, copying its contents to "/", and then we'd
know exactly what we needed to remove afterwards. I.e. just a mirror of
the structure we copied from our just init-ed repo.

But all that's a digression for this series, which I think is good
enough as-is. I just wondered why we had some of these odd looking
patterns.



