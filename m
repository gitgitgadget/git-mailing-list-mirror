Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91AD81F462
	for <e@80x24.org>; Fri, 14 Jun 2019 18:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFNSTw (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 14:19:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56211 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfFNSTt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 14:19:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C76B16159F;
        Fri, 14 Jun 2019 14:19:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=arNh6dnmExQ6
        W7LYW967edbsAeY=; b=hGQAU+NuQ29LOSmjY+vzEicCw6loUny3C9OtudUmqw8W
        70tWXe+rP14HEOOQ2IZFwew9NXU6KmpfiP1iFxatUl12akftHraHr1A90FPSfuoY
        pw+GCioOnI/Y9vrxj+9pzW86bnD0RljJOgHG/KREJhIyKWhcnkcMFn2jhwhgmbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=v50jbD
        bcS4iUY754L3URBgLVkYcXLONuC9GuuiQZGXJ8JwPM5Nnc9k3SQBy+GLJD6Ufw7W
        rrAIVWcvL7w5Ay+lf6gaDjEyaJ//JAu4SHnut5DkL6Zp0VzjWIvhHT6gm6MEbpXo
        636/+xt4NqiWO+XiK+jDapXHsCK99k5FoWl0Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 94F8616159E;
        Fri, 14 Jun 2019 14:19:45 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E448916159C;
        Fri, 14 Jun 2019 14:19:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC/PATCH v1 0/4] compat/obstack: update from upstream
References: <20190614095308.GG31952@szeder.dev>
        <20190614100059.13540-1-szeder.dev@gmail.com>
Date:   Fri, 14 Jun 2019 11:19:43 -0700
In-Reply-To: <20190614100059.13540-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 14 Jun 2019 12:00:55 +0200")
Message-ID: <xmqqy324t4g0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FC58CFD6-8ED0-11E9-B44D-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> And here is an all-green build of these patches on Travis CI:
>
>   https://travis-ci.org/szeder/git/builds/545645247
>
> (and one bonus patch on top to deal with some Homebrew nonsense)

Is this the one that making all of the jobs pass in the above
output, including the mac gcc one.  It would be wonderful to have it
separately and fast-tracked ;-)

-- >8 --
From: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Date: Wed, 3 Apr 2019 02:49:47 +0200
Subject: [PATCH] ci: make Homebrew's operations faster

---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 7f6acdd803..f804b40ddd 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -34,7 +34,7 @@ linux-clang|linux-gcc)
 	popd
 	;;
 osx-clang|osx-gcc)
-	brew update >/dev/null
+	export HOMEBREW_NO_INSTALL_CLEANUP=3D1 HOMEBREW_NO_AUTO_UPDATE=3D1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
 	test -z "$BREW_INSTALL_PACKAGES" ||
--=20
2.22.0-68-g0aae918dd9

