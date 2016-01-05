From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/16] init: allow alternate backends to be set for new repos
Date: Tue, 05 Jan 2016 10:03:39 -0800
Message-ID: <xmqqk2nnkio4.fsf@gitster.mtv.corp.google.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	<1449102921-7707-14-git-send-email-dturner@twopensource.com>
	<567AA2DF.1020408@alum.mit.edu>
	<1452014787.3892.40.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 19:04:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGVxd-0001mq-01
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 19:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbcAESDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 13:03:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752380AbcAESDt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 13:03:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9416C372A2;
	Tue,  5 Jan 2016 13:03:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JIAWKM+xfWpgwNHp02qGXAUOLwg=; b=lGuPXx
	bgx+6y++Wv4FECyTDh6DKwdsPeMXXxSEKgUAVa2+L7lUksHJjn48TKEEtgVEo47A
	pYrUKcarNt+aum69x9a5BGRu+4Yrp7NLVVCySa892TDQu6mi4683LIpTx4PvssjW
	+q+9B3F9PG58JYK7kZB3Td/eHX1f2+7igudfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IJWi94qTt/vNJpD7iue1NQkkOU5+hwXP
	822lwSD5Xi0JnxYLi1eRkIpirlGBR6UKIdi++apkhEAEfMXHgx+KGM/iBnbA+BaS
	DSnjscCVhQl9P/6ZqX1+oR2iMy97//lfwgIYtEqDoui6v18BY87n6hb2JWXswH5g
	hBeoipiImRI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 81519372A1;
	Tue,  5 Jan 2016 13:03:41 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E36C73729E;
	Tue,  5 Jan 2016 13:03:40 -0500 (EST)
In-Reply-To: <1452014787.3892.40.camel@twopensource.com> (David Turner's
	message of "Tue, 05 Jan 2016 12:26:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A6EB57C2-B3D6-11E5-AEC7-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283391>

David Turner <dturner@twopensource.com> writes:

> I'm working on the rest now, but wanted to comment on this first.  I
> went ahead and made this change, but I'm not sure I like it.  In the
> git codebase, the concept will continue to be called "backend"; there
> are already-accepted patches using that terminology.  Having two
> separate names for the same thing seems confusing to me.

We have the option to update whatever "are already-accepted" [*1*].
That would allow us to uniformly call it "ref storage", if we wanted
to.

In any case, we shouldn't be using an unqualified "backend" (or
"storage" for that matter); we should always say "ref", i.e. either
"ref backend" or "ref storage", in the name.

Between "backend" and "storage", I am slightly in favor of the
latter, but I am not good at naming things so...


[Footnote]

*1* Output from

    $ git grep backend master --

seems to show me only 

    master:refs.c: * The backend-independent part of the reference module.

and all others are other kinds of backends, e.g. "merge backend",
"http-backend", etc. so that may not be too bad.
