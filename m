Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165EC17C220
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945606; cv=none; b=gEMb/es1eb21svRss0HbYcRGhgtr49QKahJKBgq6Ngi5GzsmD6t5mnaTcUWnaO/d6/znRQssNM5acMhoU/cUfcSrvDPwIGyQc1yruPtN5X6XAmJorAdCWGsHtQamCHLUlKuLz5AlV607VvW3M46owT/jfo40xA7v0mNL+VuFbd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945606; c=relaxed/simple;
	bh=v9xQKwhcbp3Qjj56FRww2+HnisWHgFrc3sjzYE0tQ6s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=F3e0pbBoWRLAuLQjes1mUb9BWwKq7jDh5PYp0nKjxqdlnj321t+aWuW6l0m5Q3w9Qhawjwk0puT3gfnKq1vV/DbXrVENa6+hMVmxbqnY82EDx8R/l/Ruq8myo1P++wpUPyrctDV17Cb+xblCYXNJpOXP17HHaqhh7vyx3tL9Nek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7vXi1Di; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7vXi1Di"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-459d4d7c745so44384025e9.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754945603; x=1755550403; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2trcYk8TVmGlmC24UMBDj84s9eK7uggQc41/Vjo9PhE=;
        b=A7vXi1DieTdcpJ3xwN3NR32D8byC8RvsAHRoweEqF1CSnaQ7VxGaiKGySr1SIg0RAa
         Dpo8kZCQfhZ6zi0xC0Ou2bsdDKQgnB5dleNQ9mo8SpxcyOtsXeENeYkofGDju9cw8oGN
         yjjmFf6jobjcLKFCxq40OCJ4bFumJOLt9qdnA2SuJKK2v0LQ2OWgwd4S9evPdN2FsK1t
         Ez3mVm3xhL2jOCgOhIlnApaMm20X0jNekz75CQNll5wdw0K8k28zwqR11mG0XD8u7Zq3
         JQHYGupa5vHtXJ3osz/H/H3z6ea/YxYBBEd10Jg5wmKiuOGcbXLZxtgnuZr7rkzjXLd3
         TmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754945603; x=1755550403;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2trcYk8TVmGlmC24UMBDj84s9eK7uggQc41/Vjo9PhE=;
        b=Jo9jo28DhEuo2wrzIzNzXVL0wWRgarRm+Ht5bWqZz/GmePRgswNNQUpNQt9EgblXAe
         xDv1KmdML5sWv6e2Jy1Z/25Tq2VHrGjKgyoyiZ9YUx4+CKLvTgAgS3WTBeWBZYOoc03U
         f9PHoxKDT0rbHcOp2neRmiqOBp/5ZULCIToARPEwENdvMm0CWv3q2fXqsRuV6ryHm/6h
         QHzDmnTYUvwjD8Kz6hnY/1gUSae/U5axyT2C+6h4WSJeWG7eXqhKA25ECEPGxVqUGzQh
         P3jzqXYraumNBJEV5kAuWPf2GYCihKi+eP4KsSzBSASZKXIQRrrOolD8nA/tz5hn4C+H
         opVQ==
X-Gm-Message-State: AOJu0YzwGA4Qn8L267E1xMkQy25kfGk3tRdYwk3BZ7puvs12Af0OFJ8g
	xWA3+YwBIJqgn5xCyB2RWgDlQqPm3WQlrXz0+KkMvPOc7ym99G+sOy6lD/FFNg==
X-Gm-Gg: ASbGncuo9spk0ucnudZGGSD9OMAIiJAwh8tNjgvEltib2NclX5Kf9GmTFhmc3BhNBQZ
	UWS6KICwhGQEzW8JOGWwShWXqsaG7iEoD63v41TJwwas/S2c7GLGxPhjOJ3MxqzZ0TRTu/TKVTX
	zyeR5Du73ssMMUOcnB5/v+PVtR0zKCCCVAu0m4dmXmdXVMzdOLkHH1M4NoSMohYJ70gvaIncuHo
	cI7++CfOTsdpH/y8czlunEnZ+X3aGFmdgGg9IMyICduknalquibQDkXUaiSCmpEfHT4pKJqIvQ0
	xJzbaJc4z/PMwXzivrt8kNGUBMtnztaNxPVugHDpnyQD+fGOS+1mjbJ09tiRW6NZVcLEcKYXFCU
	86I7FkFBxv6ItrDJB+BLTSvqYQMpnuTao8g==
X-Google-Smtp-Source: AGHT+IF9JCKu/SpWphY7UhTVtGKySn8BTpt9tC2Xbtk5QnBC8BKJR3fXwktYQG4dXgHa5+LXYRD77w==
X-Received: by 2002:a05:600c:a085:b0:456:11cc:360d with SMTP id 5b1f17b1804b1-459f7a5d1f4mr120227775e9.9.1754945603002;
        Mon, 11 Aug 2025 13:53:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c51e2sm40652812f8f.32.2025.08.11.13.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:53:22 -0700 (PDT)
Message-Id: <pull.1945.v3.git.1754945600.gitgitgadget@gmail.com>
In-Reply-To: <pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
References: <pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 20:53:14 +0000
Subject: [PATCH v3 0/6] Introduce more doc linting
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Collin Funk <collin.funk1@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

Reviewing the documentation part of the last patches, it turns out that the
majority of my comments are related to the latest documentation guidelines
which are both easy to forget and almost trivial to automatically check.

This series implements the automatic tests for basic doc rules. At the
moment it conflicts with "[GSoC][PATCH v6 0/6] Add refs list subcommand" and
possibly with "[PATCH v4 0/9] refs: fix migration of reflog entries"

Changes since v1:

 * fix a small typo

Changes since v2:

 * extend range of check files for multiple entries in definition list
   entries
 * extend checks for new synopsis styles

Jean-Noël Avila (6):
  doc: test linkgit macros for well-formedness
  doc: check well-formedness of delimited sections
  doc: check for absence of multiple terms in each entry of desc list
  doc: check for absence of the form --[no-]parameter
  doc:git-for-each-ref: fix styling and typos
  doc lint: check that synopsis manpages have synopsis inlines

 Documentation/Makefile                        |  21 +-
 Documentation/RelNotes/1.6.2.4.adoc           |   1 +
 Documentation/blame-options.adoc              |   3 +-
 Documentation/diff-format.adoc                |   1 +
 Documentation/diff-options.adoc               |   3 +-
 Documentation/fetch-options.adoc              |  15 +-
 Documentation/git-am.adoc                     |   3 +-
 Documentation/git-backfill.adoc               |   3 +-
 Documentation/git-cat-file.adoc               |   6 +-
 Documentation/git-check-attr.adoc             |   3 +-
 Documentation/git-check-ignore.adoc           |   9 +-
 Documentation/git-check-ref-format.adoc       |   3 +-
 Documentation/git-checkout.adoc               |   2 +-
 Documentation/git-clone.adoc                  |  12 +-
 Documentation/git-commit-graph.adoc           |   3 +-
 Documentation/git-commit.adoc                 |   4 +-
 Documentation/git-config.adoc                 |   3 +-
 Documentation/git-difftool.adoc               |   9 +-
 Documentation/git-fast-import.adoc            |   5 +-
 Documentation/git-fmt-merge-msg.adoc          |   3 +-
 Documentation/git-for-each-ref.adoc           | 264 +++++++++---------
 Documentation/git-format-patch.adoc           |  12 +-
 Documentation/git-fsck.adoc                   |   9 +-
 Documentation/git-gc.adoc                     |   6 +-
 Documentation/git-http-fetch.adoc             |   5 +-
 Documentation/git-index-pack.adoc             |   3 +-
 Documentation/git-log.adoc                    |   6 +-
 Documentation/git-merge-tree.adoc             |   3 +-
 Documentation/git-multi-pack-index.adoc       |   3 +-
 Documentation/git-p4.adoc                     |   1 +
 Documentation/git-pack-objects.adoc           |   3 +-
 Documentation/git-pull.adoc                   |   3 +-
 Documentation/git-push.adoc                   |  18 +-
 Documentation/git-range-diff.adoc             |   3 +-
 Documentation/git-read-tree.adoc              |   3 +-
 Documentation/git-rebase.adoc                 |   2 +-
 Documentation/git-refs.adoc                   |  20 +-
 Documentation/git-reset.adoc                  |   3 +-
 Documentation/git-send-email.adoc             |  30 +-
 Documentation/git-send-pack.adoc              |   3 +-
 Documentation/git-submodule.adoc              |   6 +-
 Documentation/git-svn.adoc                    |   2 +
 Documentation/git-update-index.adoc           |  12 +-
 Documentation/git-upload-pack.adoc            |   3 +-
 Documentation/git-worktree.adoc               |  12 +-
 Documentation/gitprotocol-http.adoc           |   2 +-
 Documentation/gitsubmodules.adoc              |   3 +-
 Documentation/gitweb.conf.adoc                |   2 +-
 Documentation/lint-delimited-sections.perl    |  48 ++++
 Documentation/lint-documentation-style.perl   |  33 +++
 Documentation/lint-gitlink.perl               |   7 +
 Documentation/merge-options.adoc              |   3 +-
 Documentation/mergetools/vimdiff.adoc         |   8 +
 Documentation/scalar.adoc                     |  18 +-
 Documentation/technical/api-path-walk.adoc    |   5 +-
 .../long-running-process-protocol.adoc        |   1 +
 shared.mak                                    |   2 +
 57 files changed, 447 insertions(+), 232 deletions(-)
 create mode 100755 Documentation/lint-delimited-sections.perl
 create mode 100755 Documentation/lint-documentation-style.perl


base-commit: 112648dd6bdd8e4f485cd0ae11636807959d48be
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1945%2Fjnavila%2Fdoc_linting-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1945/jnavila/doc_linting-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1945

Range-diff vs v2:

 1:  e79bd6a67ef = 1:  e79bd6a67ef doc: test linkgit macros for well-formedness
 2:  322df2d8dde = 2:  322df2d8dde doc: check well-formedness of delimited sections
 3:  5806390052b ! 3:  4e0178218e8 doc: check for absence of multiple terms in each entry of desc list
     @@ Metadata
       ## Commit message ##
          doc: check for absence of multiple terms in each entry of desc list
      
     -    Due to portability issues, the script generate-configlist.sh was fixed to
     -    not use carriage returns in the output. However, the result is that it no
     -    longer correctly handles multiple terms in a single entry of the definition
     -    list.
     +    For simplifying automated translation of the documentation, it is better to
     +    only present one term in each entry of a description list of options. This
     +    is because most of these terms can automatically be marked as
     +    notranslatable.
      
     -    We now check that these entries do not exist in the documentation.
     +    Also, due to portability issues, the script generate-configlist.sh can no
     +    longer insert newlines in the output. However, the result is that it no
     +    longer correctly handles multiple terms in a single entry of definition
     +    lists.
      
     +    As a result, we now check that these entries do not exist in the
     +    documentation.
     +
     +    Reviewed-by: Collin Funk <collin.funk1@gmail.com>
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Documentation/Makefile ##
     @@ Documentation/Makefile: $(LINT_DOCS_DELIMITED_SECTIONS): .build/lint-docs/delimi
       lint-docs-delimited-sections: $(LINT_DOCS_DELIMITED_SECTIONS)
       
      +## Lint: Documentation style
     -+LINT_DOCS_DOC_STYLE = $(patsubst %.adoc,.build/lint-docs/doc-style/%.ok,$(MAN_TXT))
     ++LINT_DOCS_DOC_STYLE = $(patsubst %.adoc,.build/lint-docs/doc-style/%.ok,$(DOC_DEP_TXT))
      +$(LINT_DOCS_DOC_STYLE): lint-documentation-style.perl
      +$(LINT_DOCS_DOC_STYLE): .build/lint-docs/doc-style/%.ok: %.adoc
      +	$(call mkdir_p_parent_template)
     @@ Documentation/git-http-fetch.adoc: commit-id::
               pull.
       
      --a, -c, -t::
     -+-a::-c::
     ++-a::
     ++-c::
      +-t::
       	These options are ignored for historical reasons.
      +
 4:  03a8428849f = 4:  2b43e196ec0 doc: check for absence of the form --[no-]parameter
 5:  713c86dae92 = 5:  c32e74fad94 doc:git-for-each-ref: fix styling and typos
 6:  d57478ea5cd = 6:  8ec969fe4bd doc lint: check that synopsis manpages have synopsis inlines

-- 
gitgitgadget
