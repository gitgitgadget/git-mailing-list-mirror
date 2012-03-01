From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] http: try http_proxy env var when http.proxy
 config option is not set
Date: Thu, 1 Mar 2012 16:01:29 -0500
Message-ID: <20120301210129.GD17631@sigill.intra.peff.net>
References: <4F4FBE0F.6020004@seap.minhap.es>
 <7vy5rkm91t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, sam@vilain.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:01:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3D84-0006T3-WC
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 22:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640Ab2CAVBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 16:01:32 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34546
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932534Ab2CAVBb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 16:01:31 -0500
Received: (qmail 8803 invoked by uid 107); 1 Mar 2012 21:01:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Mar 2012 16:01:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Mar 2012 16:01:29 -0500
Content-Disposition: inline
In-Reply-To: <7vy5rkm91t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191970>

On Thu, Mar 01, 2012 at 11:10:38AM -0800, Junio C Hamano wrote:

> Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:
> 
> > CuRL already reads it, but if $http_proxy has username but no password
> > curl will not ask you for the password.. so we read it ourselves to
> > detect that and ask for the password.
> 
> Please stop the double-dot.  Also your capitalization for cURL is screwed
> up.
> 
> More importantly, please describe what happens after "will not ask".
> "will not ask you for the password and the connection fails"?
> "will not ask you for the password and the gives an error message saying
> 'authentication failure'"?

When we need to authenticate for the destination webserver, we detect an
HTTP 401, _then_ ask for the credentials, and retry the request. I'm
curious what the error condition is for the authentication failure, and
if we can do the same here (from a brief skim of rfc2616, it looks like
it should be a 407, but I do not even have a proxy set up to try).

-Peff
