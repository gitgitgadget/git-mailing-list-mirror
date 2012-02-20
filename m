From: Jeff King <peff@peff.net>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Mon, 20 Feb 2012 09:22:06 -0500
Message-ID: <20120220142206.GA5775@sigill.intra.peff.net>
References: <20120215190318.GA5992@sigill.intra.peff.net>
 <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net>
 <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <CACsJy8AHEHDAa2v4DvNgwd1YsBQuRCL9bHaxF70L8O4yWc4gZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 15:22:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzU87-0005J7-Pi
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 15:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185Ab2BTOWK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 09:22:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43816
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752877Ab2BTOWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 09:22:09 -0500
Received: (qmail 1333 invoked by uid 107); 20 Feb 2012 14:22:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Feb 2012 09:22:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2012 09:22:06 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8AHEHDAa2v4DvNgwd1YsBQuRCL9bHaxF70L8O4yWc4gZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191074>

On Mon, Feb 20, 2012 at 09:16:43PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Mon, Feb 20, 2012 at 9:06 PM, Jeff King <peff@peff.net> wrote:
> > Interestingly, on my git.git repo, I had an empty cache. Running "g=
it
> > read-tree HEAD" filled it (according to test-dump-cache-tree). It s=
eems
> > that running "git checkout" empties the cache. =C2=A0So perhaps git=
 could do
> > better about keeping the cache valid over time.
>=20
> For fast forward case when result index matches 100% destination tree=
,
> yeah we should repopulate cache-tree. "git reset" does that. Not sure
> about other cases though. I don't think we can keep track what
> subtrees are unchanged after unpack_trees() in order to keep them.

Yeah, doing it after unpack_trees seems crazy. But I really feel like
unpack_trees should be able to handle cache updates as it unpacks. It
knows what is being updated and what is being merged. But maybe it is
more complicated than that; I haven't looked at the code yet.

-Peff
