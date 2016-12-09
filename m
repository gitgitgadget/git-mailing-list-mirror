Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD111FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 20:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbcLIUEk (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 15:04:40 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33787 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbcLIUEj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 15:04:39 -0500
Received: by mail-pg0-f49.google.com with SMTP id 3so11048489pgd.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 12:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l0TIvMvf568jrsV4ItAbDc9ETYab/lKvg8JOxgRGQDs=;
        b=GVFJ6qlYTooS++FUsD3u3FRtWKt0F7LnmRbmIWPeCWJm7Tmmqijf5lq0AnEW5brSUh
         LBty1xluBD2e9BXRiWYgxFQ9Af1ejovpiOvN8orbmI+U/O7UAWs3DWrLE7Huoonk0HRU
         NtQvd6xy0mcWT5HJM8bhn3pOVAzPuOH9BHgAtV25PbjXmpxEgAEQf3HSChtEY7jqwngy
         3ZgZ50IS1H5QzzDrMqPqufoUNCaFsmZtXpMUNnZh8IEW4NeugWySjqFHJwMrR5x5JIxY
         PlFU2xMQ16/7rQB8FYzc9ZfjaALXr5UaQjMPjemnz0v7+mcpHeSBmgMTM2apWvtEq1ov
         Kgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l0TIvMvf568jrsV4ItAbDc9ETYab/lKvg8JOxgRGQDs=;
        b=SBtv5vYu3hyrnCswchIiqDw2EgAvP0eEiIXDmkyv3SAO8AMVtiiZrjcm3yMS6eURyK
         0QGs9mi0c4CXl3X3s5ipVo5AZkwZAkWzUIqCZQCMMtg8IlEdrqNyVNpkTdHbRTRaYz/u
         1dZDibGfRhfnL7rMGUSoXJouCun4RuAj2AlcX8YCIiI41BQwE5eUId/cBrNas36PFknE
         oZE+YTuy+UdVR/UbOnKC512cGsTu0lSlXwAMOkmwYqAVDnsJRvSTqui9uhSPX0/nSsHY
         wcTJkmGHdGOMGifa6BOgwkCeQaD2/fOvqHIoB5AUosVWXxeuY4Rl5v8wGmiRWX4kT/hT
         +LVw==
X-Gm-Message-State: AKaTC03fXHKzf+L0bAJVvbOj0J8CpDbfYoM978RZ9Po3UqQlcGJoCzVN8BFVWEXGIsrXvyCt
X-Received: by 10.84.142.131 with SMTP id 3mr159806698plx.124.1481313878361;
        Fri, 09 Dec 2016 12:04:38 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b541:bdf2:ef3a:110f])
        by smtp.gmail.com with ESMTPSA id l69sm59473124pfk.34.2016.12.09.12.04.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 12:04:37 -0800 (PST)
Date:   Fri, 9 Dec 2016 12:04:36 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, pclouds@gmail.com
Subject: Re: [PATCH v2 1/4] real_path: resolve symlinks by hand
Message-ID: <20161209200436.GD88637@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1481241494-6861-1-git-send-email-bmwill@google.com>
 <1481241494-6861-2-git-send-email-bmwill@google.com>
 <944a3e91-934a-7923-2b2a-639af81e707d@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <944a3e91-934a-7923-2b2a-639af81e707d@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09, Johannes Sixt wrote:
> Am 09.12.2016 um 00:58 schrieb Brandon Williams:
> >The current implementation of real_path uses chdir() in order to resolve
> >symlinks.  Unfortunately this isn't thread-safe as chdir() affects a
> >process as a whole and not just an individual thread.  Instead perform
> >the symlink resolution by hand so that the calls to chdir() can be
> >removed, making real_path one step closer to being reentrant.
> >
> >Signed-off-by: Brandon Williams <bmwill@google.com>
> >---
> > abspath.c | 183 +++++++++++++++++++++++++++++++++++++++++---------------------
> > 1 file changed, 122 insertions(+), 61 deletions(-)
> >
> >diff --git a/abspath.c b/abspath.c
> >index 2825de8..92f2a29 100644
> >--- a/abspath.c
> >+++ b/abspath.c
> >@@ -11,8 +11,38 @@ int is_directory(const char *path)
> > 	return (!stat(path, &st) && S_ISDIR(st.st_mode));
> > }
> >
> >+/* removes the last path component from 'path' except if 'path' is root */
> >+static void strip_last_component(struct strbuf *path)
> >+{
> >+	if (path->len > offset_1st_component(path->buf)) {
> >+		char *last_slash = find_last_dir_sep(path->buf);
> >+		strbuf_setlen(path, last_slash - path->buf);
> >+	}
> >+}
> 
> This implementation is not correct because when the input is "/foo",
> the result is "" when it should be "/". Also, can the input be a
> non-normalized path? When the input is "foo///bar", should the
> result be "foo" or would "foo//" be an acceptable result? I think it
> should be the former. find_last_dir_sep() returns the last of the
> three slashes, not the first one. Therefore, I've rewritten the
> function thusly:
> 
> static void strip_last_component(struct strbuf *path)
> {
> 	size_t offset = offset_1st_component(path->buf);
> 	size_t len = path->len;
> 	while (offset < len && !is_dir_sep(path->buf[len - 1]))
> 		len--;
> 	while (offset < len && is_dir_sep(path->buf[len - 1]))
> 		len--;
> 	strbuf_setlen(path, len);
> }
> 

Thanks for that catch.  So your rewrite takes the offset of the 1st
component and ensures that we don't cut that part off.  It first strips
all non directory separators and then all directory separators.  This
way "/foo////bar" becomes "/foo" and as you pointed out "/foo" would
become "/".  The offset would also take care of windows drive letters
and the like.  Looks good.  Thanks!

> >+		strbuf_addbuf(&resolved, &next);
> >+
> >+		if (lstat(resolved.buf, &st)) {
> >+			/* error out unless this was the last component */
> >+			if (!(errno == ENOENT && !remaining.len)) {
> 
> Perhaps it was easier to _write_ the condition in this way, but I
> would have an easier time to _read_ it when it is
> 
> 			if (errno != ENOENT || remaining.len) {
> 

Yes I did write it out weird, mostly because it made the most sense for
what I was trying to accomplish (add path components must exist, except
for the very last one).  I'm fine applying DeMorgan's since it looks a
little cleaner.

> >+
> >+			if (is_absolute_path(symlink.buf)) {
> >+				/* absolute symlink; set resolved to root */
> >+				int offset = offset_1st_component(symlink.buf);
> >+				strbuf_reset(&resolved);
> >+				strbuf_add(&resolved, symlink.buf, offset);
> >+				strbuf_remove(&symlink, 0, offset);
> 
> Good. I would have expected some kind of "goto repeat;" because when
> we encounter a symlink to an absolute path, most, if not all, work
> done so far is obsoleted. But I haven't thought too deeply about
> this.

It made the most sense to just reuse the same looping condition that
I already had in place.  Resetting the resolved string to be the root
component of the absolute symlink made it easy to "throw away" all the
old work to allow us to start from scratch again.

-- 
Brandon Williams
