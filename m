From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Problem with git-svn with limited SVN access
Date: Wed, 9 Nov 2011 23:38:25 +0100
Message-ID: <201111092338.26164.trast@student.ethz.ch>
References: <4EBA63CA.7000201@stickyadstv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Antoine Bonavita <antoine@stickyadstv.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 23:38:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROGn0-0004Ef-5r
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 23:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827Ab1KIWib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 17:38:31 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:37612 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932271Ab1KIWia (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 17:38:30 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 9 Nov
 2011 23:38:26 +0100
Received: from thomas.inf.ethz.ch (84.73.49.17) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 9 Nov
 2011 23:38:26 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-46-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <4EBA63CA.7000201@stickyadstv.com>
X-Originating-IP: [84.73.49.17]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185175>

Antoine Bonavita wrote:
> ### If I try to add one of the branches manually:
> branches = branches/XXX:refs/remotes/branches/XXX
>  > git svn fetch
> One '*' is needed in glob: 'branches/XXX'

I think having several fetch specs should do the trick, although I
cannot easily test with actual permissions.

You can start configuring the repo with

  git init
  git svn init svn://server/ -T trunk

to get an initial layout.  The .git/config will look like

  [svn-remote "svn"]
          url = svn://server/
          fetch = trunk:refs/remotes/trunk

The clue is that the config says 'fetch', not 'trunk'.  Much like with
git remotes, you can add more fetch specs along the lines of

          fetch = branches/XXX:refs/remotes/svn/XXX

or whatever layout you prefer.

Please tell us whether that works even in the face of restrictions on
branches/ itself :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
