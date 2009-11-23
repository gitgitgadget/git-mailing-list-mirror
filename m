From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log --format: document %w
Date: Sun, 22 Nov 2009 16:06:07 -0800
Message-ID: <7vtywmayvk.fsf@alter.siamese.dyndns.org>
References: <4B0963A3.4060804@lsrfire.ath.cx>
 <7vzl6eiiyx.fsf@alter.siamese.dyndns.org> <4B09CD5A.4070401@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Nov 23 01:06:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCMRn-0007zw-7d
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 01:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877AbZKWAGJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 19:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755855AbZKWAGJ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 19:06:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbZKWAGI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Nov 2009 19:06:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 935A1A0B2C;
	Sun, 22 Nov 2009 19:06:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=81OUizUtGWK7
	jVFeAJ2/9BuOwlc=; b=DeeR9ANSoXD59AVoRUg2Rqv9ed8AVgvG7irAQk7uuDc8
	5QZxh/+Eysnjw/gKDEoFxeG2LbPYAAStVHNwPb5B1352/o+802zrxQJg7FuOB5XN
	Wfv5oeRfrsuEqBhsKbsHh2T28OM8KHm1aaGndrAcu5FIl1uCppti+HKZ0qoK2fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PtGbdD
	0rrs1ckChcMRLanNYWrLBpfjlxhdP6vbAeQtT0Eu2ZA/aP2vGZVPWkRYcdY+aNA4
	K50sGQ1Qa6owbFYp8lYOQg2HYHLmh/EsNi5lt4OUEgIygMlsauefio3myLOwhlJT
	WeLoSQNtbuI/5qdbJ/JcHYQHgECMHjmpkotIs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 72735A0B2A;
	Sun, 22 Nov 2009 19:06:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8715FA0B29; Sun, 22 Nov 2009
 19:06:09 -0500 (EST)
In-Reply-To: <4B09CD5A.4070401@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon\, 23 Nov 2009 00\:46\:34 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0290085C-D7C4-11DE-A559-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133469>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> I think utf8_width() is too generic for that; we shouldn't teach it t=
erminal
> control details.

I agree that the function whose purpose is to compute display width sho=
uld
not be called utf8_width().

The outside caller of utf8_width() in diff.c uses it to truncate the
function name hint on the hunk header line at character boundary.  The
input shouldn't have color escapes _we_ add (it might contain such
sequences from the user data, though), so I agree that we shouldn't
contaminate this function with color escapes.

> strbuf_add_wrapped_text(); ignoring display mode escape codes in ther=
e can be
> justified with its purpose.

Surely, and thanks.  The patch looks good.
