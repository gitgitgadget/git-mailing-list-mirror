From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Fix tracing when GIT_TRACE is set to an empty string.
Date: Sat, 14 Oct 2006 21:55:32 +0200
Message-ID: <200610142155.32816.chriscool@tuxfamily.org>
References: <20061014160525.c013e6d2.chriscool@tuxfamily.org> <7vodseahty.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 14 21:49:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYpV5-0000zR-V1
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 21:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbWJNTst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 15:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbWJNTst
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 15:48:49 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:6873 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1752140AbWJNTss (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Oct 2006 15:48:48 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 6977175C17;
	Sat, 14 Oct 2006 21:48:45 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.4
In-Reply-To: <7vodseahty.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28888>

Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
> >  trace.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/trace.c b/trace.c
> > index f9efc91..495e5ed 100644
> > --- a/trace.c
> > +++ b/trace.c
> > @@ -55,7 +55,8 @@ static int get_trace_fd(int *need_close)
> >  {
> >  	char *trace = getenv("GIT_TRACE");
> >
> > -	if (!trace || !strcmp(trace, "0") || !strcasecmp(trace, "false"))
> > +	if (!trace || !strcmp(trace, "") ||
> > +	    !strcmp(trace, "0") || !strcasecmp(trace, "false"))
> >  		return 0;
> >  	if (!strcmp(trace, "1") || !strcasecmp(trace, "true"))
> >  		return STDERR_FILENO;
> > --
> > 1.4.3.rc2.gadba
>
> This means that
>
> 	GIT_TRACE= git-foo
> and
> 	unset GIT_TRACE ; git-foo
>
> should behave the same way, right?

Yes, that's the goal of this patch.

> If so that sounds sensible.

Thanks,
Christian.
