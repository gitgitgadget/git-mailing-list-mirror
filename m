Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29949653
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710205089; cv=none; b=cpyXEy5Tn2t9J3lbqRlSki3cxwp7tmsmNYUxWfxM9ZDI28p8gsE4ZnixVeGpz6kMase1dsVtna9EBf7PfkHX0igsr98zTHdF1kFh9DWOsjIa5c65l+7oi9ZqreJS3d/WcvpO22RgnbxiUZDosel4sAS8UcPh0UyWR7/IGCow5CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710205089; c=relaxed/simple;
	bh=ev6FS94MDPu8uWQ/z2BuoyoxoXnS11hgohupsEBT/X4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IaOCIKiUGrlPje/4KH3ZMgrIKuOIQJHtDWgdGn+Rm++YRwu4nSWYlfaWcgLmh8WdKoTmtTPtDCKIfpLjT6xcCu60VCvCM97+jXVN6C7pqdh5Z3yQbC+wNFwBmSgWEnegFT6SAIZbexFvkBtbe7BlSdAW3+2JjzheagRp/y1k6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=WGm57h0r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NG+v5U5U; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="WGm57h0r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NG+v5U5U"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id BD4C61800084;
	Mon, 11 Mar 2024 20:58:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 11 Mar 2024 20:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1710205085; x=1710291485; bh=/6jNAK9Wtf48RjYaJxuRy
	UJR2DXs2KjFz7FsBYDnC0U=; b=WGm57h0rPG6dA6vxsVNtcrkcgXrzy9MLFBsC8
	13/U7ltoOT/+/DrVRF9Oz+oATzobMRK1Lk+psrq1C39mtjb2SSeFAhBkSqm+tN6r
	uh3J7q+noHIEOqBElkiUirQBhNtyYS+oGme8WqkX35Ah8cF+Ivy5kpSvmERRXdno
	3Pv5XNaPHkL58OENlnxMJFcEiVJW6+oWCtKvIFeJByykdZW/XzAHVUI3RiIuWzam
	Ha5Cgvdl5y3nsBJxDhosoWYDwPyK+0MYEU8f4CjVCoT2SIMZ1jNDWsxW7AVF1tMI
	IIDItfR8HH5Ze3PWerNNzVWMmMFpI3zNKiYSChUVe9rbNHlAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710205085; x=1710291485; bh=/6jNAK9Wtf48RjYaJxuRyUJR2DXs
	2KjFz7FsBYDnC0U=; b=NG+v5U5Uxa14dRkuHzGHkEtp4zOXbGkvT4qlvZtY/CVc
	2PGRMQU35riPEbh8RWaih+Lg5mkL1dNaHM8EADawCTcoUNvx+A93ioAwihCaa4A8
	z8euf2FqdF/tR/qhUO9vF4ijRlZ5UCR1qZ7bW0zADIzBvBWi+wJEBD6Jfh1Dv0MO
	YwgnRyPIg7HRLOu3X0ooTUVsj+q9Q5ppn6VK+sthkXEW5fgIFLM221+dVp4rxW/w
	2fKEFkYUmN3Ap/IqrFfN29WF9ICd6ILZYcLqqyhfVo4/LK3ex58+jlndoKYS13vv
	qaKkXBCFrxZ6Lxk0g9iedh5x4tSBEVx3fwx2FnSVaw==
X-ME-Sender: <xms:nKjvZXAafyvdMy_DaPuOApjb0htkB9MKc3EiTZw99a0hBTS1D77rbQ>
    <xme:nKjvZdj9FH65Pc0H6YRi2D8Rpy_dPJrwFF4ol0XO87kfBnbfU_lTGDOEupK-yKJMq
    5rI53PVUtAGTB45MA8>
X-ME-Received: <xmr:nKjvZSl9gNW-DvEocKCrEYgAYPFTriAAoE7bLQVUGwkRs0B_RJRzP1HZH2_-Gx5-RxZLzTwXNhBsFoeiaOzzkbTT3lMEuVkbZv_F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgvrhcu
    jfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvghtqe
    enucggtffrrghtthgvrhhnpeefleehgffhgffgieduveejjeejveetfeelhfdttdevueek
    ieeltefhudeufeeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:nKjvZZyM14zyApH9k0TjWxRD7vmHnBdRSHiaUZu0wfHkdR8MtAOGYQ>
    <xmx:nKjvZcTKLsTc4awgD7H6FlQ846AMGgylaTevspKqzeNDv6KMca8Ajg>
    <xmx:nKjvZcYJr_dxUhk4dxsCe7dWcOEajFEFZXm76wVT2IXV8TsENnE4bg>
    <xmx:nKjvZdSedOGtFV7C3neQT4fNyXZSwpaGtnuE5cSPcr8aY6dz-0D7fw>
    <xmx:najvZSO0Q3QllkWx-NMbo6CZaXuuuqbj0Ahhj1iAa5QHx3H2ZT6op1FGAss>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 20:58:02 -0400 (EDT)
Date: Tue, 12 Mar 2024 10:57:56 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, David Heidelberg <david@ixit.cz>
Subject: [PATCH v2] diff: add diff.srcprefix and diff.dstprefix configuration
 variables
Message-ID: <20240312005756.GA3029606@quokka>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplw0r6c3.fsf@gitster.g>

Allow the default prefixes "a/" and "b/" to be tweaked by the
diff.srcprefix and diff.dstprefix configuration variables.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
Changes to v1:
- note default in documentation
- drop the custom prefix function, change the defaults instead
- commit message: options -> configuration variables

Junio: all of your comments squashed in as requested, thanks for the
review and suggestions, much simpler now.

 Documentation/config/diff.txt |  6 ++++++
 diff.c                        | 12 ++++++++++--
 t/t4013-diff-various.sh       | 20 ++++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 6c7e09a1ef5e..43d94df19876 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -111,6 +111,12 @@ diff.mnemonicPrefix::
 diff.noprefix::
 	If set, 'git diff' does not show any source or destination prefix.
 
+diff.srcprefix::
+	If set, 'git diff' uses this source prefix. Defaults to 'a/'.
+
+diff.dstprefix::
+	If set, 'git diff' uses this destination prefix. Defaults to 'b/'.
+
 diff.relative::
 	If set to 'true', 'git diff' does not show changes outside of the directory
 	and show pathnames relative to the current directory.
diff --git a/diff.c b/diff.c
index e50def45383e..4439b1a95864 100644
--- a/diff.c
+++ b/diff.c
@@ -62,6 +62,8 @@ static const char *diff_order_file_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
+static const char *diff_src_prefix = "a/";
+static const char *diff_dst_prefix = "b/";
 static int diff_relative;
 static int diff_stat_name_width;
 static int diff_stat_graph_width;
@@ -408,6 +410,12 @@ int git_diff_ui_config(const char *var, const char *value,
 		diff_no_prefix = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.srcprefix")) {
+		return git_config_string(&diff_src_prefix, var, value);
+	}
+	if (!strcmp(var, "diff.dstprefix")) {
+		return git_config_string(&diff_dst_prefix, var, value);
+	}
 	if (!strcmp(var, "diff.relative")) {
 		diff_relative = git_config_bool(var, value);
 		return 0;
@@ -3425,8 +3433,8 @@ void diff_set_noprefix(struct diff_options *options)
 
 void diff_set_default_prefix(struct diff_options *options)
 {
-	options->a_prefix = "a/";
-	options->b_prefix = "b/";
+	options->a_prefix = diff_src_prefix;
+	options->b_prefix = diff_dst_prefix;
 }
 
 struct userdiff_driver *get_textconv(struct repository *r,
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 1e3b2dbea484..86834186fdba 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -663,6 +663,26 @@ test_expect_success 'diff --default-prefix overrides diff.mnemonicprefix' '
 	check_prefix actual a/file0 b/file0
 '
 
+test_expect_success 'diff respects diff.srcprefix' '
+	git -c diff.srcprefix=x/ diff >actual &&
+	check_prefix actual x/file0 b/file0
+'
+
+test_expect_success 'diff respects diff.dstprefix' '
+	git -c diff.dstprefix=y/ diff >actual &&
+	check_prefix actual a/file0 y/file0
+'
+
+test_expect_success 'diff src/dstprefix ignored with diff.noprefix' '
+	git -c diff.dstprefix=y/ -c diff.srcprefix=x/ -c diff.noprefix diff >actual &&
+	check_prefix actual file0 file0
+'
+
+test_expect_success 'diff src/dstprefix ignored with diff.mnemonicprefix' '
+	git -c diff.dstprefix=x/ -c diff.srcprefix=y/ -c diff.mnemonicprefix diff >actual &&
+	check_prefix actual i/file0 w/file0
+'
+
 test_expect_success 'diff --no-renames cannot be abbreviated' '
 	test_expect_code 129 git diff --no-rename >actual 2>error &&
 	test_must_be_empty actual &&
-- 
2.44.0

