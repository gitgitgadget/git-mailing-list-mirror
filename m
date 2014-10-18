From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] git-completion.bash - avoid excruciatingly slow
 ref completion on Cygwin
Date: Sat, 18 Oct 2014 22:47:31 +0800
Message-ID: <CALUzUxpGXwu=sdh7MHjEcJzDRzZZkTR0NajU0hrBGCZZLGj2aw@mail.gmail.com>
References: <1413042673-24052-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, 
	"msysgit@googlegroups.com" <msysgit@googlegroups.com>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: msysgit+bncBCEMFWO7QMPRBF73RGRAKGQE4F2A4UA@googlegroups.com Sat Oct 18 16:47:54 2014
Return-path: <msysgit+bncBCEMFWO7QMPRBF73RGRAKGQE4F2A4UA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oi0-f55.google.com ([209.85.218.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCEMFWO7QMPRBF73RGRAKGQE4F2A4UA@googlegroups.com>)
	id 1XfVIP-0003a6-3i
	for gcvm-msysgit@m.gmane.org; Sat, 18 Oct 2014 16:47:53 +0200
Received: by mail-oi0-f55.google.com with SMTP id u20sf357057oif.0
        for <gcvm-msysgit@m.gmane.org>; Sat, 18 Oct 2014 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=Mh8ROT6OSF12aoil9p46hPBCruj3ZNa/TAxeGAUzNd4=;
        b=N4QZUTlV8lEYdgDJmxsZJSfFUjr+k9ZZKA+/PcP0rkyoqzevTs48pjEfH7brizQCUh
         tnir5XOM1qgDeO7WsfgR6BomOz2Uk4ON+ZgJFINgTKLG4KUk8uyD3nR1gXUrD81GzioF
         jbfdXkWf5y3l10u8QU2d/Cg6+RQaEucXjCz+Dj+Og1h11sDQDXwPcJFESybIAvCmr76V
         mUlnvT96Zu+Nbb5VKgboE0dabnL35eTsc/PEU+90cNUMnUJ+hlIXx8S/0MlCQi1yhFNt
         vOna/jQ55Dkozt8fJ745SPuXVSoD1JFXGFoPR8eC7Z1+2+Pr+CHB7u1cdoJPOYHhB2BP
         uoBw==
X-Received: by 10.182.215.229 with SMTP id ol5mr78596obc.3.1413643672115;
        Sat, 18 Oct 2014 07:47:52 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.96.103 with SMTP id dr7ls618785obb.93.gmail; Sat, 18 Oct
 2014 07:47:51 -0700 (PDT)
X-Received: by 10.182.81.37 with SMTP id w5mr10813177obx.29.1413643671498;
        Sat, 18 Oct 2014 07:47:51 -0700 (PDT)
Received: from mail-ig0-x22a.google.com (mail-ig0-x22a.google.com. [2607:f8b0:4001:c05::22a])
        by gmr-mx.google.com with ESMTPS id tr5si197187igb.1.2014.10.18.07.47.51
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 18 Oct 2014 07:47:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of rctay89@gmail.com designates 2607:f8b0:4001:c05::22a as permitted sender) client-ip=2607:f8b0:4001:c05::22a;
Received: by mail-ig0-x22a.google.com with SMTP id hn15so4293348igb.1
        for <msysgit@googlegroups.com>; Sat, 18 Oct 2014 07:47:51 -0700 (PDT)
X-Received: by 10.50.110.65 with SMTP id hy1mr6007938igb.13.1413643671390;
 Sat, 18 Oct 2014 07:47:51 -0700 (PDT)
Received: by 10.64.8.200 with HTTP; Sat, 18 Oct 2014 07:47:31 -0700 (PDT)
In-Reply-To: <1413042673-24052-1-git-send-email-mlevedahl@gmail.com>
X-Original-Sender: rctay89@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of rctay89@gmail.com designates 2607:f8b0:4001:c05::22a
 as permitted sender) smtp.mail=rctay89@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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

On Sat, Oct 11, 2014 at 11:51 PM, Mark Levedahl <mlevedahl@gmail.com> wrote:
>
> $git checkout <tab> was taking about 3.5 seconds to respond on one
> repository having four remotes with about 100 total refs (measured on
> Cygwin).  All of the time was being claimed in "git for-each-ref" to do
> its work.  This working directory was created using git-new-workdir, and
> thus .git/refs and .git/packed-refs are both symlinks.  for-each-ref
> operates in a way that causes the .git/refs symlink to be resolved
> multiple times for each ref in the repository, and Cygwin is especially
> slow in such operations.

Thanks for looking into this.

> Patching refs.c to avoid repeatedly dereferencing the symlink reduced
> execution time from about 3.5 seconds to about 1.1 seconds (but no
> improvement on Linux),

This makes your patch sound bad, but it isn't when one realises it is
already fast on Linux!

> [snip]
>
> Relevant timing results using the same repository on both Linux and
> Cygwin:

FWIW, timings on msysgit:

$ time git for-each-ref --format="%(refname:short)" refs

real    0m8.799s
user    0m0.109s
sys     0m0.250s

$ time (cd "$GIT_DIR" ; cat packed-refs ; find refs/ -type f) \
        2>/dev/null | sed -ne 's@^.*refs/@refs/@p' | sort | uniq

real    0m3.406s
user    0m1.073s
sys     0m2.398s

so while your symlink-analysis might not accurately describe msysgit
(I believe copies are made in place of a symlink), msysgit benefits
from this too.

-- 
Cheers,
Ray Chuan

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
