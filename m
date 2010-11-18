From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] t9157-git-svn-fetch-merge.sh: remove dependency on
 subversion 1.5
Date: Thu, 18 Nov 2010 16:15:59 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1011181606340.14285@dr-wily.mit.edu>
References: <1287737937.3785.15.camel@balanced-tree> <1287798958-22549-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: normalperson@yhbt.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 22:21:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJBuw-00015H-Ig
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 22:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760515Ab0KRVVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 16:21:05 -0500
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:54890 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760529Ab0KRVVE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Nov 2010 16:21:04 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Nov 2010 16:21:04 EST
X-AuditID: 12074425-b7c98ae000000a04-16-4ce597924714
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Brightmail Gateway) with SMTP id A5.3D.02564.29795EC4; Thu, 18 Nov 2010 16:16:02 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id oAILG1fN017480;
	Thu, 18 Nov 2010 16:16:01 -0500
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id oAILG061027706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 18 Nov 2010 16:16:00 -0500 (EST)
In-Reply-To: <1287798958-22549-1-git-send-email-stevenrwalter@gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161713>

Junio: Did this get lost?  It fixes a test suite regression between 
v1.7.3.1 and v1.7.3.2 on systems with Subversion 1.4.

Steven: Can you sign off on your commit?

Anders

On Fri, 22 Oct 2010, Steven Walter wrote:

> Specify a revision range to "merge" and manually set the svn:mergeinfo
> property.
> ---
>  t/t9157-git-svn-fetch-merge.sh |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t9157-git-svn-fetch-merge.sh b/t/t9157-git-svn-fetch-merge.sh
> index da582c5..424e1fa 100755
> --- a/t/t9157-git-svn-fetch-merge.sh
> +++ b/t/t9157-git-svn-fetch-merge.sh
> @@ -25,15 +25,19 @@ test_expect_success 'initialize source svn repo' '
>  		svn add baz &&
>  		svn commit -m x &&
>  		svn switch "$svnrepo"/trunk &&
> -		svn merge "$svnrepo"/branches/branch1 &&
> +		svn merge -r3:7 "$svnrepo"/branches/branch1 &&
> +		svn propset svn:mergeinfo "/branches/branch1:4-7" . &&
>  		svn commit -m "merge" &&
>  		svn switch "$svnrepo"/branches/branch1 &&
>  		svn commit -m x &&
>  		svn switch "$svnrepo"/branches/branch2 &&
> -		svn merge "$svnrepo"/branches/branch1 &&
> +		svn merge -r3:8 "$svnrepo"/branches/branch1 &&
> +		svn propset svn:mergeinfo "/branches/branch1:4-8" . &&
>  		svn commit -m "merge branch1" &&
>  		svn switch "$svnrepo"/trunk &&
> -		svn merge "$svnrepo"/branches/branch2 &&
> +		svn merge -r5:9 "$svnrepo"/branches/branch2 &&
> +		svn propset svn:mergeinfo "/branches/branch1:4-8
> +/branches/branch2:6-9" . &&
>  		svn resolved baz &&
>  		svn commit -m "merge branch2"
>  	) &&
> -- 
> 1.6.3.3
> 
> 
