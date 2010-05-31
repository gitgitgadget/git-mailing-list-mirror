From: Marc Van Olmen <marc@sky4studios.be>
Subject: Re: Problems with git-svn and space in the URL
Date: Mon, 31 May 2010 11:33:34 -0400
Message-ID: <0A790195-2DB1-4E1F-BAE2-9D65C261AD26@sky4studios.be>
References: <13CB2F6C-49BB-44CB-84A7-2264CAF76766@sky4studios.be>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 31 17:33:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJ6zm-0007KR-GQ
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 17:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078Ab0EaPdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 11:33:36 -0400
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:32993 "EHLO
	elasmtp-kukur.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754478Ab0EaPdf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 11:33:35 -0400
Received: from [208.120.208.90] (helo=[192.168.15.16])
	by elasmtp-kukur.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <marc@sky4studios.be>)
	id 1OJ6zf-0000RD-Cn
	for git@vger.kernel.org; Mon, 31 May 2010 11:33:35 -0400
In-Reply-To: <13CB2F6C-49BB-44CB-84A7-2264CAF76766@sky4studios.be>
X-Mailer: Apple Mail (2.1078)
X-ELNK-Trace: aadfff9530346fbe1a6815bbddd658034d2b10475b57112082c295a16af264ea5fc8f6ad4edecf5719c9e15d1c7c699c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 208.120.208.90
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148045>

Hi,

Don't think it was a space in URL but something else, haven't conclude what it was.
git 1.7.1
svn 1.6.6
svn server 1.6.5

I was doing the following:
-------------------------

* git svn clone -s **myserver**/svn/OnTheAir%20Video
* git checkout -b local/ticket_0004_multiple_playback_buffers ticket_0004_multiple_playback_buffers
* git merge master
* resolved all the conflicts (list was huge) several files were renamed and moved. So thanks to git i could resolve it all.
* git commit 
* git svn dcommit ( this gave error below


I resolved the issue by doing a new checkout merge

* git svn clone -s **myserver**/svn/OnTheAir%20Video
* git checkout -b local/ticket_0004_multiple_playback_buffers ticket_0004_multiple_playback_buffers

(Several iterations of:)

 * I took one folder from previous merge above copied this over
 * git commit 
 * git dcommit

After 7 of these steps everything was working fine. 

So it wasn't clear why above wasn't working. Maybe 'git merge master' caused some svn metadata issues?

regards,

marc



On May 30, 2010, at 11:05 PM, Marc Van Olmen wrote:

> Hi,
> 
> First time user.
> 
> Was trying to do a commit back to the svn repository: The svn repo has a space in the main project name:
> 
> When I try to commit, got this:
> 
> Quad-Raid-2:OnTheAir%20Video copy marcvano$ git svn dcommit
> Committing to **myserver**/svn/OnTheAir Video/branches/ticket_0004_multiple_playback_buffers ...
> Filesystem has no item: '/svn/!svn/bc/2643/OnTheAir' path not found at /usr/local/git/libexec/git-core/git-svn line 572
> 
> When I run:
> 
> Quad-Raid-2:OnTheAir%20Video copy marcvano$ git svn info
> Path: .
> URL: **myserver**/svn/OnTheAir%20Video/branches/ticket_0004_multiple_playback_buffers
> Repository Root: **myserver**/svn
> Repository UUID: 6f96b356-5bf8-4915-87a6-d3080d869cd8
> Revision: 2643
> Node Kind: directory
> Schedule: normal
> Last Changed Author: XXXXXX
> Last Changed Rev: 2643
> Last Changed Date: 2010-05-02 18:01:52 -0400 (Sun, 02 May 2010)
> 
> 
> any solution for this problem?
> 
> marc
