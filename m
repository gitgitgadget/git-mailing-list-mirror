From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fetch: avoid local fetching from alternate (again)
Date: Tue, 06 Nov 2007 22:24:28 -0800
Message-ID: <7vsl3iefoj.fsf@gitster.siamese.dyndns.org>
References: <20071107024118.GA11043@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 07:24:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpeLL-0003HO-Dw
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 07:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830AbXKGGYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 01:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755712AbXKGGYg
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 01:24:36 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:58379 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681AbXKGGYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 01:24:35 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id CC9982F0;
	Wed,  7 Nov 2007 01:24:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 660E3900A4;
	Wed,  7 Nov 2007 01:24:54 -0500 (EST)
In-Reply-To: <20071107024118.GA11043@spearce.org> (Shawn O. Pearce's message
	of "Tue, 6 Nov 2007 21:41:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63773>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Back in e3c6f240fd9c5bdeb33f2d47adc859f37935e2df Junio taught
> git-fetch to avoid copying objects when we are fetching from
> a repository that is already registered as an alternate object
> database.  In such a case there is no reason to copy any objects
> as we can already obtain them through the alternate.

Well spotted.  It would be a good idea to commit the big comment
from contrib/examples/git-fetch.sh to fetch_local_nocopy()
function, which would have made us realize that the patch does
not refrain from applying this optimization even when shallow
is in effect.  But I think that is actually a good change.

The run-command change and the main part of the fix are
logically independent.

The regression the patch fixes should be testable with a
script.  Please have a new test for it.

Thanks.
