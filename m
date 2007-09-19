From: Sam Vilain <sam@vilain.net>
Subject: Re: State of Perforce importing.
Date: Wed, 19 Sep 2007 12:20:44 +1200
Message-ID: <46F06B5C.2050207@vilain.net>
References: <20070917193027.GA24282@old.davidb.org> <46EF7DD1.9090301@vilain.net> <20070918154918.GA19106@old.davidb.org> <3f4fd2640709181053t70b7abcdi2c4eaf67e7b75338@mail.gmail.com> <20070918231921.GA17652@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 02:19:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXnHS-0004uY-Av
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 02:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbXISAS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 20:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbXISAS4
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 20:18:56 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:42741 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbXISASz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 20:18:55 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 8157621CFB8; Wed, 19 Sep 2007 12:18:52 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id D88F121CF28;
	Wed, 19 Sep 2007 12:18:48 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <20070918231921.GA17652@old.davidb.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58664>

David Brown wrote:
> On Tue, Sep 18, 2007 at 06:53:45PM +0100, Reece Dunn wrote:
> 
>> The main issues with using client workspaces is that they require you
>> to use `p4 sync`, whereas git-p4 uses `p4 print` and that they may
>> change as the repository changes, but Perforce does not track these
>> changes.
> 
> Unfortunately, we have one project that heavily abuses P4 client specs.
> For every release, someone creates a >900 line client spec and labels the
> files in it.  Those are the versions that need to get checked in, and
> without rewriting much of what P4 does, I'm going to have to let P4 do the
> syncing and checking out.

If you can get a hold of the "checkpoint" and "journal" files, you could
probably throw the client spec data into a few Pg tables, chuck a couple
of constraints on it to confirm that it works the way you thought, and
then get the information on what's where using a SQL query.  The file
images themselves can come from wherever, it doesn't really matter
because there are MD5 hashes in the data tables you can use to confirm
you got the right file.

I haven't looked at importing the client spec because it's not important
for the project I'm importing.  But I'd be happy to provide pointers.

>> I would not do that. It is a good idea to keep the original log
>> messages, even if it does make for an uninformative shortlog. Look at
>> some of the CVS/SVN imported logs!
> I think what I want then is something to filter between 'git log' and 'git
> shortlog' that would find a summary line in the commit message and copy it
> to the top.  It wouldn't change the history, but clean it up for shortlog's
> purpose.

Sounds like a job for a templating git-log porcelain.

Sam.
