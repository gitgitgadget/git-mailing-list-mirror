From: Jeff King <peff@peff.net>
Subject: Re: Bug report: stash in upstream caused remote fetch to fail
Date: Wed, 15 Jan 2014 05:48:26 -0500
Message-ID: <20140115104826.GF14335@sigill.intra.peff.net>
References: <CAECVvXYD69Xrp85bVJg6XogvctUTwrFDae+3tawFgoCAUGhwGg@mail.gmail.com>
 <20140106152742.GA26221@sigill.intra.peff.net>
 <xmqqbnzpkrvk.fsf@gitster.dls.corp.google.com>
 <20140106193625.GA27062@sigill.intra.peff.net>
 <xmqq61pwj25q.fsf@gitster.dls.corp.google.com>
 <20140106230348.GA7811@sigill.intra.peff.net>
 <xmqq4n5ghf0z.fsf@gitster.dls.corp.google.com>
 <7vtxdg1nsg.fsf@alter.siamese.dyndns.org>
 <20140115104612.GE14335@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matt Burke <spraints@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 11:48:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3O1X-0003Sa-4f
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 11:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbaAOKsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 05:48:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:32775 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751789AbaAOKs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 05:48:28 -0500
Received: (qmail 15566 invoked by uid 102); 15 Jan 2014 10:48:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 04:48:29 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 05:48:26 -0500
Content-Disposition: inline
In-Reply-To: <20140115104612.GE14335@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240451>

On Wed, Jan 15, 2014 at 05:46:13AM -0500, Jeff King wrote:

> This discussion stalled, but I finally got around to looking at it
> today. I agree that we should leave aside more complex policy for now,
> and start with bringing the "fetch" and "fetch-pack" filters into
> harmony. That turns off format-checking for things outside "refs/" (so
> allows "HEAD"), and checks the whole string for things inside "refs/"
> (so it does not fall afoul of the one-level check).

By the way, an interesting implication of this is that I do not think
there is any format check on things outside of refs/. If you were to do

  git fetch ... +*:*

you would write whatever crap the other side gives you. I can't imagine
any reason a client would _ever_ do that, though, so I don't think it's
a big deal. We tend to fetch HEAD explicitly by name, and that's it.

-Peff
