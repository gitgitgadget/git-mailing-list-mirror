From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2012, #01; Tue, 2)
Date: Wed, 03 Oct 2012 23:01:04 -0700
Message-ID: <7v626q3hen.fsf@alter.siamese.dyndns.org>
References: <7vmx045umh.fsf@alter.siamese.dyndns.org>
 <CACsJy8BGuoW6K_9vEgGrb2XC2bNtR=0jNRU3JQhsv7_diGQpbA@mail.gmail.com>
 <7vbogj5sji.fsf@alter.siamese.dyndns.org>
 <CACsJy8CAGaEzGZBJq7pOW_2SDpRDLiPqJK0t2WjpuNqLU+yewQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:03:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtOp-0001DP-Iv
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935Ab2JDGBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 02:01:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57221 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964Ab2JDGBM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 02:01:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B64856190;
	Thu,  4 Oct 2012 02:01:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HfRZvH3UrL9WyFpkZH8NxyKsR18=; b=tb+8wK
	+A8fzRmKi4mQsK35Th/fdbWYoIaQZ7lSVYt0EYJjmbZAhu+6qnRDTqdG22K0FRQu
	DEvlN355R8OGJNYutPm7rzK9OipGozDq5+lRhTW2JbHyv83JXntYiDJVKxYhxrEi
	b6iiqCEGiJpvW/4rpD01xMg/KgHsBGxHP0bX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YKp5gOyDf2OrCJfZfglSHYHfKbRVcB1j
	+GVeLat9Hzdea9fXSOd7+V6bErRw1O+ahNpVw6RCfwqFbxPXKT3zyNUUWnjc8SOO
	lzq/tl0xAXCeVc4gNX0n5eEmrScaswsYFCOj4B0eHIXl03L1BANyPLFaOU1BI/Ix
	8sQQPW+k8OI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A25F6618F;
	Thu,  4 Oct 2012 02:01:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72482618B; Thu,  4 Oct 2012
 02:01:09 -0400 (EDT)
In-Reply-To: <CACsJy8CAGaEzGZBJq7pOW_2SDpRDLiPqJK0t2WjpuNqLU+yewQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 4 Oct 2012 08:56:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4AEA1BE-0DE8-11E2-8001-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206958>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> I am guessing that the only sensible definition is that "**"
>> requires anything that comes before it (if exists) is at a proper
>> hierarchy boundary, and anything matches it is also at a proper
>> hierarchy boundary, so "x**y" matches "x/a/y"
>
> and "x/y" too? (As opposed to "x/**/y" which does not)

Yeah, x**y would match x/y under that "sensible" semantics.

>> and not "xy", "xay",
>> nor "xa/by" in the above example.  If "x**y" can match "xy" or "xay"
>> (or "**foo" can match "afoo"), it would be unreasonable to say it
>> implies the pattern is anchored at any level, no?
>
> Yeah. That makes things easier to reason, though not exactly what we're having.

It sounds like that "x**y" with the code you imported would match
"xy" and "xa/b/cy", and I do not think of a concise and good way to
describe what it does to the end users.

"matches anything including '/'" is not a useful description for the
purpose of allowing the user to intuitively understand why "x**y" is
anchored at the level (or is not anchored and can appear anywhere).

Perhaps the wildmatch code may not be what we want X-<.
