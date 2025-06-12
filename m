Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151191DAC95
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749701010; cv=none; b=R2xW7aybx25puguZjATGCx7X+N5UQ7Yk6sEAo7TcDFbEhBJJgmC4dvpfpLSoMWRKkTgUthkPR2Qlg7WgkJXvICOd4FMGan6VsJPhwQ/e3Xpe6UIScskQDSVdJzi2feE+rb8kE6YNhkvWbV/cF6cl8PDyRZpke6pDDjYiTr/gHIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749701010; c=relaxed/simple;
	bh=/KT9pUNdbtGEymstNmBo6bH9NoH1uoi3TULAm0LSmuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l80M5zKdOGio6wM0xbHPHwCnNN0HNeMH0JGs2Yr4yBOWQUJegP/s9F2wrazivgoxHGze0PFfDnyuxXj0gEMe40FO+Ah607YOMPqb7rkx5NLVsLFgDZ6y/0rZrhHIJXCU4Ki76bAbuUYiSgLv3UwfQKGbnE+imGHlXnRfPpVq8m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=05tNmo76; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mH7j80TU; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="05tNmo76";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mH7j80TU"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4042A11401BE;
	Thu, 12 Jun 2025 00:03:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 12 Jun 2025 00:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749701007;
	 x=1749787407; bh=Ma9cvaEzo43FnvsHLRdHaT2Ou2iXLOXABoWjDrVgaT4=; b=
	05tNmo76HlEjXaAOQXwo+xUmk8c0CbPIQzfxUxgn7Angzu9lDuPEKPWsl5bpCLhu
	tBqJ1lUd9/2T4vLNeJ174dmtZ54qxHEKhZwckg3UmGjJRr0q3R5QyCXrrdChEIvY
	xJyxJB8EVRjSaR19QDoFGeHSeCfPtoI9wFjCzbeRghH8VjnM346CDcdhyhUcLW9/
	HUA9Kk48xzd6qlf6TSU9Grsz23PLXpEyuKzBs5yIn9/okjn/BSGpkn00xAyjllwn
	isRqsyTscXsGOzD582JUZSRCCJD+myKD/TuDwipTs1jgp5Cnqqco8lIEWRRQ2D3j
	2RM88ehJcPoaj6fXVY2DbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749701007; x=
	1749787407; bh=Ma9cvaEzo43FnvsHLRdHaT2Ou2iXLOXABoWjDrVgaT4=; b=m
	H7j80TUiCo79gZtHReTX4YX0LA20UaVZav/3ZOX6ie+XGorxKvRMzCOGTP/K8ffw
	RMCv5Su8PupDxsZ8k0LkVGsuVlb9B3ZGqhdt+bRd2kDyZk7QbcaWXKVzsoKND5u8
	ZVGR/MDLBef1vCP8QtC1XfPZbws9lK62kPHEb2Lm52ehhMosXNlMjmcFWcfyW3gG
	aKqdQ7S1MDcrhHZw+DePgBkOSn0+Epq1jbwi6PcCWYEEH8lP8SjKGqRamBikga0A
	rP7n6Ul3d5USfG8P/dNhq4hiIkcLJNmQAwaVBao8pA3BsZbQ9Eql3udQnFQ/ZpqP
	NoIlxjT0/hgM3CP/DZ8Pg==
X-ME-Sender: <xms:j1FKaKPka93vOo_AdEM4fIwqTAakEkDlE_lNFMWLQo3-1sYW82dCsQ>
    <xme:j1FKaI_nlJ7rugNmfwO-z-gBKysD0ypT7G3XAd-9RWwh82mcGT_gnrodDB2m8vp7p
    MBXAyKDdd0_jJel5Q>
X-ME-Received: <xmr:j1FKaBRqpb5tTWaZFdjGKj8DC9HAkivgPb9dZCggb7Ncs79rcoKYeVUrRX0EbL1peZkGnyqugLRydaYizCzDGUUlfODIuemYVsQ7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddugedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghrrggusegtoh
    hmshhthihlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:j1FKaKuODzEz4GN7JvDSc72ssTpE6G3gep-AOr7FDOEYBuucX5FyuQ>
    <xmx:j1FKaCclten9F0lNYUaC9HfVSxETC9mGAQw0TYMX9OQQjtVaCCEuCg>
    <xmx:j1FKaO13XNTmRI1TvrPFFt8Dd4AOI9k7ALFC9105X5i-ys09IwCRkA>
    <xmx:j1FKaG-PNwb2AEhh67pgSH7A102wnTt0xzzikJhFJUBcygnHRQh7ZA>
    <xmx:j1FKaGTL3swHumLYoetELSukd4gXNw0YBAww-B8_PFvPvoHQeqeZlJJ0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 00:03:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Brad Smith <brad@comstyle.com>
Cc: git@vger.kernel.org
Subject: Re: Solaris sed
In-Reply-To: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com> (Brad Smith's
	message of "Wed, 11 Jun 2025 23:23:38 -0400")
References: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com>
Date: Wed, 11 Jun 2025 21:03:25 -0700
Message-ID: <xmqqo6utfvxu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Brad Smith <brad@comstyle.com> writes:

> Building on Solaris I noticed the following two issues with Solaris sed.
>
>     GEN version-def.h
> sed: Missing newline at end of file standard input.

Perhaps it is this input line it is complaining about.  sed works on
text files, and a file that ends in incomplete line was not quite
text.

-REPLACED=$(printf "%s" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
+REPLACED=$(printf "%s\n" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
 	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
 	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
 	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \

>     GEN config-list.h
> sed: illegal option -- E
> Usage:  sed [-n] script [file...]
>         sed [-n] [-e script]...[-f script_file]...[file...]

This is a bit trickier but should be doable.  It does not like the
-E option to use ERE (as opposed to BRE) for pattern matching used
in generate-configlist.sh script.

	sed -E '
	/^`?[a-zA-Z].*\..*`?::$/ {
	/deprecated/d;
	s/::$//;
	s/`//g;
	s/^.*$/	"&",/;
	p;};
	d'

I think the only problematic one is the first address, whose BRE
equivalent I think is

	/^`\{0,1\}[a-zA-Z].*\..*`\{0,1\}::$/

In practice, I suspect \{0,1\} is unnecessarily strict and using
something looser like

	/^`*[a-zA-Z].*\..*`*::$/

may be sufficient.  Replace the address expression associated with
the {editing command} and drop "-E", and use "-e" for readability,
perhaps?

Totally untested patch follows.

 GIT-VERSION-GEN        | 2 +-
 generate-configlist.sh | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git c/GIT-VERSION-GEN w/GIT-VERSION-GEN
index 208e91a17f..de989657fb 100755
--- c/GIT-VERSION-GEN
+++ w/GIT-VERSION-GEN
@@ -82,7 +82,7 @@ read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION GIT_PATCH_LEVEL trail
 $(echo "$GIT_VERSION" 0 0 0 0 | tr '.a-zA-Z-' ' ')
 EOF
 
-REPLACED=$(printf "%s" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
+REPLACED=$(printf "%s\n" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
 	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
 	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
 	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
diff --git c/generate-configlist.sh w/generate-configlist.sh
index 9d2ad6165d..75c39ade20 100755
--- c/generate-configlist.sh
+++ w/generate-configlist.sh
@@ -13,16 +13,16 @@ print_config_list () {
 	cat <<EOF
 static const char *config_name_list[] = {
 EOF
-	sed -E '
-/^`?[a-zA-Z].*\..*`?::$/ {
+	sed -e '
+	/^`*[a-zA-Z].*\..*`*::$/ {
 	/deprecated/d;
 	s/::$//;
 	s/`//g;
 	s/^.*$/	"&",/;
 	p;};
-d' \
+	d' \
 	    "$SOURCE_DIR"/Documentation/*config.adoc \
-	    "$SOURCE_DIR"/Documentation/config/*.adoc|
+	    "$SOURCE_DIR"/Documentation/config/*.adoc |
 	sort
 	cat <<EOF
 	NULL,
