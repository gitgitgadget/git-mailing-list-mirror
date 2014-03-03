From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] rebase: accept -<number> as another way of saying HEAD~<number>
Date: Mon, 03 Mar 2014 13:44:05 -0800
Message-ID: <xmqqlhwrneje.fsf@gitster.dls.corp.google.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-3-git-send-email-pclouds@gmail.com>
	<CAPig+cSPKSsVG_yqaQfOCswaENKdUGrWt_YcQ3yZCpgG5jQ+JQ@mail.gmail.com>
	<CAPig+cSFWT6kwZUFFUE3=TcfHRUJnx54+fcZCzJwmOSJKFsYeA@mail.gmail.com>
	<vpqlhwsr3ww.fsf@anie.imag.fr> <53144881.6090702@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 03 22:44:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKaem-0001iP-PT
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 22:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873AbaCCVoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 16:44:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54838 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501AbaCCVoL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 16:44:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2F0F71763;
	Mon,  3 Mar 2014 16:44:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RZTe/PpwUAJibTQP81Js4lGVypM=; b=uec3Iy
	mG6AqaNexGy+frQJ8IKPacDqn6PWjZA816LOD0JjHaJnA87+eTK9Ek20znA0KaGE
	NWiBCVl6261j4lupP6gxDAXsqqo7mTqMJevleXs2Bx0tV0YSgu3Zq/stZus4fgFA
	DWvzQ6g7Zi+qIouE5H1+yCWRXKcVURbqKNQu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YjzeRO6b5yDBJKutVo6Ij7dKyOl5gTHc
	CiusdNY5X2w/ZjKApAKk1x8cqZRIEIaLdHNmn8vQFBXJ2diGJCKXtOkm42A7pbGR
	LiPIJeIYd1IAMBtoSwPCJSGNjgx6zmbX7ariJ+PHzVkOwC7aV3+0Iq+LLyv/nAYq
	Qkwkyz6uQBY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9837771762;
	Mon,  3 Mar 2014 16:44:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92A757175C;
	Mon,  3 Mar 2014 16:44:09 -0500 (EST)
In-Reply-To: <53144881.6090702@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 03 Mar 2014 10:16:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F3DD04D0-A31C-11E3-8E44-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243274>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This might be a reason that "-NUM" is a bad idea.
>
> Or perhaps "-NUM" should fail with an error message if any of the last
> NUM commits are merges.  In that restricted scenario (which probably
> accounts for 99% of rebases), "-NUM" is equivalent to "HEAD~NUM".

That sounds like one possible way out; the opposite would be to
enable mode that preserges merges when we see any.

If "rebase" had a "--first-parent" mode that simply replays only the
commits on the first parent chain, merging the same second and later
parents without looking at their history when dealing with merge
commits, and always used that mode unless "--flatten-history" was
given, the world might have been a better place.  We cannot go there
in a single step, but we could plan such a backward incompatible
migration if we wanted to.
