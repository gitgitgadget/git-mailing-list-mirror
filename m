From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] remote.c: introduce a way to have different remotes
 for fetch/push
Date: Wed, 20 Mar 2013 12:48:03 -0700
Message-ID: <7v7gl1etu4.fsf@alter.siamese.dyndns.org>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-5-git-send-email-artagnon@gmail.com>
 <7vfvzpevwf.fsf@alter.siamese.dyndns.org>
 <CALkWK0=29fu92A8_XQCmW86U2y-ktNAOy4qMmJAhyYHo8FgX1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 20:48:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIP00-0001Kv-73
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 20:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665Ab3CTTsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 15:48:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52743 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605Ab3CTTsH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 15:48:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ECB0AD4A;
	Wed, 20 Mar 2013 15:48:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uz1T3sxWJrGQ/fop086cLEeHPKY=; b=Abj2BM
	amA0Bqn8rfcKrlPxXXCbZOXkm40tldgSfDH2UKQWhFar6qK3EGOsZTK5TIs/rPyY
	wKTUCljO9ZuHKMC7lrzEbT/I31Q6fiOjJlgxloN0DHkM+HkfyiWRuQfxAHnw+wwV
	DZJJ3NeYS/nlQ0xcSING5N9r0bC4Fn6QJli90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P1qFrgi3YuGfXvd/9uvqVj06QZZePXUX
	aQZQ451kQ5yOosw8U58BGVB8fYkAKmwaxRiWRBBYnRpCJkK/UouRCldAo7DvEMns
	i12xgh93WHwnNIFExEIaSTr8eHioyepI74bDHA8NUj/pFN5GcXlOBap/oGPr9mES
	KakkwUNFWXM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61D4BAD49;
	Wed, 20 Mar 2013 15:48:06 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0CAFAD47; Wed, 20 Mar 2013
 15:48:05 -0400 (EDT)
In-Reply-To: <CALkWK0=29fu92A8_XQCmW86U2y-ktNAOy4qMmJAhyYHo8FgX1Q@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Thu, 21 Mar 2013 01:13:58 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 154CD1D8-9197-11E2-A999-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218667>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> ...  There is no implicit fallback (like
> "origin"): it just falls back to the .remote codepath, if not
> explicitly specified.

That one sentence is enough to explain the apparent asymmetry, which
bothered me.
