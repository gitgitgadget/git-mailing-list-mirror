From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Mon, 04 Aug 2008 18:03:32 -0700
Message-ID: <4897A6E4.3070508@zytor.com>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org> <7vwsix7nhw.fsf@gitster.siamese.dyndns.org> <20080804035921.GB2963@spearce.org> <4896D19C.6040704@dawes.za.net> <20080804144824.GB27666@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rogan Dawes <lists@dawes.za.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 03:04:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQAyh-0001fU-KH
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 03:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757382AbYHEBDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 21:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755018AbYHEBDl
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 21:03:41 -0400
Received: from terminus.zytor.com ([198.137.202.10]:39165 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbYHEBDl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 21:03:41 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7513ZuS008749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2008 18:03:35 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7513YBh013231;
	Mon, 4 Aug 2008 18:03:34 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7513Wwj007523;
	Mon, 4 Aug 2008 18:03:33 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080804144824.GB27666@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/7941/Mon Aug  4 15:44:27 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91396>

Shawn O. Pearce wrote:
> 
> Currently git-http-backend requests no caching for info/refs, but
> I could see us tweaking that to permit several minutes of caching,
> especially on big public sites like kernel.org.  Having info/refs
> report stale by 5 minutes is not an issue when writes to there
> already have a lag due to the master-slave mirroring system in use.
> 
> Because git-http-backend emulates a dumb server there is a command
> dispatch table based upon the URL submitted.  Thus we already have
> the command dispatch behavior implemented in the URL and doing it
> in the POST body would only complicate the code further.
> 

Let's put it this way: we're not seeing a huge amount of load from git 
protocol requests, and I'm going to assume "git+http" protocol to be 
used only by sites behind braindamaged firewalls (everyone else would 
use git protocol), so I'm not really all that worried about it.

I'm not sure if "emulating a dumb server" is desirable at all; it seems 
like it would at least in part defeat the purpose of minimizing the 
transaction count and otherwise be as much of a "smart" server as the 
medium permits.

	-hpa
