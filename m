From: Junio C Hamano <gitster@pobox.com>
Subject: Re: possible bug of git stash deleting uncommitted files in corner case
Date: Fri, 22 Apr 2016 10:37:19 -0700
Message-ID: <xmqqmvolpmsw.fsf@gitster.mtv.corp.google.com>
References: <CAND5yRvCK9YuVOJ91CHbnbWAVYcPrpihGkoKs28f7PJgzRwW6Q@mail.gmail.com>
	<CAND5yRvU1-AgvQW106fHbNN-GRQ615HjTDjR6AY9gkpoquBgDw@mail.gmail.com>
	<1304154573.4013923.1461328186541.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Daniele Segato <daniele.segato@gmail.com>, git@vger.kernel.org
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 22 19:37:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atf1F-0006Gf-Nh
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 19:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbcDVRh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 13:37:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932091AbcDVRhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 13:37:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2E1E1577B;
	Fri, 22 Apr 2016 13:37:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iQhqUakvk92MreUMMHzYDEpqNlg=; b=EigzFY
	tCI5OYNoSj/gUh8r63n7NqICnJylnEp8JytiJGN3hPsfyfVjrP8aTkD8j3TmIy1c
	og04J9ibI0I6RHMe0dWHUcallEDk74dGw6nId0kDtIvJIU1bgzDR8BVF/9/noF5h
	yiGUpHkz9AT8anQBkb4Y/20qTJdPWR2ERFrN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DhUQ2f05eCgtsBHVjh4VciJnD9LaFNfm
	AOqgFHjUM/WgmglmW8vKx4DqrAiabfu8HlzrRnUtFy9OwjHRcvMcUiXPj+F9bBZP
	hKs9y8mlfuwSVMHWH/wc1804PkSAIVRLITK5912wHmCz5HUa5n4DY0WAhrVy7sai
	Uux6iFq/MHo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA2F51577A;
	Fri, 22 Apr 2016 13:37:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D698915779;
	Fri, 22 Apr 2016 13:37:20 -0400 (EDT)
In-Reply-To: <1304154573.4013923.1461328186541.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Fri, 22 Apr 2016 14:29:46 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DDBF70BA-08B0-11E6-86F9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292236>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
writes:

> Daniele Segato <daniele.segato@gmail.com> wrote:
> ...
>> git version 1.9.1
>
> Contrary to what I expected, this seems to still be the case with:
>   $ git --version
>   git version 2.8.0.rc2

I do not think "git stash" has been updated in any major way to
address correctness (including its corner case behaviour) ever since
it was originally written, so it is very likely that any bug you see
would be with it since the very old days.
