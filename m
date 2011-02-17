From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2 (v2)] submodule: no [--merge|--rebase] when newly
 cloned
Date: Thu, 17 Feb 2011 12:25:19 -0800
Message-ID: <7vzkpu9zo0.fsf@alter.siamese.dyndns.org>
References: <1297959526-8089-1-git-send-email-olsonse@umich.edu>
 <4D5D7A06.6050700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Spencer E. Olson" <olsonse@umich.edu>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 17 21:25:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqAPw-0006kQ-5H
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 21:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285Ab1BQUZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 15:25:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab1BQUZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 15:25:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BF4663536;
	Thu, 17 Feb 2011 15:26:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=npi2FSV6bLoo7LCEhRvM1g3N++A=; b=Aqw3XD
	PCq15XaZjdguCCggc4Y7vJvVzAAwXxh0XYf5qKAZt0mxvm4910VezprSYBVhrwlb
	F5hH/cPx8pVwdDLJEQB0hzoEvh+czvzwEi7lShh796XRrc5IR5OSd/wDJbXA4RYN
	gGgd/Hp+CweSRlgB1Wq7BbDSE6/nqwTwUPMC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H89akPkUnCgnsXeLAvPPSytOGooOGRrb
	d+n/wA08aOi9fwRP/FrsGrJZNXhlO0Tk0rI4vALXq/S39V4eKS/DLuVcttx2B0R5
	6jVlEmreqp5EoEJUhfB10OobRIPC5B4bbZ5zLB7uumjGgvbWM7yrH2LBcfPndZDa
	TVHb29Dk4KU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 89C59352F;
	Thu, 17 Feb 2011 15:26:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5C724352D; Thu, 17 Feb 2011
 15:26:28 -0500 (EST)
In-Reply-To: <4D5D7A06.6050700@web.de> (Jens Lehmann's message of "Thu\, 17
 Feb 2011 20\:41\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 357204E0-3AD4-11E0-9B51-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167113>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 17.02.2011 17:18, schrieb Spencer E. Olson:
>> Previously, when a new submodule is cloned by running "git submodule update
>> [--merge|--rebase]", the newly cloned submodule does not get checked out and a
>> rebase or merge is incorrectly attempted against an empty working directory.
>> This patch ignores --rebase or --merge for new submodules and instead simply
>> checks out the appropriate revision.
>
> Nice work, thanks!
>
> Just a small thing: This problem also happens when the configuration
> "submodule.<name>.update" is set to either "rebase" or "merge", not only
> when using the command line options. So perhaps you could reword the topic
> to something like "submodule: don't merge or rebase when newly cloned" and
> adjust both commit messages a bit?

I tentatively queued with this rewrite (the patch text is the same as the
one I sent previously).

    From: Spencer E. Olson <olsonse@umich.edu>
    Date: Thu, 17 Feb 2011 09:18:45 -0700
    Subject: [PATCH] submodule: no [--merge|--rebase] when newly cloned

    "git submodule update" can be run with either the "--merge" or "--rebase"
    option, or submodule.<name>.update configuration variable can be set to
    "merge" or "rebase, to cause local work to get integrated when updating
    the submodule.

    When a submodule is newly cloned, however, it does not have a check out
    when a rebase or merge is attempted, leading to a failure.  For newly
    cloned submodules, simply check out the appropriate revision.  There is no
    local work to integrate with for them.

    Signed-off-by: Spencer E. Olson <olsonse@umich.edu>
    Acked-by: Jens Lehmann <Jens.Lehmann@web.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
