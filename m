Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B6114A62B
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119509; cv=none; b=rp34j/POjB7LR7derEuM1EyGi5DPkOiWfu4VlfJN1Mb5pqS7mroq107hsf/8QZ1mDjRJmgupXNDVM/yrf4IGei1sv4XBi4+QXrSp+k1gXaFEcccnB7NEXuRjlfg+MSDcl6x8yHQjQn31p5K9KMdY1ifWkusXKrEO6nuKixOqV+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119509; c=relaxed/simple;
	bh=9JQGcGa/LVQ/3FYnsS7pWqheIruoGzre/ER+7gCkBIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cV9hcrZa7U+J9yaFlPgVsJK0fEKF9raeAXV0x1/WtEOyzXNJNLm8n4WeT1gtb0pM3C/Zbfx7eWQNfM4ZVrFsIEJgV3oc1craq6QhKh+zM77s44ew8QNfLRztNe1IpfPEjoEL3hZrPvgkravjWsX6DOwJ6U9tE9S4vFb+y8+53eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VRg537X+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZfuKSP8D; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VRg537X+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZfuKSP8D"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 65419EC05AC;
	Thu, 26 Feb 2026 10:25:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 26 Feb 2026 10:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772119507; x=1772205907; bh=tMxMQkVh+R
	qY4fMMJOy0C4PdWAtagP81J4l1aanDrCA=; b=VRg537X+72qZOsjP+3uWikLTsK
	w8g7Nj/WPUQgi+VFWJo/QcBqQFww8eZQ+2UIdwIiuRMABcV6ExwZSmnuHhbTU5Yy
	zNYJnIo1YGw3QOYGYrbvAC8JzLOtewagnFfN5MB2wFDKLifOQ8tt0zF3NP75A3l9
	xjllEN3siYXPmVghRSwwhh4XgDDVx5ElGsdyiopH5PjYc5+37oO/VNFU1mmUSdJc
	i+AjvCiapdlHB5bR00SkxQKlWwYneEbGW2aQ0y+o15pcpXLuoxM3/DAq624XQHMW
	SdfaHRR4FO1D5GaFo/DwOSWpaiqaU8c3ntzBh9oXT4TbAhTT6blD5mhMxcyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772119507; x=1772205907; bh=tMxMQkVh+RqY4fMMJOy0C4PdWAtagP81J4l
	1aanDrCA=; b=ZfuKSP8DGhmnKeZhoct6OYmPXOLo1MDRKzdwE06qbjtMkPeRLI1
	cAyjSoBvQRMagqUXp2Yr34MVOTc8DhlzT+kU8ibc0pUUMOOI71sxTBDkFYGmDerN
	zdd5/QTEkf3Xeuc72sNhrDRAwTmWUnDu52hAx+TfI6QtG9kI6FsELMF4We7KLOd6
	rw77hXMrN6NOuuZ7UVJ7cmuazJ4e/ST+4OP/yJcUtezAT+KEffYato9FlMLMTxPU
	VnyVRxC+OhIi3HYGhTbx+ojv0JXIH7zsYu+ldYfynSwI/zHc9nqkvXYpUTT83cLD
	NHngaSg44MWsb9RdjdzGSDAskkADtIq2pFA==
X-ME-Sender: <xms:02Wgab7CN_Bc4sw9PKbrTnTyKN4vYVtqUgreWh7k2h0uUt28itqU9w>
    <xme:02WgaZX5n_ShbMnzjlAI78I1bKYLPppxvbjaTztp00TJdb6ZFpKGjiQS0zeDkGEP2
    AJrJAmif_ubD2KSik8p4cEk9fHVSKsTcbsfuenldDp22o8Ei58B>
X-ME-Received: <xmr:02WgaS6SohHWMfSoK05ZnlgbcsMr6dWpvcxm2QeE7alRwpzz7yUxXjAnwcVe7OtGB78t3OXTSpA6Jov8wtkOGN8UFBbokG0g6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeifeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjie
    htsehkuggsghdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithessghluhhmihgrrdhnvghtpdhrtghpthhtohepfigrnhhgiihitghh
    ohhnghesuggvvghpihhnrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:02Wgacpga54NWpKphi3yC0sVxxVpmy13YcT0zai_8mLcFf6YCBJ9aQ>
    <xmx:02WgadnQFeIn7-dxupi61j0BC3y0OoR_InMv4hsFkO1gLndSkCOXTQ>
    <xmx:02WgaQNZAaE4IvkPSgZjy4UXOzX2eZaagjC582zBOAT8vuVoBHrorA>
    <xmx:02WgaZOcHWtAGNezbS8mP0DTuWS3UlBy2_PKQDr_y_BCnOl12tYnDw>
    <xmx:02WgaYYmLskwuYd9LJID0i3W3BCMoa_E3W9BUWbv3hzOsoqxyLB_QPYa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 10:25:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: "Gary Wang via GitGitGadget" <gitgitgadget@gmail.com>,
    git@vger.kernel.org,
    Gary Wang <git@blumia.net>,
      Wang Zichong <wangzichong@deepin.org>
Subject: Re: [PATCH] gitk: support config the color of linkfgcolor via Gitk
 Preferences
In-Reply-To: <pull.2217.git.git.1772109195114.gitgitgadget@gmail.com> (Gary
	Wang via GitGitGadget's message of "Thu, 26 Feb 2026 12:33:15 +0000")
References: <pull.2217.git.git.1772109195114.gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 07:25:05 -0800
Message-ID: <xmqqecm75xym.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gary Wang via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Wang Zichong <wangzichong@deepin.org>
>
> As a dark-theme user, I use the Preferences dialog to set colors
> for gitk, the only color I cannot change via that dialog is the
> link foreground color, which will lead me to use the default link
> color on a dark background that make it not really readable.
>
> This patch makes the link foreground color also configurable in the
> Gitk Preferences dialog's Color tab, so user won't need to dig into
> the code/manual to know if the link color is configurable and can
> simply set the color there.
>
> CC: Mark Levedahl <mlevedahl@gmail.com>, Paul Mackerras <paulus@samba.org>
> Signed-off-by: Wang Zichong <wangzichong@deepin.org>
> ---
>     gitk: support config the color of linkfgcolor via Gitk Preferences
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2217%2FBLumia%2Fgitk-linkfgcolor-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2217/BLumia/gitk-linkfgcolor-v1
> Pull-Request: https://github.com/git/git/pull/2217
>
>  gitk-git/gitk | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index cbaaee994e..b60f140636 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -11796,7 +11796,7 @@ proc prefspage_general {notebook} {
>  
>  proc prefspage_colors {notebook} {
>      global bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
> -    global diffbgcolors
> +    global diffbgcolors linkfgcolor
>      global themeloader
>  
>      set page [create_prefs_page $notebook.colors]
> @@ -11873,6 +11873,11 @@ proc prefspage_colors {notebook} {
>          -command [list choosecolor selectbgcolor {} $page [mc "background"]]
>      grid x $page.selbgbut $page.selbgsep -sticky w
>  
> +    label $page.linkfg -padx 40 -relief sunk -background $linkfgcolor
> +    ttk::button $page.linkfgbut -text [mc "Link color"] \
> +        -command [list choosecolor linkfgcolor {} $page [mc "link color"]]
> +    grid x $page.linkfgbut $page.linkfg -sticky w
> +
>      grid columnconfigure $page 2 -weight 1
>  
>      return $page
> @@ -11880,7 +11885,7 @@ proc prefspage_colors {notebook} {
>  
>  proc prefspage_set_colorswatches {page} {
>      global bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
> -    global diffbgcolors
> +    global diffbgcolors linkfgcolor
>  
>      $page.bg configure -background $bgcolor
>      $page.fg configure -background $fgcolor
> @@ -11891,6 +11896,7 @@ proc prefspage_set_colorswatches {page} {
>      $page.hunksep configure -background [lindex $diffcolors 2]
>      $page.markbgsep configure -background $markbgcolor
>      $page.selbgsep configure -background $selectbgcolor
> +    $page.linkfg configure -background $linkfgcolor
>  }
>  
>  proc prefspage_fonts {notebook} {
>
> base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
