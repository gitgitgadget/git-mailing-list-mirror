Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C3E23392B
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784504826; cv=none; b=IZevq3vThLgo7bYxGZIVqAKe7KDtg4MGOq42rneMx2Ad6oH6fsD5o5cfs/fWMPGk3lX5LcQtGlZ+RpDGen5Nn+INJPOrLRgfwA1q1fogKEvmv7gflyHIh9dCSNWciGUATN4B6RH6sdUEBtApNleJW7ECouOC1QK5mMFHVlHFmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784504826; c=relaxed/simple;
	bh=WKE+cid8oDaGPylI635Lh24JRU5L5WL7To6U2SZWt2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oECvnMKZFNzEANDFg4qFFT7GJwRnBCxGlZZX2MNE1nKB/mocboabHW/OW36PKRj+EjyCdE7Ac6+tBdt/zduwzI94MSqTk/DmRUfAzM2Bli5nvgWr5P9eIHchsn63G/wt7HLsAkkXIOs1v/NWoTo9I4QFv0KaRLYEWl0irzGKCXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wRd2u95G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oz6KoslS; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wRd2u95G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oz6KoslS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 27F7D140003B;
	Sun, 19 Jul 2026 19:47:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 19 Jul 2026 19:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784504824;
	 x=1784591224; bh=pJTyZpwDpCeZ2wN+rF7uizZvrn3PlvVpq/Ot7zlumFk=; b=
	wRd2u95G8C2Ou/pYm/C7IK2+UWJT2GuD5shv5lYMviLEhVFQdob2QO9ZrhUlw9Eu
	iJ53pynqGUi3BmpTabzjHAlbTdJKdr4FSGjzpdC1VsOyRz2Yf5II4Wsf0EmrptEr
	w2EoVpFbJNBz5N6c2HbmtGw2stXcp9yD+Bm10Fpyn0xW6v94J4xTSmd+j1+Uem/G
	UCNyi2SIPiMETcSkimxwXVTjJ4e22cQNU1C/7rqKZv6QswlnWlfw9s+x1TeCQNCK
	NcF0y6QWv1mpYmFAylSHn46qORp0WkEnlvQU3b6i1hTCvHqYifJdDL7GxE0IV8OA
	7RSPOmpA2twDx4h/fDD0vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784504824; x=
	1784591224; bh=pJTyZpwDpCeZ2wN+rF7uizZvrn3PlvVpq/Ot7zlumFk=; b=O
	z6KoslSVKo7jW4S1C7wMg0yS6mKw1tATXlhGY4q1XkWEfmo11/QPAAvddiYUstz7
	vxWFzHSrVQChUcGzwwqAb+oVWc8BMonJu5OBWk//FMzXUMmWBxcwv3P/2sFjqQ4+
	T3SBkU/an9RDNC8auM8pn0Q0KyfQKaz916cKta1v1AlRof2sI9/3QszRfH8C8RNb
	3YwN72XFfhQtQZ1SQPax9xf+Sn58Y73AkgzT1Y/V9YSfsEjwurae9W1l6pMAMxaK
	LsZUOz29a14Uxpe0XtD4aeVBX+nQ3kNUuVDttgX31TJbcZrRK4HH2JFhep5ZNx2q
	pBryg3da4GVqbA4knXa/w==
X-ME-Sender: <xms:-GFdapyYuCBK_j1PzsXRoVve6KiGCTjqajt37phIPhafI9KjIIL3qA>
    <xme:-GFdagTjsyKA4Y-SyMgsho5hrKgrmxI1epXYBCEqLXcXOgSkeClyJBGglBfQFTCFr
    21qE0D88HjcAkls9UCqFIXJ6hbtEYg1gbtYapvMjsDBxUkPdr6NUV8>
X-ME-Received: <xmr:-GFdaoVOJ5IOzpbf5yNCzc6Cy2aGKI-skwIL_QJObO2PJFGOLIuBw_f7XwQybe8YSPKInfoZaAoz2OqL46vRR41_MCOm_w5jwg>
X-ME-Proxy-Cause: dmFkZTF/Byxd+cbBqz03DuqmXRvgs2ZyYNq3DQQhzU8gKUrcg6wuXpDRYy6fBEmQVe+09R
    a4gSGfCY70w6XjuVo1/zpo2wHHcp9kcF/XriBnJkm0h7yRkNExsxr5kcci6d3tSK1ISGhu
    Mu5/enqsuRmw/jAO8/DHmBECYrEx1DW0Nhoy40H1lVn23nw45XDk3InIi77KRPfGZwsyEA
    UXgJVKSHM7V39/shiog7r2AAxPUGjp54fDaoPJ9UoiUdprj41XJo8Nz15CQVcoFbNoH5Es
    KQXNP0Kr7uNKbHRobdH8TS/irK1WarAAy7kh3vtKKAJJy0InfFcTd0nh+Eo+veO7AaIjL0
    e5VpuUgfdjzKoa1iVEmY/zanbAhx6M0imSrA0S1/jUQ7McfaEuVD28QeY0L2OlcjXy4Yt7
    URx2/dz+zgb39ONQR8tFCue8yaztvvTSUonVLXNM2x/3k5H9HZEIJO0uevT+q6q0AoMdGZ
    tdj6FxyR65vMMwSAgnAhFBxtpPryiA/0Gcfo+CI8ygyLXqeq7IUMGZbGbdQw3rzYEy7XIT
    U/qaaHlQs+ZJ5202OH4sV14fdcrCQaDMjOQRTS+1Z8/1QiIGPFQjnDXTcC06Iras2mTXVT
    v1mtJxrfHjnC4IOU46ORiugpgFdpDjj73OKW5aKYb7R92kXhc1VWbXMAzJiQ
X-ME-Proxy: <xmx:-GFdaqb6Ax0VLbyk_J2UbiNIFV6gwXfC5WXynOCLvP9Oi8qOHXfb6w>
    <xmx:-GFdam0SLKCR31lOD6nKHZxPkxKIurJu76k4VOxKqP9uTbWSsIBuug>
    <xmx:-GFdakgUZJz0_AYEp0WQ8dZC37gS3cLuY-Qrih0y5I39r-5cFNHQEw>
    <xmx:-GFdaiZmICt4t5pUAokayBwIgtX-Ec8RVwbIl79SaJK8r1oz7tyKZQ>
    <xmx:-GFdanXCaNHtISmWnQHhhHspAuQDPqLfeSci_OHIAoZxVj5LezZE5mG6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 19:47:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 4/4] doc: convert git-request-pull synopsis and options
 to new style
In-Reply-To: <5b6e9bd3f3569cf9977d1cfd120a92756ec86b29.1784490878.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Sun,
 19 Jul 2026
	19:54:37 +0000")
References: <pull.2185.git.1784490878.gitgitgadget@gmail.com>
	<5b6e9bd3f3569cf9977d1cfd120a92756ec86b29.1784490878.git.gitgitgadget@gmail.com>
Date: Sun, 19 Jul 2026 16:47:02 -0700
Message-ID: <xmqqfr1eleyx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -54,11 +54,15 @@ the `v1.0` release, and want it to be integrated into the project.
>  First you push that change to your public repository for others to
>  see:
>  
> -	git push https://git.ko.xz/project master
> +-----
> +git push https://git.ko.xz/project master
> +-----
>  
>  Then, you run this command:
>  
> -	git request-pull v1.0 https://git.ko.xz/project master
> +------
> +git request-pull v1.0 https://git.ko.xz/project master
> +------
>  
>  which will produce a request to the upstream, summarizing the
>  changes between the `v1.0` release and your `master`, to pull it
> @@ -67,11 +71,15 @@ from your public repository.
>  If you pushed your change to a branch whose name is different from
>  the one you have locally, e.g.
>  
> -	git push https://git.ko.xz/project master:for-linus
> +-----
> +git push https://git.ko.xz/project master:for-linus
> +-----
>  
>  then you can ask that to be pulled with
>  
> -	git request-pull v1.0 https://git.ko.xz/project master:for-linus
> +-----
> +git request-pull v1.0 https://git.ko.xz/project master:for-linus
> +-----

Is there a widely accepted guideline among AsciiDoc users governing
how many dashes should delimit these blocks, other than "at least
four, with the opening and closing counts matching"?  If so, what is
it?  We see five, six, five, and five dashes in the proposed changes
above, and in '[PATCH 1/4]' we saw nine.  Even if varying counts are
functionally equivalent, the inconsistency is a bit distracting.

Thanks.

[Footnote]

 * an excerpt from [PATCH 1/4]

diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 538b91afc0..dd1e0a3718 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -192,7 +192,10 @@ supports only `XOAUTH2` as the mechanism.
 
 Once the commits are ready to be sent, run the following command:
 
-  $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
+
+---------
+$ git format-patch --cover-letter -M --stdout origin/master | git imap-send
+---------
