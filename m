From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [PATCH] Add warning about known issues to documentation of	cvsimport
Date: Mon, 23 Mar 2009 21:33:55 +0100
Message-ID: <49C7F233.9050205@pelagic.nl>
References: <20090323195304.GC26678@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 21:35:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llqs3-0002tX-Up
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 21:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264AbZCWUeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 16:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbZCWUeI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 16:34:08 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:36923 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751779AbZCWUeG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 16:34:06 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id EAACF58BD88;
	Mon, 23 Mar 2009 21:33:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090323195304.GC26678@macbook.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114348>

Heiko Voigt wrote:
> The described issues are compiled from the tests by Michael Haggerty and me.
> Because it is not apparent that these can be fixed anytime soon at least warn
> unwary users not to rely on the inbuilt cvsimport to much.
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  Documentation/git-cvsimport.txt |   34 ++++++++++++++++++++++++++++++++++
>  1 files changed, 34 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
> index b7a8c10..3123725 100644
> --- a/Documentation/git-cvsimport.txt
> +++ b/Documentation/git-cvsimport.txt
> @@ -24,6 +24,9 @@ repository, or incrementally import into an existing one.
>  Splitting the CVS log into patch sets is done by 'cvsps'.
>  At least version 2.1 is required.
>  
> +*WARNING:* for certain situations the import leads to incorrect results.
> +Please see the section <<issues,ISSUES>> for further reference.
> +
>  You should *never* do any work of your own on the branches that are
>  created by 'git-cvsimport'.  By default initial import will create and populate a
>  "master" branch from the CVS repository's main branch which you're free
> @@ -164,6 +167,37 @@ If '-v' is specified, the script reports what it is doing.
>  Otherwise, success is indicated the Unix way, i.e. by simply exiting with
>  a zero exit status.
>  
> +[[issues]]
> +ISSUES
> +------
> +Problems related to timestamps:
> +
> + * If timestamps of commits in the cvs repository are not stable enough
> +   to be used for ordering commits
> + * If any files were ever "cvs import"ed more than once (e.g., import of
> +   more than one vendor release)
> + * If the timestamp order of different files cross the revision order
> +   within the commit matching time window
> +
> +Problems related to branches:
> +
> + * Branches on which no commits have been made are not imported
> + * All files from the branching point are added to a branch even if
> +   never added in cvs
> + * files added to the source branch *after* a daughter branch was
> +   created: If previously no commit was made on the daugther branch they
> +   will erroneously be added to the daughter branch in git
> +
> +Problems related to tags:
> +
> +* Multiple tags on the same revision are not imported
> +
> +If you suspect that any of these issues may apply to the repository you
> +want to import consider using these alternative tools which proved to be
> +more stable in practise:
> +
> +* cvs2git (part of cvs2svn), `http://cvs2svn.tigris.org`
> +* parsecvs, `http://cgit.freedesktop.org/~keithp/parsecvs`
>  
>  Author
>  ------
maybe you can also add remarks about autocrlf and safecrlf?
both need to be off
