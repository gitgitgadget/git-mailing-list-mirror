Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B092B9CC
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720366543; cv=none; b=spVPGzqa0XqMTjdB5lsRelWUNax00jEXpoPh8ta32eDq6o65hA0kHhRBETR4BqFWvrLDSok8VviT+MNe4rFLhI+1DPRc0Vi9WvDG13IH0SJD1/dmK6w611KjfGLycxf1kmzLUzKhAZDknx8NqTDM+92/eMN0nGm9WR614LjwoL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720366543; c=relaxed/simple;
	bh=V3m36Re1ooTp80ocGLmFt46FVw4P8VqYQ/1eFqtPP/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyRjVCKDXFhNlZ127u0a73U//fLr4e9DiNHTWCnIIS7KLyYhPquoVdO0tZ92AAbl7Uzeg4s/J7yWKrImpAr5GtlsRkyBK74nqPY31kmKd4P7gaqWpgmpoUrtZ8DqfsrRO6cEPhZqJ5mqp0kzdNzKJSJfsW0IQYmUhg8u7Q5XT+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=IEK950NL; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="IEK950NL"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77c7d3e8bcso266171866b.1
        for <git@vger.kernel.org>; Sun, 07 Jul 2024 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1720366538; x=1720971338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wex59E8kGPE7RlIVoLttDqI4qD1fgEoHiVicztBPGks=;
        b=IEK950NLEu3A4D1+q1PySO9PosXpliCRmr5HSbACCFHgM4/U2YnMaJ2zY8E8j0RRed
         WNJUwXnGZbKDqcWkCQm/C1Y+OLsTj9J2wJG7qYQmdmBbvpJIoWfI367UZ98vsoxRM5RR
         8fxGy9g0QBPCfyJRrcKrqUq7DMGM87+0QnOmimVQ2ksr3PvdNMaa6wRiPHGGKf5j3w57
         jkmsKZ14zrdZpnmVSEqXUUZf65mts5NSQLWvS829baqix9votov/Qqhzx1wvEc/u/lIq
         hU5gxVIISXvaIBKpcRDkh0OoMnjm0Z/pA5gedTpU2nZGxARkM/Pyl3BYo4ZuH/iZytSG
         Z6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720366538; x=1720971338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wex59E8kGPE7RlIVoLttDqI4qD1fgEoHiVicztBPGks=;
        b=b7+NHVArTAOGhhh10AYUeOa4Do6Dkc/cOdZ6WO9EAvsz99KpuxDWQC2bwv1FNi0bbs
         MZ71lTjU+41CyIGg3Bnxa+ClvY4CDoUf2O8lxBvpUWMwSHdXUWtfOnApmXmVdhV54rwG
         IFTwSjKD//dVqXFmdJoMQHj6Pw+dJGCtEac2WQ9GrPDvTipeJsmTS8L/GraxiogxzZkx
         2r24/mFJf7IRqRbuLRfAcLZPbh7fyKlRxe9WHGLun2fd++WJ8/dzg+J1tWr6n1t1SIqL
         bz6pxteSZnzz8rX3E7rhhcVRodoWRUztRE5U4/H9vZXLTKbz1YN/rFQ/vYnz0Adq8ZPM
         dbMg==
X-Gm-Message-State: AOJu0YzvE8kD4pcrcu73AbYa8LvqPtttxiEjqfEeINY22pnEc7MvA3Rh
	Ju1Tn5MzJThp3oPrACVby63mGBoxJ17kgQ49hEu/6ZSiOE+ecSBCTOmYZsy3EGJZpWFsF/QMwqB
	wQ1luj3G2
X-Google-Smtp-Source: AGHT+IEsFqHrnriji8jA5Q0pqsfnreTAPlLGM5NKHo/whcdv+P3idgThIxm5qDHjkRdOYhdQHuw6uA==
X-Received: by 2002:a17:907:72d0:b0:a77:c84b:5a60 with SMTP id a640c23a62f3a-a77c84b5b74mr615916266b.26.1720366538214;
        Sun, 07 Jul 2024 08:35:38 -0700 (PDT)
Received: from localhost.localdomain ([165.225.240.192])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77db2b70a3sm189178666b.81.2024.07.07.08.35.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Jul 2024 08:35:37 -0700 (PDT)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 3 1/1] parse-options: localize mark-up of placeholder text in the short help
Date: Sun,  7 Jul 2024 17:35:23 +0200
Message-ID: <20240707153526.97984-2-ash@kambanaria.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <xmqqttij86lc.fsf@gitster.g>
References: <xmqqttij86lc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i18n: expose substitution hint chars in functions and macros to
translators

For example (based on builtin/commit.c and shortened): the "--author"
option takes a name.  In source this can be represented as:

  OPT_STRING(0, "author", &force_author, N_("author"), N_("override author")),

When the command is run with "-h" (short help) option (git commit -h),
the above definition is displayed as:

  --[no-]author <author>    override author

Git does not use translated option names so the first part of the
above, "--[no-]author", is given as-is (it is based on the 2nd
argument of OPT_STRING).  However the string "author" in the pair of
"<>", and the explanation "override author for commit" may be
translated into user's language.

The user's language may use a convention to mark a replaceable part of
the command line (called a "placeholder string") differently from
enclosing it inside a pair of "<>", but the implementation in
parse-options.c hardcodes "<%s>".

Allow translators to specify the presentation of a placeholder string
for their languages by overriding the "<%s>".

In case the translator's writing system is sufficiently different than
Latin the "<>" characters can be substituted by an empty string thus
effectively skipping them in the output.  For example languages with
uppercase versions of characters can use that to deliniate
replaceability.

Alternatively a translator can decide to use characters that are
visually close to "<>" but are not interpreted by the shell.

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 parse-options.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 30b9e68f8a..06d962b00e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1070,11 +1070,17 @@ static int usage_argh(const struct option *opts, FILE *outfile)
 		!opts->argh || !!strpbrk(opts->argh, "()<>[]|");
 	if (opts->flags & PARSE_OPT_OPTARG)
 		if (opts->long_name)
-			s = literal ? "[=%s]" : "[=<%s>]";
+			s = literal ? "[=%s]" :
+			  /* TRANSLATORS: change `<>' to other characters or leave as is */
+			  _("[=<%s>]");
 		else
-			s = literal ? "[%s]" : "[<%s>]";
+			s = literal ? "[%s]" :
+			  /* TRANSLATORS: change `<>' to other characters or leave as is */
+			  _("[<%s>]");
 	else
-		s = literal ? " %s" : " <%s>";
+		s = literal ? " %s" :
+		  /* TRANSLATORS: change `<>' to other characters or leave as is */
+		  _(" <%s>");
 	return utf8_fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
 }
 
-- 
2.45.2

