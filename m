From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: [BUG?] Re: fail to svn clone debian's kernel repository
Date: Thu, 04 Mar 2010 03:03:19 +0100
Message-ID: <4B8F14E7.5050000@hartwork.org>
References: <20090610160524.GA24435@pengutronix.de> <20100302195454.GB12942@vidovic> <4B8DB940.9020609@hartwork.org> <201003031533.13056.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	=?UTF-8?B?VXdlIEtsZWluZS1Lw7Y=?= =?UTF-8?B?bmln?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 04 03:03:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn0PQ-0007GY-0m
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 03:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755556Ab0CDCDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 21:03:23 -0500
Received: from smtprelay01.ispgateway.de ([80.67.29.23]:49204 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab0CDCDV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 21:03:21 -0500
X-Greylist: delayed 88998 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2010 21:03:21 EST
Received: from [85.179.158.132] (helo=[192.168.0.3])
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1Nn0PH-0005gm-Ug; Thu, 04 Mar 2010 03:03:20 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7) Gecko/20100228 Thunderbird/3.0.1
In-Reply-To: <201003031533.13056.trast@student.ethz.ch>
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141495>

On 03/03/10 15:33, Thomas Rast wrote:
> Combining this fix with the above config results in correct
> "continuous" history of trunk, whereas merely using the config above
> results in a disconnect at the move.

Thanks for your time to look into that!

After applying your ideas (which seem to work well) I end up with:
==================================================================
git svn init file://"${ABS_SVN_SOURCE}"
git config svn-remote.svn.fetch 'trunk:refs/remotes/trunk@1889'
git svn fetch -r1:1889
git svn init file://"${ABS_SVN_SOURCE}" \
  --trunk=main/trunk
git config svn-remote.svn.tags 'main/tags/*:refs/tags/*'
git config svn-remote.svn.branches 'main/branches/*:refs/heads/*'
git svn fetch -r1890:HEAD
==================================================================

.git/config holds:
==================================================================
[..]
[svn-remote "svn"]
        url = file:///[..]/portage-anon-svn-repo-dump
        fetch = trunk:refs/remotes/trunk@1889
        fetch = main/trunk:refs/remotes/trunk
        tags = main/tags/*:refs/tags/*
        branches = main/branches/*:refs/heads/*
==================================================================

Thought I'd paste that if anybody else is interested.



Sebastian
