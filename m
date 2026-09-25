Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1504236829D
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790309575; cv=none; b=Bzw4Uh6yN20bLRoxaW14KpzYkXUBDPnbWfqam9LX1Bh4gabx9zlEgv7mgP3i1YSfjUGXoOPsCQRQDOh5UDlCU1hnGG/NL9Vce5EZscTDC00G9EtM5CA1QbrZ0Rhfe5013ydc5W2Sgl1j+VmhhwmRkU+ivyy+Rdgwz6ysT/N2l24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790309575; c=relaxed/simple;
	bh=z0I61EQ8TAxkAS4sEF3vtAvrfYPHyRq+b1FPf4T+MtY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OkI2XqkLnYAFxNF20086fpXOU+rX9DaxYJBjVbnH+CpTMJ901c9jfRE/LlWkg2iF7tFDpxGUdd5q06WoQkUwt+jE6n+z4Vr9HP7GFLKw/RLvHn9ZHRgx6h/cdPk0OMRIp1Wn3LGJNgTuQyVTdOFEbzjxNxq1bnEzvx3sHOFCFWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bUdwQjWJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LkFQf4nP; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bUdwQjWJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LkFQf4nP"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 04D907A0068;
	Fri, 25 Sep 2026 00:12:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 25 Sep 2026 00:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790309571; x=1790395971; bh=6cwnmQnbLr
	a4inAtUBS9uVHYUPOZ/maIkWPfHyyRyrQ=; b=bUdwQjWJa+aDm2kQsHzHi//VoR
	8HH4dEEghDtKCrJsXDq3XF/E+P0ZrIokFHk7ra1sJdJSZCepmU4irApezDoSPKJL
	QPMc/FlB9BAr03EPFG2nVo5DUzggkwf9dLX+aFrBjVGZ3bfGrolO+HuiaPTiJ4Oa
	0RQioeMvnL/6S35Z1v1/i8RRvhNCerl2wVuScXNzLhI8EfC3HhQlRbywQtImV3BB
	0J4ds4hQIEzawlQXO4sRO3LlGo3uabepY2tnRus9Xgmysk59j+ZOy5sz1VwhmKUh
	KVl+LgYujYSXul2mpd2OyM64LsdhUC4zHz/5v5V2gVZ6m3QAZtiIJgn1VJ+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790309571; x=1790395971; bh=6cwnmQnbLra4inAtUBS9uVHYUPOZ/maIkWP
	fHyyRyrQ=; b=LkFQf4nPhZ4xQ3e84GT7cEWgqT1rmeldRhGgSVf1wTMw+rm+0d3
	pt0EkUuzHdcJ6emS1Gh6+vEgDw1VUdIlejZ3WT2OjdFKTgMRko0o8AQyeUH2qXuI
	Ln9GWAOv0QRgsEdZVo8yUT+uE/ohq+TFUjflulNDFuEx4Szm4DDv1UI/yFa2kV6c
	l3RX07OFuPAHh/KFSEDqMj4AMm7yOa//uYvax42JfUgANfV6KIWWHF+L9MOIWjbh
	gjQ4m9SUbsEdCZCbim1UiX0VU410XnP6ki9aaWciqjPNj0jM6j3zFoa8Hqumd8Xu
	GjrKjDAThT5ayuG4jQQyoicbk5wBRfeKu5Q==
X-ME-Sender: <xms:w_S1ahXjyMzoRXyDkCBPUAFnOnz971-lIZgNDC6YU9hyZ1rG6_Otkw>
    <xme:w_S1aoEtV6Aks032KzitdZ0THWA4joti1TyCEpMmfIavCETQ1cFftHwOA4hF1uh6S
    Fz7JsjhU7GtSQ1dBOrZ7ZGfO6o7Tsro15hqRzTeEUWen7rTTDZc5Tc>
X-ME-Received: <xmr:w_S1arZQ1gG3ft9YwMfRgGtOf7woBF9HmBaQCrkN5x033dk9eGE9zZXcbLTahdX0WaQks7YSLJxcE9DyGNPlR3tteShh1wyOMXN6>
X-ME-Proxy-Cause: dmFkZTFMrwQZgvWLHCK0UTzUNE8rXPKi7KIcWBxXWKBsUjwVlIPRxLwcj12uGlez0O10QH
    7CjlXCtESfBziBc0LCHBfXBtjS0qzb10E1ioJsRekHXWn6dXyjaYBc0DeUFjHxwoVBIThB
    YTvIKJVviK+t54fqHfU23Muy59Frf9GIOyn8Jzq2HdnWnE/vsAjG0jwZZ8co+W2v8D/h7p
    7PW/oZ2lo/aj+qJ8oaEwFjwgxwU9G8YmjWBycji4hUr5xcjcCP5V3R+y1mp4aMPcu6w7uS
    q/qbvIJEXLaUJmtBsOB7zTlGDlZEM7UnF8U0dhzdy9pv0NAi3nePpjWZmh9TlfSCL1EMMy
    5aW9woLJDYGvcH3SgtL+TH6ogTmU5dyBLB6M6d7XPutSF6hDHymScH3GKsjtqmjMnun9su
    HgGeS8vs8lPq5F+k6ZYnWmg7udplkcD3JSRHbeHcuClx5fFgmgzYLF4saohinIyemIqpK3
    pS/K+KGfCwt/3Se0pH7k1TtVYYmlVSY868LE2xfo1v4Izusy83GaUBXYpsY22BJT34hlmD
    1dQV5QHC5VjBr4dGHKj0f2pfUEdhWK/xx1Q2RR7KSXcuNNSiG1V2ZZGs8rx90yqKvNYV4G
    qRx2ldviYq1LOPp7xB7CWA/nIJocG4qWhwfVJ3EoxYHdr5MnQkThcs0xwNuQ
X-ME-Proxy: <xmx:w_S1anEtNp7toki5-QAsoWVUMTQQv14KhzzAujHCfH64nnaQCyEYgQ>
    <xmx:w_S1ah3C_mX_zZD6V5RH_ci36beGRzidpkjCVon6LY7pP6dtHu_zXg>
    <xmx:w_S1arynYAZkNW2mpHy6HgpyNiF0XI1Me4tg8mFzrO3ERUGqIUSCmw>
    <xmx:w_S1aqigof776rYi0JU2NKtdhIBvk9ucFb0v_PU-GBsnjp9UGhK8IA>
    <xmx:w_S1ahtbOsv2VcUNBOQbhdlDmaamXN0U1KNIZzx5skLnEUV_23ScONWI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 00:12:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Eli Barzilay <eli@barzilay.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,  Elijah
 Newren <newren@gmail.com>,  Adam Johnson <me@adamj.eu>,  Victoria Dye
 <vdye@github.com>,  Jeff King <peff@peff.net>,  Derrick Stolee
 <stolee@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH v2 4/4] builtin/stash: merge index in-core
In-Reply-To: <xmqqse2yz4y4.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	24 Sep 2026 14:59:15 -0700")
References: <cover.1789853192.git.ben.knoble@gmail.com>
	<cover.1790168285.git.ben.knoble@gmail.com>
	<e49936ee12aaf5d82a98dddcc618cee01ac3c681.1790168285.git.ben.knoble@gmail.com>
	<xmqqse2yz4y4.fsf@gitster.g>
Date: Thu, 24 Sep 2026 21:12:49 -0700
Message-ID: <xmqqpky2x932.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> The new test in the attached patch will fail with this step but if
> we revert the changes to builtin/stash.c in this step, it passes.

Oh, and with the change to the code, it passes again.

diff --git i/builtin/stash.c w/builtin/stash.c
index 219ca457be..44d962cc5d 100644
--- i/builtin/stash.c
+++ w/builtin/stash.c
@@ -639,7 +639,7 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 			merge = lookup_tree(o.repo, &info->i_tree);
 			merge_base = lookup_tree(o.repo, &info->b_tree);
 
-			merge_incore_nonrecursive(&o, head, merge, merge_base,
+			merge_incore_nonrecursive(&o, merge_base, merge, head,
 						  &result);
 
 			if (!result.clean)
diff --git i/t/t3903-stash.sh w/t/t3903-stash.sh
index 3958ab3c8d..0a87e62b11 100755
--- i/t/t3903-stash.sh
+++ w/t/t3903-stash.sh
@@ -374,6 +374,38 @@ test_expect_success 'stash apply -q --index refreshes the index' '
 	test_cmp expect actual
 '
 
+
+test_expect_success 'stash apply --index does not revert unrelated upstream index changes' '
+	test_when_finished "rm -fr playpen" &&
+	mkdir playpen &&
+	(
+		cd playpen &&
+		git init &&
+		echo "base1" >file1 &&
+		echo "base2" >file2 &&
+		git add file1 file2 &&
+		git commit -m "initial base" &&
+
+		# Make a staged change to file1 and stash it
+		echo "staged1" >file1 &&
+		git add file1 &&
+		git stash &&
+
+		# Upstream advances by modifying unrelated file2
+		echo "upstream2" >file2 &&
+		git add file2 &&
+		git commit -m "upstream change to file2" &&
+
+		# Apply the stash with --index
+		git stash apply --index &&
+
+		# Verify working tree and index state
+		test "$(git show :file1)" = "staged1" &&
+		test "$(git show :file2)" = "upstream2" &&
+		test "$(git show HEAD:file2)" = "upstream2"
+	)
+'
+
 test_expect_success 'stash apply --index leaves everything untouched on failure' '
 	git reset --hard &&
 	echo test >other-file &&
