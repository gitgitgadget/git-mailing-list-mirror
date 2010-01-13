From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 19:35:20 +0100
Message-ID: <20100113183520.GA23674@inner.home.ulmdo.de>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi> <fcaeb9bf1001130539p2971caavd101d46de9269769@mail.gmail.com> <20100113135753.GA7095@Knoppix> <20100113141218.GA17687@inner.home.ulmdo.de> <20100113144745.GA7246@Knoppix> <20100113161711.GB17687@inner.home.ulmdo.de> <20100113173610.GA7609@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 13 19:35:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV84N-0003hV-IG
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 19:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576Ab0AMSf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 13:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755344Ab0AMSf2
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 13:35:28 -0500
Received: from continuum.iocl.org ([213.146.114.200]:62050 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970Ab0AMSf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 13:35:28 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id o0DIZKq02106;
	Wed, 13 Jan 2010 19:35:20 +0100
Content-Disposition: inline
In-Reply-To: <20100113173610.GA7609@Knoppix>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136853>

On Wed, 13 Jan 2010 19:36:10 +0000, Ilari Liusvaara wrote:
...
> That would violate layering badly. You need to decode the request
> first before you can authorize. And the git daemon does that.

Well, yes. The script hackery would just decide between 'is allowed
to read (or write commits)' and 'is allowed to modify refs'. On the
other hand, git-daemon does not do fine-grained (read: per-branch)
access control, you'd only prevent pushing commits at all.

...
> > (Is the unix auth via unix domain sockets part of GnuTLS?)
> 
> No, that server-only feature is part of the OS itself. In fact, it
> needs no client-side support.

Ok, then I'll be really interested in the server-side support and
the man pages on the whole stuff. Especially in how this is going
to be different from what ssh:// does or can do.

...
> GIT_PROXY abuse? There are even better ways: smart transport remote
> helpers (in next I think). Git can actually dispatch those (and yes,
> that's exactly what this uses).

Yeah, since the last mail I noticed that gitproxy is not quite what
some google hits suggest, and should have read the patch in some
more detail to find that gits is a remote helper.

Please consider my objections revoked, other than the claim that
it could be done with stunnel, however ugly that would be.

...
> Actually, that was little badly choosen term and not the true problem,
> but the basic problem is that one peer has to trust the the other peer's
> authentication for security of its own authentication.

I don't see how that would endanger the standard certificate auth in ssl
(client or server).

...
> HTTP basic auth can be trivially sniffed if attacker can become other end
> of the encrypted link

Of course, you have another problem in that case...also I'd personally
like to rely on ssl client certificates when using https.

Andreas
