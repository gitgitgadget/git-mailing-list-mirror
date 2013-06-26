From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 01/16] test: add test cases for relative_path
Date: Wed, 26 Jun 2013 10:44:31 -0700
Message-ID: <7vehbowyv4.fsf@alter.siamese.dyndns.org>
References: <cover.1372175282.git.worldhello.net@gmail.com>
	<cover.1372175282.git.worldhello.net@gmail.com>
	<569bd5216b6a8d63c9139c20390488b93f402086.1372175282.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 19:44:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urtly-0007AN-DT
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 19:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab3FZRof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 13:44:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47021 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823Ab3FZRod (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 13:44:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 669982BFE3;
	Wed, 26 Jun 2013 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=t1JAOdUOof1oZ0UMe+yU9CNYm/8=; b=CwOMQ8XcL4+PPIN2NSXc
	yFRuGB/3oOX0lomsyylJSUdrY9CK98ZptPG3oXwrLYU+bt2DAQcC+49R0Bk6OQOB
	fQu8cGcJDPMHU99y0lQ7pu6Qr+gt1MYx49bkU8pjfBSDEKTFcJCH3vxwUyIrjf+L
	Ew0nY6fuHxZmvQRgxeYvDCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=oY/glGtAKbxN11svhSjOYDVUL6rMQg8hMkRgaGVuYBzSfC
	zgA1nQOU638O3FUvS+ltTuTJQeERNdWsdxg9YsDVX8+fryW7doL/dbmu+qvoHywD
	H0v/+hiI5tPiRMmpP2J5P6Fp/VRU4I2UjamC5FQtXbi2Gr1AKxBz5AcNM0i34=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B0832BFE2;
	Wed, 26 Jun 2013 17:44:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B37FE2BFDF;
	Wed, 26 Jun 2013 17:44:32 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F423D30-DE88-11E2-AC1F-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229048>

Jiang Xin <worldhello.net@gmail.com> writes:

> Add subcommand "relative_path" in test-path-utils, and add test cases
> in t0060.
>
> Johannes tested this commit on Windows, and found that some relative_path

"this commit", or "an earlier version of this patch"?  I am guessing
it is the latter (if so, I can easily amend locally without a need
for rerolling).

> tests should be skipped on Windows. This is because the bash on Windows
> rewrites arguments of regular Windows programs, such as git and the
> test helpers, if the arguments look like absolute POSIX paths. As a
> consequence, the actual tests performed are not what the tests scripts
> expect.
>
> The tests that need *not* be skipped are those where the two paths passed
> to 'test-path-utils relative_path' have the same prefix and the result is
> expected to be a relative path. This is because the rewriting changes
> "/a/b" to "D:/Src/MSysGit/a/b", and when both inputs are extended the same
> way, this just cancels out in the relative path computation.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

I somehow lost track, but does the above list of sign-offs reflect
the origins of the changes contained in this patch, or is the second
one meant to be helped-by or something (if so, I can easily amend
locally without a need for rerolling)?

> +relative_path /		/a/b/		/	POSIX
> +relative_path /a/c	/a/b/		/a/c	POSIX
> +relative_path /a/c	/a/b		/a/c	POSIX

(mental note, not a complaint): These are notable, as some may
expect to see "..", "../.."  and "../c" for these cases, but the
rule is "ignore base and return it if it is absolute", so they are
understandable.

> +relative_path a		a/b		a	# TODO: should be: ..
> +relative_path x/y	a/b		x/y	# TODO: should be: ../../x/y
> +relative_path a/c	a/b		a/c	# TODO: should be: ../c

(mental note): OK.  Let's see how they evolve in later patches.

Thanks.
