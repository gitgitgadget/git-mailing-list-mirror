From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] git-sh-i18n--envsubst: our own envsubst(1) for
 eval_gettext()
Date: Sun, 08 May 2011 10:15:57 -0700
Message-ID: <7v1v09un8y.fsf@alter.siamese.dyndns.org>
References: <1304856659-10672-1-git-send-email-avarab@gmail.com>
 <1304856659-10672-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 19:16:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ7aY-0007V9-3z
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 19:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276Ab1EHRQJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 13:16:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35304 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753921Ab1EHRQH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2011 13:16:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 72EA44CD8;
	Sun,  8 May 2011 13:18:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vtA1ahatFWOp
	qbXF57J1NutGN9I=; b=ZbBocGpK1zSsC0ar40h+MM4Nf/CdiXiW0v+H1MjfyB9q
	uard5HYf0NRXUhaJZIh05qMc80mfqO0a/fIowkQoDhb+3sb5f1qbrJRqbpEpbXS8
	0lAtDD52hZl0v8xcb2SLu4+W4uL5F/u8OLGMN5NVLgoBpocHo8Oe/POAh/FGZNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nQTHGi
	Jrpj3/it2zfAOn07tuY/Jk1/drLZOT86Hs5OAW8B0SRDwTgtTBGeyFCDmYys9stO
	DhxE5UahXfsVjY/dWIKnSu7vYeLOVU8BtCf+JtjgWLx3j4CdVVEMFGamJ0WZB7I1
	xkZWTRsHNu/lOiJeHgeAz8oB6jWCtS6LgKR/8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B5B34CD4;
	Sun,  8 May 2011 13:18:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0473D4CD3; Sun,  8 May 2011
 13:18:03 -0400 (EDT)
In-Reply-To: <1304856659-10672-2-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 8 May
 2011 12:10:56 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 248BF3F0-7997-11E0-A489-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173164>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a git-sh-i18n--envsubst program which is a stripped-down version
> of the GNU envsubst(1) program that comes with GNU gettext for use in
> the eval_gettext() fallback

Ok up to this point.

> ... instead of using a clever (but broken)
> printf + eval + printf trick.
>
> In a previous incarnation of the gettext series I implemented the
> eval_gettext() fallback like this:
> ...
> This was clever, but ...
> ...=20
> To work around this, and to improve our variable expansion behavior
> (eval has security issues) I've imported a stripped-down version of
> gettext's envsubst(1) program.

I do not think the lengthy history of failed experiments above is worth
explaining. If you really want to say something to justify a new helper=
, I
think it is sufficient to just explain that it is unsolvable in shell. =
I
tried that in the first 9-line paragraph in:

  http://thread.gmane.org/gmane.comp.version-control.git/170703/focus=3D=
170770

In other words, "we tried X that didn't work and we tried Y that didn't
either, we cannot think of any better solution, so we are doing somethi=
ng
else" is not a good justificiation for doing that "something else".

"Anything based on shell is an unpractical solution for this and that
reasons, so we use this instead" explains that the earlier failures wer=
e
not because we did not try hard enough.  Unlike "tried X and Y but didn=
't
work", dismissing "anything based on shell" as a whole class with clear
explanation why it would not work would prevent people from pursuing th=
at
dead-end approach.  It also avoids giving quibbling people an excuse to
argue against importing envsubst implementation saying "you didn't try
hard enough".

> With it eval_gettext() is implemented
> like this:
> ...
> Reported-by: Johannes Sixt <j.sixt@viscovery.net>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>

Ok.

> diff --git a/Documentation/git-sh-i18n--envsubst.txt b/Documentation/=
git-sh-i18n--envsubst.txt
> new file mode 100644
> index 0000000..e146a2c
> --- /dev/null
> +++ b/Documentation/git-sh-i18n--envsubst.txt
> @@ -0,0 +1,36 @@
> ...
> +Author
> +------
> +Written by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> +
> +Documentation
> +--------------
> +Documentation by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason and the git-=
list
> +<git@vger.kernel.org>.

I do not think we do these individual credits these days in the doc.
