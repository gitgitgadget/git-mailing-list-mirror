From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] list-objects: only look at cmdline trees with
 edge_hint
Date: Mon, 20 Jan 2014 21:22:54 -0500
Message-ID: <20140121022254.GA4597@sigill.intra.peff.net>
References: <20140120212845.GA11451@sigill.intra.peff.net>
 <20140120213250.GB16095@sigill.intra.peff.net>
 <CACsJy8CBuW0dXgbSLgFHye9-aCDQCaK47MFpqeCh3m3JWHJOEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 03:23:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5Qzf-000738-HM
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 03:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbaAUCXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 21:23:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:35978 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753259AbaAUCW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 21:22:56 -0500
Received: (qmail 29823 invoked by uid 102); 21 Jan 2014 02:22:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jan 2014 20:22:55 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jan 2014 21:22:54 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CBuW0dXgbSLgFHye9-aCDQCaK47MFpqeCh3m3JWHJOEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240738>

On Tue, Jan 21, 2014 at 06:57:08AM +0700, Duy Nguyen wrote:

> You must have so much fun (or headache, depending on your view) with
> the variety of repos on github :)

It's fun on days like these when the solution is fairly straightforward.
:)

> > +       if (revs->edge_hint) {
> > +               for (i = 0; i < revs->cmdline.nr; i++) {
> > +                       struct object *obj = revs->cmdline.rev[i].item;
> > +                       struct commit *commit = (struct commit *)obj;
> > +                       if (obj->type != OBJ_COMMIT || !(obj->flags & UNINTERESTING))
> > +                               continue;
> > +                       mark_tree_uninteresting(commit->tree);
> > +                       if (revs->edge_hint && !(obj->flags & SHOWN)) {
> 
> Not really important, but perhaps remove revs->edge_hint here because
> it's already checked?

Yes, I think that is a good idea. Thanks.

Re-roll coming in a moment.

-Peff
