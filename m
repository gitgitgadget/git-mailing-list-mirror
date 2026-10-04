Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC1112B143
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109129; cv=none; b=hcEtr/jdyNfnmhg8+KIjpMCwYeUT63nyrZAd+D9zn3uU8Y4mlGLFe58qKXmNjQBmgSIH13XxTgWJwjyv9ZNaGXCdhRPl7M3avB0BrYr+/tLWaFmQzQIWTiG/M9Qa75IwMcFQxtJYTY3l5YSuOyrVIyjddmKCuasfcp51qBD2n3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109129; c=relaxed/simple;
	bh=593lunBRqi8CTJU9ojLLYg4S/gZ6vGRF0zci33+1w0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fh8N8uPDltLoJ/ePqDhxWm7Lcix/gISzBIHH/b7c+OoawbmOp+qVtNBLew5k2LjTB8in/lQsa0FuDYGUwCfNeMkoQLe6Y53b6zpl1FBbh5CaWIvE+MvOGVg9T2lg6lm8i3g27ulFIgmfk6BORa/HXqZ76+o15qQ69xqkK1u50RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=sPnHV5Zh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+4D6YqP; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="sPnHV5Zh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+4D6YqP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 622AA14000E7
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 06:18:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 04 Oct 2026 06:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791109126;
	 x=1791195526; bh=Uh8OuQgmcee4Wg9mQJEZ73lN9dTnbWxySDgZ4rwVBjE=; b=
	sPnHV5Zh5TLeMpHsBZvulfjMcpYfmB/76XqasNLd5OMa/aecJivonS9zg1mAstMF
	Y4l1tNojVi7Vyzur7gBXfaFHVx43j7zFwx7j42V+EDMEwVxA0M4mCnsTRqUBqIDg
	ordAkukxI/AwjhNIWZg39iZ1vV8Rwgw8sgg+weQQkxoQz94ZFPPuLTMPP7FAeDts
	/WVS7/OhcRZS433cfGY2ZhpJsgU8P52XJScwxL5WFLUGEC/N7O7ns+Kn/y3ASKe4
	vH4KUp8+GJCOQxRAN1uu5zwwjg1376ZZBPBMrsL/GAO1vFd5Rd9ve9YX0M7KtCPF
	u2/4XWvteLTh9vD+C0KD9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791109126; x=
	1791195526; bh=Uh8OuQgmcee4Wg9mQJEZ73lN9dTnbWxySDgZ4rwVBjE=; b=U
	+4D6YqP7JH0q5kMJdHh5/dK9ClcslHME5Y1pCMnAEUHEtEACayZKxG9hgwApGzfR
	wxMFQfqtQIOAZ+2HMihx77MzvktseF1g3YG8qlXp9RhQ0Wau9aLoV7z5g8OL7e/k
	iNijetFntCNJyWkARopVwTudr4yxPQYwM2RjtDrGyX4/GBi04ffY1OxPc4oAKdHW
	hng/o6Bk1+OZ9FnN/Cbnwc0VxAjp2Seuezl4avkzXzv/bnP+gkUD5Ropj9b0koAX
	BxEJbqXj8qlzjJkMZKQEy1nuUpZfNm3cZRPXTjXJF62wHKoAlA9lxEAAk5DLnnNp
	PmM41UFqRRIF2koPdFnKg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791109126; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:f4qhSCx4c7iyGnm+RvmP6OQB5OHEYhnaX27Wqx98KyIWSaj
	oKVDJJ9ex7/4jwx3Amma9vjoIQIgz2nnWBTlkE7zB6cYR8Ifp4f7R7hF4gUnhS0t
	InuBz9xs2EkKLIoPGA+N254FWbow/hXbSWWaGquK6WmO0arWIeT9UNmiNZjxakRk
	mvImE4q1YHJdjWum3aAUjj4SDSRSM0w7CTZbgDiTwwimuebr2oqWM3ocve9xAFRm
	TXCy3voJnI93uk/5TK4iVj/+8e1uana7KE/Mc6ADoatP3x0+z7SdQUDiKP9ypCzA
	0OFXd3geiu9EWhD9UVCCiu9CHC4Pz8A71tqu48g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:pbspYb029scoEDYgnMVt2106KNJHrkMDVtHtvtyXBqc=:593lunBRqi8CTJU9ojLLYg4S/gZ6vGRF0zci33+1w0Q=;
X-ME-Sender: <xms:BijCasPPhFEQkiQPVNVWwS3fxtsVuQ7tnqkVPrNdgbzqV-zrPoLjSdM>
    <xme:BijCap9oKA0BzCRg8LkUDXqbb8xhZ7m3QtDtZb66lO6yH0sSdcw2uHFaAqr0cItKi
    z08zTrR0xbc524oIpt9HapcSOM3e0Y-uUF2QGJH8HcXzRtjdl8Syg>
X-ME-Received: <xmr:BijCaoRzsaqiExUXmq7Wq2hdit2H991RITRgRKANByLuzhE5qwj6HqQiLDmb2tS3rPh9S5xrKyStFZT4GQptomkU3S6A6yICep5LdzFwr-ccPV2Xnh9Zvc8>
X-ME-Proxy-Cause: dmFkZTFW2xsfmInjB1RlfFRcMlcVYJDMBjMfVwLPvxcZXErz0cDsDgiVO1ZXOG7orXx7es
    77zQZY2P3C1kUIoabwaC7G+mjVKsWQkXaK5caisWfyyibiUjQDMnFCouxnmyUwy4PvCLKf
    8ulpKGsLfBxVZieE+cUUXIidTvLQifaD9D3piP6Eej5WMYmaEQIMu5NDBCmzJ2mziMqs6p
    s/v+9hEi31e3QBqZN30MlKHtEQJD8DucUVoCYeIazI4BILSBs6DDWiruQPUvAHly1m3mwP
    AsaEEJn7SWVmyxjKj97sj1q4KqYn0vagmW8lLysHwytAwhuEfufRf3srxPgW92FVKsE1s0
    cyixkYICPk/NishBZC5KEZdKV2/Je9XEplLC37UF1vreZrjeqYWaYN5A4kOXVi959chH2r
    8FrlU+Zh3mH1iNl+msTkfaEhyeKUNUbln5YClSW7SaJs859ivWxYFj06V51zeqwjEygn3K
    3WNPDLO4E0bNZSaaHUGVu1O0yCE7Fi0ql5aGTc61aDf+x7szjTqn5XPigtSP8m5UPHa7mD
    vFONQOKa7c8Wh+s33J0580xkOjZv/CPNmSTY08LIBBVaFnegkXAdcQPMPGWq85hFjC5lcE
    1OAwwD3886DGj478mQrROY0V6e9JiKadf8ItYc7L60ng9o2eDcNIvE5z/3nQ
X-ME-Proxy: <xmx:BijCajnVJuraPZPSgg-qLRn0IpLp6tTOs32ctqfiF2737UT5wnetzw>
    <xmx:BijCagQ150ERnOuQCXX60XJlg9hN3TAo25giLuz69bxMXQG0hpMIEQ>
    <xmx:BijCapN4WW_I4JTc96iwUjuGwZ8oiyfhDD6mZ-P8MNAQjuHuwyPU_w>
    <xmx:BijCahV82_SuHaq-dkQQX6EhHmSkk3K02B-61Jhy6SNLK3pIV9R8Ew>
    <xmx:BijCarymUpggadSYtfwyyXhGB6ts-7Q36X-wvgAWuXNG2zmubAe5txpi>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 06:18:45 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/2] format-patch: simplify get_notes_arg parameters
Date: Sun,  4 Oct 2026 12:17:53 +0200
Message-ID: <V4_simplify_params.d5d@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <V4_CV_format-patch_learn_--range-diff-notes.d5c@m5gid.xyz>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz> <V4_CV_format-patch_learn_--range-diff-notes.d5c@m5gid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

85bd88a7 (revision: add rdiff_log_arg to rev_info, 2025-09-25) added
`rdiff_log_arg` to `struct rev_info`. `get_notes_arg` was changed to
take a second parameter, namely that member:

    get_notes_args(&(rev.rdiff_log_arg), &rev);

But this is obviously unnecessary; we can just use `&rev`.

Now is also a good time to format this `for_each...` line since it’s
gotten quite long.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • Shorter commit message. No I.[1]
      🔗 1: https://lore.kernel.org/git/CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz/T/#mfbb107570d497be5bfe54fe209014b607f5d5830

Notes (testing):
    v1:
    just compile tested

 builtin/log.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 350b35c5563..560af00e2fd 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1333,16 +1333,18 @@ static int get_notes_refs(struct string_list_item *item, void *arg)
 	return 0;
 }
 
-static void get_notes_args(struct strvec *arg, struct rev_info *rev)
+static void get_notes_args(struct rev_info *rev)
 {
 	if (!rev->show_notes) {
-		strvec_push(arg, "--no-notes");
+		strvec_push(&rev->rdiff_log_arg, "--no-notes");
 	} else if (rev->notes_opt.use_default_notes > 0 ||
 		   (rev->notes_opt.use_default_notes == -1 &&
 		    !rev->notes_opt.extra_notes_refs.nr)) {
-		strvec_push(arg, "--notes");
+		strvec_push(&rev->rdiff_log_arg, "--notes");
 	} else {
-		for_each_string_list(&rev->notes_opt.extra_notes_refs, get_notes_refs, arg);
+		for_each_string_list(&rev->notes_opt.extra_notes_refs,
+				     get_notes_refs,
+				     &rev->rdiff_log_arg);
 	}
 }
 
@@ -2404,7 +2406,7 @@ int cmd_format_patch(int argc,
 		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
 					     _("Range-diff:"),
 					     _("Range-diff against v%d:"));
-		get_notes_args(&(rev.rdiff_log_arg), &rev);
+		get_notes_args(&rev);
 	}
 
 	/*
-- 
2.55.0.793.gc667de3f2c5

