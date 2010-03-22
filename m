From: Junio C Hamano <gitster@pobox.com>
Subject: Re: running "git init --shared" on an existing repo
Date: Mon, 22 Mar 2010 00:06:05 -0700
Message-ID: <7v8w9kq1ia.fsf@alter.siamese.dyndns.org>
References: <2e24e5b91003212330r2f3fd118y18386ef61c28ee89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 08:06:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntbib-0006iU-Sh
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 08:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab0CVHGS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 03:06:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab0CVHGP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 03:06:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 31235A4DF5;
	Mon, 22 Mar 2010 03:06:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hHcwScNwZmHX
	A8pJoJP75SgtBx0=; b=bqJhI7VsdbPQ9Hd/jd9n9JFyo6o+Kf1zhtHO11w79b0+
	ikVXuxwsgBYPM98bLPtu6NJOY/mcVh6+kgqt/D48uwx+B+IG6mVSP20FguLalhEt
	ZV7taNmOpfQrMgW1SqG9dv6vKreMAh28RpkfqZtNe7h9DdlLuyBZ4rWLIRw1p64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wyJ1bH
	WrUTH2G+lm8+/ijIX5nnLcxMDcOHGKOd0+NmP5oBY+qDZb4T0cCHQphB8sDuLK3K
	hosTrqZTzaruFSJ7d1xXK60oN6p9Rbm958bqUoNf8iRb4YieOmWLQ75Xb8Iw2LN3
	wbhO5RWdueb3LW29H1eyMpeIucTzvPDo9z6T0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E711A4DF4;
	Mon, 22 Mar 2010 03:06:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D092A4DF3; Mon, 22 Mar
 2010 03:06:07 -0400 (EDT)
In-Reply-To: <2e24e5b91003212330r2f3fd118y18386ef61c28ee89@mail.gmail.com>
 (Sitaram Chamarty's message of "Mon\, 22 Mar 2010 12\:00\:01 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 64A0B77E-3581-11DF-8CD9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142902>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> And it seems there was a beginning made.=C2=A0 builtin/init-db.c at l=
ine 220 says:
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * We would have created the above under user's umask -- under
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * shared-repository settings, we would need to fix them up.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */

That "the above" refers to "in this process that created the repository
directory and populated it halfway by calling copy_templates()", and ne=
ver
"some time ago by some other process that created the repository, in wh=
ich
this process is now being run", so it is not fair to say "a beginning".

You would need to run "find $GIT_DIR -print0 | xargs -0 chown/mod ..." =
or
a moral equivalent of it, I guess.  Shouldn't be a rocket surgery ;-)
