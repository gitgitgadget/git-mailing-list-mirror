Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0981A9F97
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786302079; cv=none; b=Km5vUSZPev4s3uLYkzMOzarvPEleRQX1y4z9A2iA60t4fGmHMmc8X0poi2j+Iuj5Z04thYA7OnWX8RT9x2BLW88124/Hi+PwuM1YfBrfSLEyjpCqhQNSNzhAhVl9FP+N3ItHrnAStHQwKMiPm3oB7q1abSKWkOOtR9tbrmDlziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786302079; c=relaxed/simple;
	bh=j6fbEDlE1D3UdOerWHcRVbGUkGvXGoPS4YVxZYDzZFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gruv+NGZXIR7L+OjLXYkVmW8QnM1odcDcN1ey8+no3BLIrLNz5mH9gMpZt6Pelg5U1CfKy3kd6je/XSslDqr02ArEWbb0zpNxfh6wmgQhnO1QOx9W7/PVsQ3tSZyJK2bOopgXrq/OdKTPK7m73V1lByrocfrwM5t4XDEMl0wgTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LreeyuSK; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LreeyuSK"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-456395f4e7bso745477fac.0
        for <git@vger.kernel.org>; Sun, 09 Aug 2026 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786302077; x=1786906877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K1qRyfcScxVLfCNy3zseE+ctbQnmWp9GUabWstqVpjs=;
        b=LreeyuSKxT7zSkfithrdYO7uVxTA7C42zrg759jpyCMSi+CChuYipLNLrrYF8uZ6Ie
         wRG/7pTW0EXAtOwpyM3Cnv4fTavuk/RJbozElfUX+v8zGi6lSpTkKx4c1MCFNYjKL3bS
         DLM4BzYVarLjE3VwmqZrhzfIhR2EGgGHnryR77b9LAJeWwBioa4KSg3lMtODK58m9Ave
         +InxGvKEwnkjX9k2dyZHdyv3LW7+kXpOhg/6P/mVS8xWby/T8Y5UJdz9zkn5/VWzk4Yr
         GKEBdPJc2PWUBzzd9Qdk3ea37k0CW+EpSwvK8rfvS43qU3HKOzfx/Wn6JQK/vMwnqINH
         gCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786302077; x=1786906877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K1qRyfcScxVLfCNy3zseE+ctbQnmWp9GUabWstqVpjs=;
        b=HTqafEyHnDM/MlYOdxL0UQGS2iPfghmIJXxT64UcpNZgl01CQriiy8j70CRp5iLchF
         Q6a3TKWWH6E5Zl5fLbYopbPFB71zeyxYBXh7/tCApT31aHHp9gbyj8jB9EI/4365WePC
         8kjlB7ba2TJ8B5ke4yZr0P7O5TZtHOZXUFel94o8wMdnRT9eXiKQmSje6n6LcFVIV2H9
         Lk1w+5s0DGxlWNctoyV99dQw0LYz2QFnbeUJi8aYXNIiswxkKtT+3hKodBBVYR94Onqi
         fwG9JXizAcQbzGbw+aZhgEZwLJkQrK09OU/MO5/WZVh70QWS30PX8PJYOLl6fsSpx91Y
         Hb6Q==
X-Gm-Message-State: AOJu0YwtV1YS58eZffBKq1Ql28FKyWTrw5Gm5z/ZWoVdH48zS6VARuvb
	fjKcqylLuB8uMmJwAyOikywI/gALSf0DlcApaeYGcM0Yq8E3Y3sHLQXXWInB/Q==
X-Gm-Gg: AR+sD13YNaEkvZKbba9tXrtPUeUtProxlHk06MLlGdekxcZR+VE8Yzt5nNp4KYOWdid
	uoKlwcw4F3lFcrCOlsrbfspCZRGB5A0z2esgAwaYxqS1Oe6MKsgiowkqat4/nvUyP92hPw6NzcG
	cj7QIuTnrhSphpKt45ZZ7ss87WO3+EpeiDDQ93+3Cd0A/+1aal2eTyOZTcGXGrmdhOB25kfujz8
	kabPwOdv25VJTWUIjCPpctSTP/8bBY8YlnmEEQ8ugSD0SvzTDazKIblHY4E+FphglQ1Jl2EnUxo
	Vhgx5mZf2h6CtYWOtVQrh4O2lPrW+WJksgdbTKRcjFDJu7SQhSSM0ToOED8oCNXR6wyHgZw++Kq
	hMeR1X3qWvDS7fYy0z/aK3jaDfVO1iGXZDSkrX7AoTzT1CCmTOkFAD2dqgCt5J7Hk0I+LQv77xe
	BVMINZI5ESySn8oF04f8UXUKCdSVxLERlJu0UIkFuyIPSwcv1rkbf06amENzVU5CwxDfzP
X-Received: by 2002:a05:6808:6c88:b0:4a4:9e18:607a with SMTP id 5614622812f47-4afae1f41ebmr22414848b6e.21.1786302076818;
        Sun, 09 Aug 2026 12:01:16 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af5e7b77sm4872188b6e.10.2026.08.09.12.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 12:01:16 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 6/7] builtin/receive-pack: explicitly pass packfile fd
Date: Sun,  9 Aug 2026 14:01:05 -0500
Message-ID: <20260809190106.1565882-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260809190106.1565882-1-jltobler@gmail.com>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260809190106.1565882-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When processing the incoming packfile in git-receive-pack(1), `unpack()`
assumes it should always read it from stdin. In preparation for
`unpack()` logic being moved behind a generic ODB transaction interface,
update the function signature to take the an explicit fd provided by
callers to read the incoming packfile from instead. Call sites are
updated accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 896439d46d..76e8f4216c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2292,9 +2292,9 @@ static void read_push_options(struct packet_reader *reader,
 	}
 }
 
-static const char *parse_pack_header(struct pack_header *hdr)
+static const char *parse_pack_header(struct pack_header *hdr, int pack_fd)
 {
-	switch (read_pack_header(0, hdr)) {
+	switch (read_pack_header(pack_fd, hdr)) {
 	case PH_ERROR_EOF:
 		return "eof before pack header was fully read";
 
@@ -2354,8 +2354,8 @@ struct unpack_opts {
 	int quiet;
 };
 
-static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
-		  const struct unpack_opts *opts)
+static int unpack(struct odb_transaction *transaction, int pack_fd,
+		  struct strbuf *err_msg, const struct unpack_opts *opts)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
@@ -2363,7 +2363,7 @@ static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
 	struct child_process child = CHILD_PROCESS_INIT;
 	int err_fd = opts->err_fd;
 
-	hdr_err = parse_pack_header(&hdr);
+	hdr_err = parse_pack_header(&hdr, pack_fd);
 	if (hdr_err) {
 		if (err_fd > 0)
 			close(err_fd);
@@ -2390,6 +2390,7 @@ static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
 			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
 				     (uintmax_t)opts->max_input_size);
 		child.no_stdout = 1;
+		child.in = pack_fd;
 		child.err = err_fd;
 		child.git_cmd = 1;
 		status = run_command(&child);
@@ -2424,6 +2425,7 @@ static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
 			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
 				     (uintmax_t)opts->max_input_size);
 		child.out = -1;
+		child.in = pack_fd;
 		child.err = err_fd;
 		child.git_cmd = 1;
 		status = start_command(&child);
@@ -2469,7 +2471,7 @@ static int unpack_with_sideband(struct odb_transaction *transaction,
 	int ret;
 
 	if (!use_sideband)
-		return unpack(transaction, err_msg, &opts);
+		return unpack(transaction, 0, err_msg, &opts);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
@@ -2479,7 +2481,7 @@ static int unpack_with_sideband(struct odb_transaction *transaction,
 		return 0;
 
 	opts.err_fd = muxer.in;
-	ret = unpack(transaction, err_msg, &opts);
+	ret = unpack(transaction, 0, err_msg, &opts);
 
 	finish_async(&muxer);
 	return ret;
-- 
2.55.0.424.g13c7afec21

