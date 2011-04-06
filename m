From: Jeff King <peff@peff.net>
Subject: Re: packfile is unavailable/cannot be accessed
Date: Wed, 6 Apr 2011 11:42:08 -0400
Message-ID: <20110406154208.GC1864@sigill.intra.peff.net>
References: <loom.20110406T020617-993@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Enchanter <ensoul.magazine@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 17:42:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Us6-0006hA-RK
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 17:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136Ab1DFPmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 11:42:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37248
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932079Ab1DFPmL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 11:42:11 -0400
Received: (qmail 5737 invoked by uid 107); 6 Apr 2011 15:42:58 -0000
Received: from 205.158.58.41.ptr.us.xo.net (HELO sigill.intra.peff.net) (205.158.58.41)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Apr 2011 11:42:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Apr 2011 11:42:08 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110406T020617-993@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170984>

On Wed, Apr 06, 2011 at 12:09:59AM +0000, Enchanter wrote:

> Today I found these errors when I try to pull from remote:
> 
> $ git fetch origin
> error: end of packfile
> ./objects/pack/pack-0bb4b0fb14801efb46a7cb9aab64add08620c0b1.pack
>  is unavailable error: packfile
> ./objects/pack/pack-0bb4b0fb14801efb46a7cb9aab64add08620c0b1.pack
>  cannot be accessed 
> error: refs/heads/newGPMC does not point to a valid object!
> error: end of packfile
> ./objects/pack/pack-bbb57cb715f61347809673448e9ab12084277090.pack
>  is unavailable
> error: packfile
> ./objects/pack/pack-bbb57cb715f61347809673448e9ab12084277090.pack
>  cannot be accessed
> error: end of packfile
> ./objects/pack/pack-bbb57cb715f61347809673448e9ab12084277090.pack
>  is unavailable
> error: packfile
> ./objects/pack/pack-bbb57cb715f61347809673448e9ab12084277090.pack
>  cannot be accessed
> fatal: failed to read object 8682d5d2ce5bbab82c9020a986d473aa2a97feb8:
>  Illegal seek
> fatal: The remote end hung up unexpectedly
> 
> Can anyone give me a hit on how to solve this problem? 

Looking through the source code, the only way this message can be
generated is if lseek fails on the packfile. It looks like the messages
are coming from the remote end. Where is your remote located? Which
operating system is it running on? Is the repo on an exotic filesystem
that might not support seeking?

-Peff
