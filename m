From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: Store first bad commit as comment in log file
Date: Mon, 22 Apr 2013 15:37:31 -0700
Message-ID: <7vwqrumbtg.fsf@alter.siamese.dyndns.org>
References: <20130413152257.GB16040@pvv.ntnu.no>
	<20130415.063809.1055555229072260139.chriscool@tuxfamily.org>
	<20130415095339.GA28480@pvv.ntnu.no>
	<20130422210229.GE5650@pvv.ntnu.no>
	<7vr4i2nuar.fsf@alter.siamese.dyndns.org>
	<20130422222058.GF5650@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Torstein Hegge <hegge@resisty.net>
X-From: git-owner@vger.kernel.org Tue Apr 23 00:37:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUPMg-0000Va-Sg
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 00:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555Ab3DVWhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 18:37:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44901 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753460Ab3DVWhe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 18:37:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B26971863A;
	Mon, 22 Apr 2013 22:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wZlPmJt2WxiheRqSXFz6gk+Yt/A=; b=hVctLl
	xC+m0S+8hLYuxQoOemvfV8rBaQQ2vm8EHB7UZHZIz4ygXqYeCwuZmdxOc9M2BitK
	IRc1fpKZTHB823nI3fhwOiFdg/1NyXcT5NTno/iIgyyCJdWtP4eEndJP0bgjSa/4
	puDYhOs3RAvf8aWAZjN9XzenloSs1GMFdx4QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=riu/CA1gCjz1BfxDy+s1s39OXofJE18E
	MNQFLpNb7MNzSszAtM5w8qZ4T+qw7RGiNydd6d8dNSGUlt2o1IAukTxeHmTWsNhG
	A+LbvDAiioM2bX4sQziqGY4qslls35rV/5mb1QZzK2t8ZdoIGN6OA4hKUYLk05ci
	SkE8bdgfyGU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A674418639;
	Mon, 22 Apr 2013 22:37:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15DD218635;
	Mon, 22 Apr 2013 22:37:32 +0000 (UTC)
In-Reply-To: <20130422222058.GF5650@pvv.ntnu.no> (Torstein Hegge's message of
	"Tue, 23 Apr 2013 00:20:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 391D84B6-AB9D-11E2-B5C3-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222123>

Torstein Hegge <hegge@resisty.net> writes:

> On Mon, Apr 22, 2013 at 14:13:00 -0700, Junio C Hamano wrote:
>> Torstein Hegge <hegge@resisty.net> writes:
>> 
>> > I took another look at this. I wasn't able to come up with anything
>> > useful for the "The merge base $rev is bad" case, but for the "only
>> > skipped commits left to test" case one could do something like this.
>> 
>> We skipped them because we can gain _no_ information from testing
>> these commits. They are not even "possibly bad", but are "unknown".
>> 
>> So it feels to me that by definition listing them would not be
>> useful. What am I missing?
>
> The information lies in that those commits are the only commits with an
> unknown state. So if the bisecter hands off the bisect log to someone
> else when they can't test further, the current status is recorded.

That is an interesting use case: "I've narrowed it down somewhat,
but there are a few commits I do not have proper hardware for to
test them, could you take it over from here?"
