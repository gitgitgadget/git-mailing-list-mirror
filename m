From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 3/2] Refactor Git::config_*
Date: Mon, 17 Oct 2011 16:25:08 -0700
Message-ID: <7vaa8zjj57.fsf@alter.siamese.dyndns.org>
References: <vpqty7wk9km.fsf@bauges.imag.fr>
 <201110072317.17436.jnareb@gmail.com>
 <7vsjmrl4ur.fsf@alter.siamese.dyndns.org>
 <201110172347.42568.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@googlemail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Cord Seele <cowose@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 01:25:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFwYY-0008UN-P4
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 01:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756730Ab1JQXZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 19:25:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43098 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756611Ab1JQXZK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 19:25:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 851525431;
	Mon, 17 Oct 2011 19:25:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9+dvNDgMwFCUkgqy4e32XYDYpqM=; b=XHsZMu
	I6grFZ0B2wutYrSJ9EwfOmLJHQt9lwRaDhvJQ9MzO5O4N5VpITSxjzGF6wM9rUEE
	4d8KC9AOoYcQsb7OuOlSE1qx0ZKh2rwwlyUXsXgm6wGfFvrMs3n43mOD4KtJL9uu
	OPwd8J1S29SZMm44HGS/KjM5Wh/0IaexypMh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qftkm36xSQJSB0T/uiJXlZHpliTK9qya
	JPOwcequKxuydsTeMrK/Eqshhnq7Tq77dsywlnNhmCIRWNZvTjj+zn6mh4UnJAye
	VDL7W21Pp3QM79OY7qUf8rxYlnh/SJsFyeGyyJsI+MVNs7Ib596EpCO1tu9dJ7rf
	BJGHkVAEJlA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C2795430;
	Mon, 17 Oct 2011 19:25:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD4B4542F; Mon, 17 Oct 2011
 19:25:09 -0400 (EDT)
In-Reply-To: <201110172347.42568.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon, 17 Oct 2011 23:47:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 416FC884-F917-11E0-A04F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183843>

Jakub Narebski <jnareb@gmail.com> writes:

> The problem was with duplicated _maybe_self(@_), which should be run only
> once.  t9700-perl-git.sh passed because it uses only (recommended) object
> form, and not procedural form like git-svn.

Thanks.

I have a suspicion that a more standard implementation of _maybe_self()
would instead unshift a dummy singleton Git() instance instead of undef to
lift such a limitation, but perhaps the code relies on undef'ness of self
when called as a vanilla subroutine.
