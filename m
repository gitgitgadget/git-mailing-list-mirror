From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 15:04:56 -0700
Message-ID: <20090603220456.GQ3355@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <200906032220.00238.jnareb@gmail.com> <20090603202429.GO3355@spearce.org> <200906040004.18594.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 00:05:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MByaU-0003XD-10
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 00:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbZFCWEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 18:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754382AbZFCWEz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 18:04:55 -0400
Received: from george.spearce.org ([209.20.77.23]:51994 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbZFCWEy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 18:04:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7E02F381D1; Wed,  3 Jun 2009 22:04:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906040004.18594.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120653>

Jakub Narebski <jnareb@gmail.com> wrote:
> So do I understand correctly that capabilities are governed by the
> following generic rules:
> 
> 1. Server sends space separated list of capabilities it support. It
>    MUST NOT send capabilities it *does not* support. It MAY NOT send
>    "include-tag" if there are no tag objects (or is it SHOULD NOT?).

The server SHOULD send include-tag, if it supports it, irregardless
of whether or not there are tags available.  Its just easier to
code the server to send the R@!* line up front based on the software
version, and not the repository content.

> 2. Client sends space separated list of capabilities it wants. It SHOULD
>    (or perhaps it is MAY?) send subset of server capabilities, i.e do
>    not send capabilities served does not advertise.

It SHOULD send a subset of server capabilities.

> 3. Server MUST ignore capabilities it does not understand.

True.

> Server MUST NOT ignore capabilities (or SHOULD NOT only?) that
> client requested and server advertised.

True, MUST NOT.  Otherwise you will have protocol errors.

However, include-tag can be SHOULD NOT... since the client must be
able to recover from it anyway.

> I know that client MUST send only maximum of one of "side-band" and 
> "side-band-64k", but how should server reacts if client sends both?
> Should it use "side-band-64k"?

MUST favor side-band-64k if client requests both.

-- 
Shawn.
