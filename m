From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] implemented strbuf_write_or_die()
Date: Mon, 03 Mar 2014 10:27:14 -0800
Message-ID: <xmqqzjl7qgsd.fsf@gitster.dls.corp.google.com>
References: <1393672871-28281-1-git-send-email-faiz.off93@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Faiz Kothari <faiz.off93@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:27:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKXaD-0000F1-TV
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 19:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbaCCS1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 13:27:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52772 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385AbaCCS1R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 13:27:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECF9A6F016;
	Mon,  3 Mar 2014 13:27:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nP2GKaytU8zSu9lZxvFgPt9Y2KU=; b=FY+vTp
	jg2achjTsNmJ7nK5Uer/40EnxbAPTwY+EhP2lEkgO4bYraFYJgGK2QA0OXDb62qi
	Vs+BDfeiIvvRFUz0GrIh+adP/DNvPl13HCqyZXqCh+ovW33JDwcYCzUFLfkFz+R8
	m8/5uqeiPrZ0+vrG1s2u48vEiyWnFcN9FLRjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SeU57MDmaheHGVwAlrGEoGeXpIZvlUly
	q6AdpnbaIBzP1FK/t9xblfdfIefmDnAsqbGhpFIyFXBPq7OLHKfGWc2kftNZlvKJ
	rzE176D1AtPftJDcemzc6SrW8li7Sdc2Aagdwwpty1X3hrmasnAqy6/avjrPx7da
	6nX6wpEMWJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D62C56F015;
	Mon,  3 Mar 2014 13:27:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2949F6F013;
	Mon,  3 Mar 2014 13:27:16 -0500 (EST)
In-Reply-To: <1393672871-28281-1-git-send-email-faiz.off93@gmail.com> (Faiz
	Kothari's message of "Sat, 1 Mar 2014 16:51:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7274D0E6-A301-11E3-99BF-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243246>

Faiz Kothari <faiz.off93@gmail.com> writes:

> Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
> ---
> Implemented write_or_die.c:strbuf_write_or_die() and used in relevant places
> to substitute write_or_die(). I spotted other places where strbuf can be used
> in place of buf[MAX_PATH] but that would require a change in prototype of a 
> lot of functions and functions calling them and so on....
> I'll look for more places where strbuf can be used safely.
>
> Thanks.
>
>  builtin/cat-file.c     |    2 +-
>  builtin/notes.c        |    4 ++--
>  builtin/receive-pack.c |    2 +-
>  builtin/send-pack.c    |    2 +-
>  builtin/stripspace.c   |    2 +-
>  builtin/tag.c          |    2 +-
>  bundle.c               |    2 +-
>  cache.h                |    1 +
>  credential-store.c     |    2 +-
>  fetch-pack.c           |    2 +-
>  http-backend.c         |    2 +-
>  remote-curl.c          |    8 +++++---
>  write_or_die.c         |    9 +++++++++
>  13 files changed, 26 insertions(+), 14 deletions(-)

It does not reduce the code, it does not make the resulting code
read any easier.

What is the benefit of this change?
