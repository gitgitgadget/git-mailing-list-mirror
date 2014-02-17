From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git http connection reuse
Date: Mon, 17 Feb 2014 18:47:11 -0500
Message-ID: <20140217234711.GA20499@sigill.intra.peff.net>
References: <20140216040538.GA4754@sigill.intra.peff.net>
 <377DF3F4-1F9B-4CB0-A9BF-658E561F4349@gmail.com>
 <alpine.DEB.2.00.1402161307160.10435@tvnag.unkk.fr>
 <alpine.DEB.2.00.1402161431230.10435@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Tue Feb 18 00:47:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFXuA-0002EJ-Cl
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 00:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbaBQXrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Feb 2014 18:47:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:52296 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751221AbaBQXrN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 18:47:13 -0500
Received: (qmail 24307 invoked by uid 102); 17 Feb 2014 23:47:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Feb 2014 17:47:13 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Feb 2014 18:47:11 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1402161431230.10435@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242270>

On Sun, Feb 16, 2014 at 02:33:06PM +0100, Daniel Stenberg wrote:

> On Sun, 16 Feb 2014, Daniel Stenberg wrote:
> 
> >Right, the problem is there to make sure that a NTLM-auth
> >connection with different credentials aren't re-used. NTLM with its
> >connection-oriented authentication breaks the traditional HTTP
> >paradigms and before this change there was a risk that libcurl
> >would wrongly re-use a NTLM connection that was done with different
> >credentials!
> >
> >I suspect we introduced a regression here with that fix. I'll dig into this.
> 
> Thanks for pointing this out!
> 
> I could repeat this problem with a curl test case so I wrote up two,
> and then I made a fix to curl:
> 
>   https://github.com/bagder/curl/commit/d765099813f5

Thanks for the quick turnaround. I've confirmed that your patch fixes
both my limited test case and Git itself (when using just the curl_easy
interface).

-Peff
