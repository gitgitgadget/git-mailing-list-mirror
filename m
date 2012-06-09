From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/3] git-svn: use YAML format for mergeinfo cache when
 possible
Date: Sat, 9 Jun 2012 17:20:39 -0500
Message-ID: <20120609222039.GD28412@burratino>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
 <20120527192541.GA29490@burratino>
 <20120527201450.GA3630@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jason Gross <jgross@MIT.EDU>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 00:21:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdU2B-0004Ti-PL
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 00:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235Ab2FIWUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jun 2012 18:20:45 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50610 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab2FIWUo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2012 18:20:44 -0400
Received: by yenm10 with SMTP id m10so1930429yen.19
        for <git@vger.kernel.org>; Sat, 09 Jun 2012 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AZ7GLH3tPSoXnWUPnBt3VVZ8H1Kgki3/QB2xP/CgSJQ=;
        b=v53h8mOhRYMXBXRa+epmWxBbDOTz9Cb8WB4fZEKBjWyIRiBL1t5yveNi8NjOI3Wq4V
         ht2hX4CDttA7eQRPmHbNlW1qF0iDX/UUYUR7wLi4JCfYaAxD94RXFCf7llo7UW30suP2
         mNzTb8ushkzG3xPqm1/ywDQ4/9T+UPHjZGqXmTrGDnXcKk9PU73OTCge7bTCDrnXQWJR
         9aKQVYiWSiVvr7U4B4LfdnMObtKBArA1kSjaGlo7C1ZOj+yTXeITCoXRrhsc7DQCtNPi
         rq5vJD/wb+4T1Im7xy6dMQHt/hjCQT6eiEs9t3vuIAQnhtYZUym+rF2PbX7bj1SEEc06
         Y52Q==
Received: by 10.236.155.41 with SMTP id i29mr13755443yhk.115.1339280443838;
        Sat, 09 Jun 2012 15:20:43 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id n43sm37303089yhm.7.2012.06.09.15.20.42
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Jun 2012 15:20:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120527201450.GA3630@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199561>

Eric Wong wrote:

> Seems reasonable, a few comments below.

Thanks again.

[...]
> These should die on errors, right?

Yep, they do.  I didn't bother doing the CARP_NOT thing --- let's wait
for a bug report or rainy day and then handle errors properly (by
invalidating the cache when appropriate).

Patches 1-2 are independent from patch 3.  I'm sending them this way
for no particular reason.

Thoughts of all kinds welcome, as usual.

Jonathan Nieder (3):
  git-svn: make Git::SVN::Editor a separate file
  git-svn: make Git::SVN::RA a separate file
  git-svn: use YAML format for mergeinfo cache when possible

 git-svn.perl                 | 1115 ++----------------------------------------
 perl/Git/SVN/Editor.pm       |  536 ++++++++++++++++++++
 perl/Git/SVN/Fetcher.pm      |    3 +-
 perl/Git/SVN/Memoize/YAML.pm |   93 ++++
 perl/Git/SVN/Ra.pm           |  658 +++++++++++++++++++++++++
 perl/Makefile.PL             |    3 +
 6 files changed, 1320 insertions(+), 1088 deletions(-)
 create mode 100644 perl/Git/SVN/Editor.pm
 create mode 100644 perl/Git/SVN/Memoize/YAML.pm
 create mode 100644 perl/Git/SVN/Ra.pm
