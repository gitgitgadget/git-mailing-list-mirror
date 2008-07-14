From: Petr Baudis <pasky@suse.cz>
Subject: Re: Closing the merge window for 1.6.0
Date: Mon, 14 Jul 2008 10:55:55 +0200
Message-ID: <20080714085555.GJ32184@machine.or.cz>
References: <7vk5ggipuw.fsf@gitster.siamese.dyndns.org> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> <7vprpwhp7t.fsf@gitster.siamese.dyndns.org> <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org> <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <7vzlokhpk7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 10:57:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIJrd-0005LB-KQ
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 10:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755670AbYGNIz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 04:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755639AbYGNIz6
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 04:55:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58363 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755383AbYGNIz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 04:55:57 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id ED01B393B32A; Mon, 14 Jul 2008 10:55:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vzlokhpk7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88402>

On Mon, Jul 14, 2008 at 12:50:48AM -0700, Junio C Hamano wrote:
> By default, packfiles created with this version uses delta-base-offset
> encoding introduced in v1.4.4.  Pack idx files are using version 2 that
> allows larger packs and added robustness thanks to its CRC checking,
> introduced in v1.5.2.

Oh, I thought this was some earlier change when I noticed it few days
ago on repo.or.cz, but seems there is still a chance to turn this over -
please reconsider...? :-)

Can't we by default use the version 2 only in case we actually _need_ to
store the larger packs? The CRC checking may be nice, but not critical,
and we could wait a bit more with it yet.

I'm saying this because I believe the best conservative upper bound for
backwards compatibility is Git version in Debian stable. It gets
probably the most stale from all the widely used software distributions
using Git, and it *is* quite widely used. Etch carries v1.4.4.4, which
fails miserably on the new packs:

Getting alternates list for http://repo.or.cz/r/repo.git/
Getting pack list for http://repo.or.cz/r/repo.git/
Getting index for pack 5111285cac0f895cd9367c9939ced68e2c43dcc0
error: non-monotonic index
/usr/bin/git-fetch: line 297: 30402 Segmentation fault git-http-fetch -v -a "$head" "$remote/"

P.S.: AFAIK new Debian stable release is scheduled on Fall.

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
