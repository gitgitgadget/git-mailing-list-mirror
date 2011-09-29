From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Lack of detached signatures
Date: Wed, 28 Sep 2011 21:59:19 -0400
Message-ID: <20110929015919.GL19250@thunk.org>
References: <alpine.LNX.2.00.1109271742460.24832@bruno>
 <7vty7xttxh.fsf@alter.siamese.dyndns.org>
 <CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com>
 <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
 <1317195719.30267.4.camel@bee.lab.cmartin.tk>
 <alpine.LNX.2.00.1109280555460.25187@bruno>
 <7v1uv01uqm.fsf@alter.siamese.dyndns.org>
 <20110928222542.GA18120@sigill.intra.peff.net>
 <20110928230958.GJ19250@thunk.org>
 <7vd3ekxkca.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Joseph Parmelee <jparmele@wildbear.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	"Olsen, Alan R" <alan.r.olsen@intel.com>,
	Michael Witten <mfwitten@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 03:59:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R95uR-0002EU-1j
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 03:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533Ab1I2B73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 21:59:29 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:57053 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754074Ab1I2B72 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 21:59:28 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1R95uC-0002LV-Kd; Thu, 29 Sep 2011 01:59:20 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1R95uB-0003QG-Bz; Wed, 28 Sep 2011 21:59:19 -0400
Content-Disposition: inline
In-Reply-To: <7vd3ekxkca.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182382>

On Wed, Sep 28, 2011 at 05:28:53PM -0700, Junio C Hamano wrote:
> 
> I suspect that letting GPG do the compression and shipping foo.tar.gpg
> would work just fine as well, 

Good point.  If only "tar -xW foo.tar.gpg" automatically verified the
gpg signature, that would work really well indeed.  :-)

> I understand that the automated GPG signature k.org used to use on the
> master machine was primarily to protect the copies that the mirrors serve
> from getting tampered after they leave the master machine. Do you happen
> to know what the new policy will be? Will the developers who distribute
> their snapshot tarballs from the site be GPG signing them themselves
> before uploading?

This is still being negotiated.  Given that developers are starting to
sign their release tags (and of course Linus has been doing this
already), one of the things that I've proposed is that we support is
to have the developer do something like this:

git archive --format=tar -o e2fsprogs-1.41.12.tar v1.41.12
gzip -9n e2fsprogs-1.41.12.tar
gpg --sign --detach -a e2fsprogs-1.41.12.tar.gz

and then just uploading the tar.gz.gpg file, the URL for the git tree,
and the tag that the server should use do the extraction.

> That would improve the situation (I suspect that there
> were some people who misunderstood that these GPG signature were to
> protect against break-in at the master machine), but at the same time, it
> may create the chicken-and-egg bootstrapping problem if public keys of too
> many people need to be published securely.

We are in the process of bootstrapping a GPG web of trust.  Linus has
generated a new GPG key which has been signed by Peter Anvin, Dirk,
and myself.  We'll get a much richer set of cross signatures at the
Kernel Summit in Prague in a few months.

Also, there's a pretty good intersection between kernel developers and
the Debian web of trust; there's been some talk of using that as an
auxiliary bootstrap for isolated kernel developers in distant part of
the world.

					- Ted
