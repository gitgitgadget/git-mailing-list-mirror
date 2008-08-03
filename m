From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: More on git over HTTP POST
Date: Sat, 2 Aug 2008 21:10:14 -0700
Message-ID: <20080803041014.GD27465@spearce.org>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org> <20080803025602.GB27465@spearce.org> <7v63qiydzg.fsf@gitster.siamese.dyndns.org> <48952A62.6050709@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 06:11:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPUwA-0002sQ-Ki
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 06:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbYHCEKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 00:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbYHCEKQ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 00:10:16 -0400
Received: from george.spearce.org ([209.20.77.23]:33873 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbYHCEKP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 00:10:15 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8C07C38419; Sun,  3 Aug 2008 04:10:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48952A62.6050709@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91203>

"H. Peter Anvin" <hpa@zytor.com> wrote:
> Junio C Hamano wrote:
>>  For example, putting them [capabilities] on extra HTTP headers is probably Ok.
>
> I think that would be a mistake, just because it's one more thing for  
> proxies to screw up on.

I didn't realize we were in an era of proxies that are that
brain-damaged that they cannot relay the other headers.  The Amazon
S3 service relies heavily upon their own extended headers to make
their REST API work.  If proxies stripped that stuff out then the
client wouldn't work at all.

IOW I had thought we were past this dark age of the Internet.

> It's better to have negotiation information in  
> the payload, before the "real" data.

I guess I could do that.  At least for the really complex stuff.

> Obviously one thing that needs to be included in each transaction is a  
> transaction ID that will be reported back on the next transaction, since  
> you can't rely on a persistent connection.

No.  That requires the server to maintain state.  We don't want to
do that if we can avoid it.  I would much rather have the clients
handle the state management as it simplifies the server side,
especially when you start talking about reverse proxies and/or
load-balancers running in front of the server farm.

-- 
Shawn.
