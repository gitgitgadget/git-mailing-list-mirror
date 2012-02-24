From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] bulk checkin does not respect filters
Date: Thu, 23 Feb 2012 19:17:49 -0800
Message-ID: <7vvcmw2a3m.fsf@alter.siamese.dyndns.org>
References: <20120224030244.GA15742@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 24 04:18:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0lfS-0007Ws-4J
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 04:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108Ab2BXDRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 22:17:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43678 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754817Ab2BXDRv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 22:17:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 158EF7481;
	Thu, 23 Feb 2012 22:17:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FMQpjxCcHCy8QqS9vsGLhsIUlZI=; b=UTcIdb
	Rx59NTGreBu4HyTSKR5E1f6+ufWmGoRSytnWoJnECO/Wt8xLAh/VvrDB+zT2EpET
	1ETmif8W+DlAM9KiqrPccJM2gIJ7O7oWutECQHlk+l8M+/SKLL6iw6kKjcOI6ZHU
	nmvR2oWMUtvfkRKqs93aHGdWMIKWB+XT2qRFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jv7H58ZCT2Oy3za2vUdCsStViDBxEXmo
	jIR5c1ReZG/eRroC8zt9bxaI9MmLU41nXSQeRbEC1xy9e2+I1UC66iScVv++yJzx
	W8yvpKpVRN/CznYgMnM/O5pvdJUpPDo4XWf2rlI/Q8ZKNCNW6P+SNpWuEab00qdO
	AaqXAOZGxx0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E27D7480;
	Thu, 23 Feb 2012 22:17:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F866747E; Thu, 23 Feb 2012
 22:17:50 -0500 (EST)
In-Reply-To: <20120224030244.GA15742@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 23 Feb 2012 22:02:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21E6497C-5E96-11E1-8ED0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191412>

Jeff King <peff@peff.net> writes:

> Thoughts? Was this intentional, or just overlooked?

This is intentional in the sense it is not worth worrying about (I
personally consider large and binary gunk equivalent and something nobody
should care about anything more than 1. what the exact contents it had at
each point in history and 2. if it did or did not change between two
versions, but definitely not 3. how different these two versions were),
and does not deserve the complexity to support filtering and textconv'ing.

If somebody strongly feels about lifting the limitation with a clean patch
that does not harm the common case codepaths, patches are welcome, but I
am not planning to do it myself ;-)

It is worth documenting this limitation, though.
