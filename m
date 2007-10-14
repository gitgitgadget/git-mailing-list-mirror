From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 01/14] Change git_connect() to return a struct child_process instead of a pid_t.
Date: Sun, 14 Oct 2007 11:40:10 +0200
Message-ID: <200710141140.10597.johannes.sixt@telecom.at>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at> <1192305984-22594-2-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.64.0710140156100.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 11:40:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgzxP-0004iV-Qz
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 11:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbXJNJkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 05:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754880AbXJNJkO
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 05:40:14 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:49095 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583AbXJNJkM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 05:40:12 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 04EE1BF232;
	Sun, 14 Oct 2007 11:40:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id C283A58CE9;
	Sun, 14 Oct 2007 11:40:10 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0710140156100.25221@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60821>

On Sunday 14 October 2007 02:57, Johannes Schindelin wrote:
> Hi,
>
> On Sat, 13 Oct 2007, Johannes Sixt wrote:
> > -int finish_connect(pid_t pid)
> > +int finish_connect(struct child_process *conn)
> >  {
> > -	if (pid == 0)
> > +	if (conn == NULL)
> >  		return 0;
> >
> > -	while (waitpid(pid, NULL, 0) < 0) {
> > +	while (waitpid(conn->pid, NULL, 0) < 0) {
> >  		if (errno != EINTR)
> >  			return -1;
>
> Just for completeness' sake: could you do a free(conn); before return -1;?

I know. But the loop is going away with the next patch, so I didn't bother. 
Can you live with that?

-- Hannes
