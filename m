From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] for-each-ref: add option to omit newlines
Date: Fri, 14 Feb 2014 15:24:51 -0800
Message-ID: <xmqq1tz5gtvg.fsf@gitster.dls.corp.google.com>
References: <1392314429-15281-1-git-send-email-oystwa@gmail.com>
	<xmqq38jmlqo6.fsf@gitster.dls.corp.google.com>
	<loom.20140214T085928-630@post.gmane.org>
	<xmqq38jlk6a1.fsf@gitster.dls.corp.google.com>
	<loom.20140215T000328-538@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 15 00:25:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WES81-00023h-EF
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 00:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbaBNXY7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Feb 2014 18:24:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45305 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934AbaBNXY6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Feb 2014 18:24:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4A6F6DA50;
	Fri, 14 Feb 2014 18:24:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OFS/Q0vFbYzI
	ddmXDZQuyzDPMe8=; b=TfB8XTsNhiTuo/RD4tRfZA24zEJcWS439l/5x4lq9ViK
	5JH4ZKM1c2z93KpcOJtv4gCnzWL7iS6OZzF8UsShv639028bSeTUae8O6uvv1bVC
	Vel40oUu68JIeXVI1ANKk2XL5WgPyiGgZN1+SjrIJ+TwIRST9OxDvXw9AM2PcdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OsJxPt
	nGPAHXbHh2Uy/orXY8j8tSgydwP93Gs25TMrbA/XmKM1a1hIaaGtQXlapQbJ5kbe
	4Pj5p+vZ+9B3WnPkyhi294B1nJN2QftNqrBGSrihQKGvhZRyRQVZC904r3rnQTDA
	3k8JHNNjBFfeaaUVmmcFhNpgKV2n1N4BoIWfw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C17C6DA4F;
	Fri, 14 Feb 2014 18:24:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6B736DA4D;
	Fri, 14 Feb 2014 18:24:55 -0500 (EST)
In-Reply-To: <loom.20140215T000328-538@post.gmane.org> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
	message of "Fri, 14 Feb 2014 23:03:21 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 36B022C0-95CF-11E3-A1D2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242158>

=C3=98ystein Walle <oystwa@gmail.com> writes:

> Maybe it's all subjective... I'm okay with just leaving things as the=
y
> are.

Lack of "-z" in for-each-ref can be called an inconsistency that
already exists you may want to fix in any case.

As an extension to that, I would not be fundamentally against a new
option, e.g. "--terminiator=3D7", that causes us to use putchar(7)
instead of putchar('\n') or putchar('\0') to terminate each records.
At that point, "-z" becomes a synonym for "--terminator=3D0".

And "--terminator=3D''" might even be a natural extension to that
option to cause us not to call any putchar() there.

If we were to do that, we should do them for all commands that let
you use "-z", not just for-each-ref, for consistency reasons, I
would think.
