Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A35F9203E2
	for <e@80x24.org>; Fri, 19 Aug 2016 01:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754625AbcHSBBX (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:01:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:60233 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754623AbcHSBBW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:01:22 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 18 Aug 2016 11:26:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,541,1464678000"; 
   d="scan'208";a="1038019170"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by orsmga002.jf.intel.com with ESMTP; 18 Aug 2016 11:26:15 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v7 2/7] graph: add support for --line-prefix on all graph-aware output
Date:   Thu, 18 Aug 2016 11:26:03 -0700
Message-Id: <20160818182603.10772-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.217.g609f9e8.dirty
In-Reply-To: <CAGZ79kZeSwteU84-=GZ0cZDCJUf6=VrGzAiNqC_gx7DgTQX-8Q@mail.gmail.com>
References: <CAGZ79kZeSwteU84-=GZ0cZDCJUf6=VrGzAiNqC_gx7DgTQX-8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

On Thu, Aug 18, 2016 at 10:56 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Aug 17, 2016 at 5:51 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>> -                               /*
>> -                                * Add a newline after the commit message.
>> -                                *
>> -                                * Usually, this newline produces a blank
>> -                                * padding line between entries, in which case
>> -                                * we need to add graph padding on this line.
>> -                                *
>> -                                * However, the commit message may not end in a
>> -                                * newline.  In this case the newline simply
>> -                                * ends the last line of the commit message,
>> -                                * and we don't need any graph output.  (This
>> -                                * always happens with CMIT_FMT_ONELINE, and it
>> -                                * happens with CMIT_FMT_USERFORMAT when the
>> -                                * format doesn't explicitly end in a newline.)
>> -                                */
>> -                               if (buf.len && buf.buf[buf.len - 1] == '\n')
>> -                                       graph_show_padding(revs->graph);
>> -                               putchar('\n');
>> -                       } else {
>> -                               /*
>> -                                * If the message buffer is empty, just show
>> -                                * the rest of the graph output for this
>> -                                * commit.
>> -                                */
>> -                               if (graph_show_remainder(revs->graph))
>> -                                       putchar('\n');
>> -                               if (revs->commit_format == CMIT_FMT_ONELINE)
>> -                                       putchar('\n');
>> -                       }
>> +                       /*
>> +                               * Add a newline after the commit message.
>
> I wondered if it is my webmailer displaying things wrongly here so I checked
> it at public inbox, and fetched the mails and applied them.
>
> It seems to me as if this long comment is broken in indentation
> (i.e. you removed a blank ' ' directly in front of the '*' instead of a '\t' ?)
>

Yea it is indeed broken. Something like the following squash should fix it.
We could also re-flow the text if desired too, but I don't really see the
advantage.

8<-----

From 345bbaa47cc14aba7049738e99c3649e2c06748c Mon Sep 17 00:00:00 2001
From: Jacob Keller <jacob.keller@gmail.com>
Date: Thu, 18 Aug 2016 11:13:04 -0700
Subject: [PATCH] SQUASH: fix indentation of comment in builtin/rev-list.c

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/rev-list.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 1a75a83538f4..21cde8dd6b31 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -129,20 +129,20 @@ static void show_commit(struct commit *commit, void *data)
 			graph_show_commit_msg(revs->graph, stdout, &buf);
 
 			/*
-				* Add a newline after the commit message.
-				*
-				* Usually, this newline produces a blank
-				* padding line between entries, in which case
-				* we need to add graph padding on this line.
-				*
-				* However, the commit message may not end in a
-				* newline.  In this case the newline simply
-				* ends the last line of the commit message,
-				* and we don't need any graph output.  (This
-				* always happens with CMIT_FMT_ONELINE, and it
-				* happens with CMIT_FMT_USERFORMAT when the
-				* format doesn't explicitly end in a newline.)
-				*/
+			* Add a newline after the commit message.
+			*
+			* Usually, this newline produces a blank
+			* padding line between entries, in which case
+			* we need to add graph padding on this line.
+			*
+			* However, the commit message may not end in a
+			* newline.  In this case the newline simply
+			* ends the last line of the commit message,
+			* and we don't need any graph output.  (This
+			* always happens with CMIT_FMT_ONELINE, and it
+			* happens with CMIT_FMT_USERFORMAT when the
+			* format doesn't explicitly end in a newline.)
+			*/
 			if (buf.len && buf.buf[buf.len - 1] == '\n')
 				graph_show_padding(revs->graph);
 			putchar('\n');
-- 
2.10.0.rc0.217.g609f9e8.dirty

