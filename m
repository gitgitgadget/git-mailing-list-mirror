Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5B174EF0
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975400; cv=none; b=i3UseoTo3kOAUOZtfVSrtQJF0TYF7Uz6sHy3tUKV89iKynnrCX4nxOJxSe886YJ5S89ELsZsbDIgwaB5NEPDKV6BIlj4FlJ+lsdVG6OoTKMZtEgPAKJ7Eukv2VkKAzgMDZZWHbKXZRswyK1nnmdmoPbD1KYJHgU6iwbG5sRQe7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975400; c=relaxed/simple;
	bh=hT/w2owPGqW/WlycrbUSyGNRIXk1XQp9Y0N7Q/watr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I5HE2xQrRCPGomJBmr31mdD9meGer5lRwtQaNkm6Yj02KiUFdTzkePSlgpsnCCRlrJOdo1robCGLFP+QSqnatr3zAHwcKC/bg6P+YzIvLLXv4J+CmjgLgY10qS3E2sYxDJXci5xiihzs7y0cv0/XqssJClyoVQgb3kuNnxkPtFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mK9yrMYE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IUeK6+Fx; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mK9yrMYE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IUeK6+Fx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9066F25401D8;
	Wed, 26 Mar 2025 03:49:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 26 Mar 2025 03:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742975394; x=1743061794; bh=fFotmK+TKX
	Dwp4oQdATDiQpDpxovza4OhUxBhaD3ZTY=; b=mK9yrMYEqru6zT9rMThYM6Ql6g
	tD0psxNY9GR0uSmHptmlAHgyDKQE+MbsOZbYiU8IXpTnmP1F/nzXxY01RhHM2/uO
	yOFmqPeLPQ8R2qcnOwMGxVNnu30CRWAOCwukiWmuxtel9C/xE3HQc0EhYtB6BEvR
	SwxhvTJkKZQnKi97Nh2SQ0QQPOxUQ5xby7Y4bEEAEC4eiLkhKCUoE1eI7YLTirnl
	HpyUXeCeSDGtWFXde1h2eFQxtNME/OQU19wZ8mbTXI0FmgNzvvBoRH+hQpOLMt6O
	KplWYly/WdNHpeJz2ME6u7Idsa2oZw3lNR4nz6/L+Hxs5nw/88l9VS8DpEng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742975394; x=1743061794; bh=fFotmK+TKXDwp4oQdATDiQpDpxovza4OhUx
	BhaD3ZTY=; b=IUeK6+FxerDZqrGXO4YO2xUlZUdaxMND/Q6eChnfmde6bgHFplt
	zchBDS+J6hOpGaXVDtIeFoKlHYKWId2qUETFqirbYkkVqjjhEZn5N3cE0P4E7Ewv
	QbmFwGikJW5uSD33PE82BRXkbRpzI7tRN0N+gO9UPHpFdoapSBxKQ9OSMRuKE7Y0
	seh4TF0OE2R3LPwiHxIfLLbHkPaTpDOHn53Pt4yKZ5WQ7tnOrTCclZIxQyUgeq4M
	sxerpI0lmo+Ya7ww0pKxbIvgLuTXiZ+Bz6K0QwYnROjRJ4S6zhAMum5EY3EQrmLZ
	4oEjlsiSJjKgA/a0PVb4PC0xMGr7fpNl0Aw==
X-ME-Sender: <xms:orHjZxSC_7TftHW5urW8MtfvWcYlaHNLQnkxYnJJ3afD8OjKp5W8CA>
    <xme:orHjZ6x2DioedLa3ED1hL794t9LDeDtf4r4efMdTMknaqTIIaGPNWfFgCgZ_T7elo
    4WAqpAsfyEX2fzWvw>
X-ME-Received: <xmr:orHjZ21nt2zt-JVHWWtx80egug754fJw05UCvF39xtqmwf4x-CBRvKfvpUdGChI6tzyhmAeSUO35HNyrYdmWucf6YrB-04ubPzJobrM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepkefhgedtfeetkeejleffudevjefgteet
    ffetvefhvdeiveffjeehjeffhfehtefgnecuffhomhgrihhnpeguihhffhdquggvlhhtrg
    drtgifpdifihhlughmrghttghhrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphhhihhlihhpohgrkhhlvgihsehivggvrdgvmhgr
    ihhlpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:orHjZ5BjYjR4Uu1VtWria4Q_1F6FbzDuW0RWpx--sPWJhTUOa0X0sw>
    <xmx:orHjZ6iIW5ijE_7JkV008JObHfN2s3INT8yRlEAUrqJXLn5fKSmVjw>
    <xmx:orHjZ9q7hkc0thk4q4nW5qFuPBkJx9cJlBsUkmyyOKOpQUJoDy3sCw>
    <xmx:orHjZ1hpuSznuxmqtTOY-kf9ws8zo8PNVPtcHoqYkN1r7kDthIC5Dg>
    <xmx:orHjZ1OIF0zJEO1BwuvH1ZeYq-WzL4gOmDo0-cMhBN9PW-7v9evWF0CB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 03:49:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Philip Oakley <philipoakley@iee.email>,  Patrick
 Steinhardt <ps@pks.im>,  Phillip Wood <phillip.wood123@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,
  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 07/10] wildmatch: explicitly mark intentional use of
 the comma operator
In-Reply-To: <9a6de12b8076266fb0c88f6b658c20d37409ce13.1742945534.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Tue, 25 Mar 2025
	23:32:11 +0000")
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
	<pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
	<9a6de12b8076266fb0c88f6b658c20d37409ce13.1742945534.git.gitgitgadget@gmail.com>
Date: Wed, 26 Mar 2025 00:49:52 -0700
Message-ID: <xmqq4izgjknz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/wildmatch.c b/wildmatch.c
> index 8ea29141bd7..ce8108a6d57 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -268,7 +268,7 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
>  					p_ch = 0; /* This makes "prev_ch" get set to 0. */
>  				} else if (t_ch == p_ch)
>  					matched = 1;
> -			} while (prev_ch = p_ch, (p_ch = *++p) != ']');
> +			} while ((void)(prev_ch = p_ch), (p_ch = *++p) != ']');
>  			if (matched == negated ||
>  			    ((flags & WM_PATHNAME) && t_ch == '/'))
>  				return WM_NOMATCH;

Hmph, I personally do not find the (void) convention any easier to
read and understand than the original, and more importantly, it does
not look like a good signal to say that the author knows what they
are doing.

For this particular loop, it probably makes a lot more sense to do a
stupid and more obvious rewrite.  And the same thing can be said for
the previous step.

Perhaps like so?


 diff-delta.c | 37 ++++++++++++++++++++++++-------------
 wildmatch.c  |  4 +++-
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git c/diff-delta.c w/diff-delta.c
index a4faf73829..a999b875d4 100644
--- c/diff-delta.c
+++ w/diff-delta.c
@@ -438,19 +438,30 @@ create_delta(const struct delta_index *index,
 			op = out + outpos++;
 			i = 0x80;
 
-			if (moff & 0x000000ff)
-				out[outpos++] = moff >> 0,  i |= 0x01;
-			if (moff & 0x0000ff00)
-				out[outpos++] = moff >> 8,  i |= 0x02;
-			if (moff & 0x00ff0000)
-				out[outpos++] = moff >> 16, i |= 0x04;
-			if (moff & 0xff000000)
-				out[outpos++] = moff >> 24, i |= 0x08;
-
-			if (msize & 0x00ff)
-				out[outpos++] = msize >> 0, i |= 0x10;
-			if (msize & 0xff00)
-				out[outpos++] = msize >> 8, i |= 0x20;
+			if (moff & 0x000000ff) {
+				out[outpos++] = moff >> 0;
+				i |= 0x01;
+			}
+			if (moff & 0x0000ff00) {
+				out[outpos++] = moff >> 8;
+				i |= 0x02;
+			}
+			if (moff & 0x00ff0000) {
+				out[outpos++] = moff >> 16;
+				i |= 0x04;
+			}
+			if (moff & 0xff000000) {
+				out[outpos++] = moff >> 24;
+				i |= 0x08;
+			}
+			if (msize & 0x00ff) {
+				out[outpos++] = msize >> 0;
+				i |= 0x10;
+			}
+			if (msize & 0xff00) {
+				out[outpos++] = msize >> 8;
+				i |= 0x20;
+			}
 
 			*op = i;
 
diff --git c/wildmatch.c w/wildmatch.c
index 8ea29141bd..29f4b4df75 100644
--- c/wildmatch.c
+++ w/wildmatch.c
@@ -268,7 +268,9 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 					p_ch = 0; /* This makes "prev_ch" get set to 0. */
 				} else if (t_ch == p_ch)
 					matched = 1;
-			} while (prev_ch = p_ch, (p_ch = *++p) != ']');
+
+				prev_ch = p_ch;
+			} while ((p_ch = *++p) != ']');
 			if (matched == negated ||
 			    ((flags & WM_PATHNAME) && t_ch == '/'))
 				return WM_NOMATCH;


