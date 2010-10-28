From: Johan Herland <johan@herland.net>
Subject: Re: Restart submodule update --recursive
Date: Thu, 28 Oct 2010 12:35:14 +0200
Message-ID: <201010281235.14313.johan@herland.net>
References: <loom.20101028T090353-376@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lukasz Palczewski <l.palczewski@prevac.pl>
X-From: git-owner@vger.kernel.org Thu Oct 28 12:35:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBPpc-0008Q7-KW
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 12:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757825Ab0J1Kfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 06:35:36 -0400
Received: from smtp.opera.com ([213.236.208.81]:48573 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757061Ab0J1Kfe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 06:35:34 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o9SAZEee004344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 28 Oct 2010 10:35:15 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <loom.20101028T090353-376@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160169>

On Thursday 28 October 2010, Lukasz Palczewski wrote:
> Hi.
> I have a problem with the time and the stoping of the submodule
> update command when the error occures.
> In our project we have lots of submodules with submodules in them. So
> I use git command: git submodule update --recursive, to update all
> the submodules, but it take some time to do it. I have to do it quite
> often becouse I'm a tester of the software and I usually don't know
> which submodule I need to update, to have the newest version. If I
> have some local changes in some submodule, the command stops and I
> have to revert the changes and start the submodule update from the
> begining again.
> Is there a way to start the submodule update from the place, where
> the error occured and the command stop? Something like:
> git submodule update --recursive --restart_form_last_error

No, but you can use 'git submodule foreach --recursive "$SCRIPT"', where 
$SCRIPT is a command (or list of commands) for updating your current 
submodule. As long as the SCRIPT returns successfully (exit value 0), 
the submodule foreach will keep going into each submodule. You can the 
look at the output from your script to deduce which submodules need to 
be updated manually. Or you may even be able to solve your problem 
automatically.

You could for example try something like (all on one line):

git submodule foreach --recursive "git fetch && git stash && git 
checkout $sha1 && git stash pop; true"


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
