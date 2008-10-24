From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 21:42:09 +0200
Message-ID: <cb7bb73a0810241242y7467f6fexcca4b7cd768e7992@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <4901077A.7050904@gmx.ch>
	 <cb7bb73a0810232355u6de0479cyc260c80227f44e59@mail.gmail.com>
	 <m38wsei8ne.fsf@localhost.localdomain>
	 <7vabct3l1e.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.10.0810241159290.27333@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Jean-Luc Herren" <jlh@gmx.ch>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Oct 24 21:43:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtSZG-0004hE-CQ
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 21:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbYJXTmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 15:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbYJXTmN
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 15:42:13 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:40130 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbYJXTmM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 15:42:12 -0400
Received: by gxk9 with SMTP id 9so116488gxk.13
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=v8d0wmP9P4khUIpx2kzB3p+nhgeN5dgtEBood8Zi7Qg=;
        b=MAV4maUKx9J5hFrJUICHcAkB/mqq1bjWt/RqzebHStkIDtqU5qAY/KxvIRzOvSN1hG
         3wRUSf/oL4PjfgjQBiB53w+L/pV3xHyCXgvefLg7ol5NthxFkx6xhMFhQhvS/0kS82PE
         fx2q/JriBqH/Jp1mPK80rIC5tzUudDQOeT/Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=BWJrmx8muvNcXa6qPZdU/0po8SNeiUCySKiFWrQ1Bg2O/jEtNv5i/n3GM8Ymua1DBG
         y9vo6QLD9jIWQgYD369uVZV7VllhePhQYVLrHrLgAd2pHl8Ndp1grF/3mEhsV6RJoPOr
         DPi5O9HTQAjaEir0/XoHO53WMpYGOJ+QYeMes=
Received: by 10.151.145.21 with SMTP id x21mr6405027ybn.218.1224877329617;
        Fri, 24 Oct 2008 12:42:09 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Fri, 24 Oct 2008 12:42:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0810241159290.27333@asgard.lang.hm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99053>

I was slowly writing a reply but it seems David beat me to it, so here
goes a couple of additional comments.

On Fri, Oct 24, 2008 at 9:11 PM,  <david@lang.hm> wrote:
> On Fri, 24 Oct 2008, Junio C Hamano wrote:
>> Running "git init" in an empty directory consumes about 100k of diskspace
>> on the machine I am typing this on, and you should be able to share most
>> of them (except one 41-byte file that is the branch tip ref) when you
>> track many files inside a single directory by using a single repository,
>> one branch per file (or "one set of branches per file") model.
>
> the reason to use seperate repos is to ease the work involved if you need to
> move that file (and it's repo) elsewhere.

Precisely. The one-repo-per-file is just the simplest and most
flexible solution. But yes, I have to admit I hadn't looked into disk
usage, and indeed we should try and squeeze this as much as possible.

> with the git directory being under .zit, would it be possible to link the
> things that are nessasary togeather?

I'm not sure about _which_ files could be shared.

> hmm, looking at this in more detail.
>
> about 44K of diskspace is used by the .sample hook files, so those can be
> removed

Exactly. I'm setting up zit to prepare its repos to a more compact
form, and getting rid of hooks and description is the first step.

> the remaining 56K is mostly directories eating up a disk block
>
> find . -ls
> 200367    4 drwxr-xr-x   7 dlang    users        4096 Oct 24 12:00 .
> 200368    4 drwxr-xr-x   4 dlang    users        4096 Oct 24 12:00 ./refs
> 200369    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00
> ./refs/heads
> 200370    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00
> ./refs/tags
> 200371    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00
> ./branches
> 200372    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00 ./hooks
> 200373    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00 ./info
> 1798469   4 -rw-r--r--   1 dlang    users         240 Oct 24 12:00
> ./info/exclude
> 1600716   4 -rw-r--r--   1 dlang    users          58 Oct 24 12:00
> ./description
> 200374    4 drwxr-xr-x   4 dlang    users        4096 Oct 24 12:00 ./objects
> 200375    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00
> ./objects/pack
> 200376    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00
> ./objects/info
> 1600717   4 -rw-r--r--   1 dlang    users          23 Oct 24 12:00 ./HEAD
> 1600719   4 -rw-r--r--   1 dlang    users          92 Oct 24 12:00 ./config
>
> how many of these are _really_ nessasary?

For starters, I'm wondering if setting core.preferSymlinkRefs would be
useful here. Does it break sometihng?

> tags, info, hooks, branches, and description could probably be skipped for
> the common zit case, as long as they can be created as needed.

It seems that tags, hooks, branches and description can be done with.

info contains exclude which is rather essential, and this is something
that could be shared across repositories. Also, we could spare a block
by removing info, moving exclude to the .git dir and setting
core.excludesfile appropriately

> the objects directory will eat up more space as revisions are checked in
> (and more sub-directories are created), would it make sense to have a config
> option to do a flat objects directory instead of the current fan-out?

This is probably the biggest remaining spacewaste. Typical zit usage
will generate a rather small number of objects, so flattening the
object store for the repo wouldn't be a bad idea. Is that possible?

-- 
Giuseppe "Oblomov" Bilotta
