From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Thu, 22 Mar 2007 04:33:31 -0400
Message-ID: <20070322083330.GA16915@segfault.peff.net>
References: <20070321120643.GI20583@mellanox.co.il> <7v648u38ws.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 09:33:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUIjO-0000Mg-Ry
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 09:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965850AbXCVIdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 04:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965854AbXCVIdG
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 04:33:06 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2632 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965850AbXCVIdF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 04:33:05 -0400
Received: (qmail 16935 invoked by uid 1000); 22 Mar 2007 04:33:31 -0400
Content-Disposition: inline
In-Reply-To: <7v648u38ws.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42847>

On Wed, Mar 21, 2007 at 08:37:07AM -0700, Junio C Hamano wrote:

> I often hear from people who seems to like "fetch & merge",
> instead of "pull & reset ORIG_HEAD", as a workflow to avoid
> undesirable merging.  This might largely be a matter of taste,
> but from philosophical point of view, fetch & merge is a sign of
> distrust (your default is not to merge, and you merge only when
> you choose to), and pull & reset is the opposite (your default
> is to merge, and after you inspect you may choose not to merge).
> Tool support to encourage the former feels somewhat wrong.

I don't think it necessarily means distrust; I always do a fetch +
inspect + merge, and I am often fetching my own code to a different
platform!

My reason is that the inspect step takes an arbitrary amount of time,
and I don't want to lose my place. That is, I might go eat dinner in the
middle of the 'inspect' and then come back. By using my branch head as a
checkpoint, I am recording "I have inspected up to my master"; when I am
done inspecting, the merge moves my checkpoint forward. That way I never
fail to look over the commits; I don't do this out of distrust, but
because I want to see all of the commits.

I could just use FETCH_HEAD, but it is easy to overwrite accidentally
(if I do another git-fetch after dinner, not realizing I'm in the middle
of an inspection already, or if I'm looking to grab more changes). I
could also use the reflog, but it will also change if I fetch again in
the middle.

Of course, I use this for small-ish projects like git, or personal
projects. I don't think trying to glance over every commit to the kernel
would be scalable.

-Peff
