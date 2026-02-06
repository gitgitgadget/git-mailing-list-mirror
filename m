Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FFC329375
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395159; cv=none; b=CqprarCQsXuCb+SU+xj5Qkq72+6Lb8qLnypwVek+iT4mGWDlmJlJUqJtYFslpPFSrxXwS7OKPk5n1DBFGApp/x3rUCJpJ218fdVy+uSuslt4XhXz/SnlDNybG6bETto0sydnJK0sUxsoD0Z0hI5P5KwjwKj5BWcOIyAjUAKHvpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395159; c=relaxed/simple;
	bh=Wb3C8XnahjnB71g9PUN/jpDGg3j/Yh1MJVUT0EV6Z2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iCmLsDBV84Erz21ROlcavJiOo8kw5CvfpXfz0w3jX7H7IVewTwC+6D1DTGZDkBlHdVfxMyJNV/88KPJ0IOg0u6oCzrepYMJSu1/M1kSHF5u11IeLUXHvurZxd6b6uAO+qrEMfwmsA3FJzzkE8pthqpQla0hX5qspEKoYs4wz0C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OIziOpno; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NSDbF3aQ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OIziOpno";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NSDbF3aQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B9717EC0300;
	Fri,  6 Feb 2026 11:25:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 06 Feb 2026 11:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770395158; x=1770481558; bh=l9ubrcA5ls
	BGwocN2abVbG/IGT3CWT8PwohHuI77xRQ=; b=OIziOpnoDVLI8eo6Ri9ebDvnWy
	o/eq46itCfLzci5iVKBD5Smpq5tGlFOgXXHvhjtVgL6m8sZ+q6REt1rm73xRuobL
	aAGj9oULXJbJNxPe5cgRQmGRufW1QMXYgGLoWRipXx1RhNileDeHOHJ1zyVR85Uk
	jJ2TTE4YVSeOSc2XcWZsLEfGudpNV3UIFnjS9JCTm51XoLBfK5CUhFToEfG9nTOa
	wHhcJ90Z4s2MnCLzx6icTxuN/FPLWFhwrKsZNBFUCfrnBsXzhKWnp8e1Cot8qPqT
	x0wTkCjFrimRKi+Ni5H+23p+dk0HCRaTHUEnr1hhxrNpcT/RQIvq6Z/0F/8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770395158; x=1770481558; bh=l9ubrcA5lsBGwocN2abVbG/IGT3CWT8Pwoh
	HuI77xRQ=; b=NSDbF3aQD2pWiLr+9TgWgsr4W4nisNsC2SzbcRwmWg8k8XIn7qu
	m9I08e26jHmkNxkSHJCb20PYqH72izfNSGQv2lOzMvnGIUac9pdtsRfYsf4Wa331
	TQpaiCAFlkksZIK6f0fuykaZgXkMwKW8t9zS4T7v5vXyU4l2Qu/Q0Hoc0iGrrUvT
	2nsgzDCdRkRMOZ+aJjJAzk8cdqgW+4e0H02BJl7tH1IsH8mY7jCtS/o1OaO+5oc3
	vX/RhmBXlS6sbXsDZFl7rmGUJ2qhc7a9Uw1PiPFmcCxH++4waf6hmi2G4tTEGKYC
	K4mcED75B7WKhenXZk8eWYRP88Yhp5EMEvg==
X-ME-Sender: <xms:FhaGadtgoQSOYuk_a4mdV785FfejvXqpYmAEFiQfsVaWoo4vId5IoA>
    <xme:FhaGad72cNv21-z-V8y0U1dKDTcAcuPBwS0zEg8213-kuV3qiyoeb6zH9hgawqiZ3
    zcodxVggl-W7otS0gJv5wpcx492eIdAoDxUECJkDwpYzQKoV5-VGGo>
X-ME-Received: <xmr:FhaGaeKYCjr_-NBWit-uvMmNosSakqttEKkem_ZdmG1gc0oIOCwzrILre5nRB14KWjuRuYFL77wt7vtz72yFoTdWY9GZ1IiSRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:FhaGad6nABH0O0G7FBz__wHEydk1jzAKdFEGVp5VuUCVEcYLyfjsQg>
    <xmx:FhaGaRxpIoNpWXfgEEbs_ZtRIfizzWY-6ghN4nQx11KkzNyuvHHQaQ>
    <xmx:FhaGaRZqd_gxd64jfKupwkng-YdstCAMam8rszKWYuzHs86j-lf7vA>
    <xmx:FhaGaTT5QmLoboAwer9XtOEO5P6piZDk8-pFmEO6aBdSxZiqGJ_GYA>
    <xmx:FhaGaeAr98Jtd5rMfwuEKQeTWR-LA1fdR_wFPEZ3l4Ud9zt89UaI7JuM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 11:25:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] whitespace: symbolic links usually lack LF at the end
In-Reply-To: <xmqqecn0nqyt.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	04 Feb 2026 13:23:06 -0800")
References: <xmqqecn0nqyt.fsf@gitster.g>
Date: Fri, 06 Feb 2026 08:25:57 -0800
Message-ID: <xmqqpl6hhm96.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

For a patch that touches a symbolic link, it is perfectly normal
that the contents ends with "\ No newline at end of file".  The
checks introduced recently to detect incomplete lines (i.e., a text
file that lack the newline on its final line) should not trigger.

Disable the check early for symbolic links, both in "git apply" and
"git diff" and test them.  For "git apply", we check only when the
postimage is a symbolic link regardless of the preimage, and we only
care about preimage when applying in reverse.  Similarly, "git diff"
would warn only when the postimage is a symbolic link, or the
preimage when running "git diff -R".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * v1 used to disable whitespace=incomplete-line when either side of
   comparison is a symbolic link; this iteration only cares about
   the case where the postimage is a symbolic link.  If you turn
   what used to be a symlink into a text file, and if incomplete
   line detection is turned on, you would want to make sure that the
   resulting text file is without an incomplete line.

 apply.c                    | 20 +++++++++
 diff.c                     | 22 +++++++++-
 t/t4015-diff-whitespace.sh | 26 ++++++++++++
 t/t4124-apply-ws-rule.sh   | 86 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index c9fb45247d..f01204d15b 100644
--- a/apply.c
+++ b/apply.c
@@ -1725,6 +1725,26 @@ static int parse_fragment(struct apply_state *state,
 	unsigned long oldlines, newlines;
 	unsigned long leading, trailing;
 
+	/* do not complain a symbolic link being an incomplete line */
+	if (patch->ws_rule & WS_INCOMPLETE_LINE) {
+		/*
+		 * We want to figure out if the postimage is a
+		 * symbolic link when applying the patch normally, or
+		 * if the preimage is a symbolic link when applying
+		 * the patch in reverse.  A normal patch only has
+		 * old_mode without new_mode.  If it changes the
+		 * filemode, new_mode has value, which is different
+		 * from old_mode.
+		 */
+		unsigned mode = (state->apply_in_reverse
+				 ? patch->old_mode
+				 : patch->new_mode
+				 ? patch->new_mode
+				 : patch->old_mode);
+		if (mode && S_ISLNK(mode))
+			patch->ws_rule &= ~WS_INCOMPLETE_LINE;
+	}
+
 	offset = parse_fragment_header(line, len, fragment);
 	if (offset < 0)
 		return -1;
diff --git a/diff.c b/diff.c
index 7b7cd50dc2..9e4b92ed69 100644
--- a/diff.c
+++ b/diff.c
@@ -1834,6 +1834,7 @@ static void emit_rewrite_diff(const char *name_a,
 	const char *a_prefix, *b_prefix;
 	char *data_one, *data_two;
 	size_t size_one, size_two;
+	unsigned ws_rule;
 	struct emit_callback ecbdata;
 	struct strbuf out = STRBUF_INIT;
 
@@ -1856,9 +1857,15 @@ static void emit_rewrite_diff(const char *name_a,
 	size_one = fill_textconv(o->repo, textconv_one, one, &data_one);
 	size_two = fill_textconv(o->repo, textconv_two, two, &data_two);
 
+	ws_rule = whitespace_rule(o->repo->index, name_b);
+
+	/* symlink being an incomplete line is not a news */
+	if (DIFF_FILE_VALID(two) && S_ISLNK(two->mode))
+		ws_rule &= ~WS_INCOMPLETE_LINE;
+
 	memset(&ecbdata, 0, sizeof(ecbdata));
 	ecbdata.color_diff = o->use_color;
-	ecbdata.ws_rule = whitespace_rule(o->repo->index, name_b);
+	ecbdata.ws_rule = ws_rule;
 	ecbdata.opt = o;
 	if (ecbdata.ws_rule & WS_BLANK_AT_EOF) {
 		mmfile_t mf1, mf2;
@@ -3762,6 +3769,7 @@ static void builtin_diff(const char *name_a,
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
 		struct emit_callback ecbdata;
+		unsigned ws_rule;
 		const struct userdiff_funcname *pe;
 
 		if (must_show_header) {
@@ -3773,6 +3781,12 @@ static void builtin_diff(const char *name_a,
 		mf1.size = fill_textconv(o->repo, textconv_one, one, &mf1.ptr);
 		mf2.size = fill_textconv(o->repo, textconv_two, two, &mf2.ptr);
 
+		ws_rule = whitespace_rule(o->repo->index, name_b);
+
+		/* symlink being an incomplete line is not a news */
+		if (DIFF_FILE_VALID(two) && S_ISLNK(two->mode))
+			ws_rule &= ~WS_INCOMPLETE_LINE;
+
 		pe = diff_funcname_pattern(o, one);
 		if (!pe)
 			pe = diff_funcname_pattern(o, two);
@@ -3784,7 +3798,7 @@ static void builtin_diff(const char *name_a,
 			lbl[0] = NULL;
 		ecbdata.label_path = lbl;
 		ecbdata.color_diff = o->use_color;
-		ecbdata.ws_rule = whitespace_rule(o->repo->index, name_b);
+		ecbdata.ws_rule = ws_rule;
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 		ecbdata.opt = o;
@@ -3991,6 +4005,10 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	data.ws_rule = whitespace_rule(o->repo->index, attr_path);
 	data.conflict_marker_size = ll_merge_marker_size(o->repo->index, attr_path);
 
+	/* symlink being an incomplete line is not a news */
+	if (DIFF_FILE_VALID(two) && S_ISLNK(two->mode))
+		data.ws_rule &= ~WS_INCOMPLETE_LINE;
+
 	if (fill_mmfile(o->repo, &mf1, one) < 0 ||
 	    fill_mmfile(o->repo, &mf2, two) < 0)
 		die("unable to read files to diff");
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 3c8eb02e4f..b691d29479 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -90,6 +90,32 @@ test_expect_success "new incomplete line in post-image" '
 	git -c core.whitespace=incomplete diff -R --check x
 '
 
+test_expect_success SYMLINKS "incomplete-line error is disabled for symlinks" '
+	test_when_finished "git reset --hard" &&
+	test_when_finished "rm -f mylink" &&
+
+	# a regular file with an incomplete line
+	printf "%s" one >mylink &&
+	git add mylink &&
+
+	# a symbolic link
+	rm mylink &&
+	ln -s two mylink &&
+
+	git -c diff.color=always -c core.whitespace=incomplete \
+		diff mylink >forward.raw &&
+	test_decode_color >forward <forward.raw &&
+	test_grep ! "<BRED>\\\\ No newline at end of file<RESET>" forward &&
+
+	git -c diff.color=always -c core.whitespace=incomplete \
+		diff -R mylink >reverse.raw &&
+	test_decode_color >reverse <reverse.raw &&
+	test_grep "<BRED>\\\\ No newline at end of file<RESET>" reverse &&
+
+	git -c core.whitespace=incomplete diff --check mylink &&
+	test_must_fail git -c core.whitespace=incomplete diff --check -R mylink
+'
+
 test_expect_success "Ray Lehtiniemi's example" '
 	cat <<-\EOF >x &&
 	do {
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 115a0f8579..29ea7d4268 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -743,4 +743,90 @@ test_expect_success 'incomplete line modified at the end (error)' '
 	test_cmp sample target
 '
 
+test_expect_success "incomplete-line error is disabled for symlinks" '
+	test_when_finished "git reset" &&
+	test_when_finished "rm -f patch.txt" &&
+	oneblob=$(printf "one" | git hash-object --stdin -w -t blob) &&
+	twoblob=$(printf "two" | git hash-object --stdin -w -t blob) &&
+
+	oneshort=$(git rev-parse --short $oneblob) &&
+	twoshort=$(git rev-parse --short $twoblob) &&
+
+	cat >patch0.txt <<-EOF &&
+	diff --git a/mylink b/mylink
+	index $oneshort..$twoshort 120000
+	--- a/mylink
+	+++ b/mylink
+	@@ -1 +1 @@
+	-one
+	\ No newline at end of file
+	+two
+	\ No newline at end of file
+	EOF
+
+	# the index has the preimage symlink
+	git update-index --add --cacheinfo "120000,$oneblob,mylink" &&
+
+	# check the patch going forward and reverse
+	git -c core.whitespace=incomplete apply --cached --check \
+		--whitespace=error patch0.txt &&
+
+	git update-index --add --cacheinfo "120000,$twoblob,mylink" &&
+	git -c core.whitespace=incomplete apply --cached --check \
+		--whitespace=error -R patch0.txt &&
+
+	# the patch turns it into the postimage symlink
+	git update-index --add --cacheinfo "120000,$oneblob,mylink" &&
+	git -c core.whitespace=incomplete apply --cached --whitespace=error \
+		patch0.txt &&
+
+	# and then back.
+	git -c core.whitespace=incomplete apply --cached -R --whitespace=error \
+		patch0.txt &&
+
+	# a text file turns into a symlink
+	cat >patch1.txt <<-EOF &&
+	diff --git a/mylink b/mylink
+	deleted file mode 100644
+	index $oneshort..0000000
+	--- a/mylink
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-one
+	\ No newline at end of file
+	diff --git a/mylink b/mylink
+	new file mode 120000
+	index 0000000..$twoshort
+	--- /dev/null
+	+++ b/mylink
+	@@ -0,0 +1 @@
+	+two
+	\ No newline at end of file
+	EOF
+
+	# the index has the preimage text
+	git update-index --cacheinfo "100644,$oneblob,mylink" &&
+
+	# check
+	git -c core.whitespace=incomplete apply --cached \
+		--check --whitespace=error patch1.txt &&
+
+	# reverse, leaving an incomplete text file, should error
+	git update-index --cacheinfo "120000,$twoblob,mylink" &&
+	test_must_fail git -c core.whitespace=incomplete \
+		apply --cached --check --whitespace=error -R patch1.txt &&
+
+	# apply to create a symbolic link
+	git update-index --cacheinfo "100644,$oneblob,mylink" &&
+	git -c core.whitespace=incomplete apply --cached --whitespace=error \
+		patch1.txt &&
+
+	# turning it back into an incomplete text file is an error
+	test_must_fail git -c core.whitespace=incomplete \
+		apply --cached --whitespace=error -R patch1.txt
+
+
+
+'
+
 test_done

Interdiff against v1:
  diff --git a/apply.c b/apply.c
  index 81ea174637..f01204d15b 100644
  --- a/apply.c
  +++ b/apply.c
  @@ -1725,6 +1725,26 @@ static int parse_fragment(struct apply_state *state,
   	unsigned long oldlines, newlines;
   	unsigned long leading, trailing;
   
  +	/* do not complain a symbolic link being an incomplete line */
  +	if (patch->ws_rule & WS_INCOMPLETE_LINE) {
  +		/*
  +		 * We want to figure out if the postimage is a
  +		 * symbolic link when applying the patch normally, or
  +		 * if the preimage is a symbolic link when applying
  +		 * the patch in reverse.  A normal patch only has
  +		 * old_mode without new_mode.  If it changes the
  +		 * filemode, new_mode has value, which is different
  +		 * from old_mode.
  +		 */
  +		unsigned mode = (state->apply_in_reverse
  +				 ? patch->old_mode
  +				 : patch->new_mode
  +				 ? patch->new_mode
  +				 : patch->old_mode);
  +		if (mode && S_ISLNK(mode))
  +			patch->ws_rule &= ~WS_INCOMPLETE_LINE;
  +	}
  +
   	offset = parse_fragment_header(line, len, fragment);
   	if (offset < 0)
   		return -1;
  @@ -2193,11 +2213,6 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
   		patch->ws_rule = whitespace_rule(state->repo->index,
   						 patch->old_name);
   
  -	/* being an incomplete line is the norm for a symbolic link */
  -	if ((patch->old_mode && S_ISLNK(patch->old_mode)) ||
  -	    (patch->new_mode && S_ISLNK(patch->new_mode)))
  -		patch->ws_rule &= ~WS_INCOMPLETE_LINE;
  -
   	patchsize = parse_single_patch(state,
   				       buffer + offset + hdrsize,
   				       size - offset - hdrsize,
  diff --git a/diff.c b/diff.c
  index c53aebc4a4..9e4b92ed69 100644
  --- a/diff.c
  +++ b/diff.c
  @@ -1858,8 +1858,9 @@ static void emit_rewrite_diff(const char *name_a,
   	size_two = fill_textconv(o->repo, textconv_two, two, &data_two);
   
   	ws_rule = whitespace_rule(o->repo->index, name_b);
  -	if ((DIFF_FILE_VALID(one) && S_ISLNK(one->mode)) ||
  -	    (DIFF_FILE_VALID(two) && S_ISLNK(two->mode)))
  +
  +	/* symlink being an incomplete line is not a news */
  +	if (DIFF_FILE_VALID(two) && S_ISLNK(two->mode))
   		ws_rule &= ~WS_INCOMPLETE_LINE;
   
   	memset(&ecbdata, 0, sizeof(ecbdata));
  @@ -3781,8 +3782,9 @@ static void builtin_diff(const char *name_a,
   		mf2.size = fill_textconv(o->repo, textconv_two, two, &mf2.ptr);
   
   		ws_rule = whitespace_rule(o->repo->index, name_b);
  -		if ((DIFF_FILE_VALID(one) && S_ISLNK(one->mode)) ||
  -		    (DIFF_FILE_VALID(two) && S_ISLNK(two->mode)))
  +
  +		/* symlink being an incomplete line is not a news */
  +		if (DIFF_FILE_VALID(two) && S_ISLNK(two->mode))
   			ws_rule &= ~WS_INCOMPLETE_LINE;
   
   		pe = diff_funcname_pattern(o, one);
  @@ -4003,8 +4005,8 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
   	data.ws_rule = whitespace_rule(o->repo->index, attr_path);
   	data.conflict_marker_size = ll_merge_marker_size(o->repo->index, attr_path);
   
  -	if ((DIFF_FILE_VALID(one) && S_ISLNK(one->mode)) ||
  -	    (DIFF_FILE_VALID(two) && S_ISLNK(two->mode)))
  +	/* symlink being an incomplete line is not a news */
  +	if (DIFF_FILE_VALID(two) && S_ISLNK(two->mode))
   		data.ws_rule &= ~WS_INCOMPLETE_LINE;
   
   	if (fill_mmfile(o->repo, &mf1, one) < 0 ||
  diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
  index 903128f1d2..b691d29479 100755
  --- a/t/t4015-diff-whitespace.sh
  +++ b/t/t4015-diff-whitespace.sh
  @@ -93,14 +93,27 @@ test_expect_success "new incomplete line in post-image" '
   test_expect_success SYMLINKS "incomplete-line error is disabled for symlinks" '
   	test_when_finished "git reset --hard" &&
   	test_when_finished "rm -f mylink" &&
  -	ln -s one mylink &&
  +
  +	# a regular file with an incomplete line
  +	printf "%s" one >mylink &&
   	git add mylink &&
  -	ln -s -f two mylink &&
   
  -	git -c core.whitespace=incomplete diff mylink &&
  -	git -c core.whitespace=incomplete diff -R mylink &&
  +	# a symbolic link
  +	rm mylink &&
  +	ln -s two mylink &&
  +
  +	git -c diff.color=always -c core.whitespace=incomplete \
  +		diff mylink >forward.raw &&
  +	test_decode_color >forward <forward.raw &&
  +	test_grep ! "<BRED>\\\\ No newline at end of file<RESET>" forward &&
  +
  +	git -c diff.color=always -c core.whitespace=incomplete \
  +		diff -R mylink >reverse.raw &&
  +	test_decode_color >reverse <reverse.raw &&
  +	test_grep "<BRED>\\\\ No newline at end of file<RESET>" reverse &&
  +
   	git -c core.whitespace=incomplete diff --check mylink &&
  -	git -c core.whitespace=incomplete diff -R --check mylink
  +	test_must_fail git -c core.whitespace=incomplete diff --check -R mylink
   '
   
   test_expect_success "Ray Lehtiniemi's example" '
  diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
  index f48d8bbf49..29ea7d4268 100755
  --- a/t/t4124-apply-ws-rule.sh
  +++ b/t/t4124-apply-ws-rule.sh
  @@ -749,11 +749,10 @@ test_expect_success "incomplete-line error is disabled for symlinks" '
   	oneblob=$(printf "one" | git hash-object --stdin -w -t blob) &&
   	twoblob=$(printf "two" | git hash-object --stdin -w -t blob) &&
   
  -	git update-index --add --cacheinfo "120000,$oneblob,mylink" &&
  -
   	oneshort=$(git rev-parse --short $oneblob) &&
   	twoshort=$(git rev-parse --short $twoblob) &&
  -	cat >patch.txt <<-EOF &&
  +
  +	cat >patch0.txt <<-EOF &&
   	diff --git a/mylink b/mylink
   	index $oneshort..$twoshort 120000
   	--- a/mylink
  @@ -765,13 +764,69 @@ test_expect_success "incomplete-line error is disabled for symlinks" '
   	\ No newline at end of file
   	EOF
   
  -	git -c core.whitespace=incomplete apply --cached --check patch.txt &&
  +	# the index has the preimage symlink
  +	git update-index --add --cacheinfo "120000,$oneblob,mylink" &&
   
  +	# check the patch going forward and reverse
  +	git -c core.whitespace=incomplete apply --cached --check \
  +		--whitespace=error patch0.txt &&
  +
  +	git update-index --add --cacheinfo "120000,$twoblob,mylink" &&
  +	git -c core.whitespace=incomplete apply --cached --check \
  +		--whitespace=error -R patch0.txt &&
  +
  +	# the patch turns it into the postimage symlink
  +	git update-index --add --cacheinfo "120000,$oneblob,mylink" &&
   	git -c core.whitespace=incomplete apply --cached --whitespace=error \
  -		patch.txt &&
  +		patch0.txt &&
   
  +	# and then back.
   	git -c core.whitespace=incomplete apply --cached -R --whitespace=error \
  -		patch.txt
  +		patch0.txt &&
  +
  +	# a text file turns into a symlink
  +	cat >patch1.txt <<-EOF &&
  +	diff --git a/mylink b/mylink
  +	deleted file mode 100644
  +	index $oneshort..0000000
  +	--- a/mylink
  +	+++ /dev/null
  +	@@ -1 +0,0 @@
  +	-one
  +	\ No newline at end of file
  +	diff --git a/mylink b/mylink
  +	new file mode 120000
  +	index 0000000..$twoshort
  +	--- /dev/null
  +	+++ b/mylink
  +	@@ -0,0 +1 @@
  +	+two
  +	\ No newline at end of file
  +	EOF
  +
  +	# the index has the preimage text
  +	git update-index --cacheinfo "100644,$oneblob,mylink" &&
  +
  +	# check
  +	git -c core.whitespace=incomplete apply --cached \
  +		--check --whitespace=error patch1.txt &&
  +
  +	# reverse, leaving an incomplete text file, should error
  +	git update-index --cacheinfo "120000,$twoblob,mylink" &&
  +	test_must_fail git -c core.whitespace=incomplete \
  +		apply --cached --check --whitespace=error -R patch1.txt &&
  +
  +	# apply to create a symbolic link
  +	git update-index --cacheinfo "100644,$oneblob,mylink" &&
  +	git -c core.whitespace=incomplete apply --cached --whitespace=error \
  +		patch1.txt &&
  +
  +	# turning it back into an incomplete text file is an error
  +	test_must_fail git -c core.whitespace=incomplete \
  +		apply --cached --whitespace=error -R patch1.txt
  +
  +
  +
   '
   
   test_done
-- 
2.53.0-179-g8fac285501

