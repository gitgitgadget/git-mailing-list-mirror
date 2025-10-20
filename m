Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF711EDA0B
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984402; cv=none; b=QB15TwhCiE6Yr9z0CQqZ3ipS8Nnxvsw55z1yAyrsDFmmQt/Qt6rVkTnQ+LZt6UcE4QCDaq8RKXPvYmXbKftF9Fxn7r8/c/DHhNJ175+yPVc01Oy4yRk8s1ezLi1io8Lvi5ssxIdRtKf1yDY/rsWOVWn0FoANJtlbkW45sGu6rvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984402; c=relaxed/simple;
	bh=r26HB3FYkwF7dmaARAK0VexdP1jNvCS0LSTWFWs8ANo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rNVrjuXdKL2dUpElaZM4i1cgiv1zM56irYS2OW+qGC+KUJt/hYW+ShRWJ0yAyM/KTof1XYVuprqiEwfgw7BHh7plT9qVEsL9tC3MjpqJ5sr4DZ7JBJW4T+CWBTTYzZeSVXzIJ/dBjIwrE8snKO30l7hS3eWlh16MkwxtF4hAu2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtQg71C9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtQg71C9"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-782e93932ffso3961081b3a.3
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 11:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760984399; x=1761589199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YQg0liU5OEtKyJv9j+5nMRGZd5g+DRAxqj5TIdr5HIU=;
        b=UtQg71C9wi2/g6msMyUsl/eujbN1LiV/iCz1J9gJibCTLAX4XdfMaY+SkPS9r9/xa4
         opqmetVoi0DXKDeDel5cy9EowDfkMOEOIKaleYevNaOCn3xQ62SRAfGFNMwjjdwoKLxn
         xR8+FxLZKni6/nGbOsmtq5gwX0KsUfSG4WniKakNwk7oITttgJCIqo7mGIUGEYBa87q+
         WlJ94ERfCaSXXC9lDBX83PErIpJlhqr1AID6SzarwCr8zNPFTmnVF29qJptkX/n40iLw
         07e5s/EeDro7XY1/NIAtikf32QhfSMmvsisedtQyCpcUPDbs9TgIv7Ij7W/SpBYj/WuV
         fYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760984399; x=1761589199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQg0liU5OEtKyJv9j+5nMRGZd5g+DRAxqj5TIdr5HIU=;
        b=TchJI5EnQzlPT7B77bMBOuwZyMHFbZil9710pmqebxL53FAHeTxnAYLSM/pqQ/abZv
         bFTZCB3E3SYpvLRacwOfpYXtFQMD8Ifzw0Nm2SvJeNZADbP6akpI2qleNerNXAhRNbJN
         XZuxBY1q0voElZaoBAnC4gfd41m1vkLF2Qd+XvK1tjt8rKSCtpPH5YrcZGUKVT56i9X4
         /ImFsxToPis4SRba3C98wt3AgpbGBsnPnmbmNyiHV7aZI98cZ+6j7sUA4D3t8OI3RJiy
         4IhMFl68qQRmB5D6qQ7sukbrF0zrW8a2iLoM5J2Oidew7iMKrOgr5Nin7E9x49HRdo/c
         b75Q==
X-Gm-Message-State: AOJu0YzhKDtFumcJuQgU3JwbEJqbf1U9bp7NUrtuB4dt43DS3jYkQmSj
	8hsA+szmN/Dr2c4GitrHHsZ48I3xW49h7tZrmmV48Arg4ECagy2y0QcAR1MTQhmO
X-Gm-Gg: ASbGncseWlqt+wGNjo//CuvXBQx0Cj72VIERQCwetraG2IUzmDgOavNFlMgEd78f8AZ
	XSICOaF5lo4QnqZPoA+Wsbj9UDvpsnZyZ92qkThInqvsHTnav/NSr6V/7VC6BBoTZLbOdv/WqTS
	sT1GVNCIdrFXQ/QsbnUciMTVlBqZ0j6uN+iLkOl+4L4nelnllF/10vNDpEHoqf/vwmjWre9XJJP
	ajnPjdSWABq8XevdY2Jo1hvd5YGJWsgFN3Wh0+9sLD/mQvkXSnz+oNWpj1IqQgH8N1CkRHXbH+B
	ItHZ8sT69hp2+KQ/z3Ffb2TsmgpG9zt7k5njNYvLkRCkYS2o1H1dRrZQjF/PDv+SMWUDjUhRKQI
	jbV0fKTDfe/kLThYCpszVzHus3qn8Ik4/Gkqk3gwXBw6YAFN8aly7Rpn/whKClgF62nOWfXdoSf
	VYnqMhrKfrACdUBHzb2uYGh48yZx6hg5KV2bZz4G8yrHo2U18ZkI12UHPwIVo=
X-Google-Smtp-Source: AGHT+IFlVb/1F9GZnGcaFfj+bC4MdYbrn5k5VZ00qhlFW/uW9q9fjsVS52nm9K6c+8JaEQNntsTt3A==
X-Received: by 2002:a05:6a20:1585:b0:334:89c6:cdf5 with SMTP id adf61e73a8af0-334a8610ac5mr19273672637.39.1760984399201;
        Mon, 20 Oct 2025 11:19:59 -0700 (PDT)
Received: from localhost.localdomain ([177.118.183.70])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76673a86sm8099382a12.10.2025.10.20.11.19.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Oct 2025 11:19:58 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 0/2] repo: add --all to repo-info
Date: Mon, 20 Oct 2025 13:19:45 -0300
Message-ID: <20251020181943.6314-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

The main change introduced in this v2 is that now 
`git repo info --all <some.key>` returns the values for all the
available keys plus the value of `<some.key>` (which will be
duplicated). If `<some.key>` is an invalid key, the command will proceed
the same way that it would do without the `--all` flag.

PS: Sorry for sending this v2 after a month. I've been really busy last
weeks, but I still want to finish this :-)

Here's the rangediff against v1:

-:  ---------- > 1:  5f72f07589 repo: factor out field printing to dedicated function
1:  94c7b835f0 ! 2:  b8158bb7b8 repo: add --all to git-repo-info
    @@ Metadata
      ## Commit message ##
         repo: add --all to git-repo-info
     
    -    Add a new flag `--all` to git-repo-info for requesting all the available
    -    keys. By using this flag, the user can retrieve all the values instead
    -    of searching what are the desired keys for what they wants.
    +    Add a new flag `--all` to git-repo-info for requesting values for all
    +    the available keys. By using this flag, the user can retrieve all the
    +    values instead of searching what are the desired keys for what they
    +    wants.
     
         Helped-by: Karthik Nayak <karthik.188@gmail.com>
         Helped-by: Patrick Steinhardt <ps@pks.im>
    @@ Documentation/git-repo.adoc: git-repo - Retrieve information about the repositor
      --------
      [synopsis]
     -git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
    -+git repo info [--format=(keyvalue|nul)] [-z] [--all] [<key>...]
    ++git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]
      
      DESCRIPTION
      -----------
    @@ Documentation/git-repo.adoc: THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHAN
      COMMANDS
      --------
     -`info [--format=(keyvalue|nul)] [-z] [<key>...]`::
    -+`info [--format=(keyvalue|nul)] [-z] [--all] [<key>...]`::
    ++`info [--format=(keyvalue|nul)] [-z] [--all | <key>...]`::
      	Retrieve metadata-related information about the current repository. Only
      	the requested data will be returned based on their keys (see "INFO KEYS"
      	section below).
      +
      The values are returned in the same order in which their respective keys were
     -requested.
    -+requested. The `--all` flag requests all keys.
    ++requested. The `--all` flag requests the values for all the available keys.
    ++Keys requested after `--all` will be duplicated.
      +
      The output format can be chosen through the flag `--format`. Two formats are
      supported:
    @@ builtin/repo.c
      
      static const char *const repo_usage[] = {
     -	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
    -+	"git repo info [--format=(keyvalue|nul)] [-z] [--all] [<key>...]",
    ++	"git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]",
      	NULL
      };
      
    -@@ builtin/repo.c: static get_value_fn *get_value_fn_for_key(const char *key)
    - 	return found ? found->get_value : NULL;
    - }
    - 
    -+static void print_field(enum output_format format, const char *key,
    -+			struct strbuf *valbuf, struct strbuf *quotbuf)
    -+{
    -+	strbuf_reset(quotbuf);
    -+
    -+	switch (format) {
    -+	case FORMAT_KEYVALUE:
    -+		quote_c_style(valbuf->buf, quotbuf, NULL, 0);
    -+		printf("%s=%s\n", key, quotbuf->buf);
    -+		break;
    -+	case FORMAT_NUL_TERMINATED:
    -+		printf("%s\n%s%c", key, valbuf->buf, '\0');
    -+		break;
    -+	default:
    -+		BUG("not a valid output format: %d", format);
    -+	}
    -+}
    -+
    - static int print_fields(int argc, const char **argv,
    - 			struct repository *repo,
    - 			enum output_format format)
    -@@ builtin/repo.c: static int print_fields(int argc, const char **argv,
    - 		}
    - 
    - 		strbuf_reset(&valbuf);
    --		strbuf_reset(&quotbuf);
    --
    - 		get_value(repo, &valbuf);
    --
    --		switch (format) {
    --		case FORMAT_KEYVALUE:
    --			quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
    --			printf("%s=%s\n", key, quotbuf.buf);
    --			break;
    --		case FORMAT_NUL_TERMINATED:
    --			printf("%s\n%s%c", key, valbuf.buf, '\0');
    --			break;
    --		default:
    --			BUG("not a valid output format: %d", format);
    --		}
    -+		print_field(format, key, &valbuf, &quotbuf);
    - 	}
    - 
    - 	strbuf_release(&valbuf);
     @@ builtin/repo.c: static int print_fields(int argc, const char **argv,
      	return ret;
      }
    @@ builtin/repo.c: static int repo_info(int argc, const char **argv, const char *pr
      
      	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
      
    -+	if (all_keys) {
    ++	if (all_keys)
     +		print_all_fields(repo, format);
    -+		return 0;
    -+	}
     +
      	return print_fields(argc, argv, repo, format);
      }
      
     
      ## t/t1900-repo.sh ##
    +@@ t/t1900-repo.sh: test_description='test git repo-info'
    + 
    + . ./test-lib.sh
    + 
    ++# git-repo-info keys. It must contain the same keys listed in the const
    ++# repo_info_fields, in lexicographical order.
    ++REPO_INFO_KEYS='
    ++	layout.bare
    ++	layout.shallow
    ++	object.format
    ++	references.format
    ++'
    ++
    + # Test whether a key-value pair is correctly returned
    + #
    + # Usage: test_repo_info <label> <init command> <repo_name> <key> <expected value>
     @@ t/t1900-repo.sh: test_expect_success 'git repo info uses the last requested format' '
      	test_cmp expected actual
      '
      
    -+test_expect_success 'git repo info --all returns all fields' '
    -+	git repo info layout.bare layout.shallow object.format references.format >expect &&
    ++test_expect_success 'git repo info --all returns all key-value pairs' '
    ++	git repo info $REPO_INFO_KEYS >expect &&
     +	git repo info --all >actual &&
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'git repo info --all <key> duplicates <key>' '
    ++	git repo info $REPO_INFO_KEYS object.format >expect &&
    ++	git repo info --all object.format >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'git repo info --all <invalid key> warns about invalid key' '
    ++	git repo info $REPO_INFO_KEYS >expect &&
    ++	echo "error: key ${SQ}no.key${SQ} not found" >expect_err &&
    ++	test_must_fail git repo info --all no.key >actual 2>actual_err &&
    ++	test_cmp expect actual &&
    ++	test_cmp expect_err actual_err
    ++'
     +
      test_done

Lucas Seiki Oshiro (2):
  repo: factor out field printing to dedicated function
  repo: add --all to git-repo-info

 Documentation/git-repo.adoc |  7 +++--
 builtin/repo.c              | 60 +++++++++++++++++++++++++++----------
 t/t1900-repo.sh             | 29 ++++++++++++++++++
 3 files changed, 78 insertions(+), 18 deletions(-)

-- 
2.50.1 (Apple Git-155)

