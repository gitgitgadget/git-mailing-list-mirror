From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/14] Change git_connect() to return a struct child_process
 instead of a pid_t.
Date: Sun, 14 Oct 2007 01:57:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710140156100.25221@racer.site>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-2-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Oct 14 02:57:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgrnZ-0004Jo-Ut
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 02:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344AbXJNA5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 20:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbXJNA5c
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 20:57:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:36150 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752214AbXJNA5b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 20:57:31 -0400
Received: (qmail invoked by alias); 14 Oct 2007 00:57:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 14 Oct 2007 02:57:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dFyBSbJbdr9Ylm63Yg1CWxHTQ/qpgTMYLS5FAuC
	pviEyhTOXA5vM9
X-X-Sender: gene099@racer.site
In-Reply-To: <1192305984-22594-2-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60788>

Hi,

On Sat, 13 Oct 2007, Johannes Sixt wrote:

> -int finish_connect(pid_t pid)
> +int finish_connect(struct child_process *conn)
>  {
> -	if (pid == 0)
> +	if (conn == NULL)
>  		return 0;
>  
> -	while (waitpid(pid, NULL, 0) < 0) {
> +	while (waitpid(conn->pid, NULL, 0) < 0) {
>  		if (errno != EINTR)
>  			return -1;

Just for completeness' sake: could you do a free(conn); before return -1;?

Thanks,
Dscho
