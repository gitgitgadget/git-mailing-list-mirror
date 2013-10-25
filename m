From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] Update documentation for http.continue option
Date: Fri, 25 Oct 2013 03:17:06 -0400
Message-ID: <20131025071706.GA17029@sigill.intra.peff.net>
References: <1381530945-90590-3-git-send-email-sandals@crustytoothpaste.net>
 <20131011235052.GV9464@google.com>
 <20131012002639.GE79408@vauxhall.crustytoothpaste.net>
 <20131018221535.GM865149@vauxhall.crustytoothpaste.net>
 <xmqqeh7csygy.fsf@gitster.dls.corp.google.com>
 <20131022233257.GA9464@google.com>
 <20131023013400.GB9464@google.com>
 <20131023030048.GX865149@vauxhall.crustytoothpaste.net>
 <CAJo=hJssxNtJSeLgwG5nON=Y-7HzZPULiwzH+0SXeU8tp3FC-A@mail.gmail.com>
 <20131023225632.GZ865149@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 09:17:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZbe4-0006we-VB
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 09:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab3JYHRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 03:17:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:55389 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751182Ab3JYHRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 03:17:09 -0400
Received: (qmail 7103 invoked by uid 102); 25 Oct 2013 07:17:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Oct 2013 02:17:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 03:17:06 -0400
Content-Disposition: inline
In-Reply-To: <20131023225632.GZ865149@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236691>

On Wed, Oct 23, 2013 at 10:56:32PM +0000, brian m. carlson wrote:

> On Tue, Oct 22, 2013 at 08:21:48PM -0700, Shawn Pearce wrote:
> > From my perspective, it is OK to defaulting to use 100-continue if the
> > server supports Negotiate. If the user is stuck behind a broken proxy
> > and can't authenticate, they can't authenticate. They can either set
> > the variable to false, or fix their proxy, or use a different server,
> > etc.
> 
> I think Jonathan's suggestion was to get rid of the variable altogether
> and simply make the code conditional on whether the server is offering
> GSS-Negotiate.  I plan to make the use of 100-continue conditional on
> large_request as well, so that it only covers the case where it would
> otherwise fail.

I think that makes sense. Would you also want to suppress the probe
request in that case? It serves the same purpose, but would cause you to
do an extra auth for no reason (which potentially means user input,
which is annoying).

Also, if I recall your original complaint correctly, the "Expect"
handling was only half of the problem. Wasn't there also an issue where
git prompts for a password, even though GSS-Negotiate doesn't use it? Do
you have a plan for that?

-Peff
