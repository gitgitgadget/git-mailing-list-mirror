From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: How to pull from windows box
Date: Thu, 16 Aug 2012 20:28:39 +0400
Message-ID: <20120816202839.3fb84d2a98ebf6c25c0cf9e1@domain007.com>
References: <502CF180.2030605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: "J.V." <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 18:33:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2316-0002ej-J7
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 18:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933056Ab2HPQdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 12:33:46 -0400
Received: from gw2.007spb.ru ([78.140.204.222]:53485 "EHLO mailhub.007spb.ru"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932996Ab2HPQdp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 12:33:45 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Aug 2012 12:33:45 EDT
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id q7GGSdTG006804;
	Thu, 16 Aug 2012 20:28:40 +0400
In-Reply-To: <502CF180.2030605@gmail.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 16 Aug 2012 07:11:28 -0600
"J.V." <jvsrvcs@gmail.com> wrote:

> We have a central/shared bare repo setup on a Linux box by our
> scc/build team.
> 
> Each developer pulls/pushes to this repo.  I have two windows boxes 
> where I have cloned the repo.  I want to commit and then on my second 
> windows box pull from my other box and keep those in sync until it is 
> time to push to central.
> 
> What do I need to setup on each Windows 7 box to get this working?

Create a regular Windows share for the project directory on the box
you want to fetch from, ensure your user from another box is able to
successfully authenticate on that share, and then on that box add
the created share as a remote like this:

git remote add otherbox file:////thatbox/sharename

To fetch from that "otherbox" remote you then go like this:
1) Run Windows Explorer, navigate to \\thatbox\sharename,
   authenticate (if needed).  This will ensure all the next accesses
   will be automatically authenticated.
2) Do `git fetch otherbox`.

Of course, you can just attach that share as a network drive and then
modify the URL for your remote accordingly.

Note that since the repos are normal (non-bare) this will work well only
for fetches (see the FAQ for more info).
