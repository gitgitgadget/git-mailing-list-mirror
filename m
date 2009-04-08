From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] list-objects: add "void *data" parameter to show
 functions
Date: Tue, 07 Apr 2009 19:29:20 -0700
Message-ID: <7vk55vubcv.fsf@gitster.siamese.dyndns.org>
References: <20090407040819.4338.4291.chriscool@tuxfamily.org>
 <20090407040854.4338.94304.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Apr 08 04:31:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrNZd-0007nH-R1
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 04:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760301AbZDHC31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 22:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757106AbZDHC31
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 22:29:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51020 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757005AbZDHC30 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 22:29:26 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 57C3FB0AB;
	Tue,  7 Apr 2009 22:29:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9A3C4B0A8; Tue, 
 7 Apr 2009 22:29:21 -0400 (EDT)
In-Reply-To: <20090407040854.4338.94304.chriscool@tuxfamily.org> (Christian
 Couder's message of "Mon, 6 Apr 2009 21:28:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 13BF9126-23E5-11DE-B992-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116023>

Christian Couder <chriscool@tuxfamily.org> writes:

> The goal of this patch is to get rid of the "static struct rev_info
> revs" static variable in "builtin-rev-list.c".

Hmm.  If it were a more library-ish file, a removal of such a static
variable might help you to make more than one calls to a library function,
but does it matter in files like builtin-rev-list.c?  Its cmd_rev_list()
is like main() --- it is meant to run once and exit.

So if it is the only goal of this series, I am inclined to say that I do
not have a reason to look at the rest of the series, but as a side effect
does this removal make some other API better?  Perhaps a more library-ish
function is in builtin-rev-list.c and this structure should really needs
to be passed around as a parameter, but I cannot tell solely by reading
the goal above, without reading the patches themselves.

> Anyway this makes the code more clean and more generic, so it
> should be a good thing in the long run.

I wouldn't disagree with that "long run" thing, but the answer to the
above question affects the placement of this series in my prioritized
queue.
