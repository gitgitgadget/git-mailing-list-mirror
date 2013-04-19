From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3400 (rebase): add failing test for a peculiar rev spec
Date: Fri, 19 Apr 2013 10:53:37 -0700
Message-ID: <7vy5ce1k66.fsf@alter.siamese.dyndns.org>
References: <1366275155-26244-1-git-send-email-artagnon@gmail.com>
	<7vmwsv94jo.fsf@alter.siamese.dyndns.org>
	<CALkWK0=RDCCSxOJ2TU4=tniSRTg9VJohJ8Pf6uN9E=fd3jg=_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 19:53:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTFVJ-0004Hr-7d
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 19:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590Ab3DSRxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 13:53:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59165 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439Ab3DSRxk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 13:53:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E173D1777F;
	Fri, 19 Apr 2013 17:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YkA1BmyRfdKU3a9GL6hLCrHc6t8=; b=YJYTXF
	6hIF5OFxYnNFrYc34NDw4euOfj5sc3CA4voPedYUYnFo0CL3/oovlXcOTdPLt3nL
	OrWGRc31+l46tZP6jF3Qs5XFTgU8QGP/VicHluJnrZPQwyT4jL5TSkUNgZE0oHMM
	dFpgQkQ4bYiYPinZac9hq8v1HpSoFxTrFtWq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B1DGNnRWZ86XeQuOSzcqQ0ycayG1SyPE
	M1EhGfERHOWpGzk/XtzBqtcbvRTtRvhEyb8Xo9hdqfdYTqIWy/r2rmop9FM3hjmm
	P1YtB7DWBlAEGKvSahJt6GcRKxvYW66xMvJn80r2cp6eSJfwt2ruNfSHYDV331Vb
	0mOYcVjxr4c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D82AD1777E;
	Fri, 19 Apr 2013 17:53:39 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A45B1777C;
	Fri, 19 Apr 2013 17:53:39 +0000 (UTC)
In-Reply-To: <CALkWK0=RDCCSxOJ2TU4=tniSRTg9VJohJ8Pf6uN9E=fd3jg=_Q@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 19 Apr 2013 13:13:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10FCDDCC-A91A-11E2-9492-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221787>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>         peel_committish () {
>>                 case "$1" in
>>                 :/*)
>>                         peeltmp=$(git rev-parse --verify "$1") &&
>>                         git rev-parse --verify "$peeltmp^0"
>>                         ;;
>>                 *)
>>                         git rev-parse --verify "$1^0"
>>                         ;;
>>                 esac
>>         }
>
> Thanks.  Yeah, that's the obvious "hack solution": special handling
> for refspecs of the kind :/text.

By the way, that is not a "hack", but is merely "working within the
given constraints".  Welcome to the real life.

Unlike "rebase" that has the luxury of possibly update the
underlying plumbing, third-party tools have to work within the
constraints of existing versions of Git.  It is better to learn that
you sometimes need to do so, and how to do so when you need to.
