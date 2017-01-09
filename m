Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C0611FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 18:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758269AbdAISEW (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 13:04:22 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34441 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755316AbdAISEV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 13:04:21 -0500
Received: by mail-pg0-f44.google.com with SMTP id 14so32084599pgg.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 10:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sAy4/b3SWZ+tWBdo5NGYgN79LxsR8m4loBqkaqe0gyc=;
        b=Cy3da89Ye3s7sk6UPZhtm15UAwm8cNirix31wck6h2nZMJKprtiSC0gBvB4npPsZLc
         SOisKQpNDr0jKnTsz9F8r8AB0zv44Nev2eaeVYAe7qec1E+r4sKp7BpieUZ9mxZoyYWm
         t+X1Ets/vTvLcVJ0RKw9theL3ZAq/t91nK+tk/5K3UYxqKOF7odZa+l8tYWtSV8bDugN
         cWbb/vPZhGtjUxFM4ke7+NKMEZyBmfPA6CZ4nl0nUed2d9jfOf+ViLVewx9YUFzga4TJ
         V2iQhBUfTzvuJ/doHJ24TMmpvX9eTPNcjWTS9flK0xO9uu2SxbwwGZqq8al2F4WYL5oR
         T1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sAy4/b3SWZ+tWBdo5NGYgN79LxsR8m4loBqkaqe0gyc=;
        b=kpSJti/JXW6obrQiy4xtGk+oUd9ZBLEndWMD6Y91Lex7knBopJyuqJ0/XZJum1DwmY
         CxlabyoeVo8Bb2LWq8cbhgwBShWsbgyX+yLjimEkRPR1r3xtVXyvIM2MUV/aE6ZOoSQR
         Km5eqU7az6UfjR1zkDqLHXzy7ZnVBXEKt6GICJKTdxhMBYSqMTx/mD8QlWy4uVShbGTW
         Or23x0+o1VfMIcSCks4Ggyl2s2Esc1BP3Qs6+M2CJfos+P2FMN8mnwwy8o3zLomz1F4w
         yPWvehy5aHKj5T0MwCUSoiKesrBHwW4Q2U07QmQRyyjaQAliz9PkeX17OrchpobJ7fXb
         rydQ==
X-Gm-Message-State: AIkVDXK4mxrl5rSrUvk7fYFgoxFWuq1wT55MYN3Ad6mmIf2ucwsHmFIgSStOkFeAgJ+jj4hq
X-Received: by 10.99.24.92 with SMTP id 28mr46249494pgy.100.1483985060324;
        Mon, 09 Jan 2017 10:04:20 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:cb5:8f45:2d29:8a81])
        by smtp.gmail.com with ESMTPSA id 64sm181121396pfu.17.2017.01.09.10.04.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 10:04:19 -0800 (PST)
Date:   Mon, 9 Jan 2017 10:04:18 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, ramsay@ramsayjones.plus.com, tboegi@web.de,
        j6t@kdbg.org, pclouds@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v5 0/5] road to reentrant real_path
Message-ID: <20170109180418.GB62878@google.com>
References: <20170103190923.11882-1-bmwill@google.com>
 <20170104220124.145808-1-bmwill@google.com>
 <xmqqpojy1c49.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpojy1c49.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/07, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > changes in v5:
> > * set errno to ELOOP when MAXSYMLINKS is exceded.
> > * revert to use MAXSYMLINKS instead of MAXDEPTH.
> > * If the OS hasn't defined MAXSYMLINKS, use a fallback value of 32.
> >
> > Brandon Williams (4):
> >   real_path: resolve symlinks by hand
> >   real_path: convert real_path_internal to strbuf_realpath
> >   real_path: create real_pathdup
> >   real_path: have callers use real_pathdup and strbuf_realpath
> >
> > Johannes Sixt (1):
> >   real_path: canonicalize directory separators in root parts
> >
> 
> How does this relate to the 5-patch real_path: series that has been
> on 'next' since last year?

The only difference should be in the first patch of the series which
handles the #define a bit differently due to the discussion that
happened last week.

Here is the interdiff between v5 and 'origin/bw/realpath-wo-chdir':

diff --git a/abspath.c b/abspath.c
index 1d56f5ed9..fce40fddc 100644
--- a/abspath.c
+++ b/abspath.c
@@ -62,7 +62,9 @@ static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
 }
 
 /* We allow "recursive" symbolic links. Only within reason, though. */
-#define MAXSYMLINKS 5
+#ifndef MAXSYMLINKS
+#define MAXSYMLINKS 32
+#endif
 
 /*
  * Return the real path (i.e., absolute path, with symlinks resolved
@@ -139,6 +141,8 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 			strbuf_reset(&symlink);
 
 			if (num_symlinks++ > MAXSYMLINKS) {
+				errno = ELOOP;
+
 				if (die_on_error)
 					die("More than %d nested symlinks "
 					    "on path '%s'", MAXSYMLINKS, path);

-- 
Brandon Williams
