From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/15] string_list: add string_list_duplicate
Date: Wed, 27 Apr 2016 16:17:14 -0700
Message-ID: <xmqqbn4u7ibp.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-2-git-send-email-sbeller@google.com>
	<xmqqh9eoc7zc.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbWMN3YG5Jtz8i8Y9A3id8bX-YxSWp19+yGAdzMX_wKKA@mail.gmail.com>
	<xmqqzise7o4l.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kagX5TJU_mbjpo4PKJDoc1wh24DhyS814Kkq76EU9aykA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 01:17:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avYhu-0008QL-Ac
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 01:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbcD0XRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 19:17:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751038AbcD0XRR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 19:17:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 839C91792D;
	Wed, 27 Apr 2016 19:17:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/RiZQF+nVzzNQkZt5Zi7iDCRsC4=; b=u3ebci
	TDQ4GOBKzWW8jFKMn1oPlIERiNbLHI1dqS8ZCcV5KrS/05i8D3C8//d/SPfH8/jB
	Qz07YZ6o6D+gKnDkTRjOt+rlpDjob0NvPo2MobnXxCMVps9nkz/y7XlhkvQJCeFx
	6sZQIuJJnG8EnpGINsfxQoxDSapJQyEetG3Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YzbZfRajU9MBfBV5FF/r06Zos0IDUcwl
	OS3g2k+SuPJi6IkKMfBuz3I4SyoRvNXqQ5Pqe4UmnXQMbKSiiMs6heAhB2zaBJI/
	Cbp+VSJk0Qz8PPBHVsNIbJotn4wMwCWEMlOTDyebAKLRGcSERFLqA+FxRwZtB6KV
	9JxQF8lDmSc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B42D1792C;
	Wed, 27 Apr 2016 19:17:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C59AC1792A;
	Wed, 27 Apr 2016 19:17:15 -0400 (EDT)
In-Reply-To: <CAGZ79kagX5TJU_mbjpo4PKJDoc1wh24DhyS814Kkq76EU9aykA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 27 Apr 2016 14:17:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E22D800-0CCE-11E6-9A12-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292840>

Stefan Beller <sbeller@google.com> writes:

> Another way to corrupt it is to change the configuration (e.g. add
> things to the config hashmap such that it reallocates and grows).

You're right.  But doesn't it hint that there is a deeper problem?

By making a copy and keeping it, you would hold onto a stale value
and would not see the result of updates you yourself make to the
system.
