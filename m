From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v14 5/8] bisect: introduce --no-checkout support into
 porcelain.
Date: Wed, 03 Aug 2011 10:01:56 -0700
Message-ID: <7vd3gmcttn.fsf@alter.siamese.dyndns.org>
References: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com>
 <1312323362-20096-6-git-send-email-jon.seymour@gmail.com>
 <7voc07ct9z.fsf@alter.siamese.dyndns.org>
 <7vk4avcsk9.fsf@alter.siamese.dyndns.org>
 <CAH3AnrrtfhU1r1DWO8ski5Jd=cLXcj3Wq-MowB8QKv+r1-BT_A@mail.gmail.com>
 <CAH3AnrpPaUY1fj9thMybPUgeM=mBEN3FjawjiR2vhw4S-v6qyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 19:02:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoepZ-0005YZ-RF
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 19:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071Ab1HCRCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 13:02:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32911 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934Ab1HCRCA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 13:02:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57AA05071;
	Wed,  3 Aug 2011 13:01:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=THXQZQgXu3HyAxjKQ9DJyVxTILc=; b=ZAh12g
	MvEiK3kQ+2l+MipTfUuQAlAmFVRcHKsZjLteZhb+Rg6AP71gwvHJqD44bYPgCgs3
	XbQ7ogYM296MbJ9ZgIkam0bfesSnR9hW3XBkFRAZJae+94ESGXJ3LJSyM+Rs1hgi
	ZhbJaO4GU4o6zyIGdPlna9fw1xHTX320BLsyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kX8BOW3TYQIMUS0GdQ9/CM8rPMOwwTfC
	TyU2rLR5fNUn6LHkNqxIentZWvx3E1iYBfTMw2WEAaaoUuO3twY3dvYfcsdQ8/Ay
	8MGs9CWoM7rDEAYurLtZf6ghuwFhSS+Pf5Eq486jxKoECDIjUQFoV4Go20w0YGmS
	DqnXWMCWqXM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C9AC5070;
	Wed,  3 Aug 2011 13:01:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B9CF506F; Wed,  3 Aug 2011
 13:01:58 -0400 (EDT)
In-Reply-To: <CAH3AnrpPaUY1fj9thMybPUgeM=mBEN3FjawjiR2vhw4S-v6qyg@mail.gmail.com> (Jon
 Seymour's message of "Thu, 4 Aug 2011 01:24:12 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4C97681C-BDF2-11E0-91DD-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178596>

Jon Seymour <jon.seymour@gmail.com> writes:

> I had a quick go at doing this, but haven't been able to test it
> fully. At a minimum it will require that we relax the barriers in
> git-bisect.sh and git.c that prevent git-bisect
> and bisect--helper running without a working tree. Other paths in
> these modules will need to  be checked to see that they don't have an
> implicit assumption that a  working tree is available.
>
> I  won't have time to tackle this properly until the weekend.

That is Ok and thanks for looking. Making this available to bare
repository is a totally separate follow-on topic that can and should be
done as a separate series that depends on the current topic anyway, so
let's focus on the current topic at hand first.
