From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make error message after failing commit_lock_file() less
 confusing
Date: Tue, 1 Dec 2015 18:17:01 -0500
Message-ID: <20151201231701.GB13245@sigill.intra.peff.net>
References: <1448883653-9140-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Dec 02 00:17:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3uAY-0007fp-9E
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 00:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365AbbLAXRG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2015 18:17:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:35995 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755328AbbLAXRE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 18:17:04 -0500
Received: (qmail 22629 invoked by uid 102); 1 Dec 2015 23:17:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 17:17:04 -0600
Received: (qmail 23913 invoked by uid 107); 1 Dec 2015 23:17:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 18:17:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Dec 2015 18:17:01 -0500
Content-Disposition: inline
In-Reply-To: <1448883653-9140-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281863>

On Mon, Nov 30, 2015 at 12:40:53PM +0100, SZEDER G=C3=A1bor wrote:

> The error message after a failing commit_lock_file() call sometimes
> looks like this, causing confusion:
>=20
>   $ git remote add remote git@server.com/repo.git
>   error: could not commit config file .git/config
>   # Huh?!
>   # I didn't want to commit anything, especially not my config file!

I like the intent of this patch; I've had the same "huh" moment myself.

> The error message is of course bikeshedable.

You chose "write", which I think is OK. It's really a "rename", and
maybe that matters for some values of errno. I'd guess in practice
probably not (the likely reason is going to be something like EPERM).
And I can't think of a concise way to express rename (just saying
"rename" is confusing, too, without indicating that it's from the
tempfile to the final resting place).

So perhaps "write" is the best we can do.

-Peff
