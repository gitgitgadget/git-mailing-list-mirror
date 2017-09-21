Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 247F420281
	for <e@80x24.org>; Thu, 21 Sep 2017 04:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdIUElj (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 00:41:39 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36220 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdIUEli (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 00:41:38 -0400
Received: by mail-pg0-f65.google.com with SMTP id d8so2806381pgt.3
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 21:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c3r/DIl2hXvmvlDEb7d2S1PLKv5PWeJKtf6l4MMs35g=;
        b=TUt/L+YLhdUGzZYP/RxHEbWFJp02DQi83ky+1ANxJqfD3UruxhHjWbVca3zi/wkGsI
         5+CYV1J+0X3+u0QZsMujNVttCZ2fRtcQmFFgeYN8gReUU2GBTINLOb0kGGhr752V3FIF
         CoblsnDyGzHNi3rBAqCy88LX0qVJC8H5Rm6vlC7rJHzu1AeueKI58rmsn6hHSk382zXE
         RDtRTY88v6lb8RNtt1LvN17NTtXA3FwqoUeYMCHDvLPFL9IiLaKBKfzdje2GdjeRltT1
         wCT7BT0LwITDeKzIs3Gsf0WMU2NS0gkpc1Dc2U2ZxNXGVJ4ES/DzvmfeqBRWoiuxzTTA
         fS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c3r/DIl2hXvmvlDEb7d2S1PLKv5PWeJKtf6l4MMs35g=;
        b=Vo7JhOxTrSod3C69a4VtfN3kU1DraGnwnbPoQax2sRK5X9VC0acyRL5DhYmPhloBZu
         YwwOUHMGFZqeTHAe8Br3ViggFOA7d937ZGRNWfQlD0d54CcIWQqM7duqAHIAGNAoD9BO
         MhvYNF0Oos9z5ejjYykAYcjxWiTsdaovU4aYF1qghT6bnmIzpL1BFCet+JSrWi2NJ60/
         +TKaukRH+lResIkZ6R0ngg0vLItpKUC9+q0T6nF/KpHaQth5iLJGlzIoK1o1uM2y+7/0
         1o4CC3RIOrir2cIZ5LfU1oLVCG6rxi79SIsCwLD6t6MvukkgvnC12ggBMpirVYtMQQIS
         kgQQ==
X-Gm-Message-State: AHPjjUhpyD03Y9ZopmMfCSwreVb8/DMVOLML/eMwXcdPBZiMIEp6B7wT
        TyNnnm3L1Hlw4Hi6CCpK1LY=
X-Google-Smtp-Source: AOwi7QDRIBQeETteoKjSwXYjPUfM0y0floG8lNuIO2SvEtJ9kyWHvlleVedSgyrpzmep+ccxXCt2kQ==
X-Received: by 10.98.135.194 with SMTP id i185mr4357326pfe.330.1505968897391;
        Wed, 20 Sep 2017 21:41:37 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:da9:ac38:cdcf:de91])
        by smtp.gmail.com with ESMTPSA id e27sm745016pfk.41.2017.09.20.21.41.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 21:41:36 -0700 (PDT)
Date:   Wed, 20 Sep 2017 21:41:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: replace "struct cmdline_pathspec" with
 argv_array
Message-ID: <20170921044112.GB91069@aiede.mtv.corp.google.com>
References: <1505936846-2195-4-git-send-email-martin.agren@gmail.com>
 <20170920202552.kkwhigmv7lq6cj3y@sigill.intra.peff.net>
 <20170920203659.xqy76bg5nfabvbfx@sigill.intra.peff.net>
 <20170920224826.GH27425@aiede.mtv.corp.google.com>
 <20170921030424.akqaou7tqj2updgr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921030424.akqaou7tqj2updgr@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, Sep 20, 2017 at 03:48:26PM -0700, Jonathan Nieder wrote:
>> Jeff King wrote:

>>> Subject: [PATCH] revision: replace "struct cmdline_pathspec" with argv_array
>>>
>>> We assemble an array of strings in a custom struct,
>>> NULL-terminate the result, and then pass it to
>>> parse_pathspec().
>>>
>>> But then we never free the array or the individual strings
>>> (nor can we do the latter, as they are heap-allocated when
>>> they come from stdin but not when they come from the
>>> passed-in argv).
[...]
>> Except... is the idea that this allows the strings from stdin to be
>> freed sooner, as soon as they have been parsed into a "struct
>> pathspec"?
>
> Well, no...the idea is that this is a function which leaks a bunch of
> memory, and we shouldn't have to think hard about how often its leak can
> be triggered or how severe it is. We should just fix it.

I forgot to say: thanks for writing such a pleasant patch.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> I certainly agree that the pathspec interface could use better
> documentation. Patches welcome? :)

Here's such a patch.

-- 8< --
Subject: pathspec doc: parse_pathspec does not maintain references to args

The command line arguments passed to main() are valid for the life of
a program, but the same is not true for all other argv-style arrays
(e.g.  when a caller creates an argv_array).  Clarify that
parse_pathspec does not rely on the argv passed to it to remain valid.

This makes it easier to tell that callers like "git rev-list --stdin"
are safe and ensures that that is more likely to remain true as the
implementation of parse_pathspec evolves.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 pathspec.c | 4 ----
 pathspec.h | 7 +++++++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index e2a23ebc96..cdefdc7cc0 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -526,10 +526,6 @@ static void NORETURN unsupported_magic(const char *pattern,
 	    pattern, sb.buf);
 }
 
-/*
- * Given command line arguments and a prefix, convert the input to
- * pathspec. die() if any magic in magic_mask is used.
- */
 void parse_pathspec(struct pathspec *pathspec,
 		    unsigned magic_mask, unsigned flags,
 		    const char *prefix, const char **argv)
diff --git a/pathspec.h b/pathspec.h
index 60e6500401..6420d1080a 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -70,6 +70,13 @@ struct pathspec {
  */
 #define PATHSPEC_LITERAL_PATH (1<<6)
 
+/*
+ * Given command line arguments and a prefix, convert the input to
+ * pathspec. die() if any magic in magic_mask is used.
+ *
+ * Any arguments used are copied. It is safe for the caller to modify
+ * or free 'prefix' and 'args' after calling this function.
+ */
 extern void parse_pathspec(struct pathspec *pathspec,
 			   unsigned magic_mask,
 			   unsigned flags,
-- 
2.14.1.821.g8fa685d3b7

