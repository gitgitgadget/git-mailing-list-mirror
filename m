From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] grep --no-index: don't use git standard exclusions
Date: Thu, 15 Sep 2011 12:44:08 -0700
Message-ID: <7vmxe5pp4n.fsf@alter.siamese.dyndns.org>
References: <2f376e61802a1a38c67698d5ec263d1807b1fcee.1316110876.git.bert.wesarg@googlemail.com> <7b3551dd84a2bfec78c8db1d14dd2d0e6dda35f6.1316110876.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 21:44:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4HrG-0000Xf-AY
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 21:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934654Ab1IOToS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 15:44:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33433 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934532Ab1IOToO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 15:44:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2BF95EB5;
	Thu, 15 Sep 2011 15:44:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZhaN+MkDi3pQIzJJ66+eg9QZEhI=; b=TH6tpV
	2erfWId9W+NdRuiy9ypt3CqbGCwSzURBhEuae70G38hJLVcnWQlLaIpMLfOHJyHo
	blh07AKsl66YROMRmtGnT8erE558Pbdd1Wm/IpqhSHQ5B5gpDQ3hRkXoTK7Lb/ef
	vb8+nkoNSKUavOTqapfTDC8NLAeJZHmegdc9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K3Wsy6rxopWhEf8CnsD7ZBfSz/Kx1UHU
	PCrOfpoFalbKCuOiGGBGwPdks1XOWofrj65Rvpcc7CDoYSqAEVgcUurA9J8Otho5
	EfrUY1pecu1b6N9Ol43EwCXzqftPMbfnHDLTTd3Sl0Xp/Vaj8ynE8uBoPaMwOTmG
	jgYJwNXCozE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99A695EB4;
	Thu, 15 Sep 2011 15:44:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C4095EB3; Thu, 15 Sep 2011
 15:44:12 -0400 (EDT)
In-Reply-To: <7b3551dd84a2bfec78c8db1d14dd2d0e6dda35f6.1316110876.git.bert.wesarg@googlemail.com> (Bert Wesarg's message of "Thu, 15 Sep 2011 20:26:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16095C3A-DFD3-11E0-90D5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181488>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> On Wed, Jul 20, 2011 at 22:57, Junio C Hamano <gitster@pobox.com> wrote:
>>  - Since 3081623 (grep --no-index: allow use of "git grep" outside a git
>>   repository, 2010-01-15) and 59332d1 (Resurrect "git grep --no-index",
>>   2010-02-06), "grep --no-index" incorrectly paid attention to the
>>   exclude patterns. We shouldn't have, and we'd fix that bug.
>
> Fix this bug.

On a busy list like this, it is brutal to withhold the better clues you
certainly had when you wrote this message that would help people to locate
the original message you are quoting, and instead forcing everybody to go
back 5000 messages in the archive to find it. E.g.

    http://article.gmane.org/gmane.comp.version-control.git/177548
    http://mid.gmane.org/7vzkk86577.fsf@alter.siamese.dyndns.org

Or perhaps have

    References: <7vzkk86577.fsf@alter.siamese.dyndns.org>

in the header.

As to the patch, I think this addresses only one fourth of the issue
identified in that discussion (it is a good starting point, though).

With this change, it would now make sense to teach --[no-]exclude-standard
to "git grep", and "--exclude-standard" is immediately useful when used
with "--no-index". When we add "git grep --untracked-too" (which lets us
search in the working tree), people can add "--no-exclude-standard" to the
command line to say "I want to find the needle even from an ignored file".

Thanks.
