From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Why SHA are 40 bytes? (aka looking for flames)
Date: Sat, 21 Apr 2007 18:53:31 +0200
Message-ID: <20070421165331.GA5080@diana.vm.bytemark.co.uk>
References: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com> <200704211608.06171.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 18:53:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfIqD-0003Vr-Ss
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 18:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbXDUQxf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Apr 2007 12:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256AbXDUQxf
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 12:53:35 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2468 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbXDUQxe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 12:53:34 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HfIq3-0001RD-00; Sat, 21 Apr 2007 17:53:31 +0100
Content-Disposition: inline
In-Reply-To: <200704211608.06171.andyparkins@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45178>

On 2007-04-21 16:08:01 +0100, Andy Parkins wrote:

> On Saturday 2007, April 21, Marco Costalba wrote:
>
> > Well, why to store always the full length SHA?
>
> Well apart from being easier than working out the optimum size for
> every single object write, one really good reason would be that
> there is no way to predict that an object in the future won't have a
> conflicting SHA - every object /has/ to be stored with its full
> hash, because you are preventing conflicts with everything object
> now, in the past and all possible futures.

Well, any hash is "incomplete" or "not long enough" inasmuch as it's
theoretically possible to find collisions. The choice of the full 160
bits (note: this is 20 bytes, not 40) is arbitrary -- it's just "long
enough". 128 bits would have been enough to prevent any naturally
occurring collisions, too (maybe even 96 bits would be enough, I'm too
lazy to do the math). The only reason to go as high as 160 is to
prevent any possible collision created by a malicious adversary, too,
so that it's possible to e.g. sign just a commit and be able to trust
everything it points to. The SHA1 designers felt that 160 bits was a
good compromise between size and robustness, and we just trust that
their (and the cryptographic community's) guess is good enough.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
