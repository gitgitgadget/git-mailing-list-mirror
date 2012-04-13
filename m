From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/5] http: try http_proxy env var when http.proxy
 config option is not set
Date: Fri, 13 Apr 2012 16:52:22 -0400
Message-ID: <20120413205222.GB7919@sigill.intra.peff.net>
References: <4F5F5392.5010700@seap.minhap.es>
 <20120413204858.GA7919@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri Apr 13 22:52:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SInTq-0005JT-KI
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 22:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830Ab2DMUwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 16:52:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33490
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755981Ab2DMUwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 16:52:25 -0400
Received: (qmail 12687 invoked by uid 107); 13 Apr 2012 20:52:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Apr 2012 16:52:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Apr 2012 16:52:22 -0400
Content-Disposition: inline
In-Reply-To: <20120413204858.GA7919@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195444>

On Fri, Apr 13, 2012 at 04:48:58PM -0400, Jeff King wrote:

> > +	if (!curl_http_proxy) {
> > +		const char *env_proxy, *no_proxy;
> > +		char *env_proxy_var;
> > +		int read_http_proxy;
> > +		struct strbuf buf = STRBUF_INIT;
> > +		credential_from_url(&cre_url, url);
> > +		strbuf_addf(&buf, "%s_proxy", cre_url.protocol);
> > +		env_proxy_var = strbuf_detach(&buf, NULL);
> > +		env_proxy = getenv(env_proxy_var);

Also, shouldn't we be checking HTTPS_PROXY in addition to https_proxy,
by curl's rules? Only http_proxy is not allowed to be upper-cased.

-Peff
