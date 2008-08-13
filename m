From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-daemon: Simplify child management and associated
	logging by
Date: Wed, 13 Aug 2008 08:20:08 +0200
Message-ID: <20080813062008.GA4345@blimp.local>
References: <20080812193613.32388.92145.stgit@aristoteles.cuci.nl> <20080812212534.6871.19377.stgit@aristoteles.cuci.nl> <20080812223224.GA4134@steel.home> <20080812231210.GB15265@cuci.nl>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Aug 13 08:21:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT9jQ-000256-3Z
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 08:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbYHMGUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 02:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbYHMGUM
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 02:20:12 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:39069 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbYHMGUL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 02:20:11 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20lf5y8=
Received: from tigra.home (Fab06.f.strato-dslnet.de [195.4.171.6])
	by post.webmailer.de (klopstock mo19) (RZmta 16.47)
	with ESMTP id C071a5k7D3OLFs ; Wed, 13 Aug 2008 08:20:08 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 707D4277AE;
	Wed, 13 Aug 2008 08:20:08 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 4BE3C36D1A; Wed, 13 Aug 2008 08:20:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080812231210.GB15265@cuci.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92180>

Stephen R. van den Berg, Wed, Aug 13, 2008 01:12:10 +0200:
> Alex Riesen wrote:
> >Stephen R. van den Berg, Tue, Aug 12, 2008 23:25:35 +0200:
> >> @@ -1105,6 +1026,10 @@ int main(int argc, char **argv)
> >>  			init_timeout = atoi(arg+15);
> >>  			continue;
> 
> >> +		if (!prefixcmp(arg, "--max-connections=")) {
> >> +			max_connections = atoi(arg+18);
> 
> >An error checking wouldn't go amiss. And it can't be done with atoi
> >(consider strtol).
> 
> I merely copied the other argument parsing methods, didn't want to
> improve this, just functionally equivalent (will do fine here, IMO).

In case of error max_connections will be 0. How does your code handle
it? It is a server side program, which supposed to provide reliable
service. In this case, an operator mistake is not even noticable until
the first request and even than the clients have to complain first.
