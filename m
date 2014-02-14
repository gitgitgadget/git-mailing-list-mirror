From: Josef Wolf <jw@raven.inka.de>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Fri, 14 Feb 2014 17:52:48 +0100
Message-ID: <20140214165247.GC17817@raven.inka.de>
References: <20140214113136.GA17817@raven.inka.de>
 <87a9dt981o.fsf@igel.home>
 <CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
 <20140214151619.GB17817@raven.inka.de>
 <87ppmp3dxp.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 14 18:00:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEM7d-0004Yr-Sn
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 18:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbaBNRAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 12:00:11 -0500
Received: from quechua.inka.de ([193.197.184.2]:58969 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbaBNRAK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 12:00:10 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1WEM7V-0003cu-DG; Fri, 14 Feb 2014 18:00:09 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 45A907629A; Fri, 14 Feb 2014 17:52:48 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87ppmp3dxp.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242113>

On Fri, Feb 14, 2014 at 04:35:14PM +0100, David Kastrup wrote:
> Josef Wolf <jw@raven.inka.de> writes:
> > The only command in this script that uses "heads" is
> >
> >   git symbolic-ref HEAD "refs/heads/$new_branch"
> >
> You probably should check how $new_branch comes about.

This is the line of code where $new_branch is comes to live:

    my (undef, $new_branch, @new_path) = split ("/", $new_item);

So it is impossible that it might contain any slashes.

In any other situation, this script cares only about branches which start with
the string "scan-file-XXXX":

    sub local_branches  { grep {m+^scan-file-+} &all_branches; }
    sub remote_branches { grep {m+^remotes/origin/scan-file-+} &all_branches; }

This is hard-coded, so I can't see any way for the user to inject "refs/heads"

> Also, once a
> directory refs/heads/refs/heads exists, "refs/heads/$new_branch" may
> possibly be resolved as a branch with the name refs/heads/$new_branch.

Can you elobarte on this? I don't get what you are trying to say.

As I already said, this happens on opensuse with git-1.8.1.4.
I have not yet seen this problem on ubuntu with  git-1.7.9.5.

-- 
Josef Wolf
jw@raven.inka.de
