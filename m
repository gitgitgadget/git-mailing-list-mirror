From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 2/6] Add git_env_ulong() to parse environment variable
Date: Tue, 26 Aug 2014 16:31:59 -0400
Message-ID: <20140826203158.GA30651@peff.net>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de>
 <1409066605-4851-3-git-send-email-prohaska@zib.de>
 <20140826182125.GC17546@peff.net>
 <xmqq38cjhuje.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 22:32:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMNPT-0002jR-RJ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 22:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbaHZUcC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 16:32:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:59543 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753601AbaHZUcB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 16:32:01 -0400
Received: (qmail 12860 invoked by uid 102); 26 Aug 2014 20:32:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 15:32:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 16:31:59 -0400
Content-Disposition: inline
In-Reply-To: <xmqq38cjhuje.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255942>

On Tue, Aug 26, 2014 at 01:20:53PM -0700, Junio C Hamano wrote:

> I think different people have different confusion criteria.
> To me, these two are very different operations:
> 
>     $ VAR=
>     $ unset VAR
> 
> I think it boils down to that I see that the distance between "unset
> vs set to empty" is far larger than the distance between "empty vs
> false".  You probably see these two distances the other way,
> i.e. "set to empty is almost like unset" and "empty is not a valid
> way to say false".
> 
> Due to this difference, the new test confused me and had me read it
> three times.

I agree that it is rather a subjective decision.

> So, I am not sure the patch in the message I am responding to, and I
> am not sure about that *v check in Steffen's patch, either.

If it is truly "some people prefer it one way and some the other", I am
not sure if we should leave it as-is (that is preferring one way). The
middle ground would be to die(). That does not seem super-friendly, but
then we would also die with GIT_SMART_HTTP=foobar, so perhaps it is not
unreasonable to just consider it a syntax error.

I dunno. I can live with leaving it as-is. Certainly the existing
behavior is not what I expected, but it is not like it came up in the
real world (and I would not expect it to do so often). And it is
consistent with the config, which treats:

  [foo]
  bar =

as boolean false. That _also_ seems weird to me, but that is not
something I think we can easily change or outlaw at this point anyway.

-Peff
