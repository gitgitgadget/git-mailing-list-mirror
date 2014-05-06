From: David Turner <dturner@twopensource.com>
Subject: Re: Watchman support for git
Date: Mon, 05 May 2014 20:13:44 -0700
Organization: Twitter
Message-ID: <1399346024.11843.43.camel@stross>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	 <CACsJy8C72QQZd4v+p4bkFFKHnN2Uj1zD-BELwGtYB7sx1P6q6g@mail.gmail.com>
	 <1399091986.5310.20.camel@stross>
	 <CACsJy8B1Q3WEPT+nzDDwS5f7Wx+u5CHfN9JppRHv5VEx5NTxSw@mail.gmail.com>
	 <1399150149.5310.47.camel@stross>
	 <CACsJy8Dr=m5FwmD2gXTM3bN-iYv+fyZ9RBUyvcj3UJJCC1yYtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 20:49:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiHi-0007Xo-Is
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933886AbaEFDNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 23:13:49 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:63369 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933809AbaEFDNt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 23:13:49 -0400
Received: by mail-qa0-f50.google.com with SMTP id j15so2758854qaq.23
        for <git@vger.kernel.org>; Mon, 05 May 2014 20:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=mqz1p/R6QpXhlaYyBs0hnGCCqCO9Z7jfzu7g5RLVVHM=;
        b=Nc+uzK+bJpJePwKyl4I4/9uNos+PFMABYWC68glqM47ib4QUUivzmwipvkCGclKltc
         tpTiqbMLdjjfaakqe6N9eVBWbxZi0ZqVn8iQswkrSI5bbwsbcwkdswF68RU3vpzQ5/qb
         Y5D50WRbRwtV+a6HBB/XMwGyCL+7ANTMpF4WgFCan3Gki8RAKv7C0dmId5DYXmfTbsre
         hlXsfsY6uVVN/+kShzA4XREzeC9r2N6lVoMYtk0rSfkC5lEQM4gD7I1+0Vxnks1sSQde
         giblxiHA6CiKvmioLpPNCoEJQ3GknIVJC3PlvJ2qrcG2HiC+KzmmWZW9WqjT07zTJBA9
         1jaA==
X-Gm-Message-State: ALoCoQmc3g1YlM+AGM94bmaYWqqQD/GeStGiyb6uMQbwB8C3ZfzwrLlVNd3LXuakphUIRRXnFhCw
X-Received: by 10.140.101.99 with SMTP id t90mr9529669qge.115.1399346028395;
        Mon, 05 May 2014 20:13:48 -0700 (PDT)
Received: from [172.25.143.182] ([8.25.197.27])
        by mx.google.com with ESMTPSA id 104sm14035223qgq.1.2014.05.05.20.13.45
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Mon, 05 May 2014 20:13:47 -0700 (PDT)
In-Reply-To: <CACsJy8Dr=m5FwmD2gXTM3bN-iYv+fyZ9RBUyvcj3UJJCC1yYtg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248211>

On Sun, 2014-05-04 at 07:15 +0700, Duy Nguyen wrote:
> > I would like to merge the feature into master.  It works well for me,
> > and some of my colleagues who have tried it out.
> 
> Have you tried to turn watchman on by default, then run it with git
> test suite? That usually helps.

I have.  The tests work run fine under make, but prove sometimes freezes
due to an issue in libwatchman which I just fixed (and which I plan to
merge as soon as I can get a colleague to look the changes over).

> > I can split the vmac patch into two, but one of them will remain quite
> > large because it contains the code for VMAC and AES, which total a bit
> > over 100k.  Since the list will probably reject that, I'll post a link
> > to a repository containing the patches.
> 
> With the read-cache deamon, I think hashing cost is less of an issue,
> so new hashing algorithm becomes less important. If you store the file
> cache in the deamon's memory only, there's no need to hash anything.
> But I guess you already tried this.

I agree that with the daemon, the cost is less of an issue, but I am not
100% sure it is a non-issue; consecutive commands that need to
read/write the index can still be slowed down.

> > I'm not 100% sure how to split the watchman patch up.  I could add the
> > fs_cache code and then separately add the watchman code that populates
> > the cache.  Do you think there is a need to divide it up beyond this?
> 
> I'll need to have closer look at your patches to give any suggestions.

I have uploaded a new version (which is about 5-10% faster and which
corrects some minor changes) to https://github.com/dturner-tw/git.git on
the watchman branch.  

> Although if you don't mind waiting a bit, I can try to put my
> untracked cache patches in good shape (hopefully in 2 weeks), then you
> can mostly avoid touching dir.c and reuse my work.

If the untracked cache patches are going to make it into master, then I
would of course be willing to rewrite on top of them.  But I would also
like to have a sense of whether there is any interest in watchman
support (outside of Twitter).

For what it's worth, the numbers today for index version 4 are for my
superscience repo are:
~380 (no watchman), ~260 (untracked-cache), ~175 (watchman).

That's because untracked-cache still has to stat every directory.

> I backed away from watchman support because I was worried about its
> overhead (of watchman itself, and git/watchman IPC because it's not
> designed specifically for git), which led me to try optimizing git as
> much as possible without watchman first, then see how/if watchman can
> help on top of that. I still think it's a good approach (maybe because
> it started to make me doubt if watchman could pull a big performance
> win on top to justify the changes to support it)

I think on large repositories (especially deeply-nested ones), with the
common case of a small number of changes, watchman will end up being a
big win.  Java tends towards deep nesting
(src/main/java/com/twitter/common/...), which is probably why my test
repo had the largest speedup (>50%).  The IPC overhead might become bad
if there were a large number of changes, but so far this has not been an
issue for me in testing.  
