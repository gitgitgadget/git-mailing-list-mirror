From: Kevin D <me@ikke.info>
Subject: Re: fatal: Unable to mark file .ruby-version
Date: Sun, 15 Mar 2015 18:45:43 +0100
Message-ID: <20150315174543.GA11832@vps892.directvps.nl>
References: <1645103.91WotSCBpm@linux-wzza.site>
 <20150315123004.GB12619@hank>
 <7217253.Nyz2WfkBbo@linux-wzza.site>
 <20150315165819.GA17591@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: t.gummerer@gmail.com, git@vger.kernel.org
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 18:45:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXCbm-0000d0-Je
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 18:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbbCORpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 13:45:45 -0400
Received: from ikke.info ([178.21.113.177]:44987 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512AbbCORpo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 13:45:44 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 397A11DCF6D; Sun, 15 Mar 2015 18:45:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150315165819.GA17591@hank>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265502>

On Sun, Mar 15, 2015 at 05:58:19PM +0100, t.gummerer@gmail.com wrote:
> On 03/15, Arup Rakshit wrote:
> > On Sunday, March 15, 2015 01:30:04 PM you wrote:
> > > 
> > > With --assume-unchanged you're promising git that you will not change
> > > a file that is already in the repository.  Git doesn't check those
> > > files for changes anymore, which can improve performance.
> > > 
> > 
> > I didn't understand your point. Could you please elaborate more on it ?
> 
> --assume-unchanged only works on files that you added on the
> repository, not on untracked files.  Because you don't seem to want
> these files in the repository, update-index --assume-unchanged will
> not work for you.
> 

And to elaborate what on what t.gummerer meant earlier: git update-index
--assume-unchanged is often abused to ignore already tracked files,
thinking that they can change the file while git happily ignores it.

--assume-unchanged was neaver built for this purpose, it's built for
large code bases where parts of the code base never changes, and git
checking this part would only slow it down. So that's why it's called a
promise to git that the file never changes, because git doesn't check
the status of the file everytime you run git status.

But because the file is still tracked, any commit that changes the file
causes git to still update that file, but git will then protest, because
it found it the file actually changed in the mean time, and you broke
that promise.

But also already said, this only applies to tracked files, so not to files
that aren't being tracked in the first place.

Kevin
