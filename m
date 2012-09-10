From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/14] filter_refs(): build refs list as we go
Date: Mon, 10 Sep 2012 14:18:52 -0700
Message-ID: <7v392pmv9f.fsf@alter.siamese.dyndns.org>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
 <1347171589-13327-10-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 10 23:19:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBBNn-0000T2-LS
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 23:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843Ab2IJVS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 17:18:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60392 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272Ab2IJVSz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 17:18:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F00C9B58;
	Mon, 10 Sep 2012 17:18:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=wPhEj7bEqcPRRZnTwBz/rdRY4Wc=; b=XohFUVPhbGFByQk8wyWe
	+/4bKeFBDHteAJOur4CMxcdmWUH+CLPG3Ps7obIK1HtHEgpIXssMOvE5G9Dgq85g
	y6a+Ws+Xx0yY0HDfR8WJ4DTumhNUQCniK0BybdTfYGZTuG5TUYkvK2c5M3n7KJMy
	XwbLoWccLOU7LVUpk7G7gBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=YYfQ0XdDb90Co1BLt/VoN8P3LEhj0JtDQLsi2q44HWAuO8
	Vn9osXNnvvqKgN9wJ/6aFih/m2AV9KEPUWxp3VDvrrokaaqNktwfrTM2xnQ1jVJt
	FQZovdvXxE9PMxUyxXr05XJh8RXuPa2PvN++6hOuB6tNlRpFkJSnHB/iThjYU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C2019B57;
	Mon, 10 Sep 2012 17:18:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF4029B55; Mon, 10 Sep 2012
 17:18:53 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FBC4C52-FB8D-11E1-A0EC-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205183>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Instead of temporarily storing matched refs to temporary array
> "return_refs", simply append them to newlist as we go.  This changes
> the order of references in newlist to strictly sorted if "--all" and
> "--depth" and named references are all specified, but that usage is
> broken anyway (see the last two tests in t5500).

Removes two warts (the temporary array in general, and the
fastarray[] special case) with one patch.  Nicely done.
