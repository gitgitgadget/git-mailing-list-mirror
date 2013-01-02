From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test failures with python versions when building git 1.8.1
Date: Tue, 01 Jan 2013 23:18:46 -0800
Message-ID: <7v1ue459yh.fsf@alter.siamese.dyndns.org>
References: <CAEik5nOqge8ix4WGf-h+0Dmz1CanH_XtQdB-CxvPsggSu1-LzQ@mail.gmail.com>
 <7va9ss5fhq.fsf@alter.siamese.dyndns.org>
 <20130102065345.GA8685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan McGee <dan@archlinux.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>,
	"Eric S. Raymond" <esr@thyrsus.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 02 08:19:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqIbU-0005Ha-97
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 08:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab3ABHSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 02:18:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943Ab3ABHSt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 02:18:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CBF29EDE;
	Wed,  2 Jan 2013 02:18:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HYVqv7Qw9cwCnqWQZd9YIjaJ5q0=; b=aFFg/Q
	lRcNRgYS/dazGO+rQzUSerLjIsSGa6Tt0N4/VubXpQHPb8v+NMxbDqSwRNj9BIoP
	ZDhNtwM0KGMbksx1zPirBXiXEtndCwc+lMLxpcPzEnSNXv/wJufdI/fH2S3Qbxal
	2MED7AQF/2jLz/gViGFPQOcTSftJy5Op1QVFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pyk7hbY+fdyFAoiTeWBpJrbgwmWJiGOM
	2u20AuKqE2nydXFLWbtgQEWB5Amv9see/K5srZxowvVYaJtZacQa5Y+naZfsMHBs
	OB0dNnJ8gknzd7JxwW8cq3xXkJ4ZEVjcErX0EIKE9AbSWXPMSbsAfdcBEwVyapiw
	ADMCvgwqWrI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EC049EDD;
	Wed,  2 Jan 2013 02:18:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1DC49EDC; Wed,  2 Jan 2013
 02:18:47 -0500 (EST)
In-Reply-To: <20130102065345.GA8685@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 2 Jan 2013 01:53:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A65C660C-54AC-11E2-BA1F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212496>

Jeff King <peff@peff.net> writes:

> [1] This symlink is doubly wrong, because any use of symbolic links
>     in the test scripts needs to depend on the SYMLINKS prereq, and this
>     does not.

Yeah, I think we have discussed this once already in

http://thread.gmane.org/gmane.comp.version-control.git/210688/focus=210714

> [2] In both the current code and what I showed above, the test scripts
>     depend on things in contrib/. This is probably a bad idea in
>     general, as the quality of what goes into contrib is not as closely
>     watched (especially with respect to things like portability).
>     Certainly I would not have known to look more carefully at a patch
>     to contrib/svn-fe for breakage to the test suite.

As long as such tests are made skippable with appropriate
prerequisites, I do not think it is bad to have their tests in t/; I
would say it is rather better than having them in contrib/ and leave
it not run by anybody, which happened to some of the stuff in
contrib/ already.

>     ... possibly with a feature to
>     make it easier to run tests out of contrib).

Yes, that certainly is a workable alternative.
