From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] transport-helper: remove duplicate free()
Date: Wed, 2 Dec 2009 11:23:56 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0912021120440.14365@iabervon.org>
References: <20091202153950.c18095b7.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 17:24:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFrzr-0000ly-Vl
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 17:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958AbZLBQXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 11:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754934AbZLBQXv
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 11:23:51 -0500
Received: from iabervon.org ([66.92.72.58]:41960 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754639AbZLBQXu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 11:23:50 -0500
Received: (qmail 11210 invoked by uid 1000); 2 Dec 2009 16:23:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Dec 2009 16:23:56 -0000
In-Reply-To: <20091202153950.c18095b7.rctay89@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134346>

On Wed, 2 Dec 2009, Tay Ray Chuan wrote:

> Remove the free() invocation on transport->data in release_helper(), as
> disconnect_helper() has already done so.

You need to remove the one in disconnect_helper, because the entire point 
of disconnect_helper as opposed to release_helper is to *not* free that 
memory. If you remove this one, you'll access freed memory in any case 
where the helper has to be quit and restarted.

	-Daniel
*This .sig left intentionally blank*
