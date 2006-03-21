From: Jeff King <peff@peff.net>
Subject: Re: efficient cloning
Date: Tue, 21 Mar 2006 04:19:16 -0500
Message-ID: <20060321091916.GA17125@coredump.intra.peff.net>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us> <7vbqw1nakz.fsf@assigned-by-dhcp.cox.net> <7vu09tjy38.fsf@assigned-by-dhcp.cox.net> <200603201730.19373.Josef.Weidendorfer@gmx.de> <7voe00iupp.fsf@assigned-by-dhcp.cox.net> <20060320232101.GQ18185@pasky.or.cz> <7vfylcismx.fsf@assigned-by-dhcp.cox.net> <441FB715.1000500@op5.se> <7v4q1sgpet.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Mar 21 10:19:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLd1Q-00044n-IF
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 10:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWCUJTU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 04:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWCUJTT
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 04:19:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:64474 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S932353AbWCUJTS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Mar 2006 04:19:18 -0500
Received: (qmail 57132 invoked from network); 21 Mar 2006 09:19:16 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 21 Mar 2006 09:19:16 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Mar 2006 04:19:16 -0500
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v4q1sgpet.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17779>

On Tue, Mar 21, 2006 at 12:42:02AM -0800, Junio C Hamano wrote:

> The reason I would like to avoid .git/remotes/$origin is because
> it is designed to be Porcelainish thing.  The underlying C-level
> git-fetch-pack never sees it; instead the information fed to
> C-level is prepared by the upper layer using that file.  As far
> as I understand, Cogito does not understand it either, except
> that it ships with bash completion code that reads from
> filenames there.

Then why not create .git/refs/remotes/$origin/HEAD at the time of clone
(or later)? Then the core looks for:
  (current order, .git/refs, etc)
  .git/refs/remotes/foo
  .git/refs/remotes/foo/HEAD
The porcelain can take care of managing the contents of HEAD. If there
is no HEAD in the directory, then it cannot be looked up by 'foo'
('foo/remote-branch' must be used instead).

-Peff
