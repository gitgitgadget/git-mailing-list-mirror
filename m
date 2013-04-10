From: Jeff King <peff@peff.net>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 15:52:57 -0400
Message-ID: <20130410195256.GA24177@sigill.intra.peff.net>
References: <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org>
 <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
 <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
 <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org>
 <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 21:53:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ14w-0001Ci-Mg
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556Ab3DJTxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 15:53:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39064 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985Ab3DJTxE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:53:04 -0400
Received: (qmail 6044 invoked by uid 107); 10 Apr 2013 19:54:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 15:54:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 15:52:57 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220738>

On Thu, Apr 11, 2013 at 01:01:33AM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > On Wed, Apr 10, 2013 at 11:54:34AM -0700, Junio C Hamano wrote:
> >> > If branch.$name.remote is "when I am on this branch, I want to talk to
> >> > this remote", that rule is not be impacted by the presence of refspecs
> >> > at all.
> >>
> >> So running the above while on 'maint' will send master and next to
> >> the remote your "git push" would send to when run without any
> >> refspecs?
> >
> > Exactly. The remote selection is orthogonal to the refspecs provided,
> > and only cares about which branch you are on.
> >
> > Which is still kind of weird, because why should the branch you are on
> > affect the default push location? But that is how default "matching" has
> > always behaved, and we would remain consistent with that.
> 
> git push -- master next; pushes to my current branch's
> branch.<name>.pushremote?  Isn't that a disaster?

Maybe. But no more so than the current:

  git push

which may also push master and next to the same remote. As I said in an
earlier message, I would be OK with allowing both or neither, but
allowing one but not the other is even more confusing.

If we changed push.default=matching to ignore branch.*.remote, then that
would be consistent, and would probably be safer over all. It is a
regression, but I doubt that anybody was using branch.*.remote for this;
it really only makes sense with the "upstream" mode.

-Peff
