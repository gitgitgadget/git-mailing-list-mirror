From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Add an update=none option for 'loose' submodules
Date: Tue, 23 Aug 2011 14:46:39 -0700
Message-ID: <7vpqjvrebk.fsf@alter.siamese.dyndns.org>
References: <cover.1312923673.git.hvoigt@hvoigt.net>
 <7v8vqzreeo.fsf@alter.siamese.dyndns.org>
 <20110811195955.GA21185@book.hvoigt.net>
 <7vy5yujtr2.fsf@alter.siamese.dyndns.org> <20110822200052.GC11745@sandbox-rc>
 <7v62lpuky8.fsf@alter.siamese.dyndns.org>
 <20110823194350.GA57187@book.hvoigt.net> <4E540B03.2030909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Aug 23 23:46:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvyo5-0003mp-4n
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 23:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853Ab1HWVqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 17:46:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54799 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754637Ab1HWVqn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 17:46:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39C8F4A22;
	Tue, 23 Aug 2011 17:46:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wzCuMpZauZmfi7i0zZqOj4j7fx8=; b=Td4JTx
	R3X1CXkiIWOFzr9LcTNfcB2n8HXSW9RzVpSfnQE6LD6MbdKOYZJEMeXz9b86LaN6
	9M6ca+27U8DnjfoB6YyCWsgsG535znA8a7z+nKBqVzq/r8T0JhGboM1Ah1oJW8ot
	tc4+CzYBVhWmdPVb4k5YQlijkm83wJZQRN+Xw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aY2Af0Pq527nE5scQm0SVY6pjmx0PvGd
	CPyBYUXZpybK0gDn7nJrNI26hx5Ake+CJPYWG/5LuzXPRcwuHEmS12YVeK+ZN6g/
	eq0vcheYkvf5W7DEaxPy2JKs5eZPRjpPN3N4meOLTJSEIhUX6Kk2Qd2HgUv0Ucds
	yYM3HOqYSIw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31AEC4A21;
	Tue, 23 Aug 2011 17:46:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A68034A20; Tue, 23 Aug 2011
 17:46:41 -0400 (EDT)
In-Reply-To: <4E540B03.2030909@web.de> (Jens Lehmann's message of "Tue, 23
 Aug 2011 22:18:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 632DF48A-CDD1-11E0-8CBA-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179973>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> It might surprise people. E.g. when their old scripts don't work anymore as
> they did before because a submodule won't be populated or updated in the work
> tree even though it is present in .git/config. So I agree that this should be
> documented in the release notes so people can check if their expectations are
> still met.

Worse yet, their custom old scripts that they use to update submodules in
their repository, if properly written, assume that anything registered in
the .git/config file as [submodule "foo"] _must_ be populated, but they
can no longer assume that and now has to look at submodule.foo.update and
if it notices the variable is set to "none" leave the submodule repository
alone. Having "submodule.foo" registered in the .git/config file alone
used to mean the user is interested in "foo" submodule and wants to have a
checkout for it, now it does not necessarily mean that.

That is definitely a huge semantics change.
