From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH] Embed an application manifest on MinGW
Date: Sat, 28 May 2011 22:44:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1105282241510.11411@bonsai2>
References: <1306612707-29748-1-git-send-email-cesarb@cesarb.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Cesar Eduardo Barros <cesarb@cesarb.net>
X-From: git-owner@vger.kernel.org Sat May 28 22:44:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQQMx-0007nM-MS
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 22:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106Ab1E1UoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 16:44:18 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:41414 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755581Ab1E1UoS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 16:44:18 -0400
Received: (qmail invoked by alias); 28 May 2011 20:44:15 -0000
Received: from pD9EB207C.dip0.t-ipconnect.de (EHLO noname) [217.235.32.124]
  by mail.gmx.net (mp049) with SMTP; 28 May 2011 22:44:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX197VDscStJ77J3/8JZAhvyxFrSfH98n9Df66b/6f5
	0G2AeQmu7hKDG2
X-X-Sender: gene099@bonsai2
In-Reply-To: <1306612707-29748-1-git-send-email-cesarb@cesarb.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174676>

Hi,

On Sat, 28 May 2011, Cesar Eduardo Barros wrote:

> [...]
> @@ -1551,6 +1554,11 @@ ifdef USE_NED_ALLOCATOR
>         COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
>  endif
>  
> +ifdef APPLICATION_MANIFEST
> +	# Cannot be in LIB_OBJS because it must always be linked in
> +	RESOURCE_OBJS += compat/win32/resource.o
> +endif
> +
>  ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
>  	export GIT_TEST_CMP_USE_COPIED_CONTEXT
>  endif
> [...]
>  
> -git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
> +git$X: git.o $(BUILTIN_OBJS) $(RESOURCE_OBJS) $(GITLIBS)
> [...]
>  
> -git-%$X: %.o $(GITLIBS)
> +git-%$X: %.o $(RESOURCE_OBJS) $(GITLIBS)
> [...]
>  
> -git-imap-send$X: imap-send.o $(GITLIBS)
> +git-imap-send$X: imap-send.o $(RESOURCE_OBJS) $(GITLIBS)
> [...]
>  
> -git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
> +git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(RESOURCE_OBJS) $(GITLIBS)
> [...]
> -git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
> +git-http-push$X: revision.o http.o http-push.o $(RESOURCE_OBJS) $(GITLIBS)
> [...]
>  
> -$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o $(GITLIBS)
> +$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o $(RESOURCE_OBJS) $(GITLIBS)
> [...]
>  
> -test-%$X: test-%.o $(GITLIBS)
> +test-%$X: test-%.o $(RESOURCE_OBJS) $(GITLIBS)
> [...]

Is it possible that adding the resource object to GITLIBS would reduce the 
patch and be "more correct", too?

Thanks,
Johannes
