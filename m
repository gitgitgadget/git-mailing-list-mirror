Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F19481FA3
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667167; cv=none; b=evwYNhW4jSZomE3qmfAJWQIz3T8DRRIoNZwIy+Y3tuuLCP4+UlAq1QhE03/7DfPCv9hUQ4QoePEqb/4sTGHGdRFSoLXvb6CMsrQhSFpS7eWvFBeoJGfoHIYAloELvisTivqFRj70oXoFF++028yNIEAsiiZakorYSwB+YvGAkAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667167; c=relaxed/simple;
	bh=LDk9jhFTtzsHf0d9u3rqtSCE5oqVKezKY3pkUQxb6js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=soHu5vFjoG2alPtHwGaHmM0eFsGa/i8ZcIAsVtaFAJ77iCqGq+XXuM8Es8UjB2pKkuCsHlQG2agFWkymY15uBNsDbcmXYJceqE3vEbntcehOWLhcSsFflP9oi4vYuztJ4XnwIyhmvlfr9tLILgIOhExMK7M4gaJzkgvVlijz0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HfQKLXD2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iVEt5V9Y; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HfQKLXD2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iVEt5V9Y"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 06A2B1D0004F
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 25 Aug 2026 10:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787667164;
	 x=1787753564; bh=aCMRcS9HwxIREPILHYhXJ+EsYIAgxsC+gk4SmH4YKYw=; b=
	HfQKLXD2qSkiNxPP7zlgDg9z6eg8JWm4tWVnAzL3p6h5ftKA1aOVNRrY7hrccebM
	TEaQNsjVAwUxsAsVhpMxlsxvb6kAu2M3nKXSKiKl0FrQDaE7k9OfHDOgzoSVrWx1
	HUp6qATyImyvaMI8ijFWfitIOagiEt7zTnuPe6vZ7Gv3so2zxU71NVlFs7afJVJ9
	W1W4I0ZMicdtswl6jvJjv0YsEWFYMW4npkgtbfmFruNKMujGXvXgBQOs0WpF3H3y
	gL5+plWbV4NVAvUzdQ10m4srZA1KnmMYSUKOVqBRvp5fSAB4AMFnsvlEmjsP1utk
	fgabuGkk1h+Jv58nt1O2zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787667164; x=
	1787753564; bh=aCMRcS9HwxIREPILHYhXJ+EsYIAgxsC+gk4SmH4YKYw=; b=i
	VEt5V9Y7pWxV/E/Pitji3I6Cnb/nKktlncxTqBPkc7TXGCQ7gXyc1mKeuXp6JeDx
	d4a++1MnKZlEcq7TQQqOWkC2j3I8gOZakeA9J865WMamTpxnZuCTP229qz1MlMye
	IVXAbfcGeo/jc2frnZI/q2cGTdX4ShJb3UXwjPDgZFQRXWDzLNYyCejRJC9ae/NO
	mQIN9EQi5hX41Nll5NQebxjFGpMUlRWu+4AvmV0KrVTzo1MSxCXD1Lx3RSp+Uv2F
	h++V266Y2Tz2qkXSPAi/8qS4dTN82Re+cVV2ODCsD77IAIipAwEVGwdUdMz9POr1
	CsnHUOT2OUAypwKphbavQ==
X-ME-Sender: <xms:3KKNajYDYhwmXfC5Deb-bCZ1UGdwMT7CeHeUSyfGziI4nANC_oMJGA>
    <xme:3KKNapX2BZWWqMRSKHnck0dVNcVjT7su_ocdfjkw0yk37cqxtcfIW4XZ6WKndB3fG
    UJ1ShgbhwgsSaPSruTKoPyMp29OTCE80AQiQIkzZSnfi-uIUZ-XKkY>
X-ME-Received: <xmr:3KKNarlGktKMhXkAfztyCZpWxv8CWZUzQeutXje_MEjOMgXYso62A0ckxnaoNdotKijwmwk7lqk3jp1gNR2oA8lekqIKKZj0HnkyViFpGQ>
X-ME-Proxy-Cause: dmFkZTGPBdwbSbO06IkE+pgLK5uTczUziWqOH/uYnonJp+gR1K8s9KcJmzkNCHgJyCUUlT
    GIVTAYDD9iABWD0ngtRRNh+q8eMI6Mz2svbNVxcaYR8P93dtpnXukEnXiP+6Rd8wVnuHjA
    n4DhE/Ks6YesUECbn5dbB5cLGbVmxOsg0RgiRACzFD2T0hBG5tFm+D/ARGqI+bE/7v/e2Z
    8Ux8bIVApVmD8d95tIENQoJP02kWqXe8/Aj6NuXYnsNb1x7KOR61Rf6lTNYCrE0vNMhCPv
    XRuISTZqaYRuTW2MzYpaa/XyGleqgi6+SnJzpnlMNChsoFQ4jgHnxWyohNEhiF3k6c62qK
    gHXLuqXem+f4LBkUtAL5AnRAc9fO92sN4fLlLrPdAhWx35aRfuGDCon77rEwbAgk6AMxy3
    gQXl2B+kaMAICuN6ivcBXQ6SRKWpsy5+Tjic4Oa8pIenWyDJGv5tcQoRavGU9BxgprRRty
    LWP2YMRzV9sbxrUtv5IQYIZ3IIfgOhlvGgnIHY16jY36UoY/0lFIVxI9k5I0VO2b1zfJux
    da9F74NkJjCp7JWfII9MQmBbl9tsLTM/zWefb4fXyEzPjYN8mg49z3Y7UJd60+IrUNRqEZ
    aOvOsJDyjxTHmp9QOhjmtjwXh87EiPbsxtY1SuVdJU3RI8xXN2VoCcbE/R6A
X-ME-Proxy: <xmx:3KKNauzT0xz1S8aMhtoJLW8SV6oF8FJe8dNFytLFI-h7JMXEvUEYFg>
    <xmx:3KKNaug4TD1OAXDyLDYEBvfDsmj3uQeuFFENKAwd9C5MDSVnUqOzwA>
    <xmx:3KKNarWXH_wjWkd8p3BrnpOu3VNuUQE_qHP_fvqt6MuXtBuTPljvcg>
    <xmx:3KKNao0_m5uWEMKz56Ssu07OuRpOEc6P33MO7ZynHRP512ONbUixrg>
    <xmx:3KKNal72VOLC0TvDqD6ZdGrohSD2OyYVrctOx2HJPzEyzdoS17uX8nnB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 28dcef3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:12:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:11:53 +0200
Subject: [PATCH 4/8] builtin/clone: move setup of alternates for shared
 local clones
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-write-alternates-at-creation-time-v1-4-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When cloning a local repository with "--shared" we add that repository
to the new repository's alternates. This is done in `clone_local()`,
which is responsible for performing local clones.

Move the logic into `collect_alternates()` to unify our setup of
alternates. Furthermore, this will allow us to set up alternates right
at creation time of the object database.

Note that the logic for cloning a local repository with "--no-shared" is
not yet part of `collect_alternates()`. This will be handled in the next
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 8eae3ac7d9..08c8f5a94f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -220,7 +220,8 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
 	fclose(in);
 }
 
-static void collect_alternates(struct strvec *alternates)
+static void collect_alternates(struct strvec *alternates,
+			       const char *src_repo, bool is_local)
 {
 	if (option_required_reference.nr || option_optional_reference.nr) {
 		struct add_one_alternate_data data = {
@@ -234,6 +235,16 @@ static void collect_alternates(struct strvec *alternates)
 		for_each_string_list(&option_optional_reference,
 				     add_one_alternate, &data);
 	}
+
+	if (is_local) {
+		struct strbuf commondir = STRBUF_INIT;
+
+		get_common_dir(&commondir, src_repo);
+		if (option_shared)
+			strvec_pushf(alternates, "%s/objects", commondir.buf);
+
+		strbuf_release(&commondir);
+	}
 }
 
 static void mkdir_if_missing(const char *pathname, mode_t mode)
@@ -357,13 +368,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 
 static void clone_local(const char *src_repo, const char *dest_repo)
 {
-	if (option_shared) {
-		struct strbuf alt = STRBUF_INIT;
-		get_common_dir(&alt, src_repo);
-		strbuf_addstr(&alt, "/objects");
-		odb_add_to_alternates_file(the_repository->objects, alt.buf);
-		strbuf_release(&alt);
-	} else {
+	if (!option_shared) {
 		struct strbuf src = STRBUF_INIT;
 		struct strbuf dest = STRBUF_INIT;
 		get_common_dir(&src, src_repo);
@@ -1352,7 +1357,7 @@ int cmd_clone(int argc,
 		warning(_("--local is ignored"));
 
 	create_object_database(the_repository);
-	collect_alternates(&alternates);
+	collect_alternates(&alternates, path, is_local);
 
 	for (size_t i = 0; i < alternates.nr; i++)
 		odb_add_to_alternates_file(the_repository->objects, alternates.v[i]);

-- 
2.55.0.822.g20453c30eb.dirty

