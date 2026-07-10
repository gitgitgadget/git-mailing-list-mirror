Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B2543B3C3
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701688; cv=none; b=NE8gyNBYOhs+XcebQkXVVaTg5w/TNI2rzxzGNDT/7PNFAG4RkJB1t8hYDkSoHFX0Sed8/HPpg2zaoRBNVNP2dzU+IpSc3v9yuUR6nBhRerUqoKSGGqXlF+LoibmsuTamY0Iyb9wsTW2uoffTHhoRkeHnONM+K3efPGlwM2K3Xmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701688; c=relaxed/simple;
	bh=6k0kMfYnJmCwIdPkWssD5zEV/eauRPzgV77mGG1iYGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXCCruSWUYOQlHPt/eT+64dinuQSOuyQ2ZQWUGmwCPRmAnLCt2Ri3wcXgmaCxXWfUrQ7zI4YTH+afiYlmNCKsZ78g/sn4wLTkBuAcV+q20NfwcnJN9BRNhMHpBNzgSkK4Nw8a0Wb7Tm5OCLMZ3yC59H8Z/7ZNy2ga48ZUPliVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKkgVJ5W; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKkgVJ5W"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47defd0c1c5so811649f8f.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701684; x=1784306484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xDH1k+iBTJ9gcIBuqIu9IzburDWmK30cfWuLZdlEKtw=;
        b=DKkgVJ5WO5gGO5Cix05iCarhdC9pl9E33F/vmQulb/LatyuUDkweXGzr9B71eLEZR8
         At5uAu4firHRPLA1oLbu2cWQrtzMFNv2pF7Vaf9f46JeiivxDEYpRqzzRLre8jMpZp+1
         O/dAOv6FB3vkMg/EpwjcgMjHrXIqX3hOiu8oZVaSkl9zSt6YR3+PHZeU1jQqC6nuS23O
         7AtbdYB0Ps26kEem6mtxOvupxxhGdId00r3RjdapFJUje8mh7/TK9rUgQuWRmvNF0XUA
         KOmRFVYUzPCj1lC6JigIZpCVDOxKlv7C62DN6Jx6RjZEAn/LCN3dXvkhkqsmXJpWJpKn
         8Xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701684; x=1784306484;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDH1k+iBTJ9gcIBuqIu9IzburDWmK30cfWuLZdlEKtw=;
        b=iRHw+FR7Ei8H/+PWFKiFWlkD404aRzRWNLP6R8+xPK2+AI2qtD22weCj1L1ox5v9Xa
         Mvdk0ZKpEI6D8bME6nXilVQP8gg7zEHCxwck9Ge4GGNU2lYqkkhVroTVpUIFXbpsAxH+
         QGJjwFPw4oDebRwoB1DN7U2X6AOzXDMr8jlT+igb8uUw8WOj6SHKIVPyMoVSK0NM+Q3k
         XPPqCdVd8CXKsgbFU2HoKAalaCLs065RFfqDwZU6W85l/hKBAKLnlstc1yFGUVktPs9O
         w/Lz7pRwkM6cg2e1HGZqvSw/Nln8coaTQcMfIsK8AzgzxPlthzZEE21oOXZRgLsxVy/p
         /Qzw==
X-Gm-Message-State: AOJu0YyWbc6obajIXyV9mAPODswuOsz5PbduxvlgKKbdEnLRqydUHT+N
	Oz8Ol1UF08EUvd/kerlhnzqdkfJhKm2eaP8DU4PEABHaERYPTRrajbT+zALrOiFy
X-Gm-Gg: AfdE7ckCfOJw4qloc/vhayeDUBlshqY8BGzxCNgwckx5mz/2El3b3KXBhy+RO1p0gY6
	79aoP024lYFgZOgIBZ/8kT3eQMBVFchPjdRbaFocFABjrhbgtcdoIsjrYdGETS+nbG9KvjhrlA5
	DagmkbISSSA81fAFO0eMO4VvXWeGftRH60f+GABCLfngYJ+rXg7fv+Gbr99hlyX3EC5p0TwsPaJ
	/WrcLrp5z/lDeE2UbOmPdGxcU+Q525ELl1D5TttQmwR98AbEgun3aVddtceTaT2B8KlDROFbPc+
	PXBEFko8GCgU8B03O6ebORgQ2RVkOPdmErcngH0XW2PW0Vp/m5ylrvk+mf9v7LjAzko8XilIcSv
	JSX0r6VBoOGFglwXBWuRQo9aS/18sQyyT4xhOerewVzsPiDvtkHMRYjerAuMpbjG/Qy80LPzpVd
	Dy9ZEtj2d6NMPj5OoYOFIDStXoaPfrjUAqX+NQ3bU5xrDIrililrU+7N4AYuV6Dph3bTFVMLSwb
	oA0Lj836WOQpF+jjUWhV4hdrkLPUKDFLJnIOnt2OO40jx7hPL8RMU6pndHTmcpWBrioutKWilnj
	QW627mVKwr1urqejlGG/ZFRx08etvcPIc4Lfv1Zd1+ielurpUjCzg/Yc4Y8imByXWGCEc+aapSk
	WJC82Qbiczg==
X-Received: by 2002:a05:6000:25e3:b0:47f:28e2:d4c4 with SMTP id ffacd0b85a97d-47f28e2d640mr3054871f8f.2.1783701684470;
        Fri, 10 Jul 2026 09:41:24 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm63643639f8f.2.2026.07.10.09.41.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 09:41:24 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v16 02/13] cat-file: declare loop counter inside for()
Date: Fri, 10 Jul 2026 18:41:08 +0200
Message-ID: <20260710-ps-eric-work-rebase-v16-2-66e07b58a8fe@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
References: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
 <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

Some code used in this series declares variable i and only uses it
in a for loop, not in any other logic outside the loop.

Change the declaration of i to be inside the for loop for readability.
While at it, we also change its type from int to size_t where the
latter makes more sense.

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c | 13 ++++---------
 fetch-pack.c       |  3 +--
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 60869b8b37..26ad07b62c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -721,14 +721,12 @@ static void dispatch_calls(struct batch_options *opt,
 		struct strbuf *output,
 		struct expand_data *data,
 		struct queued_cmd *cmd,
-		int nr)
+		size_t nr)
 {
-	int i;
-
 	if (!opt->buffer_output)
 		die(_("flush is only for --buffer mode"));
 
-	for (i = 0; i < nr; i++)
+	for (size_t i = 0; i < nr; i++)
 		cmd[i].fn(opt, cmd[i].line, output, data);
 
 	fflush(stdout);
@@ -736,9 +734,7 @@ static void dispatch_calls(struct batch_options *opt,
 
 static void free_cmds(struct queued_cmd *cmd, size_t *nr)
 {
-	size_t i;
-
-	for (i = 0; i < *nr; i++)
+	for (size_t i = 0; i < *nr; i++)
 		FREE_AND_NULL(cmd[i].line);
 
 	*nr = 0;
@@ -765,7 +761,6 @@ static void batch_objects_command(struct batch_options *opt,
 	size_t alloc = 0, nr = 0;
 
 	while (strbuf_getdelim_strip_crlf(&input, stdin, opt->input_delim) != EOF) {
-		int i;
 		const struct parse_cmd *cmd = NULL;
 		const char *p = NULL, *cmd_end;
 		struct queued_cmd call = {0};
@@ -775,7 +770,7 @@ static void batch_objects_command(struct batch_options *opt,
 		if (isspace(*input.buf))
 			die(_("whitespace before command: '%s'"), input.buf);
 
-		for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
 			if (!skip_prefix(input.buf, commands[i].name, &cmd_end))
 				continue;
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 120e01f3cf..f13951d154 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1388,9 +1388,8 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	if (advertise_sid && server_supports_v2("session-id"))
 		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
 	if (server_options && server_options->nr) {
-		int i;
 		ensure_server_supports_v2("server-option");
-		for (i = 0; i < server_options->nr; i++)
+		for (size_t i = 0; i < server_options->nr; i++)
 			packet_buf_write(req_buf, "server-option=%s",
 					 server_options->items[i].string);
 	}

-- 
2.54.0
