Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE58330D5E
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969193; cv=none; b=lt/4HC/HQQGHcNGNIClbKslauMEuC74OuBBdw3F9+zpHDeoMZy7YObE51tbJpkGuKorrm+dQh/TDhfeY23QUSaUWh+JRVrcaqigxh+OLXcNfUcm7MqjBr+OoXtC3miGnB16J5d6R6gMd5kfG+jLEFZjoWQPa1PPTVLI9PA2il/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969193; c=relaxed/simple;
	bh=rjFFBI0ysCWFAe5cgDn6z0tyBswgBmhPED/WrgAPvSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T8YOh9qMgtIfu+qGi/FEgv4CreKt3NOR5vuy6u+TpgfqgF6W/S2W+BdBpOex4hpkOctX22IjGgJaK0WIdkGNgb3l5keO70DL7FljjIlUFdkCmaQdp+wv/9EDrSWD1y2OWEpS++MGGFIo00PMvPpxmBMUITR08PUFUMR96aRHjj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SKYlRcTP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m5f4yYDW; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SKYlRcTP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m5f4yYDW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C60E01D001A5;
	Tue, 24 Feb 2026 16:39:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 24 Feb 2026 16:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771969190; x=1772055590; bh=4vv00kRUv8
	0yavxAsWZjzESyT8hgj/xuAMXfNo3tqMU=; b=SKYlRcTPJsG21KMHmbIsTU/IPw
	SQhA4khJjYDigXAMvB4npJQ3YuFXxiKuHuCuiK/Tp9gWZbW+u1ulP9o3Z+wsPekL
	Q9hdlL7yjuiFWiFPps5t7HECAEkSLQ1+pJxz/kwBJHzW6ECOmX8+gUPYE8MVF70T
	b5EaFZewQVns++km+ayFu2F4trF7tWgSHLtf/xIPmt7TGi4Y7tnBA9qT5GEtp1bR
	O5d1kLbFjuGP19+2n2p6kL2+7DI0skVX1WfQdpKzQiOhL5dUR1FXMj27e9Fnnt4X
	xZI0q0v9YlwsXTVvMInOQInUh3eZ6IMGhUa2QDjBW3+CenyUFULCDtEagLjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771969190; x=1772055590; bh=4vv00kRUv80yavxAsWZjzESyT8hgj/xuAMX
	fNo3tqMU=; b=m5f4yYDW/CVWpRwwSBLbK5tVsfaY2CwmwtK5kfQxzCBhFLq7Nr4
	mWzf3VuQVeN5DuzmZwcAYBMH2nhwTUa17nO6nMUDT30axf9RsiVLjmpXCZAgIBkd
	+Md6CM25dtM7O4bjBqSORuqTos49DwjnN2ZL1u9YR5Np+COj9Rovq2XNdAzEuRVO
	Am/1Eyg9QH+jo+p1NglkPvdcHrm5HnZ5qjN+JfhTQUbxEC3EcjabO9/FZFRbCaZU
	jKcRJWFoc5/Dvo6+G1ZVX1DfV3yUi35ThsI01E0fiW4WfChPnUNqDD7Jpfo2KF7w
	io5UTFOsg4F99ZyzlMMAfgoLiHAbxolevcA==
X-ME-Sender: <xms:phqeac3U3xd473X0VlmQpIhhlj5FnRYAWeBA2WH0SeWBoNCApsNXnQ>
    <xme:phqeaeGJqJlUu-dziryBKfv7W-otlb2Nriyz_rIdEKwrGz9zZCngf-2nnlRL0Rosq
    ZUnZpKCNnNQsh8dPDgfUhUpmGFM2HZHoDdqaT7lqL2PZAAwTHHW9g>
X-ME-Received: <xmr:phqeaZ7o-H-PDlx5m0Gs1q6FXVQYfRy1rBZBAMs4ylglFAH--KQcs39Z09t2rqHMiAF2VP225HfateTGpe3dYPhLoW0J77ob8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeduvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:phqeaUsNwWzZsKQxFOW2Mpl4sB2hMaycbdRyLKUpk-c1MuBCySKDxg>
    <xmx:phqeaa5AibjaSCCREZ9_voIGmTp5K2KrUsiL-spYaj04sGKsHGmdqw>
    <xmx:phqeafUri7WPiKhBSuYNJONW5Yo89Io-hWs26_4rsXLxYHwUO1qAug>
    <xmx:phqeac_ohtkwqNiFr-8oDcP5Xt84QBi1esZuanQHUH-xlv-p4Efgrg>
    <xmx:phqead4lKahcK1KCQMV7WHu9vjfycdUmDY28yc2z-ieoHxdAtdum7GWF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 16:39:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] format-patch: add cover-letter-format option
In-Reply-To: <xmqqjyw1g9m5.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	24 Feb 2026 12:38:42 -0800")
References: <20260224040400.751247-1-mroik@delayed.space>
	<cover.1771925291.git.mroik@delayed.space>
	<xmqqjyw1g9m5.fsf@gitster.g>
Date: Tue, 24 Feb 2026 13:39:48 -0800
Message-ID: <xmqq1pi9g6sb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Mirko Faina <mroik@delayed.space> writes:
>
>> From: Mroik <mroik@delayed.space>
>>
>> I've dropped the first patch of the series and applied the changes that
>> Jeff suggested.
>
>
> These are queued somewhere in 'seen', with a small fix-up to have
> the build pass plus a bit of obvious tweak on error handling, but
> most of the remarks I made in my reviews (like "doesn't this leak?"
> and "shouldn't we have tests") are not addressed with the fix-up.
>
> You'll find the topic in 'seen' after I push it out for today
> perhaps in a few hours.
>
>     a981554b03 format-patch: add ability to use alt cover format
>     8bf8e6ccda format-patch: add commitListFormat config
>     a85e8e535d SQUASH???
>
> Thanks.

I found another change that is needed to make the tests pass, so the
commit object name for the squash fixup is no longer a85e8e535d;
fetching my 'seen' from any of the mirrors should let you find these
commits near the tip of 'seen'.




 builtin/log.c         | 18 ++++++++----------
 t/t9902-completion.sh |  1 +
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index e6ff3627b8..c531784581 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1415,7 +1415,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 
 	if (skip_prefix(format, "log:", &format)) {
 		generate_commit_list_cover(rev->diffopt.file, format, list, nr);
-	} else {
+	} else if (!strcmp(format, "shortlog")) {
 		shortlog_init(&log);
 		log.wrap_lines = 1;
 		log.wrap = MAIL_DEFAULT_WRAP;
@@ -1428,6 +1428,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			shortlog_add_commit(&log, list[i]);
 
 		shortlog_output(&log);
+	} else {
+		die(_("--cover-letter: invalid format spec '%s'"), format);
 	}
 
 	/* We can only do diffstat with a unique reference point */
@@ -1946,7 +1948,7 @@ int cmd_format_patch(int argc,
 	int just_numbers = 0;
 	int ignore_if_in_upstream = 0;
 	int cover_letter = -1;
-	char *cover_letter_fmt = NULL;
+	const char *cover_letter_fmt = NULL;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
 	int zero_commit = 0;
@@ -2333,12 +2335,11 @@ int cmd_format_patch(int argc,
 		goto done;
 	total = list.nr;
 
-	if (cover_letter_fmt && (strcmp(cover_letter_fmt, "shortlog") && strncmp(cover_letter_fmt, "log:", 4))) {
-		die(_("--cover-letter: invalid format spec"));
-	}
-
-	if (!cover_letter_fmt)
+	if (!cover_letter_fmt) {
 		cover_letter_fmt = cfg.fmt_cover_letter_commit_list;
+		if (!cover_letter_fmt)
+			cover_letter_fmt = "shortlog";
+	}
 
 	if (cover_letter == -1) {
 		if (cfg.config_cover_letter == COVER_AUTO)
@@ -2427,9 +2428,6 @@ int cmd_format_patch(int argc,
 	rev.numbered_files = just_numbers;
 	rev.patch_suffix = fmt_patch_suffix;
 
-	if (cover_letter && !cover_letter_fmt)
-		cover_letter_fmt = "shortlog";
-
 	if (cover_letter) {
 		if (cfg.thread)
 			gen_message_id(&rev, "cover");
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 964e1f1569..4f760a7468 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2774,6 +2774,7 @@ test_expect_success PERL 'send-email' '
 	test_completion "git send-email --cov" <<-\EOF &&
 	--cover-from-description=Z
 	--cover-letter Z
+	--cover-letter-format=Z
 	EOF
 	test_completion "git send-email --val" <<-\EOF &&
 	--validate Z
-- 
2.53.0-485-gd48bbca10f

