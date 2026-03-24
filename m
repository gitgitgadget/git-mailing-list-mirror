Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DE51AF4E9
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774377158; cv=none; b=gfgpHlGqgByxR1o0WlP/otFofvy17O8CtMWrrutl08diujcKAQyyS0rehaJa8Y2GJcPicTOoAEbHGDrfIwXKXMSB2p0gEDgZZAQ0opTFt6Gzjw5OARmmIcZevh/sDuno4p1tS/qjJLaR+1jHYWMYAigWH4mQb7/l9ochZCv11XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774377158; c=relaxed/simple;
	bh=J9UUHp1sUADSoP0AUHKkjR8TiANp49em3G64gHNcRg0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SGNUrZ3LSp/8EsFmOkEEflI2/rOf7wmDMJdNay2eJL40lFj5HXuYjzlOEW6/1uhDqiRVQnaKejfYSp2+hHoqgpRmuzTrcWGRvhsYzACRr07aVNsMrDrpF4zD+CzkK3bf6whJsrN4umNp0pjmgrDKd+k1/f9nluu25A0Q1FtP4/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DpZPicDP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oo5Ojo4J; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DpZPicDP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oo5Ojo4J"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 507ED1400112;
	Tue, 24 Mar 2026 14:32:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 24 Mar 2026 14:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774377156; x=1774463556; bh=18iFmG4jMV
	Ryz2cQUMmu6P1QuPz1n+KLmBnZ8lNvGP0=; b=DpZPicDP1TJAD/fR5b38RoZnbp
	F9a1dQ88Fg7MsdMGLzQtHJuWGd3dJ0NS4Hp7IjHq1+YCT1MnKjvoYc2IBrI3v1Hm
	bjSnnrL0cC/esTgNAmKT2FnNsc3xFRNY6SWd9WbF9wOWiV9absoQdzehNczZWm7/
	9JdHqKZsRelA9IeUZ+uCYjtufWd5pAyMjv3A4+IHcFybHbVkzvqXkhlwBuaImdBx
	Aq+7XmMi6LKSJccaTBcq3yBNRzUm3jyiMwLBnfd3QkV/c7PomKoV5l1MtFwFunMk
	qsgzl1efOIQjk1pI2k9gufMYyP7k6w5E8v7ez0PPt+HWImlkwjYP5wBUNW+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774377156; x=1774463556; bh=18iFmG4jMVRyz2cQUMmu6P1QuPz1n+KLmBn
	Z8lNvGP0=; b=oo5Ojo4J9xiU2ZnjuRJYbGbDR50hMQ+dqN75EQfnDInD76pjQVP
	F3g3I+IjleUKZ351qESibDi4/btj/la0+4yTFgyDAs58deJumXMfNXEGpXndgxRO
	bvuw6blIC9g/H001gdUDRkCSaSunCwTrTAV8PnHzUXSiiesmc2wS642GpTlbPAoe
	i09f3jD9yZKH7r8209iKG3fwKQRfTCKF86rB7qC4EpfX83QAZCOFNR1svebUEbKq
	UQGLTD3ueLdDriSJ3b3Sk3hX1KJh97vALFcVnkwHSC4znFiFERye9mxdjS8slo1O
	LISKi48UkZ9ZjPegwukTF7PWf5RUEShWiRw==
X-ME-Sender: <xms:xNjCaZZC74V4mB-0vT1okoz1jAOqEA6Zm3GehtnJ9-Q1S_0vEgpUfg>
    <xme:xNjCaWa9jUvCdsBchvw22YpNmFdps3-9XPpEC2zJiwiti6McrszFpvzAHAJ-082fb
    bojdsTmXF_K6KecIUMQ9Gnx6K7RjtWZifhso4HFN3wbeBMu4YqnZw>
X-ME-Received: <xmr:xNjCaZk-1MV6APEyn0GSkF4v8yiw5b0vdMmdi7FDL6gUhZ0UYiCujN_08tkq5OznXk0djQ5pGzXy6nm8iQgKtWxrhlb9wWc8BA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepkefhueduteekgfdtueegvdfgueeiue
    dvlefggfefkedvffduvddvkeeuhfeifeejnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:xNjCaSxmgnbb57Mvg6p6AB0BPrXCx6lIhvxhG5HrE86NDLnErHrUbg>
    <xmx:xNjCaXOGp99srRBMoEN1af2Bmn4zIgbFLDMZzMqb8JR1qQBMATnYtw>
    <xmx:xNjCaWR8uwYNiHfk3eoL1rGRQ2FTwrvzdAaJQvJzKlfLxe6bl6_x_g>
    <xmx:xNjCaVaBWo9K3nlGg_42cL6vM7zteUwjBGT311_XxT4yPsyDhcz3ZA>
    <xmx:xNjCacxT99Wcq6g-eMGiTx6oHdQqXZpW6n7vcbUkDrm-Me2KDjdAH-12>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 14:32:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] t7450: make test "set -e" clean
In-Reply-To: <xmqqcy0t178a.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Tue, 24 Mar 2026 10:13:09 -0700")
References: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
	<acKqvI0EhaORjoD7@exploit> <xmqq5x6l2q5y.fsf@gitster.g>
	<acKx6yBi-BWUVJcv@exploit> <xmqqo6kd18sr.fsf@gitster.g>
	<xmqqcy0t178a.fsf_-_@gitster.g>
Date: Tue, 24 Mar 2026 11:32:34 -0700
Message-ID: <xmqqbjgdyt6l.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

In order to catch mistakes like misspelling "test_expect_success",
we would like to eventually be able to run our test suite with the
"-e" option on.

Often we write "A && test_expect_success ..." and want it to mean
"If and only if A holds true, this needs to be tested", but under
"set -e", this will cause failure when A does not hold true.  We
need to write "!A || test_expect_success ..." if we want to run the
test conditionally.

Or write it properly with if/then/fi, perhaps like:

	if ! A
	then
		test_expect_success ...
	fi

Make sure we do not fail unnecessarily under "set -e".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7450-bad-git-dotfiles.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git i/t/t7450-bad-git-dotfiles.sh w/t/t7450-bad-git-dotfiles.sh
index f512eed278..047e4085d7 100755
--- i/t/t7450-bad-git-dotfiles.sh
+++ w/t/t7450-bad-git-dotfiles.sh
@@ -220,7 +220,7 @@ check_dotx_symlink () {
 		)
 	'
 
-	test -n "$refuse_index" &&
+	test -z "$refuse_index" ||
 	test_expect_success "refuse to load symlinked $name into index ($type)" '
 		test_must_fail \
 			git -C $dir \
