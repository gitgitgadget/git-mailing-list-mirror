From: Jeff King <peff@peff.net>
Subject: Re: Reference for git.git release process
Date: Wed, 25 Mar 2009 23:49:09 -0400
Message-ID: <20090326034909.GB8031@coredump.intra.peff.net>
References: <49CA78BF.2020101@fastmail.fm> <7viqlxz9go.fsf@gitster.siamese.dyndns.org> <20090326022757.GC5835@coredump.intra.peff.net> <7vtz5hugc6.fsf@gitster.siamese.dyndns.org> <20090326031521.GA7984@coredump.intra.peff.net> <7v8wmtufn4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Raman Gupta <rocketraman@fastmail.fm>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 04:50:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmgcG-0008Oe-Pl
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 04:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbZCZDtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 23:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766AbZCZDtV
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 23:49:21 -0400
Received: from peff.net ([208.65.91.99]:46701 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754495AbZCZDtU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 23:49:20 -0400
Received: (qmail 11772 invoked by uid 107); 26 Mar 2009 03:49:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Mar 2009 23:49:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2009 23:49:09 -0400
Content-Disposition: inline
In-Reply-To: <7v8wmtufn4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114720>

On Wed, Mar 25, 2009 at 08:28:15PM -0700, Junio C Hamano wrote:

> > So if I understand correctly, you would actually like "push matching,
> > delete missing" behavior?
> 
> Hmm, that would be good.  That would allow me to start publishing the
> individual topics with ease.
> 
> I never thought of that.

I'm not sure of the best way to implement it. Is it a new behavior on
par with matching, tracking, current, etc; or is "delete missing"
orthogonal to what is being pushed? Should "delete missing" attempt to
match according to your refspecs, or according to the whole repo (like
mirror)?

I was thinking "orthogonal, limited to your refspec". So configure via

  git config remote.origin.prune-push true

and then you can

  # pseudo-mirror following your refspec or matching behavior
  git push origin

  # push foo if it exists, or delete it if it doesn't
  git push origin foo

  # sync some subset of your refs
  git push origin refs/heads/jk/*:refs/heads/jk/*

-Peff
