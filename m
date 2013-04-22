From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 12:09:47 -0700
Message-ID: <7v7gjupekk.fsf@alter.siamese.dyndns.org>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
	<87ppxmogdv.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
	<87wqruk2pj.fsf@linux-k42r.v.cablecom.net>
	<7vk3nupltx.fsf@alter.siamese.dyndns.org>
	<CALkWK0madWxOSraZw6u8U_afVeK8tyMB_+D59n1vSBmobxGqqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:10:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUM7t-0000ZC-0m
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706Ab3DVTJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:09:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39424 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754666Ab3DVTJz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 15:09:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BF971838F;
	Mon, 22 Apr 2013 19:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q8utPmf9LIBai3HBp6po+O8mzXs=; b=R4NMfP
	zKguJkx4kIDsZULc4mkew4NoH1v/jIpo2spbEX8+JBM0tYbITQf76w65ipyBxqiz
	ehRZUVzJ2CQRe5+HPz0AW9DuLR4D5C0LaIjoQvQYm3aNZx2xnNL6fQc4/fq5/FUu
	iSCRV8/n80q3Xn46xBnJD9oHNRiQ3IfDz30XE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZQHWvKL5QD489e+gGJq4oeEdEJEsHDVG
	imFzsxv88lVAIO3ZaL2fX/VOJIoHADR60BxWvBbgz5pk4kXlIUrcoP76/CzzOvnj
	aYw/ohNQDHnvjzSfuMODI1XKV6ZAG8oTDyJ1UR6Jvf7IAwAM5ZWU7VwG9f7zlSj2
	wHri/w53VvE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5000A1838D;
	Mon, 22 Apr 2013 19:09:53 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C56071838A;
	Mon, 22 Apr 2013 19:09:52 +0000 (UTC)
In-Reply-To: <CALkWK0madWxOSraZw6u8U_afVeK8tyMB_+D59n1vSBmobxGqqg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 22 Apr 2013 23:30:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36354530-AB80-11E2-A206-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222045>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> [...]
>>  (3) When (1) notices that the path being followed did not exist in
>>      any of the parents (be it a merge or a non-merge) and finds a
>>      different path with a similar looking content, it _switches_
>>      the pathspec to it, but the single pathspec it uses is a global
>>      state and affects traversals of other ancestry paths at the
>>      same time.  Because of this, "--follow" will not work correctly
>>      in a history that contains merges.  It often _appears_ to work
>>      only by accident.
>
> This explanation is all very nice, but isn't it completely tangential
> to the issue at hand?

I think you are talking mostly about (2), but the primary purpose of
my message was not about your specific issue.

It was to give a larger picture to people who may be inclined to
tackle, and may be capable of tackling, the real issues in the
"--follow" codepath.  Anybody who wants to update it needs to be
aware of all three.
