Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB83876C1
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901411; cv=none; b=Y7i+tTaGsmT72+37I1ME+AcL8izjFsa6KC6ZtTPDG4Mlz9RcAECwKd74hie9vBxD+9ZDXThkaiR4Twg8qmU8Ui7My63DA82mt3JeXmdokANETu+IsRu2xc3muwLcl5zNWP0HB61itXDPjgZnMyTkP0PKIe8GDgWsiYT0EtxEOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901411; c=relaxed/simple;
	bh=TzzMdt2s41nViX383IBzO53K62yhKRDytfx1GR7/LE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HRfO4L5MDRg6aDgjT2mcOqXzE9qwzSHV3WAYMsxY4XV9N6JF2my9CMI5F21YEzBtZ/5a3GIinsyM7k/RGmEJNDJ8o8wCgGcfKez173VIPdwjH9vU3N8X63woVjnc89trkU49o8upnlkRNpKC0FbVglhnuWi+5vB9dEUcggPeIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Esqnqic+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YA7Rxqg7; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Esqnqic+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YA7Rxqg7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 76AAA1D00011;
	Mon,  8 Jun 2026 02:50:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 08 Jun 2026 02:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780901409;
	 x=1780987809; bh=LxXkX41NSB0kdf/bO91B8xE9026yVdG77+pwV9f4Fig=; b=
	Esqnqic+zFsY+G+P3PKHPQ11mG4CMETe8Re0XruK3OabatVcwlKfhycGgCnmbV70
	IV9iqz1jpUk72qeO8iOSzOktGMYlX1XWPzw+0lJlAnStmRm4nODKiHLCOEZMFGsD
	uFTPRgSfMLh3czczlRL6HlFVNMaGBxasAZNgh8BLbENmJap7HZ0AFONdwtfU5MVQ
	2ayAoEPHyRJZYPQnspZCX9v87O/hxZaG5kLCefWqvWDSO1S/1w6JoOnBL3mXbtcj
	99+yeEI+puWyq7wGuQUNzOSZfjtm20t5ur5j4plcHOfjyh+mpqEp5D9a4oDZ1LWa
	1zVdpQHZSIh5pI0uvDoVAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780901409; x=
	1780987809; bh=LxXkX41NSB0kdf/bO91B8xE9026yVdG77+pwV9f4Fig=; b=Y
	A7Rxqg7WsWly4MnKgut/AzZKdCFOiBujs0CUxSIqSEyTIiUECH17ayLQeBKe2m9w
	C2eReUNfD3Kr2Mrc+E9MW4ul4lHzACCsQ9+a1dqNg++q88BbBNpZWzsZKD6FzTdb
	DW7cb2A2x+njDA3pT2D+U48XW4om+9SZY3NefxuRTRPc8MRreeNCqZlWrYSq/bRg
	hNYkMHWFeti9rNEdiaGqjLaLD4ZFbgyAJwvECBb75od18XY8d+LYv9bIKklp9y3L
	haLqjuLfUVlu8T213ChTbsvwyQ/Zq2PstAALwQhc07xidq2PStPjsUV8IKOJVcLo
	LfCz4gKYNDDBp7M6pw0kQ==
X-ME-Sender: <xms:IWYmahZTcaDTu6anFLsXrBQUEZ9PLfMYrdHgWT4AEt_ieD1xBofrSw>
    <xme:IWYmaiZCF0LSEZZGl0WQi6d5oBUr1cM5cY1azyvhRzm2Mg8ziMpf8HEbuOBANmbHl
    6wm072GFKOE7SJz0RXlZrPi6nAjBCz6z5fKhSSkgpIkQzVdJ4Gk>
X-ME-Received: <xmr:IWYmaqncmyC9VbLeM0RBHDnrGWPDDoDx31q_iof5aKE-hpllGHDYwzBIpqnSb2gQ_lgjgp8mCLhx3dTq8atRRrBuWp9FcqE4RJsHu1to1g>
X-ME-Proxy-Cause: dmFkZTGOHm1yZhTBAJMaIc/k4ryL3+c6oemr3XX2v2Kt1KL0M6Mx16wqrjFLmvBF9E+tet
    tPWGJJJeekdw7HiopXfysS/FmmoZpIWEuiJMmdymRaFiIVKUHdHijmIk1fiwYGtgkJx8fV
    3tga2lXu5bAQk9bt0k7xLs4syy2BsusWblZlnzwoHiyf6B+ZB5ZDZluKVymHwruanme+VB
    BxJMTfB7N0JWRxC+0DiPF0fclf+0W7YwlZIMC+LbDPVmz1ElEC/xeGoKziwNAfDov4cLzD
    9ZiNwU7vXmeKRE9Xbf2CrThsJeA4xuKDRTID9xobk6njqtVFGILOw6STx+pXhqU6DZQtSs
    6/CWA9vYHZPAlsNVjUH6sNtMJ8YPSc+Rf+XGTv7l0oieIf/zNo1EBUKBQjhuQjdhNPAUP2
    tQBWFf+b/IqFXyZJPV9f+oMUL7NxI7iO0eFJQPp4Q1xeMx4ZQ+pGjeKS2tlTOV6BbejhJF
    PNYn81926QLYWaV2ETrhsumwOk4m4bWRS3HXLkZHowhxVs9jIYqWgh6Oyf3qny8bifeODo
    mkwS5F/S4DAJ1YWGZ17so8pDlUgEj8G1Pf9JBBVOi910ovb4cderIB2doX062+uN2juaJv
    eQXDZ3tJghIyGSnjEuf5ub1yESD9W0Rnnz6ZA58bhLTfsXF2CHRpAel+BDCg
X-ME-Proxy: <xmx:IWYmat3HIMWDzSaEMefBK31SBMUh437CGaLZn6kNTJdM6AsNetcZFA>
    <xmx:IWYmaq33BMs4rOwz8DUHqa-v6VgbYPZgHUgx6AmbMrVDQ49wa1Ps0g>
    <xmx:IWYmavrC0nOM90YkrrsEmzOGPhG70AlZ-9k0skRs6hUKvr0NGknYmg>
    <xmx:IWYmamh1f71zihAi-BhVHqlD6tga8hv-C8tbq0JSyb3ZiB4Y2S6uDg>
    <xmx:IWYmaoXrUOoYw7QXLn9GeWK6aOnXpss7gYSw5o0o6vG_lWETCgZv6PYl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 02:50:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12927964 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 06:50:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Jun 2026 08:49:55 +0200
Subject: [PATCH v3 3/3] b4: introduce configuration for the Git project
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-pks-b4-v3-3-f5e497d10c56@pks.im>
References: <20260608-pks-b4-v3-0-f5e497d10c56@pks.im>
In-Reply-To: <20260608-pks-b4-v3-0-f5e497d10c56@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, 
 Weijie Yuan <wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

We're about to extend our documentation to recommend b4 for sending
patch series to the mailing list. Prepare for this by introducing a b4
configuration so that the tool knows to honor our preferences. For now,
this configuration does two things:

  - It configures "send-same-thread = shallow", which tells b4 to always
    send subsequent versions of the same patch series as a reply to the
    cover letter of the first version.

  - It configures "prep-cover-template", which tells b4 to use a custom
    template for the cover letter. The most important change compared to
    the default template is that our custom template also includes a
    range-diff.

There's potentially more things that we may want to configure going
forward, like for example auto-configuration of folks to Cc on certain
patches. But these two tweaks feel like a good place to start.

Note that these values only serve as defaults, and users may want to
tweak those defaults based on their own preference. Luckily, users can
do that without having to touch `.b4-config` at all, as b4 allows them
to override values via Git configuration:

    ```
    $ git config set b4.prep-cover-template /does/not/exist
    $ b4 send --dry-run
    ERROR: prep-cover-template says to use x, but it does not exist
    ```

So this gives users an easy way to override our defaults without having
to touch ".b4-config", which would dirty the tree.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .b4-config         |  6 ++++++
 .b4-cover-template | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000000..fd4fb56b6d
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,6 @@
+# Note that these are default values that you can tweak via the typical
+# git-config(1) machinery. You thus shouldn't ever have to change this file.
+# See also https://b4.docs.kernel.org/en/latest/config.html.
+[b4]
+send-same-thread = shallow
+prep-cover-template = ./.b4-cover-template
diff --git a/.b4-cover-template b/.b4-cover-template
new file mode 100644
index 0000000000..ab864933b5
--- /dev/null
+++ b/.b4-cover-template
@@ -0,0 +1,11 @@
+${cover}
+
+---
+${shortlog}
+
+${diffstat}
+
+${range_diff}
+---
+base-commit: ${base_commit}
+${prerequisites}

-- 
2.54.0.1136.gdb2ca164c4.dirty

