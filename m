From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: way to automatically add untracked files?
Date: Sun, 5 Aug 2007 13:22:22 +0200
Message-ID: <8EA2C4F4-F947-427B-A1E8-ABAEB06C1360@zib.de>
References: <873ayymzc1.fsf@catnip.gol.com> <fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com> <20070805041320.GH9527@spearce.org> <87lkcqlif2.fsf@catnip.gol.com> <7v8x8qip7n.fsf@assigned-by-dhcp.cox.net> <87d4y2li2c.fsf@catnip.gol.com> <7v4pjeioi6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 13:23:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHeDG-000165-Bn
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 13:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674AbXHELXk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 07:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbXHELXk
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 07:23:40 -0400
Received: from mailer.zib.de ([130.73.108.11]:49095 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645AbXHELXj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 07:23:39 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l75BLZqZ010314;
	Sun, 5 Aug 2007 13:21:43 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10786.pool.einsundeins.de [77.177.7.134])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l75BLUld021143
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 5 Aug 2007 13:21:30 +0200 (MEST)
In-Reply-To: <7v4pjeioi6.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54995>


On Aug 5, 2007, at 6:39 AM, Junio C Hamano wrote:

>
> Adding _new_ files, unless you are just beginning a new project,
> are much more rare than updating modified files that you are
> already tracking; and "git add new-file..." is what people
> usually use for the former.  "git add ." is almost always the
> "initial import" and not used later (after all you ought to know
> what files you are creating and controlling ;-)).  You get into
> an illusion that that is often used, only when you have just
> started.  As your project progresses, that feeling will fade
> away.

I exactly need the functionality that Miles is describing for
the following good reason:

Mac OS X has the notion of a bundle, which is a directory that
contains related files that are fully controlled by the application
that is writing that bundle. The bundle functionality is
directly supported by the OS and most applications save their
data as bundles. For example on Mac OS X, the Openoffice format,
which packs related files in a zip file, would just be a directory
with all related files grouped together (no ZIP archive needed).

So here is what I need: I want to be able to track a directory
with all its contents. The data inside the directory are not
under my control. It's only the directory that matters for me.

Git is already quite good at that because it doesn't need to
place anything inside the opaque directory! Subversion for example
has no chance because it clutters the directory with .svn
directories, which will be removed by the next Save (an
application first creates a new temporary directory, stores
all data there, moves the old directory to a backup location,
and renames the new directory to the final destination only
if no problems occurred).

When I started with git I figured out that

    git-ls-files -z --others dir | git-update-index --add -z --stdin
    git commit -a

does the job for me. Would

    git add dir
    git add -u dir
    git commit

be equivalent, but restricted to the changes in dir?

	Steffen
