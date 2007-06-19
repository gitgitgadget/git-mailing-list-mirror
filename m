From: David Kastrup <dak@gnu.org>
Subject: Re: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 17:12:14 +0200
Message-ID: <86k5u0q8q9.fsf@lola.quinscape.zz>
References: <18039.52754.563688.907038@lisa.zopyra.com> <Pine.LNX.4.64.0706191359160.4059@racer.site> <20070619132456.GA15023@fiberbit.xs4all.nl> <18039.57099.57602.28299@lisa.zopyra.com> <20070619143000.GA15352@fiberbit.xs4all.nl> <18039.60598.264803.940960@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 17:36:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0fkU-00044s-8N
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 17:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757734AbXFSPf5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 11:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757666AbXFSPf5
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 11:35:57 -0400
Received: from main.gmane.org ([80.91.229.2]:35507 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757551AbXFSPf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 11:35:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I0fd9-0006lw-0K
	for git@vger.kernel.org; Tue, 19 Jun 2007 17:28:31 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 17:28:30 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 17:28:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:1ol2abznNgqbf8QBR/4ETZuWwqE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50490>

Bill Lear <rael@zopyra.com> writes:

> On Tuesday, June 19, 2007 at 16:30:00 (+0200) Marco Roeland writes:
>>On Tuesday June 19th 2007 at 08:50 Bill Lear wrote:
>>> 
>>> I checked and there is no iconv package (rpm).  I really don't want
>>> to have to temporarily rename a header.  I can't hand this out to
>>> the rest of the company, some of whom do not have root access to
>>> be able to rename header files.
>>
>>You might at least investigate if there is somehow another iconv.h
>>header besides the system one under /usr/include, that might have been
>>used by the compiler instead of the standard one from GNU libc.
>
> Ok, I moved all the *iconv* stuff in /usr/local/<blah> and now
> it builds ok.
>
> However, I still get this:
>
> install -d -m755 '/opt/git-1.5.2.2/share//git-core/templates/'
                                         ^^^
> (cd blt && tar cf - .) | \
> 	(cd '/opt/git-1.5.2.2/share//git-core/templates/' && tar xf -)
                                   ^^^
> tar: This does not look like a tar archive
> tar: Skipping to next header
> tar: Archive contains obsolescent base-64 headers
> tar: Error exit delayed from previous errors
>
> So, I did a make -k and it worked ok, aside from this error.
>
> I copied this line:
>
> (cd blt && tar cf - .) | \
> 	(cd '/opt/git-1.5.2.2/share//git-core/templates/' && tar xf -)
                                   ^^^
> into a file, chmod +x'd that file, and cd'd into templates and ran
> the script.  I got the same error.  I then tried running it by
> hand from the command line:
>
> % cd templates
> % (cd blt && tar cf - .) | (cd /opt/git-1.5.2.2/share/git-core/templates
>                                                     ^^^
> && tar xf -)
>
> and it worked fine.

Not sure whether this is the problem: either cd does not understasnd
the double slashes, or your shell used for scripts has modified cd to
output some stuff when it is working (people sometimes imprudently
make shell functions or aliases for this).

Try writing something like

type cd

in a script file and see what output you get.

-- 
David Kastrup
