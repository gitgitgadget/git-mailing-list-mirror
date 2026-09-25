Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133383672BD
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362938; cv=none; b=N5pAPZw5GqjzGDSoZVHGk3ZKV8c9W7wRVvUWr21io7kbWpqsiDLSSFnTAapC1YEwpTMsBYClE2nAUrLXrM6CrwHJdYVBuW1V4GylTw2oZ+bd5R4w1Lo08DpR4qT6bu/sv72Uxjso4/WBNy43oRQNAQHKtLYHepwZBxjjaJZqRrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362938; c=relaxed/simple;
	bh=GzdTNaHoz40vRxpweb7ov0zs/415hYbZd4bvVzlsd68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dKWSgP6N4GvN0NvtVTWovZCcXH+v2gCSB7e/7F8iHes+mgD6t7kNlogj90acnwjK0gMl392fZGctn6dISy4yjxvc22uJ+NvtWu45csHQvT43ZQnRqcRczjart/yCaRk7t8/HYqlJRWAYvOKnGG+GzZjlpPOvSmYXeipu0/MCnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K7DTJQ28; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MLJLwkGA; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K7DTJQ28";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MLJLwkGA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 06618EC011F;
	Fri, 25 Sep 2026 15:02:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 25 Sep 2026 15:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790362936; x=1790449336; bh=tM91kwFEz5
	iOZxfZ8mx6F7cWmL2/mpo679NNfMedB5w=; b=K7DTJQ28yPSgvJq7ypaT5cHbVz
	Skj0gLUC5EDL8RfdndTKG5NfhBR+Z+v5DC6jXRWvvc2arSVLkcw44F2GBdYIba68
	JM4zCnGxHcEHb+VSVvDfVXsAxwrngItSX6WvhXPxQQKbvuWJVKXdRirz4iUP0rCf
	fhNdaMxJzvB1YqD48TIi8i2q05TXTU5EjkSrmpyHtErj/l/uzC9GLKGbBlZn4N/G
	QMb3O7BkjDQkmhQ3sHSySkwybcD+Ba8SykCJl1BX3XDQwLuqiCqQ3Y10aQ73KOyz
	eRzPWgOjmhQ32+HU1ATQoteAFke5EJyVwpvfkZAZBvncSxvAL4LhmbFMB3Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790362936; x=1790449336; bh=tM91kwFEz5iOZxfZ8mx6F7cWmL2/mpo679N
	NfMedB5w=; b=MLJLwkGApnyqFWMZ+6f1QfwZpeCOopiYFotZG1Yd8o0lVK+JKRi
	+DBZsyzJdwaxugBKHnwTQBtXIjrDJYIbz/sm2JHaqhkgK6VNFHbrgN0pHYX8HRGC
	q8omes9yVFPibK/4YTEZeO+N1Owx0BzcUHHOovNGyM4zOQ9QC+GOfhx7IZ9km3mZ
	O8vXX89dU2xjzzObT6aFUcd0rHl5cTf06I2mb3SuzJwN4bQAybjU2bk2/neoOzsF
	W0JZTuXD8pcCZQIvtDx14gVQFRGfKK5cpMXu1hHYZQX8By0f9u4m7ONv0/mO6hyT
	EQOMsivQHZ3D7KTE3uq2CGSUpRpAbJjVS9A==
X-ME-Sender: <xms:N8W2ag0pCw-Qo7QWV28esn-R0ixzFonb65df2WuEgyrr_7vMtdUnWA>
    <xme:N8W2aiHpzO-UYx4sLYxmRsRWVzThHy8w-viOM6Z0Z1QMsJTAOxa4Ab7zKBA2owqIM
    C_NFpKHntmhOhMdTLRW_UcYfiu1CANH9QX-RImiQuWmgLBuFdPtfw>
X-ME-Received: <xmr:N8W2at72CCrPr-enb5Goe83kZVL4rpR7KiqhsduyC0ddhO6WgBBmSW0zdk_V43KWU7rPBuzZ6jqg0IqJnajstkQ5iUmKL137lktf>
X-ME-Proxy-Cause: dmFkZTFav5D+7TqjmMHOv1JbMsU8D9qijff3pLTDs53ZgjlGwMNPWnQ/b/t+ZMIw+hTy0X
    0AB2WTPdDsqM3dOHpsU9LzqbIMN359LUyhqFTkGcB/9QThEYJsvpOdDeuNi+NmBEP0Wocc
    qkhtwGLWAaNCIc6sdpWQIWzw+oV0x7x/hWMl89/CYA6Ez+vJtmBrTdvjp8RFJq9dTRpKRE
    UFgSNAbulDsiv4NdQri6MetDc05rEn+9Gd8/DOX7woXYEHGHwTo6yN4BjTBwe8jQfWjg9J
    0LYSg4gxRM7eJ0wCh1m5ohA1FWnGJweT/Ba4Ie6jqIIYTcCyF/hmnUSjgJrSMcNCwtBbPa
    S7OJzOSUs3zu5Sf9BqgWS4iYiA+hK/cpFgsb/N3nDkZPuvAWJZqqiB2lCGgXqVdVuV0dld
    s+02H7XOQDCKl+FGREGpOIe5cY+q+44L8uW4Mx1rWa1lsMZmQF8kd8vvTRipgPishLAn9b
    pF6OAi0MAFtjmph0/e+DH/cLjKkE2oG5fkysxB0rTArA0DFggRdzGtZkfUfLzeY9N8ssSW
    JDhIscklAJCcv6heAHONCvhLKRC5gznZlq8xqLujUSTpC0VGmvSmrRJ3rClHi1ZYdcwvGy
    lBu2DcXy/4LxaDoc+4OnpJ1myNbWfam+2BWqG8g374WdKNaCPzSQLLf+807A
X-ME-Proxy: <xmx:N8W2aoueZOVtw4WL82BU6OpG0LiJ5D8IROigK1xehcdAi9cdUMdYlw>
    <xmx:N8W2au6YrXHWcMheiQj1WhkqH3NG9GWV3epHaEzDJwDhGXWrR24U3A>
    <xmx:N8W2ajU_TgwmwnCyT7AJPChXeSXnzcxW042p-kuCZ4T5G4HqLdpKwQ>
    <xmx:N8W2ag-b4UysmsvHpAGX-6YFivnBqOfjeTXkISaB3__JH9pqrl60JA>
    <xmx:OMW2apYeVM9wITO6ATFCmFH0G44m1i6aGO7BAHQQRumSfUyM8zw4NR2I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 15:02:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] ci: only warn about perforce/git-lfs/JGit on platforms
 that need them
In-Reply-To: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sat, 12 Sep 2026 14:38:02
	+0000")
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
Date: Fri, 25 Sep 2026 12:02:13 -0700
Message-ID: <xmqq1pahupca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> perforce, git-lfs, and JGit test git's own interop code, not anything
> platform-specific, so installing them once on ubuntu-* (all three)
> and macos-* (perforce) is enough coverage. debian, i386/ubuntu,
> alpine, fedora and almalinux never install them, yet the presence
> check at the end of the script warned on all of them anyway.
>
> Scope each check to the platforms that attempt the install, so a
> warning means one actually failed.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>     ci: only warn about perforce/git-lfs/JGit on platforms that need them
>     
>     Only warn about a missing perforce/git-lfs/JGit install on the platforms
>     that actually need and attempt them (ubuntu-*, plus macOS for perforce),
>     since every other platform never installs them and was warning
>     regardless.

It is curious that nobody seems to have looked at this patch, as my
cursory look suggests it would be a no brainer to check correctness
of this under the assumption that nothing will change externally.

The maintenance to keep this in sync with what exactly are tested in
each platforms will be made more costly with this change, but I do
not know by how much.  If somebody wants to start testing p4 on a
different platform, for example, as I think t98xx will just punt
without failing if p4 is not available, it will probably be a while
until they eventually notice that their test do not run due to lack
of p4 and then they have to add their platform to the logic added by
this patch.  I think jgit is also the same; silent success when JGIT
prerequisite is not met.  But if they are motivated enough to add
tests, they will eventually notice when the tests they wanted to run
were not running, so it is a reasonably low risk.  If somebody wants
to drop testing jgit on a platform, we may still install jgit even
though we do not run tests that require jgit, which may take longer
for us to notice, but the result is just as bad at most as the state
without this change, so overall I think it makes sense.

Any volunteers to offer a second pair of eyes?

Thanks.


> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2403%2FHaraldNordgren%2Fci-scope-optional-tool-warnings-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2403/HaraldNordgren/ci-scope-optional-tool-warnings-v1
> Pull-Request: https://github.com/git/git/pull/2403
>
>  ci/install-dependencies.sh | 54 ++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 23 deletions(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 2f61fbb07c..a68cec64b4 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -171,30 +171,38 @@ Documentation)
>  	;;
>  esac
>  
> -if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
> -then
> -	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
> -	p4d -V
> -	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
> -	p4 -V
> -else
> -	echo >&2 "::warning:: perforce wasn't installed, see above for clues why"
> -fi
> +case "$distro" in
> +ubuntu-*|macos-*)
> +	if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
> +	then
> +		echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
> +		p4d -V
> +		echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
> +		p4 -V
> +	else
> +		echo >&2 "::warning:: perforce wasn't installed, see above for clues why"
> +	fi
> +	;;
> +esac
>  
> -if type git-lfs >/dev/null 2>&1
> -then
> -	echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
> -	git-lfs version
> -else
> -	echo >&2 "::warning:: git-lfs wasn't installed, see above for clues why"
> -fi
> +case "$distro" in
> +ubuntu-*)
> +	if type git-lfs >/dev/null 2>&1
> +	then
> +		echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
> +		git-lfs version
> +	else
> +		echo >&2 "::warning:: git-lfs wasn't installed, see above for clues why"
> +	fi
>  
> -if type jgit >/dev/null 2>&1
> -then
> -	echo "$(tput setaf 6)JGit Version$(tput sgr0)"
> -	jgit version
> -else
> -	echo >&2 "::warning:: JGit wasn't installed, see above for clues why"
> -fi
> +	if type jgit >/dev/null 2>&1
> +	then
> +		echo "$(tput setaf 6)JGit Version$(tput sgr0)"
> +		jgit version
> +	else
> +		echo >&2 "::warning:: JGit wasn't installed, see above for clues why"
> +	fi
> +	;;
> +esac
>  
>  end_group "Install dependencies"
>
> base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
