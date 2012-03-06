From: karsten.blees@dcon.de
Subject: Re: [PATCH] fix deletion of .git/objects sub-directories in git-prune/repack
Date: Tue, 6 Mar 2012 22:47:19 +0100
Message-ID: <OF619F6614.68A2AA34-ONC12579B9.00763235-C12579B9.0077B76F@dcon.de>
References: <4F565849.80303@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	kusmabite@gmail.com,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Stefan Naewe <stefan.naewe@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncCN2Jst6HAhD5i9r6BBoElEwCqA@googlegroups.com Tue Mar 06 22:48:04 2012
Return-path: <msysgit+bncCN2Jst6HAhD5i9r6BBoElEwCqA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f58.google.com ([209.85.214.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCN2Jst6HAhD5i9r6BBoElEwCqA@googlegroups.com>)
	id 1S52El-0006IS-Ri
	for gcvm-msysgit@m.gmane.org; Tue, 06 Mar 2012 22:48:03 +0100
Received: by bkwq16 with SMTP id q16sf4783153bkw.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 06 Mar 2012 13:48:03 -0800 (PST)
Received-SPF: pass (google.com: domain of msysgit+bncCN2Jst6HAhD5i9r6BBoElEwCqA@googlegroups.com designates 10.180.90.201 as permitted sender) client-ip=10.180.90.201;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of msysgit+bncCN2Jst6HAhD5i9r6BBoElEwCqA@googlegroups.com designates 10.180.90.201 as permitted sender) smtp.mail=msysgit+bncCN2Jst6HAhD5i9r6BBoElEwCqA@googlegroups.com; dkim=pass header.i=msysgit+bncCN2Jst6HAhD5i9r6BBoElEwCqA@googlegroups.com
Received: from mr.google.com ([10.180.90.201])
        by 10.180.90.201 with SMTP id by9mr12226393wib.1.1331070483521 (num_hops = 1);
        Tue, 06 Mar 2012 13:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:in-reply-to:from:to:cc:subject
         :mime-version:x-mailer:message-id:sender:date:x-mimetrack
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:list-subscribe:list-unsubscribe:content-type;
        bh=g6/3dYs7JesUhqfpQDfddn8Kw9JKZRQ3uh1sq5e0Lhc=;
        b=52nOhAbpdzXgwdX4umPiqX1F8ZstOdOX8opE7m3Mo5F5rThkvyp5EozrHzTHAbpsMM
         9kfF2GuFyB96CMk4SIRV1CHXPcSCRDeraPuxE1SbkIR3W6WGvuhL3Bae9G2nkLs7MjPs
         Wypum+GMnPIZDwtvePU2BcWTw4fLKam4fjVdY=
Received: by 10.180.90.201 with SMTP id by9mr3593791wib.1.1331070457221;
        Tue, 06 Mar 2012 13:47:37 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.203.132 with SMTP id f4ls612467eeo.4.gmail; Tue, 06 Mar
 2012 13:47:36 -0800 (PST)
Received: by 10.14.199.133 with SMTP id x5mr1659025een.7.1331070456370;
        Tue, 06 Mar 2012 13:47:36 -0800 (PST)
Received: by 10.14.199.133 with SMTP id x5mr1659024een.7.1331070456359;
        Tue, 06 Mar 2012 13:47:36 -0800 (PST)
Received: from MAIL.DCON.DE (mail.dcon.de. [77.244.111.98])
        by gmr-mx.google.com with ESMTP id f9si14786336eea.2.2012.03.06.13.47.36;
        Tue, 06 Mar 2012 13:47:36 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@dcon.de designates 77.244.111.98 as permitted sender) client-ip=77.244.111.98;
In-Reply-To: <4F565849.80303@kdbg.org>
X-Mailer: Lotus Notes Release 7.0.3 September 26, 2007
Sender: msysgit@googlegroups.com
X-MIMETrack: Serialize by Router on DCON14/DCon(Release 7.0.3FP1|February 24, 2008) at
 06.03.2012 22:47:08,
	Serialize complete at 06.03.2012 22:47:08
X-Original-Sender: karsten.blees@dcon.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of karsten.blees@dcon.de designates 77.244.111.98 as permitted sender) smtp.mail=karsten.blees@dcon.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192401>

Johannes Sixt <j6t@kdbg.org> wrote on 06.03.2012 19:32:41:
> Am 06.03.2012 10:18, schrieb karsten.blees@dcon.de:
> > On some systems (e.g. Windows XP), directories cannot be deleted while
> > they're open. Both git-prune and git-repack (and thus, git-gc) try to
> > rmdir while holding a DIR* handle on the directory, leaving dangling
> > empty directories in the .git/objects store.
> > 
> > Fix it by swapping the rmdir / closedir calls.
> 
> The reasoning makes a lot of sense. I wonder why object directories are
> pruned nevertheless when I run git gc --prune (I run git master plus a
> few topics from pu).
> 

You're right...in upstream git, closedir() is essentially a NOOP. The OS
handle is closed in readdir() on reading the last entry. The dirent.c
'improvements' that move FindFirstFile() to opendir() and FindClose() to
closedir() are in the msysgit fork only [1] (and entirely my fault, I
guess :-)).

So this patch actually isn't currently required for Windows XP (probably
other platforms, I don't know).

[1] https://github.com/msysgit/git/commit/e2b3f70b

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***

*** Please avoid top-posting. ***

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
