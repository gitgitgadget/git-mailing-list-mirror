From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/6] Support triangular workflows
Date: Sun, 31 Mar 2013 18:50:11 -0700
Message-ID: <7vli93nhnw.fsf@alter.siamese.dyndns.org>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
 <20130328153547.GA3337@sigill.intra.peff.net>
 <CALkWK0=a0wmUe-rjK8Gg8izc0FdXYzChSrgp+W-JNsECsDf+yA@mail.gmail.com>
 <20130331214318.GA24646@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 01 03:50:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMTte-00043A-I8
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 03:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575Ab3DABuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 21:50:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004Ab3DABuO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 21:50:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78163E0F3;
	Mon,  1 Apr 2013 01:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=39EwYZIloCWet0qCG0PPNhV6AoI=; b=SM7nF1
	1OZ6rqVUhCqHnKpa8DaDSGWdibADsnbPEylHOgVSmPxhU4UtBEssy7cNE8e2sBaQ
	M5VS2BG7ZIHO4teCIHmIBfv4p3BH9oHBTVrmp+5nao8dcxBLWK8rtCyZORPDJMc/
	RbGpyPPNMcAGAZDRMXlikutT8K/6oJnJFqcsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FvOhR01Pf9h98dZC6HS4/ev7cVuUj3vE
	81aCR685vpiogzlEv8lOCu03zbV2Fk/aZaLRWIcadiRhnMrPSzPdBYXn9dyIAlP7
	Sv0sWsCX/yPbHg7uKoXCQaM03ele3rnLzVtt8V7exUdAhpx/4tzeaIz1sqREBZpo
	JMGbeG5c3Eg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E2B2E0F2;
	Mon,  1 Apr 2013 01:50:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7997E0F1; Mon,  1 Apr 2013
 01:50:12 +0000 (UTC)
In-Reply-To: <20130331214318.GA24646@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 31 Mar 2013 17:43:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E33DDA6-9A6E-11E2-8731-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219655>

Jeff King <peff@peff.net> writes:

> On Mon, Apr 01, 2013 at 02:21:22AM +0530, Ramkumar Ramachandra wrote:
>
>> Jeff King wrote:
>> > [...]
>> 
>> So, you're saying: don't test compound statements for failure, since
>> anything in the chain could fail and propagate failure.  I should only
>> test simple git-foo commands for failure?
>
> Right.

I think another thing to keep in mind is that "test_must_fail" is
used only to check for an expected failure from git-foo commands,
not for a random command (or sequence of commands).

The primary point of test_must_fail is not to declare _any_ failure
as "Oh, good, I wanted see it to fail and it returned non-zero exit
status so I am happy", but exclude uncontrolled failures, by saying
"Yuck, it returned non-zero exit status, but it died by signal
(e.g. SEGV), which is not the way I wanted to see it die".
