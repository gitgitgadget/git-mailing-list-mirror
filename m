Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63C47202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 07:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932960AbdJQHMj (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 03:12:39 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:47334 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932931AbdJQHMh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 03:12:37 -0400
Received: by mail-io0-f196.google.com with SMTP id h70so1159373ioi.4
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 00:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GGceKGkniQlNJVhTjPBnh1OgYNc7Q6WvDpVtdCqWB6o=;
        b=TA/XnDHUsBugLO2r4sQ15dB8HAfHBJRi8nGbS3Wa8WKZFBy7IG85IoY9W471p5YkXB
         gfG5NGi4eocILcWEGZRqXmQ8lQgsoYB3eod36ebenb7/p/2V0IbP5Ifjr+aVCA1UX2TL
         FG50w6hODKz/xixXkuJuYgl8SAkKhb5t4Z6e6npxghZCMSJP5lG5r0MDW3IFAIxZB/TW
         M5vyyGstqRCM0OzOJqCZ9G2s8UGgDf/zp7CIQsWNUHiSXcNkMTo2l9wilYtCZuslU3yM
         og8FAPruuLGShD7+WkDQ/4psMt9JiBxFi4mt1x83s7fH5+kuu8/eUkW4wcuwPP8zjHsi
         l0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GGceKGkniQlNJVhTjPBnh1OgYNc7Q6WvDpVtdCqWB6o=;
        b=XJ3TrfogDDEoHYzJATWBb1+sNMiq1XRv4lbqYYxwo5i7rsRJO+gPg5QVVd69lo2DEu
         Tl3YQCmJAtDhfntAoD4JQqaEGHMnNUmWkrX+kR4FoK/3ewiX7vPJ73RyElhOotHQw/CT
         X3A/WbObQ739oXQfmuEJTAIUE1Jm5ZO42oL6EmopGNqjtgGy2YYKmFG4UmLsbzhieAsC
         74focjDblDmGID81pAzSlEzl/0DoOA8rBo7hGWP/q5onp2odIlJdLQ3jKXtZJisxPUFo
         Cd8Rrwwx9Koewri4T62V70R23ALlEnEQR0yUmMxSin7h9p4jG0rYIS4LvWTvZlRqwEk6
         ZFWg==
X-Gm-Message-State: AMCzsaWloI2Cv9YNHojkmb331awJ3ABVmXWKNkBGTGAppu+z2QjcOxVc
        quVdP6iMGHPCIc5Q93plaiM0bSEn
X-Google-Smtp-Source: ABhQp+SyWNr/uKc365Yhw5zaufW/W1W/V6tP6uCYmfVR0L/eX9xAh6CFDDsjRx+QrXEJqEMyudV2pw==
X-Received: by 10.107.138.204 with SMTP id c73mr15829645ioj.91.1508224356611;
        Tue, 17 Oct 2017 00:12:36 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b102sm4876459itd.19.2017.10.17.00.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Oct 2017 00:12:36 -0700 (PDT)
Date:   Tue, 17 Oct 2017 00:12:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Marko Kungla <marko.kungla@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH 3/3] check-ref-format doc: --branch validates and expands
 <branch>
Message-ID: <20171017071234.m6j4rqn6izdvla6d@aiede.mtv.corp.google.com>
References: <20170717172709.GL93855@aiede.mtv.corp.google.com>
 <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
 <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
 <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
 <20171016224512.6fhtce5anmff577b@sigill.intra.peff.net>
 <xmqqbml6r2js.fsf@gitster.mtv.corp.google.com>
 <20171017024203.6hqzy2paed6fyvym@sigill.intra.peff.net>
 <xmqqo9p6phxg.fsf@gitster.mtv.corp.google.com>
 <xmqq7evupemj.fsf@gitster.mtv.corp.google.com>
 <20171017070619.bdgvujmbw4uxvwle@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017070619.bdgvujmbw4uxvwle@aiede.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

"git check-ref-format --branch $name" feature was originally
introduced (and was advertised) as a way for scripts to take any
end-user supplied string (like "master", "@{-1}" etc.) and see if it
is usable when Git expects to see a branch name, and also obtain the
concrete branch name that the at-mark magic expands to.

Emphasize that "see if it is usable" role in the description and
clarify that the @{...} expansion only occurs when run from within a
repository.

[jn: split out from a larger patch]

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-check-ref-format.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 92777cef25..cf0a0b7df2 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -77,7 +77,14 @@ reference name expressions (see linkgit:gitrevisions[7]):
 
 . at-open-brace `@{` is used as a notation to access a reflog entry.
 
-With the `--branch` option, it expands the ``previous branch syntax''
+With the `--branch` option, the command takes a name and checks if
+it can be used as a valid branch name (e.g. when creating a new
+branch).  The rule `git check-ref-format --branch $name` implements
+may be stricter than what `git check-ref-format refs/heads/$name`
+says (e.g. a dash may appear at the beginning of a ref component,
+but it is explicitly forbidden at the beginning of a branch name).
+When run with `--branch` option in a repository, the input is first
+expanded for the ``previous branch syntax''
 `@{-n}`.  For example, `@{-1}` is a way to refer the last branch you
 were on.  This option should be used by porcelains to accept this
 syntax anywhere a branch name is expected, so they can act as if you
-- 
2.15.0.rc1.287.g2b38de12cc

