From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: refactor lock-related headers creation for
 curl  requests
Date: Sat, 24 Jan 2009 05:11:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901240507070.13232@racer>
References: <be6fef0d0901231800t6943b01dwbca976d5e9f3397@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 05:12:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQZsg-0002xP-5i
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 05:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbZAXEK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 23:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754237AbZAXEK4
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 23:10:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:58328 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754164AbZAXEK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 23:10:56 -0500
Received: (qmail invoked by alias); 24 Jan 2009 04:10:53 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp064) with SMTP; 24 Jan 2009 05:10:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18OgGFh0OgOyIovKLunH/9KchS9nKC3lAtzcXWPoD
	POwLmyE8Qn6Dp5
X-X-Sender: gene099@racer
In-Reply-To: <be6fef0d0901231800t6943b01dwbca976d5e9f3397@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106951>

Hi,

On Sat, 24 Jan 2009, Ray Chuan wrote:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Make that an Acked-by:

> +	if(options & DAV_HEADER_IF) {
> +		strbuf_addf(&buf, "If: (<%s>)", lock->token);
> +		dav_headers = curl_slist_append(dav_headers, buf.buf);
> +		strbuf_reset(&buf);

BTW in case anyone is puzzled (like I was): curl_slist_append() takes a 
"char *" as second parameter, but does not take custody of the buffer; 
instead, it strdup()s it.  See
http://cool.haxx.se/cvs.cgi/curl/lib/sendf.c?rev=1.155&content-type=text/vnd.viewcvs-markup
for details.

BTNW this should be mentioned in the commit message, too, to spare other 
people the puzzlement.

Ciao,
Dscho
