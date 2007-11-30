From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] transport.c: call dash-less form of receive-pack and
 upload-pack on remote
Date: Fri, 30 Nov 2007 12:08:20 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711301207020.27959@racer.site>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
 <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src>
 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com>
 <alpine.LFD.0.99999.0711290905510.9605@xanadu.home> <7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
 <DB613F3E-85CC-4AF0-928C-4F4E4C8E9FB8@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Fri Nov 30 13:09:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy4g0-0001e4-KL
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 13:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbXK3MIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 07:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbXK3MIh
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 07:08:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:46215 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754098AbXK3MIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 07:08:36 -0500
Received: (qmail invoked by alias); 30 Nov 2007 12:08:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp012) with SMTP; 30 Nov 2007 13:08:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/IIVd0ia/IeQCZtR9c8Whs3I9ea8iumMqXekDqp/
	ibXvWzmDfdkR7m
X-X-Sender: gene099@racer.site
In-Reply-To: <DB613F3E-85CC-4AF0-928C-4F4E4C8E9FB8@orakel.ntnu.no>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66636>


Since we plan to move the dash-form (git-<whatever>) into an execdir, it
make sense to prepare our git protocol users for it.

Noticed by Eyvind Bernhardsen.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 30 Nov 2007, Eyvind Bernhardsen wrote:

	> - When pushing to my system over ssh, git-receive-pack and
	> git-upload-pack are expected to be in $PATH.  I resolved the 
	> problem by putting symlinks in /usr/local/bin.

	How about this?  (I only compile-tested it...)

 transport.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport.c b/transport.c
index 50db980..7bd0846 100644
--- a/transport.c
+++ b/transport.c
@@ -736,10 +736,10 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->disconnect = disconnect_git;
 
 		data->thin = 1;
-		data->uploadpack = "git-upload-pack";
+		data->uploadpack = "git upload-pack";
 		if (remote && remote->uploadpack)
 			data->uploadpack = remote->uploadpack;
-		data->receivepack = "git-receive-pack";
+		data->receivepack = "git receive-pack";
 		if (remote && remote->receivepack)
 			data->receivepack = remote->receivepack;
 	}
-- 
1.5.3.6.2088.g8c260
