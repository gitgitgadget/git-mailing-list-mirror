From: Junio C Hamano <gitster@pobox.com>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Mon, 21 May 2012 02:09:34 -0700
Message-ID: <7vaa1199yp.fsf@alter.siamese.dyndns.org>
References: <4FB9F92D.8000305@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 21 11:09:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWOcd-0007AY-Rw
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 11:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342Ab2EUJJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 05:09:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33556 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932151Ab2EUJJi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 05:09:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69E1F47D4;
	Mon, 21 May 2012 05:09:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WI2fzAED/s0ZJ2Cy6Jt8pzYiFjk=; b=WT+eSM
	WQjPD/hEc9utwQp1Qlk1/9hWeJ4CsJLH4R/59g10Wiptac/v+ddyY6ZsrSlP18YN
	l7CFqzscNj4jOglL5ETjmjgRxYySfIjYqvktW7XoSFhJ3LvLFHoU4ifaII8fCulr
	fVQkUo+pvTctfPqRkQxdGc/96IOCFyR6Dub28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AsthoZzWHbF6hhFktV54A8IZbBn4haVu
	VbDsSm/m5uxRvMhyVt2SN3Puht7P0I23wtLlRU0OApdKgmMyHTAO9NGZU2DR+HzU
	mPVL4Y00HF4NBQIlKPJjxuUDzwWoXtfrelRDpHPyS/R+viPf+nYnd1kSBJX/a+vk
	mA9nR8an/2A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FCC147D3;
	Mon, 21 May 2012 05:09:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4AC5947D0; Mon, 21 May 2012
 05:09:36 -0400 (EDT)
In-Reply-To: <4FB9F92D.8000305@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 21 May 2012 10:13:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AFE7AD74-A324-11E1-974E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198096>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It would be pretty trivial to reduce the work to O(N) by using a hash
> set to keep track of the references that have already been seen.

Sounds like a sensible thing to do.
