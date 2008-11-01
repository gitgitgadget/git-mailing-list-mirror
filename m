From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] connect.c: add a way for git-daemon to pass an error
 back to client
Date: Sat, 1 Nov 2008 03:19:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811010316340.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <b97024a40810311859t2e5a6102u31ad4480e7c75c03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tom Preston-Werner <tom@github.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 03:14:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw60d-0006Mo-SQ
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 03:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbYKACMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 22:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbYKACMO
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 22:12:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:36666 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751267AbYKACMN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 22:12:13 -0400
Received: (qmail invoked by alias); 01 Nov 2008 02:12:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 01 Nov 2008 03:12:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18u8pNhVq8utiWyqDwvNfhFQalohfzc1B6w6bvKpt
	wmCSU3Tn6VSBuc
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <b97024a40810311859t2e5a6102u31ad4480e7c75c03@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99710>

Hi,

On Fri, 31 Oct 2008, Tom Preston-Werner wrote:

> The current behavior of git-daemon is to simply close the connection on
> any error condition. This leaves the client without any information as
> to the cause of the failed fetch/push/etc.
> 
> This patch allows get_remote_heads to accept a line prefixed with "ERR"
> that it can display to the user in an informative fashion. Once clients
> can understand this ERR line, git-daemon can be made to properly report
> "repository not found", "permission denied", or other errors.
> 
> Example
> 
> S: ERR No matching repository.
> C: fatal: remote error: No matching repository.

Makes sense to me.

The cute trick with this is that even older clients would be able to 
display the error, albeit with a sort of funny message:

	protocol error: expected sha/ref, got 'No matching repository.'

Ciao,
Dscho
