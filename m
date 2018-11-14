Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF57F1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbeKNK1H (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:27:07 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38478 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731245AbeKNK1E (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 05:27:04 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAE0IbQv024221;
        Tue, 13 Nov 2018 16:26:03 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nr7by051r-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 13 Nov 2018 16:26:03 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 13 Nov 2018 16:25:56 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 13 Nov 2018 16:26:01 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 3C837221228F;
        Tue, 13 Nov 2018 16:26:01 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <larsxschneider@gmail.com>, <sandals@crustytoothpaste.net>,
        <peff@peff.net>, <me@ttaylorr.com>, <jrnieder@gmail.com>,
        <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 09/11] fast-import: remove unmaintained duplicate documentation
Date:   Tue, 13 Nov 2018 16:25:58 -0800
Message-ID: <20181114002600.29233-10-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.1063.g2b8e4a4f82.dirty
In-Reply-To: <20181114002600.29233-1-newren@gmail.com>
References: <20181111062312.16342-1-newren@gmail.com>
 <20181114002600.29233-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_17:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fast-import.c has started with a comment for nine and a half years
re-directing the reader to Documentation/git-fast-import.txt for
maintained documentation.  Instead of leaving the unmaintained
documentation in place, just excise it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 fast-import.c | 154 --------------------------------------------------
 1 file changed, 154 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 95600c78e0..555d49ad23 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1,157 +1,3 @@
-/*
-(See Documentation/git-fast-import.txt for maintained documentation.)
-Format of STDIN stream:
-
-  stream ::= cmd*;
-
-  cmd ::= new_blob
-        | new_commit
-        | new_tag
-        | reset_branch
-        | checkpoint
-        | progress
-        ;
-
-  new_blob ::= 'blob' lf
-    mark?
-    file_content;
-  file_content ::= data;
-
-  new_commit ::= 'commit' sp ref_str lf
-    mark?
-    ('author' (sp name)? sp '<' email '>' sp when lf)?
-    'committer' (sp name)? sp '<' email '>' sp when lf
-    commit_msg
-    ('from' sp commit-ish lf)?
-    ('merge' sp commit-ish lf)*
-    (file_change | ls)*
-    lf?;
-  commit_msg ::= data;
-
-  ls ::= 'ls' sp '"' quoted(path) '"' lf;
-
-  file_change ::= file_clr
-    | file_del
-    | file_rnm
-    | file_cpy
-    | file_obm
-    | file_inm;
-  file_clr ::= 'deleteall' lf;
-  file_del ::= 'D' sp path_str lf;
-  file_rnm ::= 'R' sp path_str sp path_str lf;
-  file_cpy ::= 'C' sp path_str sp path_str lf;
-  file_obm ::= 'M' sp mode sp (hexsha1 | idnum) sp path_str lf;
-  file_inm ::= 'M' sp mode sp 'inline' sp path_str lf
-    data;
-  note_obm ::= 'N' sp (hexsha1 | idnum) sp commit-ish lf;
-  note_inm ::= 'N' sp 'inline' sp commit-ish lf
-    data;
-
-  new_tag ::= 'tag' sp tag_str lf
-    'from' sp commit-ish lf
-    ('tagger' (sp name)? sp '<' email '>' sp when lf)?
-    tag_msg;
-  tag_msg ::= data;
-
-  reset_branch ::= 'reset' sp ref_str lf
-    ('from' sp commit-ish lf)?
-    lf?;
-
-  checkpoint ::= 'checkpoint' lf
-    lf?;
-
-  progress ::= 'progress' sp not_lf* lf
-    lf?;
-
-     # note: the first idnum in a stream should be 1 and subsequent
-     # idnums should not have gaps between values as this will cause
-     # the stream parser to reserve space for the gapped values.  An
-     # idnum can be updated in the future to a new object by issuing
-     # a new mark directive with the old idnum.
-     #
-  mark ::= 'mark' sp idnum lf;
-  data ::= (delimited_data | exact_data)
-    lf?;
-
-    # note: delim may be any string but must not contain lf.
-    # data_line may contain any data but must not be exactly
-    # delim.
-  delimited_data ::= 'data' sp '<<' delim lf
-    (data_line lf)*
-    delim lf;
-
-     # note: declen indicates the length of binary_data in bytes.
-     # declen does not include the lf preceding the binary data.
-     #
-  exact_data ::= 'data' sp declen lf
-    binary_data;
-
-     # note: quoted strings are C-style quoting supporting \c for
-     # common escapes of 'c' (e..g \n, \t, \\, \") or \nnn where nnn
-     # is the signed byte value in octal.  Note that the only
-     # characters which must actually be escaped to protect the
-     # stream formatting is: \, " and LF.  Otherwise these values
-     # are UTF8.
-     #
-  commit-ish  ::= (ref_str | hexsha1 | sha1exp_str | idnum);
-  ref_str     ::= ref;
-  sha1exp_str ::= sha1exp;
-  tag_str     ::= tag;
-  path_str    ::= path    | '"' quoted(path)    '"' ;
-  mode        ::= '100644' | '644'
-                | '100755' | '755'
-                | '120000'
-                ;
-
-  declen ::= # unsigned 32 bit value, ascii base10 notation;
-  bigint ::= # unsigned integer value, ascii base10 notation;
-  binary_data ::= # file content, not interpreted;
-
-  when         ::= raw_when | rfc2822_when;
-  raw_when     ::= ts sp tz;
-  rfc2822_when ::= # Valid RFC 2822 date and time;
-
-  sp ::= # ASCII space character;
-  lf ::= # ASCII newline (LF) character;
-
-     # note: a colon (':') must precede the numerical value assigned to
-     # an idnum.  This is to distinguish it from a ref or tag name as
-     # GIT does not permit ':' in ref or tag strings.
-     #
-  idnum   ::= ':' bigint;
-  path    ::= # GIT style file path, e.g. "a/b/c";
-  ref     ::= # GIT ref name, e.g. "refs/heads/MOZ_GECKO_EXPERIMENT";
-  tag     ::= # GIT tag name, e.g. "FIREFOX_1_5";
-  sha1exp ::= # Any valid GIT SHA1 expression;
-  hexsha1 ::= # SHA1 in hexadecimal format;
-
-     # note: name and email are UTF8 strings, however name must not
-     # contain '<' or lf and email must not contain any of the
-     # following: '<', '>', lf.
-     #
-  name  ::= # valid GIT author/committer name;
-  email ::= # valid GIT author/committer email;
-  ts    ::= # time since the epoch in seconds, ascii base10 notation;
-  tz    ::= # GIT style timezone;
-
-     # note: comments, get-mark, ls-tree, and cat-blob requests may
-     # appear anywhere in the input, except within a data command. Any
-     # form of the data command always escapes the related input from
-     # comment processing.
-     #
-     # In case it is not clear, the '#' that starts the comment
-     # must be the first character on that line (an lf
-     # preceded it).
-     #
-
-  get_mark ::= 'get-mark' sp idnum lf;
-  cat_blob ::= 'cat-blob' sp (hexsha1 | idnum) lf;
-  ls_tree  ::= 'ls' sp (hexsha1 | idnum) sp path_str lf;
-
-  comment ::= '#' not_lf* lf;
-  not_lf  ::= # Any byte that is not ASCII newline (LF);
-*/
-
 #include "builtin.h"
 #include "cache.h"
 #include "repository.h"
-- 
2.19.1.1063.g2b8e4a4f82.dirty

