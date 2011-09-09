From: Jeff King <peff@peff.net>
Subject: Re: can Git encrypt/decrypt .gpg on push/fetch?
Date: Fri, 9 Sep 2011 14:42:29 -0400
Message-ID: <20110909184229.GE28480@sigill.intra.peff.net>
References: <87lityxbg7.fsf@lifelogs.com>
 <CAGhXAGSw3y=cjAHXtwycDifoBPr13AkYtLHRRXejRKue0vkz7A@mail.gmail.com>
 <4E6A165D.5010703@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Aneesh Bhasin <contact.aneesh@gmail.com>, tzz@lifelogs.com,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 20:42:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2629-0005K3-PX
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 20:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759347Ab1IISmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 14:42:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41916
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758646Ab1IISmb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 14:42:31 -0400
Received: (qmail 482 invoked by uid 107); 9 Sep 2011 18:43:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Sep 2011 14:43:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2011 14:42:29 -0400
Content-Disposition: inline
In-Reply-To: <4E6A165D.5010703@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181104>

On Fri, Sep 09, 2011 at 03:36:29PM +0200, Michael J Gruber wrote:

> A) Keep blobs and checkout encrypted
> - Use an editor which can encrypt/decrypt on the fly (e.g. vim)
> - Use "*.gpg diff=gpg" in your attributes and
> [diff "gpg"]
>         textconv = gpg -d
>   in your config to have cleartext diffs. Use cachetextconv with caution ;)

I use something like this for my password store, though I use:

  textconv = gpg -qd --no-tty

to keep things as clean as possible. Running gpg-agent is a must, of
course.

The wallet itself is just a gpg-encrypted YAML file, with a few scripts
grep within the hierarchy. I'm happy to share the code if anybody is
interested. I've also written firefox hooks to fill website form fields,
but that code is a little gross.

> B) Keep blobs encrypted, checkout decrypted
> - Use Use "*.gpg filter=gpg" in your attributes and
> [filter "gpg"]
> 	smudge = gpg -d
> 	clean = gpg -e -r yourgpgkey
>   in your config.
> 
> I use A on a regular basis. B is untested (but patterned after a similar
> gzip filter I use). You may or may not have better results with "gpg -ea".

Yeah, I think that would work but have never tried it either.

-Peff
