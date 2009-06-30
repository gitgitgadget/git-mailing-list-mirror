From: Andreas Ericsson <ae@op5.se>
Subject: Re: correct workflow with bare repo and pull?
Date: Tue, 30 Jun 2009 08:28:22 +0200
Message-ID: <4A49B086.30000@op5.se>
References: <583913.73865.qm@web52205.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tim <opensourcetim@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 08:29:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLWpY-0001c9-8d
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 08:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbZF3G20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 02:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbZF3G2Z
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 02:28:25 -0400
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:41517 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751926AbZF3G2Y (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jun 2009 02:28:24 -0400
Received: from source ([209.85.219.218]) by na3sys009aob113.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSkmwiu/zLAjDteF/OGuivkBlmwBjnIyX@postini.com; Mon, 29 Jun 2009 23:28:28 PDT
Received: by ewy18 with SMTP id 18so5599428ewy.45
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 23:28:25 -0700 (PDT)
Received: by 10.211.180.19 with SMTP id h19mr675877ebp.26.1246343305762;
        Mon, 29 Jun 2009 23:28:25 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 23sm1704948eya.49.2009.06.29.23.28.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 23:28:24 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <583913.73865.qm@web52205.mail.re2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122491>

Tim wrote:
> Myself and the other developer on the team have private repos, and we
> push to a bare repo (which we use for Hudson builds).  For now we only
> use the master branch.  No other remote repos.  When another developer
> pushes changes to the bare repo, and I pull them, all of the files they
> pushed show up as modified on my box when I do "git status" (even
> though I had not modified them).  How to avoid this?

Make sure neither of you modify the executable bit on the files, and make
sure your editors work the same in both ends wrt the last line and white-
space at the ends of lines.

Also make sure you have compatible crlf settings in your git configs.

If your editors are what's causing the problem, you should only see the
files you've actually opened in your editor as being different. If it's
your git configuration, "git pull && git status" should show differences
immediately. "git help config" and searching for core.autocrlf should
point you in the right direction to what might be causing the error.
If it's modechanges that's the problem. core.filemode may also be a
possible source of errors (it has to be "false" on windows but can be
"true" on systems with posix permissions).

>   Also, one
> developer saw really strange results when they did a "git pull origin
> master" and "git status" -- the paths shown below do not exist in the
> local work area.  These files have always lived under a-core/.... so it
> is really odd that they show up under a-web
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #    new file:   a-web/src/main/java/com/blah/account/Account.java
> #    new file:   a-web/src/main/java/com/blah/account/AccountType.java
> #
> # Changed but not updated:
> #   (use "git add/rm <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #    deleted:    a-web/src/main/java/com/blah/account/Account.java
> #    deleted:    a-web/src/main/java/com/blah/account/AccountType.java
> 
> What are we doing wrong?  
> 

Hard to tell without knowing what the repository looks like. Is this
a repo you can share with us?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
