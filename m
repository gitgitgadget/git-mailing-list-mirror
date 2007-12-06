From: Jeff King <peff@peff.net>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 02:15:03 -0500
Message-ID: <20071206071503.GA19504@coredump.intra.peff.net>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> <20071205.202047.58135920.davem@davemloft.net> <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com> <20071205.204848.227521641.davem@davemloft.net> <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> <1196918132.10408.85.camel@brick> <4aca3dc20712052117j3ef5cf99y848d4962ae8ddf33@mail.gmail.com> <9e4733910712052247x116cabb4q48ebafffb93f7e03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Berlin <dberlin@dberlin.org>,
	Harvey Harrison <harvey.harrison@gmail.com>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 08:15:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0AxD-0001md-SY
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 08:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbXLFHPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 02:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbXLFHPH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 02:15:07 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3483 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbXLFHPF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 02:15:05 -0500
Received: (qmail 28652 invoked by uid 111); 6 Dec 2007 07:15:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 06 Dec 2007 02:15:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2007 02:15:03 -0500
Content-Disposition: inline
In-Reply-To: <9e4733910712052247x116cabb4q48ebafffb93f7e03@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67263>

On Thu, Dec 06, 2007 at 01:47:54AM -0500, Jon Smirl wrote:

> The key to converting repositories of this size is RAM. 4GB minimum,
> more would be better. git-repack is not multi-threaded. There were a
> few attempts at making it multi-threaded but none were too successful.
> If I remember right, with loads of RAM, a repack on a 450MB repository
> was taking about five hours on a 2.8Ghz Core2. But this is something
> you only have to do once for the import. Later repacks will reuse the
> original deltas.

Actually, Nicolas put quite a bit of work into multi-threading the
repack process; the results have been in master for some time, and will
be in the soon-to-be-released v1.5.4.

The downside is that the threading partitions the object space, so the
resulting size is not necessarily as small (but I don't know that
anybody has done testing on large repos to find out how large the
difference is).

-Peff
