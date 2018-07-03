Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3AD1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 21:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeGCVv6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 17:51:58 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34722 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeGCVv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 17:51:58 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so6841616ois.1
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VWssgQXGnfVjqjtl7x3+cwlbypgoYK+tAIMTwnnlf/M=;
        b=iIoan3GZDfYF2S8WYhLIy1+EivzmkSIccNnDWYDzhj9sBnQ+F/V0S4ZSlimOb76Ltd
         Af750eOD0MFgdlGK6Em/CGxj7in0I4SEUbLQJa35Q+G3jYD/jsXkvl8Zgik2ePAp5Vnr
         TtIoKvulz+gvaXCER44a5wIU+A53Ayt34wuWSdNRllySzBF9rnosNiwxNVXrGKEPhLIX
         9iy3159Civ5r0lVpmjn35ZLkDgg3CTRKwYJii3EDiVVThEjYyFo8e5UPDPF1M82fHusp
         2n89P8iFk0qr7OJ3YpFfHD7H9r/M48Nc1TWdGCOX0GXYGC/7Zfe00tG8KxjHwv8b357S
         WH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VWssgQXGnfVjqjtl7x3+cwlbypgoYK+tAIMTwnnlf/M=;
        b=n8KyPBcu/dzOV2HYLkW+wxzuiO/qZ4c+QNiPmDFOmarV39dPxK+ziS3JyiEYW8TAaq
         pVZG7Y8RuPmQyiQJFpj+85RUzHoRb06/qT2XeyANli8JQSXp+SRXB2ujAGy6jc80s/tk
         RMrZjHNl7BBNtRVlUJOiF0U+2vYFDSUPxAVdxRypvQ4RYJYiA5Qpn0UAMWjyeKql/nl5
         oZmAMejNxcaAS1OQi7qCfz7Wwd2SRPKi1/0/Nnz7BoyA4oSrwLYlmDelOx9z+E7nXpJ1
         LmdcUPeD20uU/N+FkoBRQ1FtEnm9Q/zqpU3B6dnrUNfl3za+AM6WNnjKQKgV6KqLvXi/
         t2iA==
X-Gm-Message-State: APt69E3cRrhTlnJzk+KKaqlNVO9mD/jyqRedo8wL9Ughd9UL56r9Hxrq
        qgLrHN8WjcIqSP5/lCg2RHfXds9qdGM=
X-Google-Smtp-Source: AAOMgpfmt2QnfCZCiH3MYfx/jQp+qqrH4c6caOaZJfJyDnCE+M8M6n3dYZDI5ZAR7NKIVbr+JoW+Eg==
X-Received: by 2002:aca:d7d6:: with SMTP id o205-v6mr21493538oig.347.1530654715673;
        Tue, 03 Jul 2018 14:51:55 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id a74-v6sm1115748oih.14.2018.07.03.14.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 14:51:54 -0700 (PDT)
Date:   Tue, 3 Jul 2018 16:51:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v3 0/2] grep.c: teach --only-matching to 'git-grep(1)'
Message-ID: <cover.1530654455.git.me@ttaylorr.com>
References: <cover.1529961706.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529961706.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached here is a third re-roll of my series to teach 'git grep
--only-matching'. (I didn't mention it in the thread, but I _thought_
that twice would be enough, so I think Peff's advice about not counting
on anything being the final re-roll of something applies to my thoughts,
too ;-) ).

Since last time:

  - The second patch has been amended to include the full invocation of
    'git grep' (including `--column`, `--only-matching`, and
    `--line-number`) [1].

  - The second patch has been also amended to add the new option
    (`--only-matching`) to Documentation/git-grep.txt per [2].

An inter-diff is available below, and thanks as always for your review
:-).

Thanks,
Taylor

[1]: https://public-inbox.org/git/20180703143820.GC23556@sigill.intra.peff.net/
[2]: https://public-inbox.org/git/xmqq1sckoxk8.fsf@gitster-ct.c.googlers.com/

Taylor Blau (2):
  grep.c: extract show_line_header()
  grep.c: teach 'git grep --only-matching'

 Documentation/git-grep.txt |  6 ++-
 builtin/grep.c             |  6 +++
 grep.c                     | 91 ++++++++++++++++++++++++--------------
 grep.h                     |  1 +
 t/t7810-grep.sh            | 15 +++++++
 5 files changed, 85 insertions(+), 34 deletions(-)

Inter-diff (since v2):

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 0de3493b80..be13fc3253 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [(-O | --open-files-in-pager) [<pager>]]
 	   [-z | --null]
-	   [-c | --count] [--all-match] [-q | --quiet]
+	   [ -o | --only-matching ] [-c | --count] [--all-match] [-q | --quiet]
 	   [--max-depth <depth>]
 	   [--color[=<when>] | --no-color]
 	   [--break] [--heading] [-p | --show-function]
@@ -201,6 +201,10 @@ providing this option will cause it to die.
 	Output \0 instead of the character that normally follows a
 	file name.

+-o::
+--only-matching::
+  Output only the matching part of the lines.
+
 -c::
 --count::
 	Instead of showing every matched line, show the number of

--
2.18.0
