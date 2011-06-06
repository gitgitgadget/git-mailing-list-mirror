From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] submodule add: allow relative repository path even
 when no url is set
Date: Mon, 06 Jun 2011 14:00:08 -0700
Message-ID: <7vei368ylj.fsf@alter.siamese.dyndns.org>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org>
 <1306943792-1825-1-git-send-email-marcnarc@xiplink.com>
 <7vsjrth4iy.fsf@alter.siamese.dyndns.org> <4DE69945.1080601@web.de>
 <7v39jsdulf.fsf@alter.siamese.dyndns.org> <4DE93B29.4030401@web.de>
 <7vipskb0br.fsf@alter.siamese.dyndns.org> <4DED30E0.6090608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>,
	Phil Hord <hordp@cisco.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 06 23:00:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTguT-0007Gb-EQ
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 23:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607Ab1FFVAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 17:00:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab1FFVAX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 17:00:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CB9B45473;
	Mon,  6 Jun 2011 17:02:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9CXZrw2FiCvBEtNvqyLNwhXgNIs=; b=UGfNBA
	bgmNuSN5WtS4GNDIkdMWcKh68ABW16ki04/QYmuz5lE9z12XkdfPTgWlNaxDgxzm
	igSonVVRBGQfsm/rdYKeR6BumzhrRWQn0kfQ6JlddsirMGYwKMXRTaEh/d7IJUD5
	PzrI1fZigy6FfJev3qcnIiLrYReL8J84i7cpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nKHB6QkupAhbWtpA2K8k81emqBOALQFN
	1Cicjnh0upcKm6dCPTTQMCXS4UEMg99cEJRlhefOc7bViF1jQeFkG5HYfcQiQbfn
	kTgKHEe5WfWboISi0cEIsf3mZfOHr8of+XXIc3kxd3DRxZIr22XeBHcUD3cs++Q3
	mNXUugnfY98=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 77DD15470;
	Mon,  6 Jun 2011 17:02:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C9FD8546C; Mon,  6 Jun 2011
 17:02:20 -0400 (EDT)
In-Reply-To: <4DED30E0.6090608@web.de> (Jens Lehmann's message of "Mon, 06
 Jun 2011 21:56:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48E13148-9080-11E0-972E-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175168>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 05.06.2011 20:27, schrieb Junio C Hamano:
>> If you think about "absense of the remote in the superproject means the
>> project originates from here", what you are doing in step 3. is to
>> changing the origin of these set of projects. After changing the origin of
>> these set of projects, isn't "git submodule sync" an established way to
>> adjust to the change? I was hoping that that would update .git/config in
>> step 3. so you wouldn't have the problem in step 4. at all.
>
> Thanks for explaining that in detail, I think I do get it now.

I actually still have a feeling that I may be missing something from the
discussion.  While I do like a solution that lifts existing limitation to
allow workflows that were hitherto impossible, that only makes sense when
the newly allowed workflow makes sense and useful, and when the lifted
limitation was not protecting some silly mistakes from getting made.

I _think_ our last exchange gave me a fuzzy confirmation that we are not
lifting a useful limitation, but I still do not know if the new workflow
matches the workflow Marc (who kicked off this thread) wanted to use. I
think it does match the set-up Phil Hord mentioned in an earlier message,
though.
