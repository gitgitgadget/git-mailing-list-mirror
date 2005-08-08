From: Chris Wright <chrisw@osdl.org>
Subject: Re: Request for help from binary packaging people.
Date: Mon, 8 Aug 2005 11:58:58 -0700
Message-ID: <20050808185858.GC8041@shell0.pdx.osdl.net>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net> <7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net> <7vacjsdcbj.fsf@assigned-by-dhcp.cox.net> <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 20:59:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2CqD-0002LL-Cz
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 20:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVHHS7O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 14:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbVHHS7O
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 14:59:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57248 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932198AbVHHS7N (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 14:59:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j78IwwjA032496
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 Aug 2005 11:58:58 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j78Iwwsc019647;
	Mon, 8 Aug 2005 11:58:58 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j78IwwrM019646;
	Mon, 8 Aug 2005 11:58:58 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Junio C Hamano (junkio@cox.net) wrote:
> For RPM, from my lack of RPM expertise (and RPM capable
> environment until recently), I have not updated the "Prereq:"
> field in git-core.spec.in at all.  I would appreciate somebody
> to sanity check the list of dependencies.  The dependency list
> Debian side has is more up-to-date and I am reasonably sure it
> is accurate.  It lists patch, diff, and rcs (for the "merge"
> command) as the essential dependency (aside from the shared
> libraries like libc), and libmail-sendmail-perl, rsync, curl,
> ssh, and libemail-valid-perl as the recommended dependency.  I
> do not even know if RPM has the notion of such multi-tier
> dependencies, but the latter list is meant to mean "you could
> live without these, but to exercise this package fully you may
> want them" (in our case of git-core, you could live without the
> networking if you do not do multi-user, multi-repository).  If
> RPM spec file has a way to say something like that, I would like
> to see these packages (probably their names are different
> between Debian and RPM) listed on the recommended dependency
> list; otherwise I would want to see them added to the main
> "Prereq:" list.

I'd say the proper rpm method would be with subpackages with their own
prereqs.  Also, rpm is able to determine the perl dependencies
automatically (of course, ditto for shared libraries).

Now, the only issue is this package is unlikely to install because of the
Mail/Sendmail.pm and Email/Valid.pm requirements.  We can add specific
package requirements for those since they are less common.

Here's the actual install dependency list:

$ rpm -qp /home/chrisw/rpms/RPMS/i386/git-core-0.99.4-1.i386.rpm --requires
/bin/sh
/usr/bin/env
/usr/bin/perl
diffutils
libc.so.6
libc.so.6(GLIBC_2.0)
libc.so.6(GLIBC_2.1)
libc.so.6(GLIBC_2.1.3)
libc.so.6(GLIBC_2.2.3)
libc.so.6(GLIBC_2.3)
libcrypto.so.4
libcurl.so.3
libssl.so.4
libz.so.1
mktemp >= 1.5
perl(Data::Dumper)
perl(Email::Valid)
perl(File::Basename)
perl(File::Path)
perl(File::Spec)
perl(File::Temp)
perl(Getopt::Long)
perl(Getopt::Std)
perl(IO::Pipe)
perl(IO::Socket)
perl(Mail::Sendmail)
perl(POSIX)
perl(Term::ReadLine)
perl(Time::Local)
perl(strict)
perl(warnings)
rcs
rpmlib(CompressedFileNames) <= 3.0.4-1
rpmlib(PayloadFilesHavePrefix) <= 4.0-1
rpmlib(VersionedDependencies) <= 3.0.3-1
rsync
sh-utils
