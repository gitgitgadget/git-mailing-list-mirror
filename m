From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git bisect goes wild?
Date: Tue, 24 Feb 2009 14:46:09 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902241427420.19665@iabervon.org>
References: <20090224184414.GE22108@duck.suse.cz> <eaa105840902241059y70143c43s7d12b10fe35127e6@mail.gmail.com> <20090224191002.GF22108@duck.suse.cz>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1804882965-1235504228=:19665"
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Jan Kara <jack@suse.cz>
X-From: git-owner@vger.kernel.org Tue Feb 24 20:47:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc3Fn-0000qI-6g
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 20:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756897AbZBXTqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 14:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754501AbZBXTqM
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 14:46:12 -0500
Received: from iabervon.org ([66.92.72.58]:38142 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754330AbZBXTqM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 14:46:12 -0500
Received: (qmail 23109 invoked by uid 1000); 24 Feb 2009 19:46:09 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Feb 2009 19:46:09 -0000
In-Reply-To: <20090224191002.GF22108@duck.suse.cz>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Content-ID: <alpine.LNX.1.00.0902241437150.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111334>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1804882965-1235504228=:19665
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.1.00.0902241437151.19665@iabervon.org>

On Tue, 24 Feb 2009, Jan Kara wrote:

> On Tue 24-02-09 13:59:16, Peter Harris wrote:
> > 2009/2/24 Jan Kara:
> > >  Hi,
> > >
> > >  I've been bisecting some change in Linux kernel. The output of
> > > "git bisect log" is:
> > ...
> > > git-bisect bad 419217cb1d0266f62cbea6cdc6b1d1324350bc34
> > ...
> > > git-bisect good 3e9830dcabdeb3656855ec1b678b6bcf3b50261c
> > >
> > >  But after the last command, I was sent to commit
> > > 9ec76fbf7d6da3e98070a7059699d0ca019b0c9b which is far outside the window
> > > between the last good and bad commit.
> > 
> > How did you determine that this commit is outside the window?
> > 
> > When I run "gitk 3e9830..419217" it shows that commit, as does "git
> > log". 9ec76fb appears to be inside the window to me.
>   Ho, hum, right. But if I do:
> git describe 9ec76fbf7d6da3e98070a7059699d0ca019b0c9b
>   I get v2.6.23-rc3-215-g9ec76fb which is a bit strange for bisecting
> between 2.6.23 and 2.6.24. Also the kernel gets named 2.6.23-rc3 and kernel
> config options get also to some pre 2.6.23 state. That's what is confusing
> me. It seems like the kernel checked out is some old one. I'm not a git
> expert so it might be fine but it just seems really strange.

If you're trying to find a problem that got into the mainline kernel 
between 2.6.23 and 2.6.24, you should expect to find a change that was 
added less than 2 weeks after 2.6.23 was released, and written before 
2.6.23 was released. Such a change would probably have been written 
against a mainline kernel somewhere in the 2.6.23-rcN range. So the 
description you should expect of the version that introduces the bug is 
"2.6.23-rcN with some patches that hadn't been merged to mainline".

In order for your bisect to end up with a commit that looks like it's 
between 2.6.23 and 2.6.24, Linus would have to have merged a buggy commit 
for 2.6.24 written after 2.6.23 was released, which is against how things 
are supposed to be done.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1804882965-1235504228=:19665--
