From: Robie Basak <robie.basak@canonical.com>
Subject: Re: [PATCH] apply: squash consecutive slashes with p_value > 0
Date: Thu, 17 Nov 2011 17:55:44 +0000
Message-ID: <20111117175544.GC17472@mal.justgohome.co.uk>
References: <20111116120403.GA10342@mal.justgohome.co.uk>
 <7v62ikq89h.fsf@alter.siamese.dyndns.org>
 <20111117150409.GB17472@mal.justgohome.co.uk>
 <7vr516myqh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 18:55:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RR6Bj-0001cs-VK
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 18:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348Ab1KQRzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 12:55:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34065 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab1KQRzr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 12:55:47 -0500
Received: from 107.27.187.81.in-addr.arpa ([81.187.27.107] helo=localhost)
	by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71)
	(envelope-from <robie.basak@canonical.com>)
	id 1RR6Bd-0000H0-Ea; Thu, 17 Nov 2011 17:55:45 +0000
Content-Disposition: inline
In-Reply-To: <7vr516myqh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185602>

On Thu, Nov 17, 2011 at 09:43:02AM -0800, Junio C Hamano wrote:
> I didn't mention this, but I suspect the code with your patch would not
> touch redundant slashes after it finds "start", either.

What is happening to me is that b//foo with -p1 gets split at the first
slash and then git apply cannot find /foo when it should be looking for
foo. But in the case of b/foo//bar and -p1, without squashing extra
slashes it would look for foo//bar which I presume that it would still
be able to find.

So in my case, I only need duplicate slashes around the -p boundary
point to be removed. I assumed that the squash_slash() later on would
eliminate the rest, but I didn't look into this; if it does it'd be a
different issue to the one that I'm seeing.

I'm now confused about what it will do (which is why I need to look at
it again to make sure), but if it turns out to be easier to just handle
that one boundary point, would you accept a patch that eliminates just
that duplicate, on the basis that in Unix-land duplicate slashes are
perfectly acceptable to be left lying around?

Thanks,

Robie
