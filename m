From: Charles Bailey <charles@hashpling.org>
Subject: Re: [RFC PATCH] archive: fix setup to work in bare repositories
Date: Wed, 22 Oct 2008 22:09:13 +0100
Message-ID: <20081022210913.GB22541@hashpling.org>
References: <gdmp0p$92r$1@ger.gmane.org> <20081022130829.GC2015@riemann.deskinm.fdns.net> <gdnsca$92r$2@ger.gmane.org> <20081022203722.GD2015@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kenneth johansson <ken@kenjo.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Wed Oct 22 23:10:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kskyh-0007II-Je
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 23:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbYJVVJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 17:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754365AbYJVVJU
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 17:09:20 -0400
Received: from ptb-relay03.plus.net ([212.159.14.147]:55748 "EHLO
	ptb-relay03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799AbYJVVJT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 17:09:19 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1Kskx8-0008IL-Ct; Wed, 22 Oct 2008 22:09:14 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m9ML9DKN023124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Oct 2008 22:09:14 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m9ML9DBr023123;
	Wed, 22 Oct 2008 22:09:13 +0100
Content-Disposition: inline
In-Reply-To: <20081022203722.GD2015@riemann.deskinm.fdns.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 51049ad6b86f55ff1aa9f58900f09a30
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98911>

On Wed, Oct 22, 2008 at 04:37:22PM -0400, Deskin Miller wrote:
> cmd_archive was calling git_config -> setup_git_env prior to
> write_archive calling setup_git_directory.  In a bare repository, the
> former will set git_dir to be '.git' since the latter has not
> determined that it's operating in a bare repository yet.
> 
> Things are complicated, however, by the fact that git archive --list
> should work from anywhere, not just in git repositories, so that
> argument needs to be checked for before setup_git_directory is called.

Just for some background, I think that this issue might be an
unintended consequence of this commit:

b99b5b40cffb5269e4aa38b6b60391b55039e27d

The only reason that the git_config call has been added is to ensure
the correct setting of core.autocrlf before convert_to_working_tree is
called on any blobs.

I haven't looked in detail, but would moving this call later make for
an cleaner change?

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
