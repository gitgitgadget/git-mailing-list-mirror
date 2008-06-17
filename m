From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-rerere: fix a small leak
Date: Tue, 17 Jun 2008 11:34:29 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806171133330.6439@racer>
References: <7vk5go7cek.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 12:37:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8YZB-0008BK-F7
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 12:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbYFQKgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 06:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbYFQKgI
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 06:36:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:59596 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751605AbYFQKgH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 06:36:07 -0400
Received: (qmail invoked by alias); 17 Jun 2008 10:36:05 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp043) with SMTP; 17 Jun 2008 12:36:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RZfNnOOwRrVb1z8QFh0oWQY63SqM5kpLkkPrzXz
	YngobIrvILHniA
X-X-Sender: gene099@racer
In-Reply-To: <7vk5go7cek.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85287>

Hi,

On Tue, 17 Jun 2008, Junio C Hamano wrote:

> The data read from MERGE_RR file is kept in path-list by hanging textual
> 40-byte conflict signature to path of the blob that contains the
> conflict.  The signature is strdup'ed twice, and the second copy is given
> to the path-list, leaking the first copy.
> 
> Signed-off-by: Junio C Hamano <junio@pobox.com>
> ---
>  * Am I overlooking something obvious, or is this simply a never-reviewed
>    buglet that nobody has noticed for a long time?

I think that it was a never-reviewed buglet.  The only code path leading 
to read_rr passes merge_rr, which has strdup_paths == 1.

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Ciao,
Dscho
