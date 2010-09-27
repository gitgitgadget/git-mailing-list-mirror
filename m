From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: option to specify rename threshold
Date: Sun, 26 Sep 2010 21:11:43 -0700
Message-ID: <7vk4m7n7uo.fsf@alter.siamese.dyndns.org>
References: <A0604F16-CA84-4A84-B74B-CE8AB455DF77@sb.org>
 <1285202724-52474-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Sep 27 06:11:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P054G-0003cY-Eq
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 06:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098Ab0I0ELv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 00:11:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab0I0ELu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 00:11:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C518D9E8B;
	Mon, 27 Sep 2010 00:11:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cXyTeN8m5nDalPc3ayNSVDXTCd0=; b=LuA/bw
	XerCqVHYgrCQHBpyQAazUOH0aRPUmi+sQqju+S3ZV+tIkPEa5/6FIUvmblNJixQu
	lfzIG3eTZtVBiP2LLOwrp/h0Sj+wN50xNhJoTtebDQbUaGaTvSJAlcRiXxhgG436
	4faN1wk//C4NOPcex2slr5ZGfqXuCPZq7FFkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PI+fYYpgfvjC76wQjKtwJFsGB6OgrMEG
	lLjskMJ8NOXNqNW7nCWlcRKU3zlGlWK7z3YIErxe4KpXJRFHB+7AwdbELMZCZI2E
	CKnJS9l7VxgalT+DFNYJuWB1CGkrMjCuhSurUx3fSELnHswi8OvD9+WyN98BS+Uy
	mBgi+zERDV0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76B07D9E89;
	Mon, 27 Sep 2010 00:11:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C28C8D9E88; Mon, 27 Sep
 2010 00:11:44 -0400 (EDT)
In-Reply-To: <1285202724-52474-1-git-send-email-kevin@sb.org> (Kevin
 Ballard's message of "Wed\, 22 Sep 2010 17\:45\:24 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 588D6CF6-C9ED-11DF-ABAE-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157293>

Kevin Ballard <kevin@sb.org> writes:

> The recursive merge strategy turns on rename detection but leaves the
> rename score at the default. Add a strategy option to allow the user
> to specify a rename score to use.

Sounds straightforward, except that Documentation/diff-options.txt seems
to call the number associated with -M "threshold", not "score".  The title
of the patch incidentally says threshold as well ;-)

At the end-user level, this new option to merge-recursive has exactly the
same meaning as existing -M given to "diff" family; people would probably
want to see it made available as a synonym to "diff" family as well, no?
