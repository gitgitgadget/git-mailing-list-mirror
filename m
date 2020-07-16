Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038CDC433E3
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 07:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE3E2206F4
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 07:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kHp8ccoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgGPHBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:01:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54724 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgGPHBO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 03:01:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D93317CC42;
        Thu, 16 Jul 2020 03:01:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9iRbCWHqUaiP/bnUnDdvSLpZEYY=; b=kHp8cc
        oipxaqLkTGP3uBSztVOJTptknCOqP/dIozvhabHVnmNcmJ13gG58TnFZDxkhHiQl
        1RKLGP8W/pi3SCwf2nxupiZKppL8HG6V/yj8TJCL/tW9YarhA1nRarZJdxbEi8aB
        UEsN/AsUiol1sI7JkTZH0RCAMxDzLH0szY1eE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uJTGAE3tP9GOStxL6IgJe4Qs0JmF8gua
        fiFmZxYg/9tnzTEVmull5r0wssWQucXUHCADISwCji9HAOkSWpDaJR81x1r79+kM
        Jis0enmhjr812TfMJ28mz1oK8KM4W0XkOmhIUSokBXmfYOj3uBQgtNtfmxb/4iBe
        s3MZuc88kAs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFC487CC41;
        Thu, 16 Jul 2020 03:01:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 647E07CC40;
        Thu, 16 Jul 2020 03:01:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] repository: allow repository format upgrade with extensions
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
        <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
        <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
        <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
        <xmqqpn8wkben.fsf@gitster.c.googlers.com>
        <20200716062054.GA3242764@google.com>
        <20200716062818.GC3242764@google.com>
Date:   Thu, 16 Jul 2020 00:01:09 -0700
In-Reply-To: <20200716062818.GC3242764@google.com> (Jonathan Nieder's message
        of "Wed, 15 Jul 2020 23:28:18 -0700")
Message-ID: <xmqqh7u8hrka.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2101D13A-C732-11EA-9147-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Now that we officially permit repository extensions in repository
> format v0, permit upgrading a repository with extensions from v0 to v1
> as well.
>
> For example, this means a repository where the user has set
> "extensions.preciousObjects" can use "git fetch --filter=blob:none
> origin" to upgrade the repository to use v1 and the partial clone
> extension.
>
> To avoid mistakes, continue to forbid repository format upgrades in v0
> repositories with an unrecognized extension.  This way, a v0 user
> using a misspelled extension field gets a chance to correct the
> mistake before updating to the less forgiving v1 format.

This needs to be managed carefully.  When the next extension is
added to the codebase, that extension may be "known" to Git, but I
do not think it is a good idea to honor it in v0 repository, or
allow upgrading v0 repository to v1 with such an extension that
weren't "known" to Git.  For example, a topic in flight adds
objectformat extension and I do not think it should be honored in v0
repository.

Having said that, the approach is OK for now at the tip of tonight's
master, but the point is "known" vs "unknown" must be fixed right
with some means.  E.g. tell people to throw the "new" extensions to
the list of "unknown extensions" in check_repo_format() when they
add new ones, or something.

Thanks.

> +	if (!repo_fmt.version && repo_fmt.unknown_extensions.nr)
> +		return error("cannot upgrade repository format: "
> +			     "unknown extension %s",
> +			     repo_fmt.unknown_extensions.items[0].string);
>  
>  	strbuf_addf(&repo_version, "%d", target_version);
>  	git_config_set("core.repositoryformatversion", repo_version.buf);
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 51d1eba6050..6aa0f313bdd 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -42,7 +42,7 @@ test_expect_success 'convert shallow clone to partial clone' '
>  	test_cmp_config -C client 1 core.repositoryformatversion
>  '
>  
> -test_expect_success 'converting to partial clone fails with noop extension' '
> +test_expect_success 'convert to partial clone with noop extension' '
>  	rm -fr server client &&
>  	test_create_repo server &&
>  	test_commit -C server my_commit 1 &&
> @@ -50,7 +50,7 @@ test_expect_success 'converting to partial clone fails with noop extension' '
>  	git clone --depth=1 "file://$(pwd)/server" client &&
>  	test_cmp_config -C client 0 core.repositoryformatversion &&
>  	git -C client config extensions.noop true &&
> -	test_must_fail git -C client fetch --unshallow --filter="blob:none"
> +	git -C client fetch --unshallow --filter="blob:none"
>  '
>  
>  test_expect_success 'converting to partial clone fails with unrecognized extension' '
