From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Mon, 03 Sep 2007 13:51:38 +0200
Message-ID: <86odgkhsqd.fsf@lola.quinscape.zz>
References: <46DACD93.9000509@trolltech.com> <46DB0478.8050402@trolltech.com> <46DB0F9C.2090306@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com> <46DBA672.9050308@trolltech.com> <Pine.LNX.4.64.0709031238400.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 13:51:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISATE-0002uN-MD
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 13:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838AbXICLvw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 07:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbXICLvw
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 07:51:52 -0400
Received: from main.gmane.org ([80.91.229.2]:50801 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898AbXICLvv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 07:51:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ISAT5-0001Hr-Bx
	for git@vger.kernel.org; Mon, 03 Sep 2007 13:51:47 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 13:51:47 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 13:51:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:lP8+l9FkJYdovu1xs8aROjH4TPY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57473>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 3 Sep 2007, Marius Storm-Olsen wrote:
>
>> Robin Rosenberg said the following on 02.09.2007 22:27:
>> > s?ndag 02 september 2007 skrev Marius Storm-Olsen:
>> > > (Also, since Windows doesn't really handle symlinks, it's fine that 
>> > > stat just uses lstat)
>> > 
>> > It does now: See 
>> > http://msdn2.microsoft.com/en-us/library/aa363866.aspx
>> 
>> Yeah, I know about Vista's improved support for symbolic
>> links. However, I think we can let that lay for a while, until we
>> decide to make Git generate proper symlinks on Vista. I don't see
>> it as a 1st priority at the moment, and we can always add the
>> needed functionality in a separate stat() function later.
>
> ... and force everybody to upgrade to Vista,

Nonsense.  Supporting a feature is different from requiring a feature.

> thereby working for Microsoft for free?  You _know_ that I will
> oppose that change.

If Microsoft decides to shoot their users less in the foot than
previously, I don't think that we should take over the gun.

However, if the symbolic link semantics hinted at elsewhere indeed are
as broken as claimed and/or documented, the actual usefulness of
symbolic links seems so limited that we would not be doing their users
a favor by supporting relative symlinks.  And absolute links frankly
have very little place in a _work_ directory (and git does not
currently keep track of enough things in order to make it useful as a
filesystem snapshot system).

I would like to see actual test results to get a confirmation of
whether indeed relative symlinks are as broken under Vista as rumored.
If they are, it seems quite pointless supporting any symlinks under
Windows at the moment.  Until I see actual test results, I would give
Microsoft the benefit of doubt.

-- 
David Kastrup
