From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git on Windows, CRLF issues
Date: Wed, 23 Apr 2008 16:01:10 -0700
Message-ID: <7vprsgqiq1.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
 <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness>
 <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com>
 <20080422023918.GA5402@sigill.intra.peff.net>
 <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com>
 <20080423080826.GA11935@sigill.intra.peff.net>
 <480F1671.2060602@viscovery.net>
 <20080423110402.GA27437@sigill.intra.peff.net>
 <480F218C.3060703@viscovery.net>
 <20080423214745.GA30057@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Karlsson <peter@softwolves.pp.se>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 24 01:02:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jonyg-0006sS-Km
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 01:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbYDWXB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 19:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbYDWXB1
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 19:01:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48357 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbYDWXB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 19:01:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8184F3885;
	Wed, 23 Apr 2008 19:01:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9FCD23880; Wed, 23 Apr 2008 19:01:13 -0400 (EDT)
In-Reply-To: <20080423214745.GA30057@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 23 Apr 2008 17:47:45 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80270>

Jeff King <peff@peff.net> writes:

> The correct fix is either:
>
>   - the blob cache needs to take into account sha1 _and_ path
>
>   - the cache lookup needs to be _inside_ the path filter. In that case
>     you would either have to support it in the script (e.g.,
>     --blob-ignore jpg), or you could make the caching an optional part
>     of the blob filter (the way you can call 'map' explicitly from your
>     filters).

But once you start saying "even originally the same blob (i.e. identified
by one object name) can be rewritten into different result, depending on
where in the tree it appears", would it make sense to have blob filters to
begin with?

Shouldn't that kind of of context sensitive (in the space dimension -- you
can introduce the context sensitivity in the time dimension by saying
there may even be cases where you would want to filter differently
depending on the path and which commit the blob appears, which is even
worse) filtering be best left to the tree or index filter?
