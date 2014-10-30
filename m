From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] receive-pack.c: use a single transaction when atomic-push is negotiated
Date: Thu, 30 Oct 2014 13:05:28 -0700
Message-ID: <xmqqegtpuxvb.fsf@gitster.dls.corp.google.com>
References: <1413924400-15418-1-git-send-email-sahlberg@google.com>
	<1413924400-15418-4-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 21:05:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjvyS-0000sW-Gb
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 21:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934146AbaJ3UFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 16:05:33 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932072AbaJ3UFc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 16:05:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A0EE4197CF;
	Thu, 30 Oct 2014 16:05:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zlXZDarDa57bUv1cTL49b9cHie4=; b=FGSR85
	WdRM9jsRtICap47girQqVzz2HYV+ypFR0kW2AjfZOf4cGPSopk+xyiVhmHSeZIAu
	pFFvo8pWRB/K3m14/0VS4ngEGX1lAFpUUx7iUMybB91oqD15YLBe30A8+WKJ2wcG
	4tmN+yB9Q7iPvAIGU+4S15GjONNFaYq2zZPaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HbPBWcQmwwlDQSsI2idbOzMwZOntQ4P1
	8UgBEtijBq8Jz/KvOG92HlSre+RQ12qLHLFngoX1KSkQ6piHTYvm/QY9ZrX1Hfaw
	oqCuKoxgxyGweFT9UCk9ODXl6+rSYj43P5VdLX0JGldosuy3VY2J63j816Vh7GwY
	R+k7L6Ui1F4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 97018197CE;
	Thu, 30 Oct 2014 16:05:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CBFBF197CA;
	Thu, 30 Oct 2014 16:05:29 -0400 (EDT)
In-Reply-To: <1413924400-15418-4-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 21 Oct 2014 13:46:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 18E8C33E-6070-11E4-B010-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> Update receive-pack to use an atomic transaction iff the client negotiated
> that it wanted atomic-push.
> This leaves the default behavior to be the old non-atomic one ref at a
> time update. This is to cause as little disruption as possible to existing
> clients. It is unknown if there are client scripts that depend on the old
> non-atomic behavior so we make it opt-in for now.
>
> Later patch in this series also adds a configuration variable where you can
> override the atomic push behavior on the receiving repo and force it
> to use atomic updates always.

Nice.
