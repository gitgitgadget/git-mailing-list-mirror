From: Mike Hommey <mh@glandium.org>
Subject: Re: What's in git.git
Date: Tue, 12 Feb 2008 10:47:55 +0100
Organization: glandium.org
Message-ID: <20080212094755.GA17195@glandium.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org> <7vd4r24ox6.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0802121010590.416@yvahk3.pbagnpgbe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Tue Feb 12 10:57:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOrtY-0004qL-3n
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 10:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759155AbYBLJ5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 04:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759183AbYBLJ5D
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 04:57:03 -0500
Received: from vuizook.err.no ([85.19.215.103]:44819 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759015AbYBLJ5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 04:57:00 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JOrtq-0008WG-5P; Tue, 12 Feb 2008 10:58:08 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1JOrsa-0004qP-7S; Tue, 12 Feb 2008 10:56:44 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0802121010590.416@yvahk3.pbagnpgbe.fr>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73647>

On Tue, Feb 12, 2008 at 10:15:28AM +0100, Daniel Stenberg <daniel@haxx.se> wrote:
> On Mon, 11 Feb 2008, Junio C Hamano wrote:
> 
> >Mike Hommey (1):
> > Work around curl-gnutls not liking to be reinitialized
> 
> But why reinitialize libcurl at all in the first place? This "work-around"
> should rather be the standard behavior since there should be no logical 
> reason to re-initialize libcurl's global state during a git's execution.
> 
> Even though Mike correctly identified a libcurl bug, it also indirectly 
> identified a git flaw: re-initialization with the curl_global_* functions 
> is pointless and only wastes time.

The important bit in the commit message reads:
> We work around this by removing the http_init and http_cleanup calls
> from get_refs_via_curl, replacing them with a transport->data
> initialization with the http_walker (which does http_init).

Which means there remains only one initialization. I agree it's not a
workaround anymore, but the word remained from the 3 previous attempts,
which were workarounds.

Mike
