From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: fix localtime=true on non-glibc environments
Date: Wed, 25 Feb 2015 19:42:13 +0000
Message-ID: <20150225194213.GA32026@dcvr.yhbt.net>
References: <1424880281-570-1-git-send-email-ryu1kkb@gmail.com>
 <xmqqfv9tomzx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryuichi Kokubo <ryu1kkb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 20:42:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQhqc-0000jx-VD
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 20:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbbBYTmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 14:42:15 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45141 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753384AbbBYTmO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 14:42:14 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC1B11F7A3;
	Wed, 25 Feb 2015 19:42:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqfv9tomzx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264407>

Junio C Hamano <gitster@pobox.com> wrote:
> Ryuichi Kokubo <ryu1kkb@gmail.com> writes:
> 
> > git svn uses POSIX::strftime('%s', $sec, $min, ...) to make unix epoch time.
> > But lowercase %s formatting character is a GNU extention. This causes problem
> > in git svn fetch --localtime on non-glibc systems, such as msys or cygwin.
> > Using Time::Local::timelocal($sec, $min, ...) fixes it.
> >
> > Signed-off-by: Ryuichi Kokubo <ryu1kkb@gmail.com>
> 
> Sounds sensible.
> 
> Because we already have "use Time::Local qw(...)" in perl/Git.pm
> that is used by git-svn, we know the platforms that are capable
> of running the current git-svn do have Time::Local available, so
> I do not have worries about new dependency, either.
> 
> Eric?

Looks good, thanks.  Signed-off and queued up.
