Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B463FE35F
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469952; cv=none; b=ejYGTJ9YdpqAOVkNx7d9JaDQ88GULa6GhAQwLqDaanFFelqRELeOm1rau4iCH6QDY7T4ySyN815SAE89DnelHhHctBjVjP7wpY7ImbA+UKgJUu347ukaBfX09j+MgfT7I9LnGdLddoE1Bk7Es+ib7GL0WV3Wi7Xqr1s6cpbTZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469952; c=relaxed/simple;
	bh=/9ubbGt+b8teYbmQm3V6umlT3wdJdlegclsAOCg27gE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=bsKKcRLrJbrFxRPgoGjAWXibF54CSVA7RPuYROAE+1gcic8gGQZJ57Q/Qsx95DOQIqUUkz1za6Bw9gA0VBgc5Sm34McFURHZ2/oQ+b15yOFLlGOesEqHXhzMYSkiyKhnc6OK8ZrDVEtAD+Fcmhzay5YvRTNSd06WnbW5zBTGmDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MgqdyXby; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g7EAGlX+; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MgqdyXby";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g7EAGlX+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2FBEF1D0005E;
	Wed,  3 Jun 2026 02:59:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 03 Jun 2026 02:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780469949;
	 x=1780556349; bh=KJuK54rPHLGDfMXNHFzWQ5WpFM86dZXv04XWqZS2NxE=; b=
	MgqdyXby2cFMiAFgbsB8XhJ5VX4eHEean2laISpIxp8OPNxdzah+LfMaVnr5Kqf+
	4ynuy5WT3oS5gME+m/PkvT5quGW3LPVgW0JFys9YR9Urd6nbTgMKwILh2sgKZkhN
	PiOU6/dJDTbw4ql/udFolJEkiz++lCZn8/HO07TqlEs641neYFlP9l7t0lBrPcbM
	NhPohf6P06GkHQ3X70SGgPe7PUx5vrgey7fa0KidRfYCDtuKgTwnQcHHQLyj0cYk
	o321qwkcTs0wMCxqE9m1u2nC0GKasevNV/H8UnyEK93GjyrMonatUiYyV1J1FIBY
	y9VYmZG9k9DrMYgldAMrFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780469949; x=
	1780556349; bh=KJuK54rPHLGDfMXNHFzWQ5WpFM86dZXv04XWqZS2NxE=; b=g
	7EAGlX+Zh4YuX91QDorEOGjgTNYznGifOF824vAlQF7Aq3E/niBmBX47dkKLln2m
	u004BPbTBaMzQhEPh57DmDBDtCZ9Rw3sav7NpQekxBamLUm+yzKEpCPv9UmtBGo3
	DeZQoxW0+4LVPIEOyiUR9vkid0mxVWGHeBCrWT7r7kMeJesscTW1ClTt3i1dkKdU
	O4uMsJrHkif4/l9uTVPwZen2A8jG1qllhSJAt+nd6C8RN/nYPu0WsZDgLBS9188j
	0NnMl4gVCNZUNJ/dldg2lM6hYz0lKmYkpeZWXgXahIsG95FlZXcaYM5J2xBOGB2I
	Qay2hJTdNUB8LR3r3Ytig==
X-ME-Sender: <xms:vdAfakm40D67PagY8mGqvYOiry7KEt6hN0C3fNfyS8JjpvwnXydPmw>
    <xme:vdAfalU3XfvuKcQ55ux7NtgjE54oWgEMT_4M9_zuBNeU964R8x_y0F-FiSYP8sr-c
    i1X_eclHH4OS_rttN19QfuSMPxW5tniG9QQYbn-tjZHI10xm8bMrQ>
X-ME-Received: <xmr:vdAfaiuq2LOZkzCBPfNT12476yYFwuKBhCEJk96q7AzM6vtrHnB4o92eHOXe9AD_Ho4rchhwcfCEVoWyVH7TsgH7LR4Z8QY_Ozu8I5B7Lz2v>
X-ME-Proxy-Cause: dmFkZTGBZwjX84KwsWQ76+65C6Qolzeap+3ij0pRfN48jlQV/0KeunB9VSKHElpqHEYIlk
    RNiironV4kulzD88PBwpwoODNoxNTUngzkwYyhmb0zFhDm0j9pnFLzyEmdTpiKrwsKjc84
    A7GGvPtBNTijuYKnY6JZhgy9yhYkktRCOAcGdEYmXqjKu7CBEmd/eDTZiVcBuW7nNYlU3/
    6UqBKdmOFz2h4WiENnzSZjNQMsXR1XdQhvGIWvARS1jmgf81xJgkmrf9Se15j6cgiPNnlF
    mU2cw8ZV3FltZpMUz5JD2f16MsmDcUIQwZqbNwa3XYSC9o61rtf5Mj4GzhfsyN/ARxPpqv
    uV6UoBR9ZfUwJlbhn7Qm1Ek5wXzriO+Tw/7I8b2H9evR/pEQTOec0mWP3XFcTBHon2Lfy7
    UmgjC8kg906aNju9uUyXZgIYRr0IqqUZEukw7e5AxjDNuEnAzFw5VIR7AlVTj0WPVoqoBy
    sTKxg3hiw4L/Ufrpe4Pp3CBtO4+Sk26KqFn4p5knVjyDfIT4VPZfdoOJitSIXuTtIWzOdK
    7cHW/s4ysjCluRfS5XbzNz+ZZpeGeIT0BmnuL5zpA1alCln9jllSJLI558PhNz7+wG6KLy
    fth96X2bT3wKulwNr+CuDNfMFRTHH9zljtBLbyKNZmhhX1CrF9gefp2ep40w
X-ME-Proxy: <xmx:vdAfagZww2lBXoB_a54YPA_g36D2sxqVGG4fb0MOLbtAzz7CTjgL5A>
    <xmx:vdAfapVenW7lAFaIh0GOAxuWpCdbnNOpWmnyoG8eFAx21kMibNgYYg>
    <xmx:vdAfatRkyNqEEnjQP_eX4UpbF0PvPQA3urafauA1LPOmVt8s9P_IuA>
    <xmx:vdAfavPAHEZPhTXY7fdLmAVotxMZNONnGgBxGTCij5RksvqG7kDa7w>
    <xmx:vdAfatoA6uoeAmzkHsrHX3qVJvy8Ty_o-o6daJ4cW1wkrfr6WhtXYGbG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 02:59:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c1f239b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 06:59:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/3] Documentation: recommend the use of b4
Date: Wed, 03 Jun 2026 08:58:58 +0200
Message-Id: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALLQH2oC/2WNQQ7CIBREr9L8tRhAbK0r72G6APqxX2PbQCWah
 rsLdenyZd7MrBDQEwY4Vyt4jBRoGjPIXQV20OMNGfWZQXJZ85pLNj8CM4odhLWS9407KQNZnj0
 6em9D1+7H4WXuaJfSLsZAYZn8Z3uKonh/o1EwznSj8ahVi611lxzs6QldSukLa8E/y6sAAAA=
X-Change-ID: 20260602-pks-b4-31cc20d7f84b
In-Reply-To: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, 
 Weijie Yuan <wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: b4 0.15.2

Hi,

this small patch series wires up b4 in Git and recommends the use
thereof via "MyFirstContribution", as discussed in [1].

Changes in v2:
  - Reorder commits so that the b4 docs are added first.
  - Add a section that highlights how to configure b4, and that points
    out that the per-project defaults can be overridden via Git
    configuration.
  - Add a patch to MyFirstContribution that recommends shallow
    threading. I mostly intend this to be a discussion starter so that
    the `.b4-config` file matches our preferred threading style.
  - Fix a typo.
  - Link to v1: https://patch.msgid.link/20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im

Thanks!

Patrick

[1]: <xmqqik81xpqx.fsf@gitster.g>

---
Patrick Steinhardt (3):
      Documentation/MyFirstContribution: recommend shallow threading
      Documentation/MyFirstContribution: recommend the use of b4
      b4: introduce configuration for the Git project

 .b4-config                             |  6 +++
 .b4-cover-template                     | 11 ++++
 Documentation/MyFirstContribution.adoc | 96 ++++++++++++++++++++++++++++++++--
 Documentation/SubmittingPatches        |  6 ++-
 4 files changed, 112 insertions(+), 7 deletions(-)

Range-diff versus v1:

-:  ---------- > 1:  359ce9ec24 Documentation/MyFirstContribution: recommend shallow threading
2:  55fffeb8f8 ! 2:  ce9aa56846 Documentation/MyFirstContribution: recommend the use of b4
    @@ Documentation/MyFirstContribution.adoc: index 88f126184c..38da593a60 100644
     +version. `b4` automatically bumps the version to `v2`, generates the range-diff
     +against the previous iteration, and threads the new series as a reply to the
     +cover letter of the first version.
    ++
    ++[[configure-b4]]
    ++=== Configure b4
    ++
    ++`b4` can be configured via linkgit:git-config[1]. In addition to that, projects
    ++can have their own set of defaults in `.b4-config` in the root tree, which also
    ++uses Git's config format. The user's configuration always takes precedence over
    ++the per-project defaults.
    ++
    ++Refer to the https://b4.docs.kernel.org/en/latest/config.html[b4 config documentation]
    ++for more information on the available options.
     +
      [[now-what]]
      == My Patch Got Emailed - Now What?
1:  0fe6cf8511 ! 3:  e2bf7b6e46 b4: introduce configuration for the Git project
    @@ Commit message
         b4: introduce configuration for the Git project
     
         We're about to extend our documentation to recommend b4 for sending
    -    patch series ot the mailing list. Prepare for this by introducing a b4
    +    patch series to the mailing list. Prepare for this by introducing a b4
         configuration so that the tool knows to honor our preferences. For now,
         this configuration does two things:
     
    @@ Commit message
         forward, like for example auto-configuration of folks to Cc on certain
         patches. But these two tweaks feel like a good place to start.
     
    +    Note that these values only serve as defaults, and users may want to
    +    tweak those defaults based on their own preference. Luckily, users can
    +    do that without having to touch `.b4-config` at all, as b4 allows them
    +    to override values via Git configuration:
    +
    +        ```
    +        $ git config set b4.prep-cover-template /does/not/exist
    +        $ b4 send --dry-run
    +        ERROR: prep-cover-template says to use x, but it does not exist
    +        ```
    +
    +    So this gives users an easy way to override our defaults without having
    +    to touch ".b4-config", which would dirty the tree.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## .b4-config (new) ##
     @@
    ++# Note that these are default values that you can tweak via the typical
    ++# git-config(1) machinery. You thus shouldn't ever have to change this file.
    ++# See also https://b4.docs.kernel.org/en/latest/config.html.
     +[b4]
     +send-same-thread = shallow
     +prep-cover-template = ./.b4-cover-template

---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260602-pks-b4-31cc20d7f84b

