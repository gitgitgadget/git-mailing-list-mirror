From: Peter Colberg <peter@colberg.org>
Subject: Re: Git Perl module not installed to --prefix
Date: Thu, 13 Sep 2012 14:40:59 -0400
Message-ID: <20120913184059.GB15312@pignolo.chem.utoronto.ca>
References: <20120913183019.GA15312@pignolo.chem.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 20:41:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCELi-0000al-Ry
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 20:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab2IMSlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 14:41:07 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.41]:38752 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab2IMSlE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 14:41:04 -0400
Received: from [176.9.47.72] (helo=pleione.colberg.org)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <peter@colberg.org>)
	id 1TCELV-0003ih-E6
	for git@vger.kernel.org; Thu, 13 Sep 2012 20:41:01 +0200
Received: by pleione.colberg.org (Postfix, from userid 2000)
	id 438651D45; Thu, 13 Sep 2012 14:41:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20120913183019.GA15312@pignolo.chem.utoronto.ca>
X-Operating-System: Debian GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: MTAwMjE5OA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205410>

On Thu, Sep 13, 2012 at 02:30:19PM -0400, Peter Colberg wrote:
> I have trouble installing the Git Perl module to the correct
> installation prefix, which is required for git send-email.
> 
> The problem is reproducible with the following commands:
> 
>     ./configure --prefix=/home/peter/usr/rhel6-x86_64/git-1.7.12
>     make
>     make install
> 
> While git is installed to --prefix, the Git Perl module is not:

Sorry, I have figured out the reason: The above commands are in fact
invoked from an installation makefile, which uses PREFIX as the
package installation prefix. Apparently this PREFIX variable was
inherited by make install, but only for the perl module.

    make -f packages.mk PREFIX=/home/peter/usr/rhel6-x86_64 CONCURRENCY_LEVEL=16 install-git

If I run configure/make/make install manually, it works fine.

Please excuse the false report.

Peter
