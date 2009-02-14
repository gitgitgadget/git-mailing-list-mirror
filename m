From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3 v2] send-email: correct logic error with
 --suppress-cc=cc
Date: Fri, 13 Feb 2009 22:52:39 -0800
Message-ID: <7viqndzf0o.fsf@gitster.siamese.dyndns.org>
References: <1234583491-61260-2-git-send-email-jaysoffian@gmail.com>
 <1234592519-71980-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 07:54:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYEPo-0007qD-H4
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 07:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbZBNGwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 01:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbZBNGwt
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 01:52:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbZBNGws (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 01:52:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 909D12B185;
	Sat, 14 Feb 2009 01:52:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 953CC2B182; Sat,
 14 Feb 2009 01:52:41 -0500 (EST)
In-Reply-To: <1234592519-71980-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Sat, 14 Feb 2009 01:21:59 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 16B72510-FA64-11DD-A1FF-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109834>

Jay Soffian <jaysoffian@gmail.com> writes:

> --suppress-cc=cc is supposed to suppress harvesting addresses from any
> Cc: lines. However, in the case where the Cc: line contained the sender,
> it would only suppress if --suppress-cc=self.

Perhaps I am personally slightly in favor of your interpretation, but the
current behaviour makes sort of sense, too.  To everybody, himself is
always special (and that is why we have 'self'); I do not think it is
entirely unreasonable if --suppress-cc=cc meant remove people from Cc list
but I am special.

> And here's a re-roll of this one. Sheesh, that logic was too subtle for
> my brain.

Perhaps it is easier to clarify the goal by updating the tests to define
what needs to happen first?  Working from tests often makes the end result
much more robust than randomly modifying the existing code here and there
until it happens to start doing something you think it should do.
