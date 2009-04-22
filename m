From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: dangling commits and blobs: is this normal?
Date: Wed, 22 Apr 2009 14:26:26 -0500
Message-ID: <FcecxnoVg4H8G3MKjZgl2T6zCGDer4yYyScIgaweFTNgDCKG65Xiig@cipher.nrlssc.navy.mil>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com> <20090422152719.GA12881@coredump.intra.peff.net> <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0904221331450.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:33:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwi86-000837-EZ
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbZDVT0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 15:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753100AbZDVT0r
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:26:47 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50367 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbZDVT0q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 15:26:46 -0400
Received: by mail.nrlssc.navy.mil id n3MJQRbf022724; Wed, 22 Apr 2009 14:26:28 -0500
In-Reply-To: <alpine.LFD.2.00.0904221331450.6741@xanadu.home>
X-OriginalArrivalTime: 22 Apr 2009 19:26:27.0282 (UTC) FILETIME=[3B2D3B20:01C9C380]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117238>

Nicolas Pitre wrote:
> On Wed, 22 Apr 2009, Brandon Casey wrote:

>> I've often wondered whether a plain 'git gc' should adopt the behavior
>> of --auto with respect to the number of packs.  If there were few packs,
>> then 'git gc' would do an incremental repack, rather than a 'repack -A -d -l'.
> 
> Why so?  Having fewer packs is always a good thing.  Having only one 
> pack is of course the optimal situation.  The --auto version doesn't do 
> it in the hope of being lightter and less noticeable by the user.

The only reason for avoiding packing all packs into one would be speed in
this case also.  I recall reading complaints or surprise about gc
repacking all packs into one, so I'm only trying to think about how to
match program behavior with user expectations.  gc does a lot already,
and even Jeff wasn't sure what to expect from 'git gc' with respect to
packs.  Possibly an acceptable trade off between speed and optimal packing
would be to adopt the --auto behavior for deciding when to use '-A' with
repack.

> However the user manually invoking gc should be expecting some work is 
> actually happening.  If you don't want the whole repo read from one pack 
> just to be written in another pack (say the repo is huge and waiting 
> after the IO is not worth it) then just mark such a pack with a .keep 
> file.

That's true, but a user who knows about the .keep mechanism would also
not be afraid to run 'repack -d -l' (I'm ignoring the other operations
of gc).

-brandon
