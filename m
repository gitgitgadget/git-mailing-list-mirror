From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] notes: don't leak memory in git_config_get_notes_strategy
Date: Wed, 30 Mar 2016 10:17:19 -0700
Message-ID: <xmqqmvpfubq8.fsf@gitster.mtv.corp.google.com>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
	<1459298333-21899-4-git-send-email-sbeller@google.com>
	<20160330011334.GC2237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:17:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJkH-0006bq-6L
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890AbcC3RRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:17:25 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932307AbcC3RRW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:17:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F0DF34FDB6;
	Wed, 30 Mar 2016 13:17:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hMelSGc3zLGTmoxjCo9A+nlG8SY=; b=XzhA0+
	e0DWI/WTTSlqmX8VGVlD6zh78xO7IA4QEKRyPeLYSsOLrPHFs+mMlNRzmDhgrByq
	0kjG5istx5XTz00UxQuAkP9Swp44gX+bCZgWgK8PnbS8wS9/BpHRMsGqREW3bbzU
	pgzZ1wzvH9JDbBBcnGUEjFvtjK8tpqvjj9VNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bQgPmA4UCoybG2dPxD7krf4f8/1F1xlX
	bpG5dlV/AcfhhyC+58egGrShBliq2tLx3hKWABowZIYe2f9fjGjikrliJ3MDPBz2
	adR+ZajhCE//O+KeD3EE2mRH5pBOs/3VnXEFHzdu6tukdm6hm0BItOt3sz0JoZ5/
	7ViELIy4yZY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E733E4FDB4;
	Wed, 30 Mar 2016 13:17:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 612004FDB3;
	Wed, 30 Mar 2016 13:17:20 -0400 (EDT)
In-Reply-To: <20160330011334.GC2237@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 29 Mar 2016 21:13:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 42B3B9AE-F69B-11E5-AAAF-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290321>

Jeff King <peff@peff.net> writes:

> I don't think this is wrong, but would it perhaps be simpler to call
> git_config_get_value() in the first place, which does not make a copy of
> the string?

Yup, I agree.
