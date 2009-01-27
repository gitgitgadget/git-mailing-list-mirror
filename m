From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Valgrind updates
Date: Tue, 27 Jan 2009 13:14:04 +0000
Message-ID: <20090127131404.GA11870@sirena.org.uk>
References: <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer> <20090121190757.GB21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901270327200.26199@intel-tinevez-2-302> <alpine.LFD.2.00.0901261934450.3123@localhost.localdomain> <alpine.DEB.1.00.0901270512171.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 27 14:15:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRnnG-0007An-62
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 14:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbZA0NOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 08:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753902AbZA0NOR
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 08:14:17 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2829 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbZA0NOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 08:14:16 -0500
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.63)
	(envelope-from <broonie@sirena.org.uk>)
	id 1LRnlV-0003TS-2T; Tue, 27 Jan 2009 13:14:05 +0000
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901270512171.14855@racer>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: broonie@sirena.org.uk
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107343>

On Tue, Jan 27, 2009 at 05:26:34AM +0100, Johannes Schindelin wrote:

> I suspected that zlib does something "cute" with alignments, i.e. that it 
> writes a possibly odd number of bytes, but then rounds up the buffer to 
> the next multiple of two of four bytes.

I don't recall anything along those lines in zlib but it does generate
warnings with valgrind which require overrides - it has at least one
unrolled loop which roll on beyond initialised memory (but keep within
memory that zlib knows it has allocated).  It rolls back the results of
the loop before producing output, but it's possible that some unused
bits in the stream may be derived from the results.
