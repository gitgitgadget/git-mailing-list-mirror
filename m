Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47D4120314
	for <e@80x24.org>; Thu,  9 Mar 2017 04:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750930AbdCIEZO (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 23:25:14 -0500
Received: from mail-ot0-f182.google.com ([74.125.82.182]:35367 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdCIEZN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 23:25:13 -0500
Received: by mail-ot0-f182.google.com with SMTP id x37so49279910ota.2
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 20:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hZWW3GLHDWZj/uBSUdVQnUVQ/4ncyvGOtwNfMZSg69w=;
        b=C2WE0kkRPazN7kb+XG+rkWtv0cF4hdstJ5zyjhMxY8c8634RZu/nDKVr4XRLw7Lxus
         cilO8CjEYvShJbbkoddjIGpLWiuqWBGZe8UaCcRLBGnJcTFyuQOYTp52n7uB8Sr5oIoO
         haSycdblQSdaDASYRw2/UzpZAVcHUwaIgk5Yymb7jKRIdayOcw75xTYkzjCHwi9nrMq7
         9NBwGL5hY4Gmn08CCv0E9OPIQDIDI9U16kjvzg1yG9+c7aKBlJtxc9/hl+qGmUTpPKG+
         1ISJUAMxlU8sPxLQwaj0069T8ebNa30/hpIwLMaOGFm0umePR4MqDDvH5xZ2ZFmUJz8N
         ExLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hZWW3GLHDWZj/uBSUdVQnUVQ/4ncyvGOtwNfMZSg69w=;
        b=S69p3QP5xm6HqtolR7DnYxs7RdQYRoZoiSK8koy6t5P7jQdLQsHncgZw0rxUZNTccz
         7Ybci2ksP+L5QY+ImVPYHI3a77DreTA5/Z+dNpVyxz58YhCcUGDapws8fDeopRAqVE3B
         gZrKQgmwmJpsZd5mXUDkNHq9lbHLMOhjKaWY9aMLB1fRTrbGnqHlEdJ7zyl1IINdmVEr
         5Bqe9goRE2ObPTp51qXLPunwfdPQtjjpTWk8CDAD8z/PhW1DUroQsNsD2d/tPtFD5Dkz
         /4SHZ8TH9AA8FKf0zpjo/O5A4syT8oyH7glcYFnikES2tenUFJagERqvMPvsR4cLC5kn
         dMeg==
X-Gm-Message-State: AFeK/H2oPkS6u6ONqyjqAOVgiYHy2zOmaM4j3BL7pBOWB25EVpVBcZkt5oLFM0ayXB3yTquPBluptC75vEguZA==
X-Received: by 10.157.15.38 with SMTP id 35mr6239043ott.49.1489033467501; Wed,
 08 Mar 2017 20:24:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.25.235 with HTTP; Wed, 8 Mar 2017 20:24:27 -0800 (PST)
From:   Vedant Bassi <sharababy.dev@gmail.com>
Date:   Thu, 9 Mar 2017 09:54:27 +0530
Message-ID: <CACczA6V6t4f6TTT=CJfqsuCtbYuM1QNh8AgtOwqRt7pz4VMeRA@mail.gmail.com>
Subject: [PATCH][GSoc] Changed signed flags to unsigned type
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of my microproject :

Use unsigned integral type for collection of bits:
Pick one field of a structure that (1) is of signed integral type and
(2) is used as a collection of multiple bits. Discuss if there is a
good reason why it has to be a signed integral field and change it to
an unsigned type otherwise.

More ref: https://public-inbox.org/git/xmqqsiebrlez.fsf@gitster.dls.corp.google.com
http://stackoverflow.com/questions/29795170/usage-of-signed-vs-unsigned-variables-for-flags-in-c

I have found several structures where a signed int was used on flags
for bitwise & to check various cases.


diff --git a/bisect.h b/bisect.h

index a979a7f..4b562a8 100644

--- a/bisect.h

+++ b/bisect.h

@@ -16,6 +16,8 @@ extern struct commit_list *filter_skipped(struct
commit_list *list,



 struct rev_list_info {

        struct rev_info *revs;

+

+ // int flags changed to unsigned int

        unsigned int flags;

        int show_timestamp;

        int hdr_termination;

diff --git a/builtin/add.c b/builtin/add.c

index 9f53f02..1212eea 100644

--- a/builtin/add.c

+++ b/builtin/add.c

@@ -26,6 +26,8 @@ static int patch_interactive, add_interactive,
edit_interactive;

 static int take_worktree_changes;



 struct update_callback_data {

+

+ // flags supposed to be unsigned

        int flags;

        int add_errors;

 };

diff --git a/parse-options.h b/parse-options.h

index dcd8a09..ad180c9 100644

--- a/parse-options.h

+++ b/parse-options.h

@@ -107,7 +107,9 @@ struct option {

        const char *argh;

        const char *help;



-   int flags;

+ // int flags changed to unsigned

+

+ unsigned int flags;

        parse_opt_cb *callback;

        intptr_t defval;

 };

@@ -201,7 +203,10 @@ struct parse_opt_ctx_t {

        const char **out;

        int argc, cpidx, total;

        const char *opt;

-   int flags;

+

+ // int flags changed to unsigned

+

+ unsigned int flags;

        const char *prefix;

 };



-------

result : the changes were made in bisect.h , parse-options.h and  builtin/add.c

I have not yet  tested these changes.
