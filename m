From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] submodule: add 'deinit' command
Date: Tue, 04 Dec 2012 15:06:55 -0800
Message-ID: <7v1uf5mn74.fsf@alter.siamese.dyndns.org>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de>
 <20121130175309.GA718@odin.tremily.us>
 <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com>
 <50BA2892.7060706@web.de> <50BA3412.60309@web.de>
 <7vy5hhmcwp.fsf@alter.siamese.dyndns.org> <50BBB22A.7050901@web.de>
 <7vhao31s9e.fsf@alter.siamese.dyndns.org> <50BE6FB9.70301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 05 00:07:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tg1a8-0007mC-C5
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 00:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab2LDXG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2012 18:06:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36341 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444Ab2LDXG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2012 18:06:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B67789F28;
	Tue,  4 Dec 2012 18:06:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AiK8EFrWhuOwiAREIpD+TLbWUD0=; b=i9VqEi
	ILrn7Zc3Dnl6JDtbyBmYDuEDkaaKY+cvFY08rjg68T6AieubL1EAE0kMEzV1j3Jo
	tqFpP4SyY+fZImHOBMJxmv8ZE9jbjyaY62zQyKgWKBolTXt5urNPgLqU5g0JHXrW
	JqVbPLk8JISadHed/Mfq0+4BmOBhYjFnWXrzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hf8kzKKVswV4Fjq5anNj7/Ptj/q4uUiN
	zkO7+6TWnYoghm57GMoBuFPSEFYv06RF8HtRZvQgnDdInCd3EZu5Oxkk0iIn6fMS
	lxFNhmoSSfP8CCwn2Bs+TTRKHp6BHdHb/dpqB4KcyrtthpjlmwHiuQSbGm7aep5V
	rUptHQYAju8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1FF19F26;
	Tue,  4 Dec 2012 18:06:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 091669F20; Tue,  4 Dec 2012
 18:06:56 -0500 (EST)
In-Reply-To: <50BE6FB9.70301@web.de> (Jens Lehmann's message of "Tue, 04 Dec
 2012 22:48:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D1A1504-3E67-11E2-A194-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211099>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> +If you only want to remove the local checkout of a submodule from your
> +work tree without committing that use `git submodule deinit` instead
> +(see linkgit:git-submodule[1]).

I'll add a comma between "without commiting that" and "use X
instead"; it will read better, I think.

> +test_expect_success 'submodule deinit should remove the whole submodule section from .git/config' '
> +	git config submodule.example.foo bar &&
> +	git submodule deinit &&
> +	test -z "$(git config submodule.example.url)" &&
> +	test -z "$(git config submodule.example.foo)"
> +'

This is sufficient, but it might be cleaner to see if

    git config --get-regexp "^submodule\.example\."

results in empty.  Does not make much difference to warrant a re-roll.

> +test_expect_success 'submodule deinit complains only when explicitly used on an uninitialized submodule' '
> +	git submodule deinit &&
> +	test_must_fail git submodule deinit example
> +'
> +
>  test_done

Thanks; will queue.
