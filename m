Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4618C20248
	for <e@80x24.org>; Fri, 15 Mar 2019 16:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfCOQJn (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 12:09:43 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:40288 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbfCOQJm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 12:09:42 -0400
Received: by mail-ed1-f52.google.com with SMTP id r23so8059630edm.7
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 09:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=5lNykcwodfX9EPMKFqfF9QHlf6cUwOW2lPGvIVw12Pc=;
        b=H/PdSDTZZ/fRwNX/im46AgI6P/Z2UT4xOaf9upDmNlT5B1HP+Es4EZaEeeqRPqqLJ0
         5/AO003SDabAVCu0ow7OyyBTKQ2TdOy2L5ka9ViOM/EiGS+fWNeR+gRVHUlz8EGr8qGa
         W3S+cnyiqM6PE4UFupBQ+IqM7UtgvdtSQwrc6089q+4qf4OiPlNz4kRrrYQXoN2hJry1
         AzgAZP1ep2/Z6zbeA8ZNTUCdVKsM94oRbMX7n1kzSHk4/Zdg+3K4IX3GA6OxubCVFzPX
         CrKelZCRWhdKuxy0p6NzC+2sepo6NSXiBzjuVNc14sWI5l69H2VAbrzBPQKvTIf9rKDE
         kUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=5lNykcwodfX9EPMKFqfF9QHlf6cUwOW2lPGvIVw12Pc=;
        b=lxvVEZB+Nyt2t42Rk4kTfNqOSHDWN44pUBXACpy7LAskAy/VCGoiyKe/BAfDqP9qZx
         6YaL8nCeJybAQK/dGuRG6sAxhZgXONutAhQDUr0d35tpiEZuqsz9WRMyWL+iDHvUm/Mx
         sZJZhXFGsYRzaw437QbGiGaGEo+MFwi6U9Lh+pYE+kwzZRbrFnEK8UJT7qvJh3BzE+iO
         2Pg8hZBmhKJXruBiCNfzgiZdgKwoBHgqy//2YnQQ9H8TyPRT+qJugrKyDnri1oTKiBAA
         p4CVVqxelNiZMLdiCsKClJNechShTDCsUkMwji7CxTo75Q7GcrKaAxJVMT6BsK+1iDTZ
         0Daw==
X-Gm-Message-State: APjAAAV2mahaw9gcW+hsDLlb2BtJyJk6DrrL/4l8jar3Ku3sdpndmtEs
        q4MZk+JON45DYu5MClSoP0Wn3NHWfn8=
X-Google-Smtp-Source: APXvYqyusEhPjMzOiUxMI2YwGISqdtg64t7msdv0s10hakpYx20QcyHUwv8BoX3eT9iBoeZ7qNsRCg==
X-Received: by 2002:a50:eb4c:: with SMTP id z12mr1428214edp.212.1552666180183;
        Fri, 15 Mar 2019 09:09:40 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id w9sm712484edq.71.2019.03.15.09.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 09:09:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git Mailing list <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [WIP PATCH/RFC] Use a higher range-diff --creation-factor for format-patch
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
Date:   Fri, 15 Mar 2019 17:09:39 +0100
Message-ID: <87y35g9l18.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just submittted
https://public-inbox.org/git/20190315155959.12390-1-avarab@gmail.com/
and for 8/8 had to tweak the creation factor to 80% due to having added
a large comment. Maybe something like the below makes more sense for
format-patch?

Also, the "Algorithm" section of git-range-diff describes how we'll try
to find a percentage similarity in the *diff*, but in this case I'm
fairly sure that e.g. a creation factor of 50 would do if it also
considered the commit message.

Maybe I'm just wrong and it does that already, but assuming I'm right in
my reading and it doesn't, was that ever considered? That should result
in fewer false "not the same patch" positives, but maybe if patches are
split up it'll screw things up in other ways.

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 1af85d404f5..67a4881a20f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -261,6 +261,10 @@ material (this may change in the future).
 	between the previous and current series of patches by adjusting the
 	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])
 	for details.
++
+Defaults to 90, whereas the linkgit:git-range-diff[1] default is
+60. It's assumed that you're submitting a new patch series & that we
+should try harder than normal to find similarities.

 --notes[=<ref>]::
 	Append the notes (see linkgit:git-notes[1]) for the commit
diff --git a/builtin/log.c b/builtin/log.c
index ab859f59041..ff340130826 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1843,7 +1843,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}

 	if (creation_factor < 0)
-		creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
+		creation_factor = RANGE_DIFF_CREATION_FACTOR_FORMAT_PATCH_DEFAULT;
 	else if (!rdiff_prev)
 		die(_("--creation-factor requires --range-diff"));

diff --git a/range-diff.h b/range-diff.h
index 08a50b6e98f..634112396d3 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -4,6 +4,7 @@
 #include "diff.h"

 #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
+#define RANGE_DIFF_CREATION_FACTOR_FORMAT_PATCH_DEFAULT 90

 /*
  * Compare series of commmits in RANGE1 and RANGE2, and emit to the
