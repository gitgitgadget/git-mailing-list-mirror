From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/48] Handling more corner cases in merge-recursive.c
Date: Thu, 04 Aug 2011 12:03:39 -0700
Message-ID: <7vpqkl3sok.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <7v4o1y81sv.fsf@alter.siamese.dyndns.org>
 <CABPp-BE=9r+upGUD45J7fPshqQE97UMZzaA+cu_WJ1A2p_Bigg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 21:03:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp3Ct-0005RO-H8
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 21:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604Ab1HDTDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 15:03:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56046 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755621Ab1HDTDl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 15:03:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26D2642C2;
	Thu,  4 Aug 2011 15:03:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qh9CeDHuye0NeKFebVoO2Q4yv1Q=; b=fKi/45
	RSrHra0kBCk+HpLX4RIHcobCjH0WyNkupU+C1+I1MPzxk3ssYgM9PT/H/sssbN6l
	UK57XGaADV9/ccFbzq3ZmdS9WlD59JVdflXrsHZPx4f7H93EBPek9kDiMiDb/JKJ
	El/ncKt/SBSd31RcIOhFVB7SlYQDyQRXvv4/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WvC+HPXNNdsRZ+Hvsg5hZEfU9ln+rKYC
	QYGk1pO7B2G1zJc/XIGp9KbsGCYViyP6EctzIXklkWE1WtL7sRX8+/NAGjTPURtT
	BSBYflop3QUh9kbs13Q/lf6cwpE5A6XJUGWlndzyWMBfJNsU9XNxefa5z3+SVybs
	FgyIIn9E+go=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DC6442C1;
	Thu,  4 Aug 2011 15:03:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C39442C0; Thu,  4 Aug 2011
 15:03:40 -0400 (EDT)
In-Reply-To: <CABPp-BE=9r+upGUD45J7fPshqQE97UMZzaA+cu_WJ1A2p_Bigg@mail.gmail.com> (Elijah
 Newren's message of "Thu, 4 Aug 2011 11:26:20 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77561096-BECC-11E0-8BCF-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178763>

Elijah Newren <newren@gmail.com> writes:

> ...  It
> would be nice to make use of the original index we had before
> unpacking, but that is overwritten at the end of unpack_trees.

I somehow thought that we can give separate src and dst index
to the unpack_tree() machinery these days. Aren't you using it?
