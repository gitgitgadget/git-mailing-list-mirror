From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 17:17:11 +0100
Message-ID: <20100113161711.GB17687@inner.home.ulmdo.de>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi> <fcaeb9bf1001130539p2971caavd101d46de9269769@mail.gmail.com> <20100113135753.GA7095@Knoppix> <20100113141218.GA17687@inner.home.ulmdo.de> <20100113144745.GA7246@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 13 17:17:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV5uP-0001Nn-3E
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 17:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936Ab0AMQRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 11:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755488Ab0AMQRS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 11:17:18 -0500
Received: from continuum.iocl.org ([213.146.114.200]:61958 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224Ab0AMQRS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 11:17:18 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id o0DGHBg09810;
	Wed, 13 Jan 2010 17:17:11 +0100
Content-Disposition: inline
In-Reply-To: <20100113144745.GA7246@Knoppix>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136837>

On Wed, 13 Jan 2010 16:47:47 +0000, Ilari Liusvaara wrote:
...
> > It doesn't need to, really. stunnel sets the environment variable
> > SSL_CLIENT_DN with the distinguished name of the client certificate,
> > which can be used in the hook scripts ('update') on the server.
> 
> That would be useless. Data about authenticated client needs to fed to
> authorization decisions already before invoking git.

If you don't want public read access then you need to wedge a script
between stunnel and git itself that checks whether authentication is
present, yes.

> And besides: Gits:// uses certificates as keypairs,

My gripe with this is that I would expect gits: to be the same
as git: except that there is SSL underneath. git: does not have
authentication, so there should be none in gits: except what
SSL provides. (And the auth via unix domain sockets would be
usable for plain git: as well; there is no reason to encrypt
local traffic?)

(Is the unix auth via unix domain sockets part of GnuTLS?)

> which would make DN
> data absolutely useless because it is untrustworthy. And adding PKI
> is way too complicated.

That's another story. I think that it would be possible nowadays
to implement gits:// (in both ways) via core.gitproxy and a server-side
wrapper program (stunnel or else), but that has the disadvantage of
being unable to just provide a clone url without installing special
software besides git.

...
> The authentication support for smart-http seems pretty bad (making the
> old mistake of not binding authentications).

Mind to explain 'binding authentications'?

Andreas
