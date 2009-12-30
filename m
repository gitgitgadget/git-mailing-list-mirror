From: Jeff King <peff@peff.net>
Subject: Re: Feature suggestion: support arguments for GIT_PROXY_COMMAND &
 core.gitproxy
Date: Wed, 30 Dec 2009 06:05:57 -0500
Message-ID: <20091230110557.GG22959@coredump.intra.peff.net>
References: <cone.1261179562.490491.4033.1000@toolshiner.phx1.kidfixit.com>
 <20091230121329.6117@nanako3.lavabit.com>
 <7vmy1051ik.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Joey Korkames <joey+floss@kidfixit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 12:06:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPwNT-00069o-6J
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 12:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbZL3LGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 06:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbZL3LGA
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 06:06:00 -0500
Received: from peff.net ([208.65.91.99]:51660 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752564AbZL3LGA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 06:06:00 -0500
Received: (qmail 5297 invoked by uid 107); 30 Dec 2009 11:10:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 30 Dec 2009 06:10:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Dec 2009 06:05:57 -0500
Content-Disposition: inline
In-Reply-To: <7vmy1051ik.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135887>

On Wed, Dec 30, 2009 at 12:06:43AM -0800, Junio C Hamano wrote:

> Nanako Shiraishi <nanako3@lavabit.com> writes:
> 
> > Junio, could you tell us what happened to this thread?
> >
> > I think this is probably related to the "textconv" change.
> 
> Yeah, you guessed right. I think the unified way to launch user specified
> programs would come first and then spawning proxy the same way as others
> would become trivial.

As a "7/6" on top of my other series, this should just be:

diff --git a/connect.c b/connect.c
index db965c9..838146c 100644
--- a/connect.c
+++ b/connect.c
@@ -432,6 +432,7 @@ static void git_proxy_connect(int fd[2], char *host)
 	argv[2] = port;
 	argv[3] = NULL;
 	memset(&proxy, 0, sizeof(proxy));
+	proxy.use_shell = 1;
 	proxy.argv = argv;
 	proxy.in = -1;
 	proxy.out = -1;

But I will leave it to somebody who actually uses the proxy feature to
test and submit a patch.

-Peff
