From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git stash pop` UX Problem
Date: Wed, 26 Feb 2014 14:17:10 -0800
Message-ID: <xmqq4n3l34ex.fsf@gitster.dls.corp.google.com>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<530C953F.9050805@booking.com> <vpqlhwz5o58.fsf@anie.imag.fr>
	<530CA4C9.60601@booking.com> <vpqeh2r43kx.fsf@anie.imag.fr>
	<530D97BA.1080107@booking.com> <vpqzjlez3c4.fsf@anie.imag.fr>
	<xmqqd2i94qfq.fsf@gitster.dls.corp.google.com>
	<vpqy50xd5cr.fsf@anie.imag.fr> <87ha7l62d6.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Omar Othman <omar.othman@booking.com>,
	Brandon McCaig <bamccaig@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 26 23:17:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WImn9-0005dT-7l
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 23:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbaBZWRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 17:17:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752816AbaBZWRR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 17:17:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DFB56DB18;
	Wed, 26 Feb 2014 17:17:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fsaF4T0dQNb1v19Jmv0HcEnNz5s=; b=hpUjdb
	C2ekdgQm2D2DLkE7vqwIuJ8E5G49riWMZc0PeoUnLSYKhwAmQ8g1HEc3TyCUiiU9
	xVs5DkQJLc6bKWLLIpw/Fqnu6MFe5TRRF/adQu8DeWDG81QA83tw1zNV/e+QOJ3j
	r6B79qy4pI2x4a3ynrNfoCTXCslYup3XYb5nM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pvzPKb5QGc0gWjSblm5M+b/qPkeKO0WJ
	7Tk8CX8IQwsVD/EICfORG0SCcBRqmjhf32+yEy1J1cwCsqZLubnfI32Vv1qtf71T
	lps3CZy0ND3VTiZSPwQUjjdRUcZqChJoKhrQ97ud6pSat9kLOt1Ab2lazV4xAtGF
	VGQCXMDWE6k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D01EC6DB15;
	Wed, 26 Feb 2014 17:17:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 553A56DB0E;
	Wed, 26 Feb 2014 17:17:13 -0500 (EST)
In-Reply-To: <87ha7l62d6.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Wed, 26 Feb 2014 21:33:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BE26ABC6-9F33-11E3-8A77-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242769>

David Kastrup <dak@gnu.org> writes:

> All that verbosity...
>
> $ git stash pop
> Auto-merging foo.txt
> CONFLICT (content): Merge conflict in foo.txt
> Cowardly refusing to drop stash.
> $

Actually, modulo "Cowardly", that may be the most harmless phrasing,
as apply_stash may try to signal an error for reasons not related to
an inability to apply the change cleanly (e.g. we may have failed to
refresh the index).

Whatever phrasing we may end up choosing, the change itself should
be trivial in any case.

 git-stash.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index f0a94ab..4798bcf 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -512,8 +512,14 @@ apply_stash () {
 pop_stash() {
 	assert_stash_ref "$@"
 
-	apply_stash "$@" &&
-	drop_stash "$@"
+	if apply_stash "$@"
+	then
+		drop_stash "$@"
+	else
+		status=$?
+		say "The stash is kept in case you need it again."
+		exit $status
+	fi
 }
 
 drop_stash () {
