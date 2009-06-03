From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 21:05:18 +0200
Message-ID: <200906032105.18459.j6t@kdbg.org>
References: <200905122329.15379.jnareb@gmail.com> <200906031121.38616.jnareb@gmail.com> <20090603144837.GE3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 21:05:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBvmG-0005qS-C9
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 21:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbZFCTFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 15:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753507AbZFCTFV
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 15:05:21 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:10409 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831AbZFCTFV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 15:05:21 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6DB812C4015;
	Wed,  3 Jun 2009 21:05:19 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0E99B1D1E6;
	Wed,  3 Jun 2009 21:05:19 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090603144837.GE3355@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120627>

On Mittwoch, 3. Juni 2009, Shawn O. Pearce wrote:
> We have a history of not leaving ourselves room for future expansion,
> and then needing to find a backdoor in the canonical implementation
> parser in order to make it work.
>
> In the protocol suite, its been the strlen() < pktlen trick which
> has generally worked.  Oh, and also sticking stuff after a fixed
> length record, where we didn't care.

This reminds me of one thing: upload-pack (of C git) sends a complete pack if 
and only if there were no errors, so that fetch-pack sees an error if 
upload-pack dies or if there is no side-band where upload-pack could signal 
an error (at least I think that are the reasons). There is a comment in 
upload-pack that explains a bit of it:

/* Data ready; we keep the last byte to ourselves
 * in case we detect broken rev-list, so that we
 * can leave the stream corrupted.  This is
 * unfortunate -- unpack-objects would happily
 * accept a valid packdata with trailing garbage,
 * so appending garbage after we pass all the
 * pack data is not good enough to signal
 * breakage to downstream.
 */

-- Hannes
