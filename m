From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-am: force egrep to use correct characters set
Date: Sun, 27 Sep 2009 03:40:15 -0400
Message-ID: <20090927074015.GB15393@coredump.intra.peff.net>
References: <215cc4f241162377b9249c2b3d74050cc77bac16.1253893253.git.chressie@gmail.com>
 <f0bd48168975c3b2328cf26f9a37a0f54b898473.1253896646.git.chressie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Christian Himpel <chressie@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 27 09:40:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MroMu-0005Yd-B2
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 09:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbZI0HkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 03:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753340AbZI0HkO
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 03:40:14 -0400
Received: from peff.net ([208.65.91.99]:44827 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299AbZI0HkN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 03:40:13 -0400
Received: (qmail 18651 invoked by uid 107); 27 Sep 2009 07:43:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 27 Sep 2009 03:43:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Sep 2009 03:40:15 -0400
Content-Disposition: inline
In-Reply-To: <f0bd48168975c3b2328cf26f9a37a0f54b898473.1253896646.git.chressie@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129196>

On Fri, Sep 25, 2009 at 06:43:20PM +0200, Christian Himpel wrote:

> According to egrep(1) the US-ASCII table is used when LC_ALL=C is set.
> We do not rely here on the LC_ALL value we get from the environment.

Hmm. Probably makes sense here, as it is a wide enough range that it may
pick up other stray non-ascii characters in other charsets (though as
the manpage notes, the likely thing is to pick up A-Z along with a-z,
which is OK here as we encompass both in our range).

There are two other calls to egrep with brackets (both in
git-submodule.sh), but they are just [0-7], which is presumably OK in
just about any charset.

Do you happen to know a charset in which this is a problem, just for
reference?

-Peff
