From: Pavel Roskin <proski@gnu.org>
Subject: Re: GIt.xs merge status
Date: Fri, 30 Jun 2006 01:08:21 -0400
Message-ID: <1151644101.10496.22.camel@dv>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
	 <20060624012202.4822.qmail@science.horizon.com>
	 <7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
	 <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
	 <7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
	 <7vmzbvmny4.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jun 30 07:08:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwBFH-0002Hg-AZ
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 07:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWF3FIf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 01:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWF3FIf
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 01:08:35 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:59798 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750853AbWF3FIe
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 01:08:34 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FwBF3-0004XR-Bj
	for git@vger.kernel.org; Fri, 30 Jun 2006 01:08:33 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FwBEs-0000AH-70; Fri, 30 Jun 2006 01:08:22 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzbvmny4.fsf_-_@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.7.3 (2.7.3-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22954>

On Thu, 2006-06-29 at 18:28 -0700, Junio C Hamano wrote:
> Checking for unpackaged file(s): /usr/lib/rpm/check-files /var/tmp/git-1.4.1.rc2.g5762-1-root-junio
> error: Installed (but unpackaged) file(s) found:
>    /usr/lib64/perl5/5.8.6/x86_64-linux-thread-multi/perllocal.pod
>    /usr/lib64/perl5/site_perl/5.8.6/x86_64-linux-thread-multi/Error.pm
>    /usr/lib64/perl5/site_perl/5.8.6/x86_64-linux-thread-multi/Git.pm
>    /usr/lib64/perl5/site_perl/5.8.6/x86_64-linux-thread-multi/auto/Git/.packlist
>    /usr/lib64/perl5/site_perl/5.8.6/x86_64-linux-thread-multi/auto/Git/Git.bs
>    /usr/lib64/perl5/site_perl/5.8.6/x86_64-linux-thread-multi/auto/Git/Git.so

I guess all this perl stuff should be in a separate module perl-Git to
comply with Red Hat conventions.  This would make git-core depend on
perl-Git, but it's OK.

Error.pm is already provided by perl-Error.  If we require perl(Error)
for building, it won't be installed.  Actually, probing for Error.pm is
incorrect, so I'm fixing it.

Git.bs, .packlist and perllocal.pod should be removed - that's what
other Perl packages do.  Red Hat packages use INSTALLDIRS=vendor so that
"site_perl" becomes "vendor_perl".

While hacking that, I have wound that "--without doc" is broken in pu,
so I'm fixing it as well.  The patches will be sent shortly.

-- 
Regards,
Pavel Roskin
