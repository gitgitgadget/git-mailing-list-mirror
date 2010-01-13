From: Junio C Hamano <gitster@pobox.com>
Subject: Re: default behaviour for `gitmerge` (no arguments)
Date: Wed, 13 Jan 2010 11:48:06 -0800
Message-ID: <7vpr5dn5vt.fsf@alter.siamese.dyndns.org>
References: <loom.20100111T185144-655@post.gmane.org>
 <7v7hrojukz.fsf@alter.siamese.dyndns.org>
 <20100112162355.GB25092@coredump.intra.peff.net>
 <7vhbqr2nxt.fsf@alter.siamese.dyndns.org>
 <20100112182550.GA15696@coredump.intra.peff.net>
 <7vwrzmqypn.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1001131024420.3043@intel-tinevez-2-302>
 <7v6376pc9w.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1001131202510.3043@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Gareth Adams <gareth.adams@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:48:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV9CX-0002eU-Qx
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 20:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773Ab0AMTsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 14:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535Ab0AMTsS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 14:48:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab0AMTsR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 14:48:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1013909E4;
	Wed, 13 Jan 2010 14:48:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=7k8E8hbSgIrde2DlRu6CjAJ4lSk=; b=lmks2VItyfVXBelfF4Ups+m
	wwaKUorB1XZjXTw+sNEeI1H6QiOFSWpXTfXgsHdRATp/rK8Z/jofAVU9HzaRA89/
	5OD2+CJMD1ad0REHaY/JuNY60Bu+E9WccZnxrQHOtVwdyg9nH4EeF2bKVejnJVF2
	w6D3csv9H963zHi2SCVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=P6/5czLbdIA7EqAsH3RYRM0vOST/q/RXnYc7cBLVrj4humWmr
	ixDlh89qZYVK6rlQXzQa1CsRsNtL0an4K7HJYtDp1MAI9ktnh5rTS7r15KkWBmCL
	+5EIGsoFHWsRhEhKrvZnOY3WVuHFIZTBwi6nsQkTeI2sop1S/SQYz/2rEI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B1A02909E3;
	Wed, 13 Jan 2010 14:48:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9A75909E1; Wed, 13 Jan
 2010 14:48:07 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9568149A-007C-11DF-B980-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136864>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So you meant to say that substitute_branch_name() calls 
> interpret_branch_name(), so the change should be in the latter.  (This is 
> supposed to be the summary of your 4 paragraphs.)

Not quite.  What I was asking was:

	*PROVIDED* *IF* you wanted to keep the same semantics between
         them, then you would have patched i-b-n, but you didn't.  Was there
         a reason callers of s-b-n should know about @{u} but callers of i-b-n
	shouldn't?

Expected answer was either:

	(a) Codepath X that uses i-b-n shouldn't interpret @{upstream} as
            a symbolic name given by the user, but it should treat it as a
            mere SHA-1 expression instead for *this and that* reason.
            Otherwise we will see *this* breakage when the user does
            *that*.  That is why i-b-n doesn't know about the new syntax;
            or

	(b) It was a thinko; all codepaths that use i-b-n should know the
            new syntax as they _are_ interested in learning the symbolic
            name when the user gives @{upstream}.
