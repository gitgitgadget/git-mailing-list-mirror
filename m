From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] checkout --to: no auto-detach if the ref is already checked out
Date: Wed, 23 Jul 2014 10:46:01 -0700
Message-ID: <xmqqmwc0dl46.fsf@gitster.dls.corp.google.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
	<1406115795-24082-4-git-send-email-pclouds@gmail.com>
	<53CFBD2A.9030803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 23 19:46:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA0cI-0001u1-OH
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbaGWRqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:46:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58500 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757655AbaGWRqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:46:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4777529677;
	Wed, 23 Jul 2014 13:46:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Agv8/vCds+p69XcGp+ueITp5rvM=; b=QtyGjL
	ocK01ARIaVNZZc0OaD4hKy2DF2dlkZpHh4inJZtNp8b587iAQS34Nyrkv0JKD2TV
	do2+yoZJuqswRc6SNl7+DIp09dQr//yv0o27XMg+OlO3xrGrweZl/Tz5G0rCf/0z
	uThRaGYx/pdVonbP+/B3oPOJgQ00WQiXcW+8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZmFnHxK8hQMvroaUlSwBGIcwZuhJ0jhA
	B70DumtTvmsY/n6NSU0ZhkrGnUp5AOM6uBVRdu+60mvmmshtVt8f/WAy47D/rlB+
	EKOKis+VaaYbIOLYsbWvANq2clJfvCpgZuVfuT+bpzzuVSgDaVvbIg7O5WcAHmpM
	hyuXjJenoec=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 391FE29676;
	Wed, 23 Jul 2014 13:46:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 38A4629668;
	Wed, 23 Jul 2014 13:46:03 -0400 (EDT)
In-Reply-To: <53CFBD2A.9030803@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 23 Jul 2014 15:48:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 37211310-1291-11E4-B896-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254096>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> +	if (advice_checkout_to)
>> +		die(_("%s is already checked out at %s.\n"
>> +		      "Either use --detach or -b together with --to "
>> +		      "or switch branch in the the other checkout."),
>
> "or switch to a different branch in the other checkout". But maybe we
> can be even more helpful, like:
>
> "%s is already checked out at %s.\n"
> "Either checkout the detached head of branch %s using\n"
> "    git checkout --detach --to %s %s\n"
> "or checkout a new branch based off %s using\n"
> "    git checkout --to %s -b %s newbranch %s\n"
> "or switch to a different branch in the other checkout."
>
> if we can figure out the appropriate arguments at this point in the code.

Another possible alternative is "go and work there instead of
creating yet another checkout", but is that too obvious without
saying?
