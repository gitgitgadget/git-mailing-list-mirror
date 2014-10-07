From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-merge: implement --ff-only-merge option.
Date: Tue, 07 Oct 2014 13:27:30 -0700
Message-ID: <xmqqegujeibx.fsf@gitster.dls.corp.google.com>
References: <1412699710-3480-1-git-send-email-sorganov@gmail.com>
	<xmqqzjd7enet.fsf@gitster.dls.corp.google.com>
	<87fvezsk5k.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 22:27:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbbM9-0001nZ-Pk
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 22:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371AbaJGU1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 16:27:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64507 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753180AbaJGU1d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 16:27:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 51CB714ED0;
	Tue,  7 Oct 2014 16:27:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kkCyEV1dHGQd93J1udpkjtDMZOY=; b=BlilEU
	HhA6bmFLQSBH+0qLMvk4SBmmuclviztYk4pfwtOVJtLh+Ysisk4TjqnCahRGHViN
	8k1nOVeWjNwmCOXtki3sG5Dh9M1VXfSrkDgT7bc82iU/J9f8DwQsqawUx7kRbvy/
	mIcwSXMBk4+5hzKbi9OpgV8+I91Geera/PgxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eSdDiY4XBNM9Hil8TWbzBFvI3AVgaTdZ
	1H6U4Vn7PLSjZs60BkQshEcMBGukZ+LZoGo8nIhBY7Y5gJxlLcKU5TVPfH5fPIOP
	HjfCa4wfBD7R1x7N6Q1BwGbv8FRLsM6z85x/+QxIJKqvO95mOunZ0o+i+1cHKkbX
	qOmB2dK3dXQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 487DE14ECF;
	Tue,  7 Oct 2014 16:27:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7CC714ECD;
	Tue,  7 Oct 2014 16:27:31 -0400 (EDT)
In-Reply-To: <87fvezsk5k.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
	08 Oct 2014 00:24:23 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5D5491B4-4E60-11E4-BAE0-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257957>

Sergey Organov <sorganov@gmail.com> writes:

>> Why would it be useful to limit the history to a shape where all
>> merges are the ones that could have been fast-forwarded?
>
> Except by true merge, how else can I express with git that 'n'
> consequitive commits constitute single logical change (being originally
> some topic branch)?

You are justifying --no-ff, aren't you?

> Moreover, as topic branches are usually rebased before merge anyway,
> why shouldn't I have simple capability to enforce it?

Because rebasing immediately before is considered a bad manner,
i.e. encouraging a wrong workflow?
