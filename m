From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-merge: implement --ff-only-merge option.
Date: Tue, 07 Oct 2014 14:38:03 -0700
Message-ID: <xmqqwq8bd0hw.fsf@gitster.dls.corp.google.com>
References: <1412699710-3480-1-git-send-email-sorganov@gmail.com>
	<xmqqzjd7enet.fsf@gitster.dls.corp.google.com>
	<87fvezsk5k.fsf@osv.gnss.ru>
	<xmqqegujeibx.fsf@gitster.dls.corp.google.com>
	<87a957obm6.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 23:38:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbcSS-0006xA-1W
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 23:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbaJGViH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 17:38:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54526 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752691AbaJGViF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 17:38:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 459A514C3E;
	Tue,  7 Oct 2014 17:38:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=89oYQN6y2+B1XondbC+uopNCFjY=; b=SmUbb6
	Lbbtdaztbg1+mpL0juignqpIYBmx7ujU39WR5ZOmoKdJZ9q4ogFXcK8O+Hk1SA3g
	3t2uSStmPrNQ3RDQWJTkTLWpiPuahDG1/260iIQMqsApYiSpbUvqgE9mpvV8Whq2
	ry7+1NQ3D6HaBytW4r+Y02Ze+SK7x8IOsYdgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AUFPAuEKfrTjLTsnJWcVcE30VLzbYzb8
	cf9SLjX5uXMqvFSeyG2CAh+5C1xeapxJty1uKQJIuF4xOqYebm+5ybaVC/LtDHod
	4vvQbkaxSlw/MqiQHKwmcFrZhMmbLb0a8u7d9T3YP3fySvUtndHA1YerZAjEySYH
	+TiSn1x9LG8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 371E214C3D;
	Tue,  7 Oct 2014 17:38:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4ECD14C3C;
	Tue,  7 Oct 2014 17:38:04 -0400 (EDT)
In-Reply-To: <87a957obm6.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
	08 Oct 2014 00:42:25 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3863D9AA-4E6A-11E4-8C91-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> Because rebasing immediately before is considered a bad manner,
>> i.e. encouraging a wrong workflow?
>
> Why? What is wrong about it?

Searching the kernel archive for messages that talks about "rebase"
and "pull-request" from Linus would tell us why it is frowned upon
in a prominent early adopter project of Git.

You destroy what you have been testing and replace it with an
untested one.  If you merge, and if the result of the merge is
broken, at least you would have something that used to work at its
second parent (i.e. the tip of your topic).

> Please also notice that I don't try to impose this on anybody who does
> consider it wrong workflow.

I know ;-).  I didn't say anything about "imposing", did I?

Having an option to make it easy to do something undesirable gives
people an excuse to say "See Git has this option to let me do that
easily, it is an officially sanctioned and encouraged workflow".
