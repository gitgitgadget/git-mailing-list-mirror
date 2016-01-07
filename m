From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to fetch entire heirarchy of refs from a remote?
Date: Thu, 07 Jan 2016 15:45:56 -0800
Message-ID: <xmqqfuy92bt7.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xqexsOma5c9NfS5ma333UJV=5i1a4GhnwZuU75eaxRd=Q@mail.gmail.com>
	<CA+P7+xra4hjskOLg=VhLMGazTSDH=ky8H+fj2VMCw+HoY2Frrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git mailing list <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 00:46:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHKFt-0004MU-Oo
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 00:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbcAGXqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 18:46:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51720 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752721AbcAGXp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 18:45:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1EEA63AA84;
	Thu,  7 Jan 2016 18:45:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aD6pGiI2z370PUDebh5Lw5bHxS4=; b=jDk7ce
	ou+BNyobvr9QBakv+eXjuDFLlcDcy38V7gk2dSr+v2jult2erZKEoCyHymjVftnK
	HH0Rf5FOCFaNwSE9T1RFpm842dyjGRTlRNg95JE0GOEQLKUV0t5ZzMhwOyWHXaMV
	nAh2Vzlqqz7RrGDYGIL9Xxt05AkERsB4yrIlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fXePRbBcggbHePVo5vP3a1r+kA2DYLdR
	YSXJW2MTWYih+6T117tnbENq7+1gSRm1zv8byiKFX0eMkVrxwYwXYirGrzYtOvOP
	OEeOXWGGxhhFWeN6Tc2Cov+T8/LamMCRS6uYKFgMNXRCT1sUYehzmZpNCH9a4xNs
	ooChFk8cn90=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1455B3AA82;
	Thu,  7 Jan 2016 18:45:58 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 895AB3AA80;
	Thu,  7 Jan 2016 18:45:57 -0500 (EST)
In-Reply-To: <CA+P7+xra4hjskOLg=VhLMGazTSDH=ky8H+fj2VMCw+HoY2Frrg@mail.gmail.com>
	(Jacob Keller's message of "Thu, 7 Jan 2016 15:36:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CC87AF6C-B598-11E5-A679-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283521>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Thu, Jan 7, 2016 at 3:06 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>
>> But, git clone --mirror and git fetch have failed to pull every ref,
>> and only end up with heads and tags.
>>
>> Regards,
>> Jake
>
> It turns out that it *does* pull the refs, but they don't appear to
> show up inside the "refs" folder.. is there a reason for this?
>
> ie:
>
> ls .git/refs/changes
>
> shows nothing,but
>
> git ls-remote file:///path/to/repo
>
> does show them? Any particular reason for why this is? I am confused
> why refs aren't showing up inside the refs folder...

Does

	git for-each-ref refs/changes/

in your local resulting repository show them?

There is nothing that says "ls -R .git/refs/" is the way to
enumerate available refs (in fact it is a _wrong_ way that is
guaranteed to give you wrong results).

Hint: .git/packed-refs
