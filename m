Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94F241F461
	for <e@80x24.org>; Thu, 11 Jul 2019 16:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfGKQJA (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 12:09:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40509 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfGKQJA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 12:09:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so6242756wmj.5
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+T9okLNkQm1yuy4ACzk+qLcigXOJEeodORFA9u/m8M=;
        b=B5JCOVk9kYp2nnpUC4H4vHhehFh4cavycqw1eDlpLMcOfxCUPUeRpD8TYbSgqXN/WL
         ke/5ifTKtpo/7JD0aWOJmfbKKrK7wraF3sxE/5g0c5i5krx+tOBQj4J65V+HY7sGg5u0
         9nXAn51WFbBx+qaEpgVlUDd601JGy9CSBGxLcGmonPfIsh5i/UE41ci7QjoTT/LrZqV+
         b6EnjSFmTzpqE4EWDYINTVDTSF6HTYAT4qE33GUKxkecSLkfrceRVUX4jTq/tAvIVOv1
         M+dZAnSr6ECHYiYoAEzr+Hg+tkh965nopCR1PlxC8Ah14fF2SsWNnPv7sKNnH7HFbxGO
         iyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+T9okLNkQm1yuy4ACzk+qLcigXOJEeodORFA9u/m8M=;
        b=b8/hYY78Z0UfslQjrx2Ocv2nsPlZjPz31bZU0fANkf+ieaQOQyZ4gRHgN/GUtnkZVs
         YG0mGmH7SpAwHjnnM9YKyLbDn4yimDCvdXrLiTaQOPM5UQUN//cq4wXF1FYK7L77PqtH
         EIDSCqdsQFcw6B2PSvdIsCSY2rwGpckQMiX8oJo61XhERtHj+58nd6vR8Rv3OkzjRrzJ
         VpWcmThnQThWNuu+NGQLeYiGd+vE4r66N+KOd0XmW9PIcCK45RO2cDl2czzrKIHzkjze
         DMHgm7kZRNuyefMATeqwk2J+RZLiqhE2SIKnUJvnJrGsOaUffQO+NmUA+xnw1xZzb6Od
         +8iw==
X-Gm-Message-State: APjAAAVTxU/6ta0wGJrYCnQTvB/ZCIjiWjx9UaVAkrnQnFJlOjNbIpc5
        lrbuNwidDzQOjRTMwG4qICVmu3PTNcM=
X-Google-Smtp-Source: APXvYqxcQXEs45j5Z87nv5bkO+icESVaoRleK7hJoTvPS0AHqUsPLo226NjFvyDQ+dAcN7ZGNn1aeA==
X-Received: by 2002:a1c:d107:: with SMTP id i7mr5210534wmg.92.1562861336234;
        Thu, 11 Jul 2019 09:08:56 -0700 (PDT)
Received: from localhost (host232-157-dynamic.24-79-r.retail.telecomitalia.it. [79.24.157.232])
        by smtp.gmail.com with ESMTPSA id l8sm10122395wrg.40.2019.07.11.09.08.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 09:08:55 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 00/14] output improvements for git range-diff
Date:   Thu, 11 Jul 2019 17:08:37 +0100
Message-Id: <20190711160851.14380-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190708163315.29912-1-t.gummerer@gmail.com>
References: <20190708163315.29912-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio for the comment on the previous round [1].  This round
reanmes the struct we're using in apply.c to 'struct gitdiff_data',
and updates the commit message of 7/14 to reflect the new name of the
renamed function.

[1]: https://public-inbox.org/git/20190708163315.29912-1-t.gummerer@gmail.com/

Thomas Gummerer (14):
  apply: replace marc.info link with public-inbox
  apply: only pass required data to skip_tree_prefix
  apply: only pass required data to git_header_name
  apply: only pass required data to check_header_line
  apply: only pass required data to find_name_*
  apply: only pass required data to gitdiff_* functions
  apply: make parse_git_diff_header public
  range-diff: fix function parameter indentation
  range-diff: split lines manually
  range-diff: don't remove funcname from inner diff
  range-diff: suppress line count in outer diff
  range-diff: add section header instead of diff header
  range-diff: add filename to inner diff
  range-diff: add headers to the outer hunk header

 apply.c                | 186 ++++++++++++++++++-----------------------
 apply.h                |  48 +++++++++++
 diff.c                 |   5 +-
 diff.h                 |   1 +
 range-diff.c           | 124 +++++++++++++++++++--------
 t/t3206-range-diff.sh  | 124 ++++++++++++++++++++++-----
 t/t3206/history.export |  84 ++++++++++++++++++-
 7 files changed, 409 insertions(+), 163 deletions(-)

Range-diff against v3:
 1:  ef2245edda =  1:  ef2245edda apply: replace marc.info link with public-inbox
 2:  94578fa45c =  2:  94578fa45c apply: only pass required data to skip_tree_prefix
 3:  988269a68e =  3:  988269a68e apply: only pass required data to git_header_name
 4:  a2c1ef3f5f =  4:  a2c1ef3f5f apply: only pass required data to check_header_line
 5:  0f4cfe21cb =  5:  0f4cfe21cb apply: only pass required data to find_name_*
 6:  07a271518d !  6:  42665e5295 apply: only pass required data to gitdiff_* functions
    @@ -28,7 +28,7 @@
      #include "rerere.h"
      #include "apply.h"
      
    -+struct parse_git_header_state {
    ++struct gitdiff_data {
     +	struct strbuf *root;
     +	int linenr;
     +	int p_value;
    @@ -42,7 +42,7 @@
      }
      
     -static int gitdiff_hdrend(struct apply_state *state,
    -+static int gitdiff_hdrend(struct parse_git_header_state *state,
    ++static int gitdiff_hdrend(struct gitdiff_data *state,
      			  const char *line,
      			  struct patch *patch)
      {
    @@ -51,7 +51,7 @@
      #define DIFF_NEW_NAME 1
      
     -static int gitdiff_verify_name(struct apply_state *state,
    -+static int gitdiff_verify_name(struct parse_git_header_state *state,
    ++static int gitdiff_verify_name(struct gitdiff_data *state,
      			       const char *line,
      			       int isnull,
      			       char **name,
    @@ -77,7 +77,7 @@
      }
      
     -static int gitdiff_oldname(struct apply_state *state,
    -+static int gitdiff_oldname(struct parse_git_header_state *state,
    ++static int gitdiff_oldname(struct gitdiff_data *state,
      			   const char *line,
      			   struct patch *patch)
      {
    @@ -86,7 +86,7 @@
      }
      
     -static int gitdiff_newname(struct apply_state *state,
    -+static int gitdiff_newname(struct parse_git_header_state *state,
    ++static int gitdiff_newname(struct gitdiff_data *state,
      			   const char *line,
      			   struct patch *patch)
      {
    @@ -95,7 +95,7 @@
      }
      
     -static int gitdiff_oldmode(struct apply_state *state,
    -+static int gitdiff_oldmode(struct parse_git_header_state *state,
    ++static int gitdiff_oldmode(struct gitdiff_data *state,
      			   const char *line,
      			   struct patch *patch)
      {
    @@ -103,7 +103,7 @@
      }
      
     -static int gitdiff_newmode(struct apply_state *state,
    -+static int gitdiff_newmode(struct parse_git_header_state *state,
    ++static int gitdiff_newmode(struct gitdiff_data *state,
      			   const char *line,
      			   struct patch *patch)
      {
    @@ -111,7 +111,7 @@
      }
      
     -static int gitdiff_delete(struct apply_state *state,
    -+static int gitdiff_delete(struct parse_git_header_state *state,
    ++static int gitdiff_delete(struct gitdiff_data *state,
      			  const char *line,
      			  struct patch *patch)
      {
    @@ -120,7 +120,7 @@
      }
      
     -static int gitdiff_newfile(struct apply_state *state,
    -+static int gitdiff_newfile(struct parse_git_header_state *state,
    ++static int gitdiff_newfile(struct gitdiff_data *state,
      			   const char *line,
      			   struct patch *patch)
      {
    @@ -129,7 +129,7 @@
      }
      
     -static int gitdiff_copysrc(struct apply_state *state,
    -+static int gitdiff_copysrc(struct parse_git_header_state *state,
    ++static int gitdiff_copysrc(struct gitdiff_data *state,
      			   const char *line,
      			   struct patch *patch)
      {
    @@ -141,7 +141,7 @@
      }
      
     -static int gitdiff_copydst(struct apply_state *state,
    -+static int gitdiff_copydst(struct parse_git_header_state *state,
    ++static int gitdiff_copydst(struct gitdiff_data *state,
      			   const char *line,
      			   struct patch *patch)
      {
    @@ -153,7 +153,7 @@
      }
      
     -static int gitdiff_renamesrc(struct apply_state *state,
    -+static int gitdiff_renamesrc(struct parse_git_header_state *state,
    ++static int gitdiff_renamesrc(struct gitdiff_data *state,
      			     const char *line,
      			     struct patch *patch)
      {
    @@ -165,7 +165,7 @@
      }
      
     -static int gitdiff_renamedst(struct apply_state *state,
    -+static int gitdiff_renamedst(struct parse_git_header_state *state,
    ++static int gitdiff_renamedst(struct gitdiff_data *state,
      			     const char *line,
      			     struct patch *patch)
      {
    @@ -177,7 +177,7 @@
      }
      
     -static int gitdiff_similarity(struct apply_state *state,
    -+static int gitdiff_similarity(struct parse_git_header_state *state,
    ++static int gitdiff_similarity(struct gitdiff_data *state,
      			      const char *line,
      			      struct patch *patch)
      {
    @@ -186,7 +186,7 @@
      }
      
     -static int gitdiff_dissimilarity(struct apply_state *state,
    -+static int gitdiff_dissimilarity(struct parse_git_header_state *state,
    ++static int gitdiff_dissimilarity(struct gitdiff_data *state,
      				 const char *line,
      				 struct patch *patch)
      {
    @@ -195,7 +195,7 @@
      }
      
     -static int gitdiff_index(struct apply_state *state,
    -+static int gitdiff_index(struct parse_git_header_state *state,
    ++static int gitdiff_index(struct gitdiff_data *state,
      			 const char *line,
      			 struct patch *patch)
      {
    @@ -204,7 +204,7 @@
       * into the next diff. Tell the parser to break out.
       */
     -static int gitdiff_unrecognized(struct apply_state *state,
    -+static int gitdiff_unrecognized(struct parse_git_header_state *state,
    ++static int gitdiff_unrecognized(struct gitdiff_data *state,
      				const char *line,
      				struct patch *patch)
      {
    @@ -212,7 +212,7 @@
      			    struct patch *patch)
      {
      	unsigned long offset;
    -+	struct parse_git_header_state parse_hdr_state;
    ++	struct gitdiff_data parse_hdr_state;
      
      	/* A git diff has explicit new/delete information, so we don't guess */
      	patch->is_new = 0;
    @@ -228,7 +228,7 @@
      		static const struct opentry {
      			const char *str;
     -			int (*fn)(struct apply_state *, const char *, struct patch *);
    -+			int (*fn)(struct parse_git_header_state *, const char *, struct patch *);
    ++			int (*fn)(struct gitdiff_data *, const char *, struct patch *);
      		} optable[] = {
      			{ "@@ -", gitdiff_hdrend },
      			{ "--- ", gitdiff_oldname },
 7:  9cb6732a5f !  7:  3068fda8a9 apply: make parse_git_header public
    @@ -1,9 +1,12 @@
     Author: Thomas Gummerer <t.gummerer@gmail.com>
     
    -    apply: make parse_git_header public
    +    apply: make parse_git_diff_header public
     
    -    Make parse_git_header a "public" function in apply.h, so we can re-use
    -    it in range-diff in a subsequent commit.
    +    Make 'parse_git_header()' (renamed to 'parse_git_diff_header()') a
    +    "public" function in apply.h, so we can re-use it in range-diff in a
    +    subsequent commit.  We're renaming the function to make it clearer in
    +    other parts of the codebase that we're talking about a diff header and
    +    not just any header.
     
         Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
    @@ -70,7 +73,7 @@
     +			  struct patch *patch)
      {
      	unsigned long offset;
    - 	struct parse_git_header_state parse_hdr_state;
    + 	struct gitdiff_data parse_hdr_state;
     @@
      	 * or removing or adding empty files), so we get
      	 * the default name from the header.
    @@ -100,7 +103,7 @@
     +	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, (*linenr)++) {
      		static const struct opentry {
      			const char *str;
    - 			int (*fn)(struct parse_git_header_state *, const char *, struct patch *);
    + 			int (*fn)(struct gitdiff_data *, const char *, struct patch *);
     @@
      			res = p->fn(&parse_hdr_state, line + oplen, patch);
      			if (res < 0)
 8:  76a11ce995 =  8:  781d054cab range-diff: fix function parameter indentation
 9:  6f70e7faa6 =  9:  68a2953310 range-diff: split lines manually
10:  6618cdff2c = 10:  8ae95d053b range-diff: don't remove funcname from inner diff
11:  2667df4fa5 = 11:  e572510c52 range-diff: suppress line count in outer diff
12:  47cd8c6733 = 12:  45605db760 range-diff: add section header instead of diff header
13:  f67fd5dd9a = 13:  89a27fbeaa range-diff: add filename to inner diff
14:  812893a5dc = 14:  8bee2c525f range-diff: add headers to the outer hunk header

-- 
2.22.0.510.g264f2c817a
