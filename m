Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDB0B20964
	for <e@80x24.org>; Thu, 23 Mar 2017 22:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932198AbdCWWuY (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 18:50:24 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34473 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755588AbdCWWuX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 18:50:23 -0400
Received: by mail-pg0-f67.google.com with SMTP id w20so13730727pgc.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 15:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5e071tpOGHt+favSPy9znfl5hbNEgoZ5uBH0YdtEMmM=;
        b=mTOTGFFbgZ6WoPpMHgpgsGJTf+Gh4uWi0jqqhX21aPz79eOZA146yp3banjmqRSdE/
         +KZhFtGgL1lcK+5JKCA1OCFHh3cR03+0YWJ6NJ1Xtp/b7LvX1FjkXthlCGY8gNpU2o/Y
         shPh0gMdXPRLtLQMFcYIZS5FlQmA5Cg4O5E7k6NCAgRd9K9z2X76XjmkvFlatd6AiWi0
         vnL4FaIZIdGt49cLQU0YCnOk6/yWpWIjM+x9saZaxFqCy4EdPZVdUG4PuEt6jvEIwzxP
         Dkleeaksu9bZc9l1zXhTVPQcH6Wze6GFc5s0zHJGDssrExkGLZSZQpVkQ5fUzzHL982L
         O53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5e071tpOGHt+favSPy9znfl5hbNEgoZ5uBH0YdtEMmM=;
        b=ld8AAoABJT6feYaiNDZ4/YkSbNfDXC7M7UGCnHxU/+VK9b4vU1fuBvgYJVp+Rdpf6E
         Mr4/MkFLAslx0TZwKUqReM6LK3f52WfKqTYj1tI8kdZMjkVze5PJHmKVapq1P6QXRZbD
         uj2UX5qb2zgg59Gosw6NEPsaa5mEUscZf89KH/y1WfenILu6p51hdvJJ3CrFi0Dhyvmi
         qr/0uFZ2ssty/5ojnVZyAHjhWCWw828sYInOM7o1GYuZN/+U+dMfk9jlVIOjO31n0Q5+
         qeSERb/CKrkh/EPqRX5gM3vVB9vDct9oG/msZrPCWBnQWcwcYR7blZLN9Hxb6ujHAFts
         Tiow==
X-Gm-Message-State: AFeK/H2ACNU2Y/8nSPxpEixhp7Leueb0DxaxnNOmCOjsWN17H1C69A0QTNwlexeTtjttQA==
X-Received: by 10.84.216.81 with SMTP id f17mr6571088plj.170.1490309421464;
        Thu, 23 Mar 2017 15:50:21 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:6c40:39b9:f9ab:ec6f])
        by smtp.gmail.com with ESMTPSA id d4sm312325pfb.104.2017.03.23.15.50.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 15:50:20 -0700 (PDT)
Date:   Thu, 23 Mar 2017 15:50:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 2/7] submodule.c: convert is_submodule_modified to use
 strbuf_getwholeline_fd
Message-ID: <20170323225019.GD20794@aiede.mtv.corp.google.com>
References: <CAGZ79kZP6JhgcFQ5+Ytc6LexpA7C4EwR-7C0QZkiWhfrRCpd6g@mail.gmail.com>
 <20170323223338.32274-1-sbeller@google.com>
 <20170323223338.32274-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323223338.32274-3-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Instead of implementing line reading yet again, make use of our beautiful
> library functions.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

This changes buffering behavior in two ways:

- by using strbuf_getwholeline_fd instead of strbuf_read, we avoid
  having to allocate memory for the entire child process output at
  once.  That is, we limit maximum memory usage (good).

- by using strbuf_getwholeline_fd instead of strbuf_read, we xread
  one byte at a time instead of larger chunks.  That means more
  overhead due to context switches (bad).

Some callers of getwholeline_fd need the one-byte-at-a-time thing to
avoid waiting too long for input, and in some cases the alternative is
deadlock.  We know this caller doesn't fall into that category because
it was doing fine slurping the entire file at once.  As the
getwholeline_fd API doc comment explains:

 * It reads one character at a time, so it is very slow.  Do not
 * use it unless you need the correct position in the file
 * descriptor.

Can this caller use xfdopen and strbuf_getwholeline instead to get
back the benefit of buffering (i.e., something like the below)?

Another consequence of switching to streaming is that we may close
before the child finishes.  Do we have to worry about handling SIGPIPE
in the child?  I haven't checked how this handles that --- a test
might be useful.

Thanks and hope that helps,
Jonathan

diff --git i/submodule.c w/submodule.c
index c1b7b78260..184d5739fc 100644
--- i/submodule.c
+++ w/submodule.c
@@ -1043,6 +1043,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
+	FILE *fp;
 	unsigned dirty_submodule = 0;
 	const char *git_dir;
 
@@ -1070,7 +1071,8 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	if (start_command(&cp))
 		die("Could not run 'git status --porcelain' in submodule %s", path);
 
-	while (strbuf_getwholeline_fd(&buf, cp.out, '\n') != EOF) {
+	fp = xfdopen(cp.out, "r");
+	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
 		if ((buf.buf[0] == '?') && (buf.buf[1] == '?')) {
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 			if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
@@ -1082,7 +1084,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 				break;
 		}
 	}
-	close(cp.out);
+	fclose(fp);
 
 	if (finish_command(&cp))
 		die("'git status --porcelain' failed in submodule %s", path);
