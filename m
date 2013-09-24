From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Tue, 24 Sep 2013 01:32:30 -0400
Message-ID: <20130924053230.GB5875@sigill.intra.peff.net>
References: <523094F0.9000509@gmail.com>
 <20130911182921.GE4326@google.com>
 <20130911191620.GB24251@sigill.intra.peff.net>
 <CAA01CsrN+VLw4WQmObvh72_MoH1Lyh9dQbizJcVhqyJoRyms-Q@mail.gmail.com>
 <CAPc5daVt4Q9twub5KyOQqZHx9CwOnkuwA97sXV44fF2j1e5HVg@mail.gmail.com>
 <CAA01CspCWFMGxXs9M3A1mtTctiUCCeJ9pJjHt=auMjhHHJU3Dg@mail.gmail.com>
 <20130919211659.GB16556@sigill.intra.peff.net>
 <024f85fe-96e9-4201-8b3a-2e15c9da53e8@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <junio@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 07:32:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOLEk-0003Wz-IL
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 07:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736Ab3IXFcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 01:32:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:53133 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab3IXFce (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 01:32:34 -0400
Received: (qmail 32696 invoked by uid 102); 24 Sep 2013 05:32:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Sep 2013 00:32:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Sep 2013 01:32:30 -0400
Content-Disposition: inline
In-Reply-To: <024f85fe-96e9-4201-8b3a-2e15c9da53e8@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235263>

On Fri, Sep 20, 2013 at 08:21:04AM +0200, Piotr Krukowiecki wrote:

> >I can't think off-hand of a way to do so using preprocessor tricks, and
> >even if we could, I suspect the result would end up quite ugly. 
> 
> What I meant was: can we add a test (in t/) which greps git source
> code and fails if it finds strcasecmp string?
> 
> It could count number of strcasecmp and expect to find only 1 or
> exclude  known location of the wrapper.

No, because it is perfectly fine (and desirable) to use strcasecmp as a
function, just not as a function pointer. Telling the difference would
involve minor parsing of C.

So I think the least bad thing is to simply catch it in review, or by
testing on affected platforms.

-Peff
