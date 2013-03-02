From: Jeff King <peff@peff.net>
Subject: Re: [bug report] git-am applying maildir patches in reverse
Date: Fri, 1 Mar 2013 19:38:12 -0500
Message-ID: <20130302003811.GA14936@sigill.intra.peff.net>
References: <20130301222018.GA839@WST420>
 <7vwqtqeox7.fsf@alter.siamese.dyndns.org>
 <20130301225231.GB862@sigill.intra.peff.net>
 <20130301230508.GC862@sigill.intra.peff.net>
 <7vlia6em9x.fsf@alter.siamese.dyndns.org>
 <20130301233548.GA13422@sigill.intra.peff.net>
 <7v621aekr0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Giokas <1007380@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 02 01:38:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBaTH-0001bY-SU
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 01:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab3CBAiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 19:38:14 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39666 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436Ab3CBAiO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 19:38:14 -0500
Received: (qmail 5650 invoked by uid 107); 2 Mar 2013 00:39:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Mar 2013 19:39:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2013 19:38:12 -0500
Content-Disposition: inline
In-Reply-To: <7v621aekr0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217313>

On Fri, Mar 01, 2013 at 03:57:39PM -0800, Junio C Hamano wrote:

> > The epoch_seconds are the time of writing into the maildir. They will
> > typically all be the same, unless your system is very slow, or you are
> > writing a really long patch series. The PID likewise should be the same
> > for a given series. It's the sequence number that is the interesting bit
> > to sort numerically (for mutt, anyway; ditto for dovecot).
> 
> OK, so as long as the user tells mutt what order the messages need
> to be written in when choosing these 16 patches, tiebreaking with
> the sequence number would be sufficient.
> 
> Is it easy to tell that to mutt, though, given that the patches
> arrive in random order, not in the order they were sent?

Yes. You can either write one at a time, or you can tag several and
write them with a single command. In the latter case, it writes them out
according to the currently displayed sort order. The usual threaded
display gets it right for delivered messages (it shows them in date
order within the thread), and you can use sort-by-subject to override it
if you are working with munged timestamps.

> I would imagine that you sort the messages in your inbox, select a
> group of messages and tell mutt to write them out to a (new) empty
> maildir, and at that point mutt writes them out in the order you used
> to sort them---is that how it is supposed to work?
> 
> Or are you assuming that the user chooses 1/16, tells mutt to write it
> out, chooses 2/16, tells mut to write that out, iterating it 16 times
> to write out a 16-patch series?

Right. The latter probably already works (unless you are so fast that
you write out multiple messages in one second), but I would expect most
people would tag and then save all at once.

-Peff
