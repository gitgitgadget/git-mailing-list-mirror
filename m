From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] post-receive-email: defend against non UTF-8
 i18n.logoutputencoding setting
Date: Thu, 8 Mar 2012 08:50:30 -0500
Message-ID: <20120308135030.GB30602@sigill.intra.peff.net>
References: <20120308115119.GA2604@burratino>
 <20120308115957.GB2750@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Gerrit Pape <pape@smarden.org>,
	Alexey Shumkin <zapped@mail.ru>, Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jon Jensen <jon@endpoint.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 14:50:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5djs-0005Kr-P3
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 14:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361Ab2CHNud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 08:50:33 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44672
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754745Ab2CHNuc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 08:50:32 -0500
Received: (qmail 7058 invoked by uid 107); 8 Mar 2012 13:50:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Mar 2012 08:50:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Mar 2012 08:50:30 -0500
Content-Disposition: inline
In-Reply-To: <20120308115957.GB2750@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192601>

On Thu, Mar 08, 2012 at 05:59:57AM -0600, Jonathan Nieder wrote:

> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> index dc184d0b..b59e03cd 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -464,7 +464,7 @@ generate_delete_branch_email()
>  	echo "       was  $oldrev"
>  	echo ""
>  	echo $LOGBEGIN
> -	git show -s --pretty=oneline $oldrev
> +	git diff-tree --encoding=UTF-8 -s --pretty=oneline $oldrev
>  	echo $LOGEND

If you are using "-s" to suppress diff output, why are you using
diff-tree? Wouldn't "rev-list -1" (or "rev-list --no-walk") work equally
well and be a little more obvious?

-Peff
