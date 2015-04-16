From: Jeff King <peff@peff.net>
Subject: Re: Issue: repack semi-frequently fails on Windows
 (msysgit) - suspecting file descriptor issues
Date: Thu, 16 Apr 2015 11:28:50 -0400
Message-ID: <20150416152849.GA30137@peff.net>
References: <20150416100359.GA19951@rhlx01.hs-esslingen.de>
 <552F98AC.5030603@virtuell-zuhause.de>
 <20150416113505.GA30818@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Andreas Mohr <andi@lisas.de>
X-From: msysgit+bncBDO2DJFKTEFBBNNKX6UQKGQEYP2RYNA@googlegroups.com Thu Apr 16 17:28:56 2015
Return-path: <msysgit+bncBDO2DJFKTEFBBNNKX6UQKGQEYP2RYNA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f189.google.com ([209.85.223.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBNNKX6UQKGQEYP2RYNA@googlegroups.com>)
	id 1Yilio-0004M5-9L
	for gcvm-msysgit@m.gmane.org; Thu, 16 Apr 2015 17:28:54 +0200
Received: by ierx19 with SMTP id x19sf10662645ier.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 16 Apr 2015 08:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=4CJq34ufXxeOEYcXmSD77P8lnHtQOD40XGsGQhBGz3E=;
        b=M+RvWmN23f+UNiVUR4RiUr0PsB0/x6gRkLapDU7S3gf01aa08QQnx4EXJ3Zi2bYYF+
         7+Rm6/FnX4w9u/ecfKXKaLRk/wxW16DjWlCm2Na4azJrs5M1ZKgz6YK/LbctT0cO62eP
         2BWGFXb6npRdbgGY5+I2ljwQXeFY7NvWP8z5+rdN5brXjx4DBrcrvSqlKpfXRxI1eqEW
         LWTzJrfYlTC5xk5Ayns/Fs/bo26EjwvAGV7jTI/XOe9wCcW1ODSGx7Wf8VGYenSkR21a
         jqIJXDQO5/Ca6uP2I5nYTa6Qte8PngSjKy02MStuQ+E8zxhO++0m1D1FR1EWtZ/cRcKa
         uIRA==
X-Received: by 10.50.30.197 with SMTP id u5mr114644igh.5.1429198133495;
        Thu, 16 Apr 2015 08:28:53 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.43.197 with SMTP id y5ls1828695igl.26.canary; Thu, 16 Apr
 2015 08:28:52 -0700 (PDT)
X-Received: by 10.66.230.228 with SMTP id tb4mr42021258pac.3.1429198132933;
        Thu, 16 Apr 2015 08:28:52 -0700 (PDT)
Received: from cloud.peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id u2si811687igh.0.2015.04.16.08.28.52
        for <msysgit@googlegroups.com>;
        Thu, 16 Apr 2015 08:28:52 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 5950 invoked by uid 102); 16 Apr 2015 15:28:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 10:28:52 -0500
Received: (qmail 25728 invoked by uid 107); 16 Apr 2015 15:29:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 11:29:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 11:28:50 -0400
Content-Disposition: inline
In-Reply-To: <20150416113505.GA30818@rhlx01.hs-esslingen.de>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted
 sender) smtp.mail=peff@peff.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267296>

On Thu, Apr 16, 2015 at 01:35:05PM +0200, Andreas Mohr wrote:

> I strongly suspect that git's repacking implementation
> (probably unrelated to msysgit-specific deviations,
> IOW, git *core* handling)
> simply is buggy
> in that it may keep certain file descriptors open
> at least a certain time (depending on scope of implementation/objects!?)
> beyond having finished its operation (rename?).

Hrm. I do not see anything in builtin/fetch.c that closes the packfile
descriptors before running "gc --auto". So basically the sequence:

  1. Fetch performs actual fetch. It needs to open packfiles to do
     commit negotiation with other side (the hard work is done
     by an index-pack subprocess, but it is likely we have to access
     _some_ objects).

  2. The packfiles remain open and mmap'd (at least on Linux) in the
     sha1_file.c:packed_git list.

  3. We spawn "gc --auto" and wait for it to finish. While we are
     waiting, the descriptors are still open, but "gc --auto" will not be
     able to delete any packs.

But this seems too simple to be the problem, as it would mean that just
about any "gc --auto" that triggers a full repack would be a problem (so
anytime you have about 50 packs). But maybe the gc "autodetach" behavior
means it works racily.

I was able to set up the situation deterministically by running the
script below:

-- >8 --
#!/bin/sh

# XXX tweak this setting as appropriate
PATH_TO_GIT_BUILD=$HOME/compile/git
PATH=$PATH_TO_GIT_BUILD/bin-wrappers:$PATH
rm -rf parent child

# make a parent/child where the child will have to access
# a packfile to fulfill another fetch
git init parent &&
git -C parent commit --allow-empty -m base &&
git clone parent child &&
git -C parent commit --allow-empty -m extra &&

# we want to make our base pack really big, because otherwise
# git will open/mmap/close it. So we must exceed core.packedgitlimit
cd child &&
$PATH_TO_GIT_BUILD/test-genrandom foo 5000000 >file &&
git add file &&
git commit -m large file &&
git repack -ad &&
git config core.packedGitLimit 1M &&

# now make some spare packs to bust the gc.autopacklimit
for i in 1 2 3 4 5; do
	git commit --allow-empty -m $i &&
	git repack -d
done &&
git config gc.autoPackLimit 3 &&
git config gc.autoDetach false &&
GIT_TRACE=1 git fetch
```

I also instrumented my (v1.9.5) git build like this:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 025bc3e..fc99e5e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1174,6 +1174,12 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	list.strdup_strings = 1;
 	string_list_clear(&list, 0);
 
+	{
+		struct packed_git *p;
+		for (p = packed_git; p; p = p->next)
+			trace_printf("pack %s has descriptor %d\n",
+				     p->pack_name, p->pack_fd);
+	}
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 
 	return result;
diff --git a/builtin/repack.c b/builtin/repack.c
index bb2314c..e8b29cf 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -105,6 +105,7 @@ static void remove_redundant_pack(const char *dir_name, const char *base_name)
 	for (i = 0; i < ARRAY_SIZE(exts); i++) {
 		strbuf_setlen(&buf, plen);
 		strbuf_addstr(&buf, exts[i]);
+		trace_printf("unlinking %s\n", buf.buf);
 		unlink(buf.buf);
 	}
 	strbuf_release(&buf);

to confirm what was happening (because of course on Linux it is
perfectly fine to delete the open file). If this does trigger the bug
for you, though, it should be obvious even without the trace calls. :)

-Peff

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
