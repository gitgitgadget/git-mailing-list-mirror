From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Support Out-Of-Tree Valgrind Tests
Date: Tue, 06 Mar 2012 15:12:02 -0800
Message-ID: <7v399lqq7x.fsf@alter.siamese.dyndns.org>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
 <1330903437-31386-2-git-send-email-greened@obbligato.org>
 <87aa3vzdoc.fsf@thomas.inf.ethz.ch> <nngy5re29zn.fsf@transit.us.cray.com>
 <878vje86cy.fsf@thomas.inf.ethz.ch> <87mx7tiyhh.fsf@smith.obbligato.org>
 <7vaa3ttvj1.fsf@alter.siamese.dyndns.org>
 <87hay1fkfk.fsf@smith.obbligato.org>
 <7vboo9qskb.fsf@alter.siamese.dyndns.org>
 <7v7gyxqrty.fsf@alter.siamese.dyndns.org>
 <87mx7te3ng.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>
To: "David A. Greene" <dag@cray.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:12:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S53YD-0002lV-0c
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 00:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031564Ab2CFXMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 18:12:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51129 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031544Ab2CFXMF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 18:12:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A5946675;
	Tue,  6 Mar 2012 18:12:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oDXpSPaSaVDCiMUJLMLEX+8vW3E=; b=GqzOaX
	daGqWAUK/pBFMvnVO54AY7q/NSuGKUT01cxbewbc50KIsMFSwbtiC630h5ivxVsy
	UjidBwMBOkPW79Tc5gymVqR8uZPO+t4PE9wsJ86Sj3HGVVFakwEaZ7Mo2jf0Awvm
	uCi+feTgXmo0g4ourZHHpil4jhcsSE98iCrks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rPGtGm5MmD1u6xXCX5UlcwuSydFoJ857
	YcqMTQVyeTMSrKgNPmi7k06+9YwRULHKcEZoPgn6tpahXDhnf/h+S+2fL8dux2PT
	y2M+2EYMI9EVc2EJPRkj8ZxJJUhrHxtvIexOmOxIFdgb9jS27N82c0fJt/5ogrXS
	7hea0DMu4D0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72D386674;
	Tue,  6 Mar 2012 18:12:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0691F6673; Tue,  6 Mar 2012
 18:12:03 -0500 (EST)
In-Reply-To: <87mx7te3ng.fsf@smith.obbligato.org> (David A. Greene's message
 of "Tue, 6 Mar 2012 17:00:19 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C94CC142-67E1-11E1-8E0C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192414>

"David A. Greene" <dag@cray.com> writes:

> Ok, I see.  So TEST_DIRECTORY is supposed to point to the "official"
> location of git's tests and testing support files.  That wasn't clear to
> me.

That is how I read the intent of what test-lib.sh does. I do not
think it has much to do with official-ness, but more about where you
find pieces of the framework from (e.g. diff-lib.sh, lib-gpg.sh,
etc.)

> I think naming is a big issue here.  Perhaps TEST_DIRECTORY needs a
> better name, something like GIT_TEST_SUPPORT or such?

I do not think so; the biggest problem I see is that nobody
documented these variables like Thomas did in the previous message
we saw in this thread (and Thomas knew more about them than all
because he added t/perf/ recently and had to play with these
variables).

Once the roles of variables are well understood, I do not think it
is worth renaming the existing uses.
