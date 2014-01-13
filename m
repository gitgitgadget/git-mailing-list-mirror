From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] remote: introduce and fill branch->pushremote
Date: Mon, 13 Jan 2014 13:59:47 -0500
Message-ID: <20140113185946.GA30279@sigill.intra.peff.net>
References: <1389546666-17438-1-git-send-email-artagnon@gmail.com>
 <1389546666-17438-4-git-send-email-artagnon@gmail.com>
 <20140113083421.GA18531@sigill.intra.peff.net>
 <CALkWK0ncSLza3Q0PSZ0oTZqB2YxjgGSqA7QYxk2+rN_77BKZMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 13 20:00:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2mjx-00047R-MV
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 20:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbaAMS7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 13:59:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:59981 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752060AbaAMS7t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 13:59:49 -0500
Received: (qmail 16290 invoked by uid 102); 13 Jan 2014 18:59:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Jan 2014 12:59:48 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jan 2014 13:59:47 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0ncSLza3Q0PSZ0oTZqB2YxjgGSqA7QYxk2+rN_77BKZMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240367>

On Mon, Jan 13, 2014 at 04:52:52PM +0530, Ramkumar Ramachandra wrote:

> Not sure I understand what the problem is. Let's say we have two
> branches: "master", and "side" with remote.pushdefault = ram,
> branch.*.remote = origin, and branch.side.pushremote = peff. Now, when
> I query master's pushremote, I get "ram" and when I query side's
> pushremote, I get "peff"; all the logic for falling-back from
> branch.*.pushremote to remote.pushdefault to branch.*.remote is in
> branch_get(), so I need to do nothing extra on the caller-side. From
> the caller's perspective, why does it matter if the pushremote of a
> particular branch is due to branch.*.pushremote or remote.pushdefault?

Imagine your HEAD is at "side". What should "master@{publish}" produce?
I would argue "ram/master". Where does "ram" come from in your code?

It does not matter for actually pushing, because to do a non-default
push, you must always specify a remote. But "@{publish}" will ask the
question "even if I am on 'side' now, what would happen if I were to
default-push on 'master'?".

-Peff
