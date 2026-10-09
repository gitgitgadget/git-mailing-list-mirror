Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4683CF698
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537220; cv=none; b=juRwZ03okwfwQIbd8lKv8oBJEB4IaakhyqcqEweLvIOYXs4iurJnkcx4rXNKlrKBsRFMR6kGKmkOur4vje4FrRoM0WgVlwr5ZrB+9RN81YyZi/XKBn9nWsl9VaQQYZ70v/0wPvj9oeE99hIHnweqYCVzwJP7hxWfPw3S7xBqbFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537220; c=relaxed/simple;
	bh=AdrOAiNDht1HwqqZnq448m4OC+h0N8j/y3gMyIqh3Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5bWVhSntjuf7uJZ6b2IK6+COl4jQP/2vZ6kzyNbFCoif4ydrn7Gfx5kgmd+QijilkzzvyqF4zU1l8EQVfOtk7hRM/p39MLH8U2e5iLJH6vBG7HLnRUz8qCd6WVMRyX8gackPaPj/F8CsnbEz9BX0nmRx35LzSqxTzMjwxpZbLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jX78C6fy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX78C6fy"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b0946c2c2so2787338f8f.3
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791537217; x=1792142017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sLVw4y2o7uyTExA8+1Eq4+qttxLgQjJL8/dGl8nftPQ=;
        b=jX78C6fynNE17L/yWxMwxOtkfpIWSDn4TWJTPyEHjaX/6VmY5PbiFjVoHHxlva8NAm
         yz+TQAhfTCLeXHNxb/zqx5OQQJfiyjLOhmVTDWbiXuZoKzTJAMNuvKptKP8wLjQhMm5y
         GDe3P1V7R4aIQXokRiusIh74+vGzQYA2jWEV97VFUf5e8Unu5i7fpQzaesd7M0cgYJLR
         p8Ybn8dXuVwGXoO1QCRZYu/8GFkwxhCOXX68UR0xjrAwox/gvg1QN4HzRX7yJEGipeKd
         pxUU3f28rm6dmzE++9LrWeQ+H8ghKXFRkZRSLFHsUWwJcOwbMRZMEAeXA7OB93rvycRF
         hsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791537217; x=1792142017;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sLVw4y2o7uyTExA8+1Eq4+qttxLgQjJL8/dGl8nftPQ=;
        b=W5rs4Xu9lAB1baNgAp8++mDfJOgRTLubhvBTQ+y+Z34sW5Jiga3gJI2FpUjUx3mO3C
         8zq3/S+f4fX4lXRS3v7Z9bkVD8YjHJlS8uLl2+sL1K7m0o/66lQSkVPyJqeuuxgpqSB6
         H2oi0sOuawIPSbYDx2Jgp7hXjSNS4F5RJHiGe/056uOR/cQxDVOSJGwp87sdnHipeIrb
         RiL5c1gwFPJzsurltv8BE5wHXcROVFBBizpQavWqqRcFMK/U9xOXJzMaWFxF5kaaGFgC
         2yv3XZ4c8w1XWLvZ5U/hdQKPY4hiXwF36IzICzWMeRN2doPVd0uSI35PhYl1emrAIgir
         6zIQ==
X-Gm-Message-State: AFq9FYKghHeSCqofmOGNHIyktoQhjO53VTQOzjcqOGtR23uVmziH7VXY
	MCHDbRFrW+GJSxIMkhvHds/tIiFbL7ONTepCtbSqqif+fr36ESsGe0TS/j+pwQ==
X-Gm-Gg: AYBFou002Mif/MFD2fTASQuHF8BgZGowOUr/KR3ChPh2rFZ9OwxdLILQx6Qvws7sCBH
	bUvJGh00c8fGEdrC21Y0/Yl7Q8ajNGlV+o+jRqA6/IlTlkREA72J+fcmm4eE3Hr8FGhyynqrupa
	f8SGuZxQNtYvevhwo3LnXdupajYGTbPubIi++O6oxE5oN77edKIwEaOlNOwBj+ToByLts28XSvu
	fM9W/AkKhEjMLMileMNQspXXI3wsuegUf8H5VxRA4pyU1NgK9/HhRJZSE1/k7T1zyHZzau+90cG
	y6nNdnlU1+fvD+MCFPink8+z8Jj6vsPGolX98VRRrMtfYRcW4OFnE1/etPDqfVTW31tOlqkwNTt
	3sGY2WyISj8Un5UcS9fLkQT5Mr4nuVci0hCVGv2riP9IhRt4jRuIRjmyEosJn0LvFMKmJU+G9yu
	HGBDgBBq34Vo7iqHFBFBs+ruDVwk9Je191nvth3NhKTczhyJMZIXqmLo0g7iqYd8LJ/u00pJzg1
	Q==
X-Received: by 2002:adf:e001:0:20b0:48b:efb:4a66 with SMTP id ffacd0b85a97d-48dba7b405bmr1698374f8f.6.1791537216776;
        Fri, 09 Oct 2026 02:13:36 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db93d6069sm2657813f8f.0.2026.10.09.02.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 02:13:36 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 0/2] checkout -m: recreate conflict labels
Date: Fri,  9 Oct 2026 10:13:23 +0100
Message-ID: <cover.1791537203.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When "git checkout -m <path>" recreates a merge conflict, it uses
the labels "base", "ours", "theirs", rather than the labels used by
the original merge. This short series teaches the ort machinery to
write the labels to ".git/MERGE_LABELS" when it switches to a merge
result containing conflicts, so that "git checkout -m" can then read
that file and use the same labels.

Thanks to Junio and Johannes for their comments.

Changes since V2:

 - only write ".git/MERGE_LABELS" when there are conflicts and added
   a check to an existing "checkout -m <branch>" test
 - change write_merge_labels() to take an array of labels
 - use a local variable to store the internal merge state when writing
   labels
 - use strbuf_detach() rather than xmemdupz() when reading labels
 - add a comment to say we ignore trailing cruft when reading the
   labels file

Changes since V1:

 - use strbuf_getline() rather than strbuf_read_file() to read labels
   so that the newline handling of the reading and writing sides match.

NB ".git/MERGE_LABELS" is still undocumented - I'm hoping to find time
to add some documentation for all the MERGE_* files in a future series.
Johannes suggested using an index extension to store the labels,
but as we already have MERGE_MODE, MERGE_RR and MERGE_MSG I think it
is easier just to add another file.

base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fconflict-labels%2Fv3
View-Changes-At: https://github.com/phillipwood/git/compare/3bc034112...182edb2e8
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/conflict-labels/v3


Phillip Wood (2):
  remove_branch_state: convert boolean argument to flags
  merge: remember conflict labels

 branch.c           | 17 ++++++++----
 branch.h           |  4 ++-
 builtin/checkout.c | 30 +++++++++++++++++----
 builtin/commit.c   |  1 +
 merge-ort.c        | 20 ++++++++++++++
 merge.c            | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 merge.h            |  3 +++
 path.c             |  1 +
 path.h             |  1 +
 repository.c       |  1 +
 repository.h       |  1 +
 sequencer.c        |  1 +
 t/t7201-co.sh      | 22 ++++++++++++++++
 13 files changed, 157 insertions(+), 11 deletions(-)

Range-diff against v2:
1:  86ef0f848a = 1:  86ef0f848a remove_branch_state: convert boolean argument to flags
2:  18bdf7df49 ! 2:  182edb2e88 merge: remember conflict labels
    @@ merge-ort.c: struct merge_options_internal {
      	struct string_list conflicted_submodules;
     +
     +	/* Copies of the labels used for conflict markers */
    -+	char *labels[3];
    ++	const char *labels[3];
      };
      
      struct conflicted_submodule_item {
    @@ merge-ort.c: void merge_switch_to_result(struct merge_options *opt,
      		}
      		trace2_region_leave("merge", "write_auto_merge", opt->repo);
     +
    -+		trace2_region_enter("merge", "write_merge_labels", opt->repo);
    -+		opt->priv = result->priv;
    -+		write_merge_labels(opt->repo, opt->priv->labels[0], opt->priv->labels[1],
    -+				   opt->priv->labels[2]);
    -+		opt->priv = NULL;
    -+		trace2_region_leave("merge", "write_merge_labels", opt->repo);
    ++		if (!result->clean) {
    ++			struct merge_options_internal *priv = result->priv;
    ++
    ++			trace2_region_enter("merge", "write_merge_labels", opt->repo);
    ++			write_merge_labels(opt->repo, priv->labels);
    ++			trace2_region_leave("merge", "write_merge_labels", opt->repo);
    ++		}
      	}
      	if (display_update_msgs)
      		merge_display_update_messages(opt, /* detailed */ 0, result);
    @@ merge.c: int checkout_fast_forward(struct repository *r,
      	return 0;
      }
     +
    -+int write_merge_labels(struct repository *r, const char *base,
    -+			  const char *ours, const char *theirs)
    ++int write_merge_labels(struct repository *r, const char *labels[3])
     +{
     +	FILE *f = fopen_or_warn(git_path_merge_labels(r), "w");
     +
     +	if (!f)
     +		return -1;
     +
    -+	fprintf(f, "%s\n%s\n%s\n", base, ours, theirs);
    ++	fprintf(f, "%s\n%s\n%s\n", labels[0], labels[1], labels[2]);
     +	if (fclose(f))
     +		return error_errno("could not write '%s'",
     +				   git_path_merge_labels(r));
     +
     +	return 0;
     +}
     +
    -+static char *parse_merge_label_line(struct strbuf *buf, FILE *fp)
    -+{
    -+	if (strbuf_getline(buf, fp) == EOF)
    -+		return NULL;
    -+
    -+	return xmemdupz(buf->buf, buf->len);
    -+}
    -+
    -+int read_merge_labels(struct repository *r,
    -+		      char **pbase, char** pours, char** ptheirs)
    ++static char *parse_merge_label_line(FILE *fp)
     +{
     +	struct strbuf buf = STRBUF_INIT;
    ++
    ++	if (strbuf_getline(&buf, fp) == EOF) {
    ++		strbuf_release(&buf);
    ++		return NULL;
    ++	}
    ++
    ++	return strbuf_detach(&buf, NULL);
    ++}
    ++
    ++int read_merge_labels(struct repository *r,
    ++		      char **pbase, char **pours, char **ptheirs)
    ++{
     +	char *base = NULL, *ours = NULL, *theirs = NULL;
     +	int ret = -1;
     +	FILE *fp = fopen(git_path_merge_labels(r), "r");
     +
     +	if (!fp)
     +		return -1;
     +
    -+	base = parse_merge_label_line(&buf, fp);
    ++	base = parse_merge_label_line(fp);
     +	if (!base)
     +		goto out;
     +
    -+	ours = parse_merge_label_line(&buf, fp);
    ++	ours = parse_merge_label_line(fp);
     +	if (!ours)
     +		goto out;
     +
    -+	theirs = parse_merge_label_line(&buf, fp);
    ++	theirs = parse_merge_label_line(fp);
     +	if (!theirs)
     +		goto out;
    ++	/* We ignore any trailing lines */
     +
     +	ret = 0;
     +	*pbase = base;
    @@ merge.c: int checkout_fast_forward(struct repository *r,
     +		free(theirs);
     +	}
     +	fclose(fp);
    -+	strbuf_release(&buf);
     +
     +	return ret;
     +}
    @@ merge.h: int checkout_fast_forward(struct repository *r,
      			  const struct object_id *from,
      			  const struct object_id *to,
      			  int overwrite_ignore);
    -+int write_merge_labels(struct repository *r,
    -+		       const char *base, const char *ours, const char *theirs);
    ++int write_merge_labels(struct repository *r, const char *labels[3]);
     +int read_merge_labels(struct repository *r,
     +		      char **base, char **ours, char **theirs);
      
    @@ sequencer.c: static int pick_commits(struct repository *r,
      		struct todo_item *item = todo_list->items + todo_list->current;
     
      ## t/t7201-co.sh ##
    +@@ t/t7201-co.sh: test_expect_success 'checkout -m with dirty tree' '
    + 
    + 	fill 0 1 2 3 4 5 6 7 8 >one &&
    + 	git checkout -m side >messages &&
    ++	test_path_is_missing .git/MERGE_LABELS &&
    + 
    + 	test "$(git symbolic-ref HEAD)" = "refs/heads/side" &&
    + 
     @@ t/t7201-co.sh: test_expect_success 'format of merge conflict from checkout -m' '
      	d
      	>>>>>>> local
-- 
2.56.0.134.g299a3c16181

