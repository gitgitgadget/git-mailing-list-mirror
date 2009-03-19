From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Microoptimize strbuf_cmp
Date: Thu, 19 Mar 2009 15:01:40 -0700
Message-ID: <7vvdq56ukb.fsf@gitster.siamese.dyndns.org>
References: <20090319210931.GB31014@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 23:03:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQKb-0002zO-QQ
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 23:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbZCSWBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 18:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbZCSWBr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 18:01:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbZCSWBr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 18:01:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AD3787637;
	Thu, 19 Mar 2009 18:01:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 083A77636; Thu,
 19 Mar 2009 18:01:41 -0400 (EDT)
In-Reply-To: <20090319210931.GB31014@blimp.localdomain> (Alex Riesen's
 message of "Thu, 19 Mar 2009 22:09:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 899A39C8-14D1-11DE-852C-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113845>

Alex Riesen <raa.lkml@gmail.com> writes:

> Make it inline and cleanup a bit. It is definitely less code
> including object code, but it is not always measurably faster
> (but mostly is).

The only in-tree user seems to be rerere, so inlining for that single
caller will reduce the object side, but I am not sure if this is a good
change in the longer term if we want to encourage the use of strbuf
library.

The rewrite of the logic does seem worth doing, though.
