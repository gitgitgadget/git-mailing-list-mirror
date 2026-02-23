Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E734365A11
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849635; cv=none; b=Cm0xbH/xLBzjcfQx++MewLrZowpX8/2MVmDSNTVPpHjzFKv5ajZbamVdQ9qPV98kGYcMDk2xQAtq+a+fmzh5lgN+Wr0Akgb+0fuFiWXGBq5bOMQXxT+U5g0Zw5Lv1KQfutRz4TVdzc9PdfAI+xDP22SmwdJE7kNvYpKdOMQHstg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849635; c=relaxed/simple;
	bh=3129kJOHsvUdzAp/qHoX7ECii3Et4GsG84w+COe5IY0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XxvT9LcxVIgUPbSpSMejqWunA3d+JVnOAoX43cdGXC6tOZfOvN8RPvZkSCJhP9aLgW1yuyFmzE7oWNoO80b0maWaQ8hCqGCH1uPE100RU3N34PTPQOpS7ywns/yjaFjDWfCV+vXxbp95CIDgznPX2k04Jn2YT86O/R+GHZdFsfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvHx/zyY; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvHx/zyY"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79801df3e42so51422827b3.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 04:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771849633; x=1772454433; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+WP4+VIpUdwyznJ2aBcdZUEix6YFOBlYs0oinRpxeA=;
        b=IvHx/zyY1Cg4CZB27XOK8MNbPLL2bt+ujtBVdDLeR/FgDINRdBHliKqnmaKHRgLRpX
         JZvv1vRMh+++0UHj4rIKIwXW7KsMG+F41I0oFR+Gjj0nlALzuOED1nIA0w3wHIVqOgMz
         w45SDsMvHVPN6xALC+nUzqmzkNoRuVa+qjs9b/497ds2ma+YM8SlOeDIANKv5Hbtn+2U
         uUk5p+KXOcDa3RKJklzhM9rAxLnygbQ0xxuzeEUnJDtJJoUidCV5n/Ycx2CRCRd5njlG
         uofgflBoMNNpglaIuD2sXYxleJ8oOF0ABjY+nwGjf4UsOzNcfP9WnP5Dd5JcbSdGDRa2
         hZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849633; x=1772454433;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5+WP4+VIpUdwyznJ2aBcdZUEix6YFOBlYs0oinRpxeA=;
        b=lU8cGfZKLkQay0PZWQ1QYjs1EDoUxydiZVGI+FNoyvCk0kSKTJVrCzRhFW09DBfog7
         59S8cfcNeyej/2+6cJtYq+cGEraMTGyJA4qzkXQ5wxsRbph9PKXobq1JNkJdNmy85/7h
         P4tLyPZMeqFVB5rqWrKw/6ZJcR+3KXs+UCqBEzdLPXpoyW43gT+Ei6CtLe8v29XUe7Fs
         Ct0WYQRfEzhqGO/4UXifbleKxv5OEM/nssFa8xmMRVHfpLJnvznWHzxkCzJ/dt4tsscW
         Di/DmZ68l4XZV7Gess3e0nvmB7ZbhSuCiA+8eWupMOXSKlvcSPPGl8bIXohE1rEtA62P
         qLVQ==
X-Gm-Message-State: AOJu0Yw1lQjDLKSEpvZU56xVjL/vHde//D//wzcGUgWDIBuBAydH/gUC
	lP44AS6kZQmqEWbF0QI7u8G0YiB4fc3NIXFOPOBC6tauqhxbvs8uu47RKRVGww==
X-Gm-Gg: ATEYQzxkFxlsk09NLCVR3NQTaLRWFlzWbcGWMlWMBZqwtTVkFbL2MR6Up4T3HEcHin8
	kOQ8XG/rbwS47Gku5bWZy0goI1DDXwwSP7VRG4dvEbOH3vZx97+Fkzlki9GB8olz5tMRY3Q7c2s
	FZUhm8KLqV+AC4JDiAH1Gbd8I61FqpgbX7Gi/4aKVsnbylmiwRREr2S68MfiQROpGpdH3F4n9/P
	oPCisv9ZtdNfhtL2M1SebsuAybcvbFtAgAzzTYa6H9mB6690vLUlum2XzW9ycBVATfFuTUy6G3E
	iYs+NacJ6Aa02if9pWyY6G5QPSVUPq817oqN0Fp3gNZPAYx1zFoJCw99eN5C3Xhq2YUm3gwihOH
	VS63hmyUdC4NHCucPfJwJnzNOhobk3P497Jtenoghb6xEN0jg2tqkEx/uX1b3pyLrLkO5pcnsDJ
	FSZPavJ3dYQVDSlfvfPpb9M3NmRA==
X-Received: by 2002:a05:690c:b19:b0:796:28aa:62eb with SMTP id 00721157ae682-79807d4411dmr106487087b3.32.1771849633114;
        Mon, 23 Feb 2026 04:27:13 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.131])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982ddccc24sm31144917b3.40.2026.02.23.04.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:27:12 -0800 (PST)
Message-Id: <078065cff0dae7f2da4d4339caa8163199b907b4.1771849615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
References: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 12:26:53 +0000
Subject: [PATCH v3 11/13] config: format colors quietly
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Move the logic for formatting color config value into a helper method
and use quiet parsing when needed.

This removes error messages when parsing a list of config values that do
not match color formats.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c  | 27 +++++++++++++++++++++------
 t/t1300-config.sh | 11 +----------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index ee77ddc87c..45304076dc 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -351,6 +351,24 @@ static int format_config_expiry_date(struct strbuf *buf,
 	return 0;
 }
 
+static int format_config_color(struct strbuf *buf,
+			       const char *key_,
+			       const char *value_,
+			       int gently)
+{
+	char v[COLOR_MAXLEN];
+
+	if (gently) {
+		if (color_parse_quietly(value_, v) < 0)
+			return -1;
+	} else if (git_config_color(v, key_, value_) < 0) {
+		return -1;
+	}
+
+	strbuf_addstr(buf, v);
+	return 0;
+}
+
 /*
  * Format the configuration key-value pair (`key_`, `value_`) and
  * append it into strbuf `buf`.  Returns a negative value on failure,
@@ -388,12 +406,9 @@ static int format_config(const struct config_display_options *opts,
 			res = format_config_path(buf, key_, value_, gently);
 		else if (opts->type == TYPE_EXPIRY_DATE)
 			res = format_config_expiry_date(buf, key_, value_, gently);
-		else if (opts->type == TYPE_COLOR) {
-			char v[COLOR_MAXLEN];
-			if (git_config_color(v, key_, value_) < 0)
-				return -1;
-			strbuf_addstr(buf, v);
-		} else if (value_) {
+		else if (opts->type == TYPE_COLOR)
+			res = format_config_color(buf, key_, value_, gently);
+		else if (value_) {
 			strbuf_addstr(buf, value_);
 		} else {
 			/* Just show the key name; back out delimiter */
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 72bdd6ab03..128971ee12 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2579,19 +2579,10 @@ test_expect_success 'list --type=color shows only canonicalizable color values'
 	section.blue=<BLUE>
 	EOF
 
-	cat >expecterr <<-EOF &&
-	error: invalid color value: True
-	error: invalid color value: 1M
-	error: invalid color value: ~/dir
-	error: invalid color value: Fri Jun 4 15:46:55 2010
-	error: invalid color value: :(optional)no-such-path
-	error: invalid color value: :(optional)expect
-	EOF
-
 	git config ${mode_prefix}list --type=color >actual.raw 2>err &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expect actual &&
-	test_cmp expecterr err
+	test_must_be_empty err
 '
 
 test_expect_success '--type rejects unknown specifiers' '
-- 
gitgitgadget

