From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: [PATCH] http/ftp: optionally ask curl to not use EPSV command
Date: Fri, 29 Sep 2006 03:07:54 +0300
Message-ID: <20060929000754.GK10617@sashak.voltaire.com>
References: <20060928192605.GD10617@sashak.voltaire.com> <7vejtvu1ja.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 02:03:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT5q9-0000b3-JG
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 02:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161394AbWI2ACu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 20:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161407AbWI2ACu
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 20:02:50 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:25810 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1161394AbWI2ACt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 20:02:49 -0400
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 29 Sep 2006 03:02:45 +0300
Received: by sashak (sSMTP sendmail emulation); Fri, 29 Sep 2006 03:07:54 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vejtvu1ja.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 29 Sep 2006 00:02:45.0585 (UTC) FILETIME=[978DC410:01C6E35A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28074>

On 14:25 Thu 28 Sep     , Junio C Hamano wrote:
> Sasha Khapyorsky <sashak@voltaire.com> writes:
> 
> > If GIT_CURL_FTP_NO_EPSV environment variable is defined, disable using
> > of EPSV ftp command (PASV will be used instead). This is helpful with
> > some "poor" ftp servers which doesn't support EPSV mode.
> >
> > Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>
> > ---
> >  http.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/http.c b/http.c
> > index 6c1937b..a966e6d 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -196,6 +196,9 @@ #endif
> >  
> >  	curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USER_AGENT);
> >  
> > +	if (getenv("GIT_CURL_FTP_NO_EPSV"))
> > +		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
> > +
> >  	return result;
> >  }
> >  
> > -- 
> > 1.4.2.1
> 
> Care to match this with existing ones?
> 
> $ git grep -e GIT_CURL -e GIT_SSL -e GIT_HTTP
> 
> tells you how they are handled and documented.  If you spot
> inconsistencies if any (e.g. some having config entry and some
> only environment -- I haven't checked), correcting them while
> you are at it might be a good thing as well.

Make sense. Will rework.

Sasha
