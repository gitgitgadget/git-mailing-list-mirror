From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Wed, 25 Feb 2015 11:01:22 -0800
Message-ID: <xmqqbnkholx9.fsf@gitster.dls.corp.google.com>
References: <54EDBEC2.8090107@peralex.com>
	<CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>
	<20150225143116.GA13567@peff.net>
	<xmqqk2z5on72.fsf@gitster.dls.corp.google.com>
	<20150225185128.GA16569@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Noel Grandin <noel@peralex.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 20:01:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQhDG-0000Lo-Fj
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 20:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbbBYTBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 14:01:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55056 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753174AbbBYTB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 14:01:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A3263BD65;
	Wed, 25 Feb 2015 14:01:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7oboMS5bzV96Zv8hHO+cf7dJ1WE=; b=xxNi7h
	gQZ1u0TZlgwNWnk0Es5ZqZSndFApx0NWZ6Og/M+VnJgdHgiyXQmWQeY/Pwk6TO3e
	Swb4ZOHDxj8DFnfI5Mq3zrmZZb6UI221xW/PnsF/QShS/tj+Ylayh/464c7QSS6p
	DKA+jdvNUcu7GzsZPfk1hAacX/D5VWLjYnFeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i9PUsr5/ncS7QwyHwGHIFxSKLf5XwdJs
	PMcCgf9UacN+e8R4/1WrInQYvLTtXJA7Ujp/IAV2WKNTVv9YnplVK1IeK6s/3EFS
	vf8IMMpuswQWF5+RbAQip1SBJAGpGBnk6sCdkAVdyDg+UKCy6o1PGtiyIbWl3Gc6
	laMxELMG4lc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 295023BD64;
	Wed, 25 Feb 2015 14:01:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9FCD93BD60;
	Wed, 25 Feb 2015 14:01:23 -0500 (EST)
In-Reply-To: <20150225185128.GA16569@peff.net> (Jeff King's message of "Wed,
	25 Feb 2015 13:51:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B126EB6E-BD20-11E4-99DC-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264404>

Jeff King <peff@peff.net> writes:

> So I think _if_ using "diff" attributes is enough for this purpose, then
> there is no code to be written.  But if somebody wants to draw a
> distinction between the uses (I want to diff "foo" files, but never see
> them in grep) then we could introduce a "grep" attribute (with the
> fallback being the value of the "diff" attribute for that path).

That is all true.

If we were to have a new 'grep' attribute that can be used to
express 'It is OK to diff two versions of this path, but hits by
grep in this path is useless' (and verse versa), the built-in macro
attribute 'binary' should also be updated with it.  A path being
'binary' currently means '-diff -merge -text' but it should also
mean '-grep' in the new world, if we were to go in that direction.

Thanks.
