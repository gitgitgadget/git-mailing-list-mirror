Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EA347ACD8
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935741; cv=none; b=oLXzo7EHBfiVN8c2MItItvXYkk4quJvZG3WeaNVJJ2x9IIbNiK/rLPFLEWm8yoPoKKKoRfSf9Tn0N8Kk5LamxFjp1fzlWtaV1mBgCpbyr6cppfya+ZycBhJyL5jxvNXZW+MNRgkXD219IhhSycQrFIGGNzwjXEwgG9cqM1hUd3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935741; c=relaxed/simple;
	bh=nqh1F8llcuycZSHX/mI5mqIGm3pNwUjwcG2gN3DmQEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jvX7G/EiwZk2kaaASb9bbTuIf84UnNK9ShpeQKmsMj2EgqC/btViqR5RN/8MezpyAeQFxzIX6q50fmyUnbH+mT70BsbAhY/Q7El03udqjfm9eizJIgfN5C3q8UaA5R/XR3WxqErtidnP96tIF+REisKP2M5xgqUinwWSkz459YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g8skJOhL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s3JyWzUT; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g8skJOhL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s3JyWzUT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2C40F1400096
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:08:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 02 Oct 2026 06:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790935737;
	 x=1791022137; bh=HbssO3z8QMnJuQ4OgxMUahyQ/Fp8sxLoTkx24z+vsm0=; b=
	g8skJOhLf3yBmX+FtpotCW6ra/XDAOTv2BjvW7UloAB87J7JJRQZ78vUSYh4yIiI
	FyZmaYX5riBXhnod9Im73tXoFZtoC4pqcTnkJ/fe3e3bTjH3wVuiAIACA4c01orv
	N7yZkev/dHQWkwGpKGHprhRstNtpYWfNcLB3J+0BrJ8fXh/5gP+/6HRijAoTA/wg
	knqUcprMsP8mKnvGPpitzhfbJejdynFck+fjTTx8agGZ6lLFtR1DA5ww+WL/JZdz
	jDatNPYo3yiNbxEH7u/T0enNDyxiLzWukUVhbAR5BMLSJ8iAhgMxq6iyDMAaClkM
	2ULwFxLCUAXFHIKK//GkJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790935737; x=
	1791022137; bh=HbssO3z8QMnJuQ4OgxMUahyQ/Fp8sxLoTkx24z+vsm0=; b=s
	3JyWzUTAVNZhev0zqKAHCX4jl2yhszcOsyeOsTgLZCdR3UO7YpXGGo4UUaDrIV/S
	wFsbqI5KVQYTFAludp7xqdowHMvYPSt44PHKr8fgFxrMHQ8t21qSKjKFxTYo1D6Z
	DY7l4Gg7j2u6Vq2rVfNecVr8cKf8ZKuCn/PaL9YhYg0Ab7Nm4rpLT4trc5Yq1JIv
	0V01VG4PMgPxj8uJuoG96cxL1aQoXB+hYu3uNKGr6lmQ+VYRw3/daAuLrBG7uSlp
	XzLDLPVdHuMv6ttvd/jE/Z2aFQHqV1GU57Dr/+DhfkL/c1ZtFiy5tMEQDpnuP5dY
	JTYR78lNOgc7dsP3501dg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790935737; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:xjvvVpp1QjuBj5uCsqzqNV/MeV9tzBeNC9PLLGnidOeSq9+
	NlJ8JF4wmt54roO50YloIZSDIiFtpR/+ycqk/xV6NdF1pHkpXGMo/WfKDtMjnvh/
	Yk41ugESG7DwSOzXSSu384dcueFlLA5b1FJW0ONrXSPXWfGnpC/6mlTJzbLSnlOS
	OX8ULU0SFORiqNZUylRn/OM3TqTFJjcDqeB/d0IhFjI30w4zTFHYRHY+pKiEbn89
	sTpwk9s/knLCT8iHeX/DZENJ5/t8XKZqgU6CaNoBuMYTi6xvFahBVGYMpDcmnVXf
	eFXmxMXxvTqRGgIJNp8H9QB+7CkJbbxMB+BDHOg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+Jf15Otf6XEx0BW1AYnHGdaf8L7jtkKzHu/XI+f7puE=:nqh1F8llcuycZSHX/mI5mqIGm3pNwUjwcG2gN3DmQEQ=;
X-ME-Sender: <xms:uYK_aojscJWw-fNbUulBojEsdG1VcfOR9n3vH_olVMdgMYMOFwQIOA>
    <xme:uYK_an_6lrn5lwShgQxYBzlJCbIc7W7Xk0AdBvDbYJjKopPFrd-FJlbMEfBr3Lxrr
    hrNJGtkdytjGNzGXHjflDsHkov4j4u0clNHzZ3Vx5m0yMbff6VxZn0>
X-ME-Received: <xmr:uYK_alstjTVq2Szrj9Yra67YbZybQaDf6EZGSsQ8OZtzh2NJUBf83w>
X-ME-Proxy-Cause: dmFkZTF34l82022tRH/XgLve1GnCAagsK1/sNQ03J1wZMCaKRfCFCANyInDwpxNlKo26XL
    EXnDaIhvf6eeyj8SFpLxHe7kMLyAMTddf/VH/Rk//b+JdUzKpEnqhJ/mj6T6WBc3r6ZJE/
    Hr1v675783mYwdLtIr+rwnhjt9V2Sg0kW0Y2Oh+akYz5iWsSjkq3O4mWIO7qqzL2LqWlBu
    4qb3Nz76srjHiKLX7WGKMZWL03bhjvTx5w07iAecZ2+wGDzrZnOrFMya6obWUIWKlk9RXi
    ATp2I5KNGIOri6x7B1ZipZsHWqVLLL4aev/pKUNaysgOv1nDj7mFcdqRSD+T2EP7frLRsv
    8Qy6HfXNo1m7mksLt87ipPl4ki1auuDMK4Kp9yrA0g1mAqc+yYh58QXmf6d6DgnEgKzplp
    msKzZO/M85qPZX1GAIBUOILFRZLXVsnDA77MeLvhlJLj3tK/lv57jV+mQteJuFCARhAQqn
    fMkXi29yKz6M52+GnHW9ICmf3GObabAbXuoN8FxSSlaAtXAZ3692Mzpj7HX30U3w344rQn
    pVHh9bdf6hcA8C2X3J1fIOW0yOWU8KtM8+PYo3vCLpWXXCLmnjKoKN9G6CpPah9qTL7hpU
    O4BbXc8sdo9BwAlRVxefFqAOVHC944xIBgQ22v03hsGp7XWh7UqFEW1RREiw
X-ME-Proxy: <xmx:uYK_auaSNcZtKccyq_Qj3HZ4vX0DY2Lw0gO6idhHLm981NkMAKBbBg>
    <xmx:uYK_alol9wemW-MEmJEpNYmogTWJn2PeIjuykI2m91q7PQCuOGPmCA>
    <xmx:uYK_aj-wbKxI69o3B6RiaWcfspS32ac_OBqKUuQkY_THHLjg988Itw>
    <xmx:uYK_ak-usjvRru2jlrmjegKHb05RxDOukgz7v9PmrsbGvyibSViioA>
    <xmx:uYK_athn7PAC9XnOIO8McQmNehBj92ygJPmWjrK88l6kHPe5k10mUEUq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 06:08:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 211c414e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 2 Oct 2026 10:08:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 12:08:22 +0200
Subject: [PATCH 11/13] odb/source-files: extract reading alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-pks-odb-move-alternates-v1-11-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In the next commit we'll add a new callsite that wants to read
alternates without having a proper object database source for a given
alternate available to it. Prepare for this by extracting the logic into
a separate function that only requires an object directory path as
input.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 9389546b3e..6aaf625352 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -174,6 +174,24 @@ static int odb_source_files_create_on_disk(struct odb_source *source,
 	return ret;
 }
 
+static int read_alternates(const char *object_dir, struct strvec *out)
+{
+	struct strbuf buf = STRBUF_INIT;
+	char *path;
+
+	path = xstrfmt("%s/info/alternates", object_dir);
+	if (strbuf_read_file(&buf, path, 1024) < 0) {
+		warn_on_fopen_errors(path);
+		free(path);
+		return 0;
+	}
+	parse_alternates(buf.buf, '\n', object_dir, out);
+
+	strbuf_release(&buf);
+	free(path);
+	return 0;
+}
+
 static void odb_source_files_prepare(struct odb_source *source,
 				     enum odb_prepare_flags flags)
 {
@@ -364,20 +382,7 @@ static int odb_source_files_begin_transaction(struct odb_source *source,
 static int odb_source_files_read_alternates(struct odb_source *source,
 					    struct strvec *out)
 {
-	struct strbuf buf = STRBUF_INIT;
-	char *path;
-
-	path = xstrfmt("%s/info/alternates", source->path);
-	if (strbuf_read_file(&buf, path, 1024) < 0) {
-		warn_on_fopen_errors(path);
-		free(path);
-		return 0;
-	}
-	parse_alternates(buf.buf, '\n', source->path, out);
-
-	strbuf_release(&buf);
-	free(path);
-	return 0;
+	return read_alternates(source->path, out);
 }
 
 static int too_many_loose_objects(struct odb_source_files *files, int limit)

-- 
2.56.0.379.gc618271300.dirty

