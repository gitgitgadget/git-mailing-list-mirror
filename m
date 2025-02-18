Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742202862A9
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917548; cv=none; b=iXrKIBPK1IsPCjlpjoVrbLIp26UglizIeZ3Ao/rqdwA+Jza6LW6CtnUzjNjlMYN4Berpt4MRyIMYKK6dqr7/EwqLDwNcyg1rVxvovX6obWaVbBXgaEM9FRJXisrKOlNGgnJskQdb0lxXy4nOVzOogWn3qGkjOLpTvKWpt6A3SNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917548; c=relaxed/simple;
	bh=bqegViCH4nShO9rKTo1lp3nvOs99t9NUlUeMlqHKW1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PKcY+jKmtIIhFnrFcyppClF5F6gioSU60HhemVTytdpJBGqtCxKNKJJcQMQ0O5go8B8m3OyLCDaahDjS9WPNwGCKURPykgCflvwzHIoPAf4a1df0+sZtB3EccKLOTK4Q2WIQtxIcfEOQiOAMArvcCw+ybAulOHoG3cy0K4hfgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UYyQe/gQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ue0C0/HH; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UYyQe/gQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ue0C0/HH"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 47B731140166;
	Tue, 18 Feb 2025 17:25:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 18 Feb 2025 17:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739917545; x=1740003945; bh=Il0b5eZ9Cx
	y5P8/WjI9YMydMtrLn84j28weNAqldkNE=; b=UYyQe/gQPMVVEJFV7gYeyYtFjb
	TqRKFEwpwolEKZwENyAeXzUo5m9w1E8Jsh80OXzsB56jQw7b5d/4vNyiGXp8Lfgi
	1uw6K+8F2ul/NcY1u83Ge/f3cr6l6UGWb5cdA1h7sCuBaYMwGDJ8Y9UoUPiq4gKK
	ZHOAjZmx5ulXS67zGOA0JUF9yxFV3mLWtxNZRtixkdHbE25ePsSze02+eEhtwibe
	G7C0ue0qrSYD9/VUdCmoctw7U0B/Uc1RgcOp/3cW3k43KQaSdZ5xva84um0OgnpC
	eCg/BetjE1GgVUOlR8ruZjRgEKT8mXk7+K/BtqG/MZfgSeVYKUl3ZaVske3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739917545; x=1740003945; bh=Il0b5eZ9Cxy5P8/WjI9YMydMtrLn84j28we
	NAqldkNE=; b=ue0C0/HHt6kO+qJ4wN6xExFOMqfw0Rh/BwI7urRF9wrvPgbnzww
	qqW3wbLrySwuQOSkedBhjHbqlsv31zzZ/MbRmmtS1X1dcrpxsEz3kkDWQ3e0zUbp
	LfAGqGEypJNx3QqXbRsqhZ2JrQzRVU/cv+XLeSmHo8XN0t/9gU+hxn0qu4ATMS8H
	Kscl6bQO/c9jsh+RnNKl45Gf1Vrqa/9tmsa7M15JYdFcCpLnec8feiGVRNH0GX9V
	j+YPtPL9DI6ZjtM95UpL5ZxjOAfpTW53jyKNMAoSwpw3rXbBuNUbP14vOPKkAsv5
	t3+OTCXIJADgsrJAx6UF0lj3a0Gv6QQVzsg==
X-ME-Sender: <xms:6Ai1Z0Mq4zBwhFq4_w4yZXC8z7w25-rLBQRi3HmEfiz4THug5MDXTQ>
    <xme:6Ai1Z69Ma0DrV3bZMv8D-skQRrPMcj8xLSIrlQuXzyByKv2c6W5vLgjfJU4KwHZPn
    Bl-Vf1VLVXwZMybgw>
X-ME-Received: <xmr:6Ai1Z7Q4ST-Qfz3UwMnrnD3ROGR-d1QlTLU5WvJPi8aNx1HdcMdDGQVDyns79pfqA0tnI9Y9Y2v6wRdhcKwQ0jxeqh9yapZC_c1JVuY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivdehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrug
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6Ai1Z8tI8l0DHHI_apzSGvhXqJTAk3Cu3bzDPx8Ys-u5Q1Ky8WQ4cw>
    <xmx:6Ai1Z8ck9w7TzSROSQV2D7mQ9Scg9VO55-91PgrnS2Ol3imPVXyjAA>
    <xmx:6Ai1Zw0PoGTm7Js8gN-gJCCPDKoFf4WqvVXrjOQWv9QvZN_UNrriZQ>
    <xmx:6Ai1Zw-oRT51V8WgS2E0X0kh_j7dfyJoXHBEM9_EieIcSdBgiYNI0g>
    <xmx:6Qi1ZxFQhCSGc3iX-FW_2HD_mGDMDzqkyXHOU1T7IRD9ZMj_anfafUHE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 17:25:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,  M Hickford
 <mirth.hickford@gmail.com>
Subject: Re: [PATCH 09/12] gitk: extract script to build Gitk
In-Reply-To: <20250218-b4-pks-meson-contrib-v1-9-c3edd292beb8@pks.im> (Patrick
	Steinhardt's message of "Tue, 18 Feb 2025 08:45:57 +0100")
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
	<20250218-b4-pks-meson-contrib-v1-9-c3edd292beb8@pks.im>
Date: Tue, 18 Feb 2025 14:25:43 -0800
Message-ID: <xmqqeczuj3fc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Extract the script that "builds" Gitk from our Makefile so that we can
> reuse it in Meson.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  gitk-git/Makefile        |  7 +++----
>  gitk-git/generate-tcl.sh | 11 +++++++++++
>  2 files changed, 14 insertions(+), 4 deletions(-)

You would want to coordinate this with Johannes Sixt, who may still
want to maintain the subtree arrangement.

Thanks.


> diff --git a/gitk-git/Makefile b/gitk-git/Makefile
> index e1f0aff4a19..a396eef581e 100644
> --- a/gitk-git/Makefile
> +++ b/gitk-git/Makefile
> @@ -8,6 +8,7 @@ gitk_libdir   ?= $(sharedir)/gitk/lib
>  msgsdir    ?= $(gitk_libdir)/msgs
>  msgsdir_SQ  = $(subst ','\'',$(msgsdir))
>  
> +SHELL_PATH ?= /bin/sh
>  TCL_PATH ?= tclsh
>  TCLTK_PATH ?= wish
>  INSTALL ?= install
> @@ -63,10 +64,8 @@ clean::
>  	$(RM) gitk-wish po/*.msg GIT-TCLTK-VARS
>  
>  gitk-wish: gitk GIT-TCLTK-VARS
> -	$(QUIET_GEN)$(RM) $@ $@+ && \
> -	sed -e '1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' <gitk >$@+ && \
> -	chmod +x $@+ && \
> -	mv -f $@+ $@
> +	$(QUIET_GEN)$(RM) $@ $@+
> +	$(QUIET_GEN)$(SHELL_PATH) ./generate-tcl.sh "$(TCLTK_PATH_SQ)" "$<" "$@"
>  
>  $(PO_TEMPLATE): gitk
>  	$(XGETTEXT) -kmc -LTcl -o $@ gitk
> diff --git a/gitk-git/generate-tcl.sh b/gitk-git/generate-tcl.sh
> new file mode 100755
> index 00000000000..46bba6d2464
> --- /dev/null
> +++ b/gitk-git/generate-tcl.sh
> @@ -0,0 +1,11 @@
> +#!/bin/sh
> +
> +set -e
> +
> +WISH=$(echo "$1" | sed 's/|/\\|/g')
> +INPUT="$2"
> +OUTPUT="$3"
> +
> +sed -e "1,3s|^exec .* \"\$0\"|exec $WISH \"\$0\"|" "$INPUT" >"$OUTPUT"+
> +chmod a+x "$OUTPUT"+
> +mv "$OUTPUT"+ "$OUTPUT"
