From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: inform pre-commit if --amend is used
Date: Mon, 24 Nov 2014 20:58:37 -0800
Message-ID: <xmqqtx1nub9e.fsf@gitster.dls.corp.google.com>
References: <1416828111-4567-1-git-send-email-oystwa@gmail.com>
	<20141125034424.GA19161@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 25 05:58:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt8D8-0000p9-1v
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 05:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbaKYE6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 23:58:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751304AbaKYE6j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 23:58:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 083FD1FC6E;
	Mon, 24 Nov 2014 23:58:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LzHkfgq4LNjVJS4LcZKPRgLYITc=; b=UbWBKf
	GLXwj1ymn4CKDOtrIPRmOzsDa/GfAg/7pEhKKxKNiCWVG+vCxzv/5Z/A4+XAtGJV
	lgRSYni7LULIssim8JtgF/IMwg6Q6+C+FShPVPNQV2ZJzCY5NvJrR+i3uYyyr3en
	45gbY4x3aSBuxbtk+gjnhzhIznfqWS9ON25l0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vh4FoEcL3IIxj1e4bAVEn53hti2JuuvM
	pFNRdHDJlJfrlZHdFfgiDkXe0qiLzmteaSTsD8W13I+Uf6MRhfUwP+OFlwZJutAV
	BRsxwBzTX0VjJfH+xsmlse4eMvms2BWdSUy6NGZ4Cncmve7a3HfOXOCZ7wozuNAy
	TZ8UizLzlkI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F25B41FC6D;
	Mon, 24 Nov 2014 23:58:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7DF781FC6C;
	Mon, 24 Nov 2014 23:58:38 -0500 (EST)
In-Reply-To: <20141125034424.GA19161@peff.net> (Jeff King's message of "Mon,
	24 Nov 2014 22:44:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B7FA014C-745F-11E4-8FE2-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260192>

Jeff King <peff@peff.net> writes:

>   1. It is a bit more obvious when debugging or dumping arguments (e.g.,
>      via GIT_TRACE), especially if new options are added after the
>      first.
>
>   2. It makes it easier for a script to work on old and new versions of
>      git. It sees either "amend" or "noamend" for the two obvious cases,
>      and if it sees no argument, then it knows that it does not know
>      either way (it is running on an old version of git).
>
>      Technically one can tell the difference in shell between an empty
>      string and a missing argument, but it is sufficiently subtle that I
>      think "noamend" is a better route.

If we ever add more info, would we want to keep piling on new
arguments, though?  Wouldn't it a viable option to use "amend" vs
not giving anything (not even an empty string), so that normal case
there won't be no parameter?
