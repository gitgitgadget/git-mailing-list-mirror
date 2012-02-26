From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 2/2] git-p4: remove bash-ism in t9800
Date: Sun, 26 Feb 2012 13:16:01 -0500
Message-ID: <20120226181601.GA10130@padd.com>
References: <1330270647-8817-1-git-send-email-pw@padd.com>
 <1330270647-8817-3-git-send-email-pw@padd.com>
 <4F4A7057.2020309@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Feb 26 19:16:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1idn-0002in-3w
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 19:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555Ab2BZSQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 13:16:06 -0500
Received: from honk.padd.com ([74.3.171.149]:59546 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319Ab2BZSQF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 13:16:05 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id D44E4E8D;
	Sun, 26 Feb 2012 10:16:03 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9C0E3313D8; Sun, 26 Feb 2012 13:16:01 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4F4A7057.2020309@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191571>

j6t@kdbg.org wrote on Sun, 26 Feb 2012 18:48 +0100:
> Am 26.02.2012 16:37, schrieb Pete Wyckoff:
> > -		P4EDITOR=touch P4USER=bob P4PASSWD=secret test_must_fail "$GITP4" commit --preserve-user &&
> > -		test_must_fail git diff --exit-code HEAD..p4/master
> > +		# dashism: test_must_fail does not propagate variables
> > +		P4EDITOR=touch P4USER=bob P4PASSWD=secret &&
> > +		export P4EDITOR P4USER P4PASSWD &&
> > +		test_must_fail "$GITP4" commit --preserve-user &&
> > +		! git diff --exit-code HEAD..p4/master
> 
> It is a bashism that variables assigned in front of a shell function are
> exported. But it is not a dashism that they are not exported; that
> (surprising?) behavior is actually conforming to POSIX.
> 
> With the new code, be aware that the variables remain exported, which
> might affect subsequent tests in general, though not this one, because
> the assignments are in a sub-shell:
> 
> >  	)
> >  '

Interesting, thanks.  I thought about the subshell behavior and
use, on purpose, the fact that the variables stay exported in the
second and third hunks.

		-- Pete
