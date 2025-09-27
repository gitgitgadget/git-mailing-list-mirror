Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EE22BDC0C
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758984657; cv=none; b=lcjHZLJNcm0YwVaaD+LTpY9JQs8ACMYsBo//UnWcV+LGxqBg3d8tF7BcKGW2RmrdsxqmF5IiwiilpbDEz3TDe+T80Jink2VCRRrEh64XkPCqnhu7sgtsKSRi15e1wXoXPa5vf6ZS2NTWmZRAkPEKKCXlwd/84yuG9V9Ne0DPKx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758984657; c=relaxed/simple;
	bh=u/kHSd0yaA5GpBi3Z+GcpzwIlt8931BbwOsXQiiiaho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMaS6bnrBSrJjpDb2xsmTpSOJXYTbrXvWCSLyRRwkYI6vUFNe7cspvhS5EyT3KttcRmBvKDn5L/ZACn60IS1d+60FDUB3isTVm37PPNIUOflO2+w40SC/lK5ujTP9QcYNoFdTKFgeFKG7NN81ri8sauuYRI7tJiPIww6f07YTQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PojhdOKJ; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PojhdOKJ"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-63a1f3c0820so1700386eaf.2
        for <git@vger.kernel.org>; Sat, 27 Sep 2025 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758984654; x=1759589454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h76RI4r1Fq4GY4KJvg+t/ZFL4pY9TAPxTXa36a0zTEc=;
        b=PojhdOKJ+uFfWN33UAi0XeX6348/v40/HCMtNT0Ir9bpfAa7enknMEzkDi+OpS5alS
         PZuGOCPrNxPxd72yd7sC92Qrz6iB20MXCatxzr3C33kMcS61k6YP8B1BffAl2SVHDF9N
         KN7/pv5in+0DWPtfUXuJeHbJ6iK4hCLLu+FK0VWYZtILbX9ldfQXqghP12fdTgCVnkCq
         44/tXNRo5NabE49MNpVdev83roOTFhqvRmQV61XQOxaMzggBK+PJ6sSuQUlnNCNeXU81
         HpnTvjDV/ZC47uyvmTiAWvHo/HVyVW6Be06Zb4XdbvFrwByiZdamwcwTk6PjQmWBu5fY
         urYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758984654; x=1759589454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h76RI4r1Fq4GY4KJvg+t/ZFL4pY9TAPxTXa36a0zTEc=;
        b=fSZOdW7NCrd19+2QLx571/WkkKDkvpor/emKj+FJlOOZ7Df0z2j8NBurdJf+5KGuh1
         xg+gmt5kJuCtBS4GlKBAO/2oa3+zsr/viuAR/tg+cL8OeqOlid8alpD7NgKiUZAd0yqi
         dCb0InbTA4zrKXrq4hF6jjn2BIoCIgkpPAqZyBGsnfLkOIK6wPmGvumf/pozGD/Ql8dX
         90wD7KAetZDF4KchmU0rvmSyfv81mKphJgbemIPti7SCxbs9a72dxz+/wdLYF0OlfwVc
         gCQsAxVDZYd1cNDA0BBZk4CCilpPKSGUc6ovhybOBuoM04/3mSeeW17KRk6CvqsrhmGr
         AlNA==
X-Gm-Message-State: AOJu0YzXhBkFim2Na3lDM7lINHZQeV4FmTIZ9wafnhWzAYuMk3NHxmVK
	UdVbMIJS8/JQxJVTpOLA9Yaa8L8EzIYV41K0yUmsscu2IoOXROpwD3rK/JkcSQ==
X-Gm-Gg: ASbGnctYFSqpnfmafisKFKUn0+MCQTSbguM2QujTIjD+cA0furJ/o7JmSB+fDbdL7Q8
	qcRBGYoGw8pYdXj6ypJ84NrvA0lv5wPqNbddVZHYu1dWaEqyhLM88UR/yuoUEkh4Lj8p6eM/40Q
	Al0TuelpnByoGgU8Kg1JBQCMEid9weiR+FnEiQFpVIr00bkWRTOzQhF+uNk6oQ6epwYtpxhEZFc
	7f2I0Y36Le7ij3b9cjOE9RmWXDDUQy2KBcqrYvY2CSPrIAmGC4Wa745IF+muR8ZHw07BB0qrPNt
	kqZWqgFV5oz4AYuWbJFSAyp7Jan1JskskeKJQWDPoG7XXZo4D93qRS9req8WKWyc7XOsZkPXCSN
	Fl6P8y5djgQAQThl1E5E16QHaN/dI/goXWTbSfiaDgQ==
X-Google-Smtp-Source: AGHT+IF0devzhPe59lmQAE6AG4dGDdbL7vpyyZtxzIlnYU5xBs+nFRlCbWeHXsh1GJYAIOVSU5/Bmw==
X-Received: by 2002:a05:6808:7007:b0:43f:5fd8:ae30 with SMTP id 5614622812f47-43f5fd8b5afmr3445885b6e.30.1758984654129;
        Sat, 27 Sep 2025 07:50:54 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f51258cf1sm1345401b6e.29.2025.09.27.07.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 07:50:53 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 0/7] builtin/repo: introduce stats subcommand
Date: Sat, 27 Sep 2025 09:50:42 -0500
Message-ID: <20250927145049.723341-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250925232928.3846-1-jltobler@gmail.com>
References: <20250925232928.3846-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

The shape of a repository's history can have huge impacts on the
performance and health of the repository itself. Currently, Git lacks a
means to surface key stats/information regarding the shape of a
repository via a single command. Acquiring this information requires
users to be fairly knowledgeable about the structure of a Git repository
and how to identify the relevant data points. To fill this gap,
supplemental tools such as git-sizer(1) have been developed.

To allow users to more readily identify potential issues for a
repository, introduce the "stats" subcommand in git-repo(1) to output
stats for the repository that may be of interest to users. The goal of
this subcommand is to eventually provide similar functionality to
git-sizer(1), but in Git natively.

In this initial version, the "stats" subcommand only surfaces counts of
the various reference and object types in a repository. In a follow-up
series, I would like to introduce additional data points that are
present in git-sizer(1) such as largest objects, combined object sizes
by type, and other general repository shape information.

Some other general features that would be nice to introduce eventually:

- A "level of concern" meter for reported stats. This could indicate to
  users which stats may be worth looking into further.
- Links to OIDs of interesting objects that correspond to certain stats.
- Options to limit which references to use when evaluating the
  repository.

Changes since V3:

- Changed from using strlen() to utf8_strlen() to take into
  consideration that translatable strings may have characters that are
  more than one byte.

Changes since V2:

- Added clang-format patch to address false postive triggered in this
  series.
- Use varargs for stats_table_add() family of functions.
- Print to stdout directly instead of using strbuf.
- Add parse_option() earlier in the series.
- Use start_delayed_progress() instead of start_progress().
- Add test to validate --[no-]progress options.
- Some other small fixes.

Changes since V1:

- Translatable terms displayed in the table have formatting separated
  out.
- Squashed the `keyvalue` and `nul` output format patches into one.
- Added a progress meter to provide users with more feedback.
- Updated docs to outline to outline reported data in a bulleted list.
- Combined similar tests together to reduce repetitive setup.
- Added patch to improve ref-filter interface so we don't have to create
  a dummy patterns array.
- Many other renames and cleanups to improve patch clarity.

Thanks,
-Justin

Justin Tobler (7):
  builtin/repo: rename repo_info() to cmd_repo_info()
  ref-filter: allow NULL filter pattern
  clang-format: exclude control macros from SpaceBeforeParens
  builtin/repo: introduce stats subcommand
  builtin/repo: add object counts in stats output
  builtin/repo: add keyvalue and nul format for stats
  builtin/repo: add progress meter for stats

 .clang-format               |   2 +-
 Documentation/git-repo.adoc |  30 +++
 builtin/repo.c              | 374 +++++++++++++++++++++++++++++++++++-
 ref-filter.c                |   4 +-
 t/meson.build               |   1 +
 t/t1901-repo-stats.sh       | 129 +++++++++++++
 6 files changed, 534 insertions(+), 6 deletions(-)
 create mode 100755 t/t1901-repo-stats.sh

Range-diff against v3:
1:  ed04168562 = 1:  ed04168562 builtin/repo: rename repo_info() to cmd_repo_info()
2:  6aa76d1323 = 2:  6aa76d1323 ref-filter: allow NULL filter pattern
3:  02a3fcc5fb = 3:  02a3fcc5fb clang-format: exclude control macros from SpaceBeforeParens
4:  12cfbdc464 ! 4:  8ec9914886 builtin/repo: introduce stats subcommand
    @@ builtin/repo.c
      #include "strbuf.h"
     +#include "string-list.h"
      #include "shallow.h"
    ++#include "utf8.h"
      
      static const char *const repo_usage[] = {
      	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	size_t name_width;
     +
     +	strbuf_vaddf(&buf, format, ap);
    -+	formatted_name = strbuf_detach(&buf, &name_width);
    ++	formatted_name = strbuf_detach(&buf, NULL);
    ++	name_width = utf8_strwidth(formatted_name);
     +
     +	item = string_list_append_nodup(&table->rows, formatted_name);
     +	item->util = entry;
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	if (name_width > table->name_col_width)
     +		table->name_col_width = name_width;
     +	if (entry) {
    -+		size_t value_width = strlen(entry->value);
    ++		size_t value_width = utf8_strwidth(entry->value);
     +		if (value_width > table->value_col_width)
     +			table->value_col_width = value_width;
     +	}
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +{
     +	const char *name_col_title = _("Repository stats");
     +	const char *value_col_title = _("Value");
    -+	size_t name_title_len = strlen(name_col_title);
    -+	size_t value_title_len = strlen(value_col_title);
    ++	size_t name_title_len = utf8_strwidth(name_col_title);
    ++	size_t value_title_len = utf8_strwidth(value_col_title);
     +	struct string_list_item *item;
     +	int name_col_width;
     +	int value_col_width;
5:  ab27340d58 = 5:  584d35f2c7 builtin/repo: add object counts in stats output
6:  f69110224d = 6:  76975b2eab builtin/repo: add keyvalue and nul format for stats
7:  cff5e183bb = 7:  1105346a3c builtin/repo: add progress meter for stats

base-commit: ca2559c1d630eb4f04cdee2328aaf1c768907a9e
-- 
2.51.0.193.g4975ec3473b

