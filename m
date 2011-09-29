From: Jeff King <peff@peff.net>
Subject: Re: Lack of detached signatures
Date: Wed, 28 Sep 2011 21:41:41 -0400
Message-ID: <20110929014141.GA23890@sigill.intra.peff.net>
References: <alpine.LNX.2.00.1109271742460.24832@bruno>
 <7vty7xttxh.fsf@alter.siamese.dyndns.org>
 <CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com>
 <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
 <1317195719.30267.4.camel@bee.lab.cmartin.tk>
 <alpine.LNX.2.00.1109280555460.25187@bruno>
 <7v1uv01uqm.fsf@alter.siamese.dyndns.org>
 <20110928222542.GA18120@sigill.intra.peff.net>
 <20110928230958.GJ19250@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Joseph Parmelee <jparmele@wildbear.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	"Olsen, Alan R" <alan.r.olsen@intel.com>,
	Michael Witten <mfwitten@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 29 03:41:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R95dE-0005XI-QZ
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 03:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419Ab1I2Blo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 21:41:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47790
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706Ab1I2Bln (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 21:41:43 -0400
Received: (qmail 14340 invoked by uid 107); 29 Sep 2011 01:46:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Sep 2011 21:46:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Sep 2011 21:41:41 -0400
Content-Disposition: inline
In-Reply-To: <20110928230958.GJ19250@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182381>

On Wed, Sep 28, 2011 at 07:09:58PM -0400, Ted Ts'o wrote:

> On Wed, Sep 28, 2011 at 06:25:43PM -0400, Jeff King wrote:
> > [1] This is a minor nit, and probably not worth breaking away from the
> > way the rest of the world does it, but it is somewhat silly to sign the
> > compressed data. I couldn't care less about the exact bytes in the
> > compressed version; what I care about is the actual tar file. The
> > compression is just a transport.
> 
> The worry I have is that many users don't check the GPG checksum files
> as it is.  If they have to decompress the file, and then run gpg to
> check the checksum, they might never get around to doing it.

It shouldn't really be any more cumbersome. But at the same time, it's
different than the way everyone else does it, so any minor convenience
we get is probably nullified by simply confusing anybody.

I wonder how many people actually check gpg checksums on downloaded
files. I don't usually. But I do expect something like a package manager
building from upstream source (e.g., freebsd-style ports, or distro
packagers pulling a new upstream) to bother to check it.

> That being said, I'm not sure I have a good solution.  One is to ship
> the file without using detached signatures, and ship a foo.tar.gz.gpg
> file, and force them to use GPG to unwrap the file before it can be
> unpacked.  But users would yell and scream if we did that...

And rightly so. I mentioned the cost of implementing the mechanism
before. If it's just "Junio runs gpg and throws the detached signature
up on the ftp site", it's not a big deal. But if it's "you can't
download and install git until you have gpg installed", that is raising
the bar quite a bit.

It should be the recipient's decision how much they want to trust the
data. We would just be helping them out by providing more information.

-Peff
