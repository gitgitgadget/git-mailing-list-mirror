Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A44501F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbeDIWqz (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:46:55 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34937 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbeDIWqz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:46:55 -0400
Received: by mail-pf0-f195.google.com with SMTP id u86so6616218pfd.2
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Dnspb9jGdQKcWRYVUGCOI34E2QuGddj82DoYgBSkqo=;
        b=mRUkdDf+PufSJjbbpL34D/ZSP/5ceInlBAdTRUPP6ow4yMTubPBFBSxSufiqpv4GUx
         txBqyo9lCLbyAUpJjLfyCceBud5huFZsRv9ikVo6GjkWdaaSZziAMlS0WXfOfzfbs/lN
         JbV9/7PBOqUqIytFNvjx5vWEmD/661kYkBukOrkexfqb0HmamJ4+5j9wVV11HWGN0UJI
         JDyThHVmisXlrY4ba7QZci2dRahlencjLBGcFvaM8PdSxWRF8fUHRqDhvRC5jQLrSXK+
         CEl+2X+Oou7Ctxt9yF087j2hCpC3KHISh4E8vmTS4y7sbrfC2ZDTKIN8T/jockHjICo1
         151A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Dnspb9jGdQKcWRYVUGCOI34E2QuGddj82DoYgBSkqo=;
        b=i3mPDhgDHBzA0CNHeY0iVjyarL3yRA5IyzM72AIpGnxh20PenbZ0vQhwklLBaT1LS/
         vQZWEy8WAOSHaju6iRyJ+gyMpEpYZOhqOE9tMnW5c5KBjsqqbIqQ+/5o8wdExwgWpkdJ
         VjMhgebGTVm3Nnk2+IG+ovj7wGFjs6HbrJ6MszQBnRjjPpMW7cZz/gugK+Qp8x5UJZ1w
         /qDbu+FVrJSbl7evkX+LyFTsC7GNCWb+/cB23p9g+nHFOjLHZ3bY3TO74zl4fss6U9Xj
         trnMhvH69k3D4mK/gUh2ViyiFF2cRDFU2wX5F982eO5lXlSi4fx+inKn75U+fHUNeZoB
         6m7w==
X-Gm-Message-State: AElRT7F4S8/N6nASiiK2WazstGuI+ojTp3YHNrrKR7D61kxwwKx+4lwj
        NhoaZnjFNY+LGZFt2JOxKv2xPXtWxRw=
X-Google-Smtp-Source: AIpwx49uA1enHZX12OYEhPbhdGyKWzKSdlgHhHL9To+3rQ0IWbQ5CbIVCUkanzeS0P1ZLMRXe49PRg==
X-Received: by 10.99.43.70 with SMTP id r67mr26843577pgr.422.1523314013789;
        Mon, 09 Apr 2018 15:46:53 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:1d66:22f3:ac1d:6007])
        by smtp.gmail.com with ESMTPSA id r75sm2540494pfb.98.2018.04.09.15.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 15:46:51 -0700 (PDT)
Date:   Mon, 9 Apr 2018 15:46:50 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, ericsunshine@sunshineco.com
Subject: [PATCH v7 0/2] builtin/config.c: support `--type=<type>` as
 preferred alias for `--type`
Message-ID: <20180409224650.GA34547@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328234719.595-1-me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is the seventh re-roll of my series to support '--type=<type>'
instead of '--<type>' in 'git-config(1)'.

Since v6, I have changed only the wording in
Documentation/git-config.txt, which Eric and I reached consensus upon in
a sub-thread [1]. Per Eric's suggestion, I have also included an
inter-diff between this re-roll and the one previous for easier
consumption.

I anticipate that since relatively little has changed since the last
re-roll, that this will be the final re-roll of this series. I apologize
that the re-roll count has gotten so high, though I am glad that we
hashed out the important details. I have a better idea of how to discuss
on this list without increasing the re-roll count so much.

Thanks in advance for your review :-).


Thanks,
Taylor

[1]: https://public-inbox.org/git/CAPig+cQXJuLWpxfwhQ98a23wfAAzKZpkOvqWBdXaKKHLiW-7Uw@mail.gmail.com/

Taylor Blau (2):
  builtin/config.c: treat type specifiers singularly
  builtin/config.c: support `--type=<type>` as preferred alias for
    `--type`

 Documentation/git-config.txt | 71 ++++++++++++++++++---------------
 builtin/config.c             | 76 +++++++++++++++++++++++-------------
 t/t1300-repo-config.sh       | 29 ++++++++++++++
 3 files changed, 117 insertions(+), 59 deletions(-)

Inter-diff (since v6):

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index b7686fcbe3..a1e3ffe750 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -38,12 +38,10 @@ existing values that match the regexp are updated or unset.  If
 you want to handle the lines that do *not* match the regex, just
 prepend a single exclamation mark in front (see also <<EXAMPLES>>).

-The `--type` option requests 'git config' to ensure that the configured values
-associated with the given variable(s) are of the given type. When given
-`--type`, 'git config' will ensure that the variable(s) are of the given type
-and convert the value to the canonical form. If no type specifier is passed, no
-checks or transformations are performed on the value. Callers may unset any
-pre-existing type specifiers with `--no-type`.
+The `--type=<type>` option instructs 'git config' to ensure that incoming and
+outgoing values are canonicalize-able under the given <type>.  If no
+`--type=<type>` is given, no canonicalization will be performed. Callers may
+unset an existing `--type` specifier with `--no-type`.

 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
--
2.17.0
