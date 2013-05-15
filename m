From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make color.ui default to 'auto'
Date: Wed, 15 May 2013 08:42:39 -0700
Message-ID: <7vy5bgckr4.fsf@alter.siamese.dyndns.org>
References: <vpq61yky2zp.fsf_-_@grenoble-inp.fr>
	<1368619757-10402-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed May 15 17:42:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucdqp-000891-M6
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 17:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758809Ab3EOPmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 11:42:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37879 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757225Ab3EOPmm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 11:42:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B89C81F960;
	Wed, 15 May 2013 15:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tMLHg6jo6rn8G712N8wAqx9HMG8=; b=PHnVAr
	YilDEOwPmXa0B0EtKu2WxCQOb/ydXoDrnGf9ySmN2qTgxG/uH0xTxAvRhdRIr/Tv
	G4dFoRrYSMEwLL5SOz1NkLCl/LsP6z+iV0t8WGrwqD2S1IQ8wMwhThjDVb810a3Y
	06A4qp05f0v15Qa2+Odtl9DNUFiXSeRKre99U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TCz8z6QX5JpttVwsZu9kbPLV2ycUS8b6
	ALHD5o4kIyknzaqYG17DFenXAvbBXVChJ2+uOJcvsDSfJ/9b6iBulvPbO9fSLkyP
	uZxEUgGZokXh5lAPqcqzuBzqyaYIJwNgVJZT6HvQoSu88aDnWMF0DXAR86ysN0Ef
	0NzG5aKlUOY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADB411F95F;
	Wed, 15 May 2013 15:42:41 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0E7A1F958;
	Wed, 15 May 2013 15:42:40 +0000 (UTC)
In-Reply-To: <1368619757-10402-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Wed, 15 May 2013 14:09:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13BA286A-BD76-11E2-BCD1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224418>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Many tutorials tell the users to set color.ui=auto as a very first step.
> These tutorials would benefit from skiping this step and starting the
> real Git manipualtions earlier. Other beginners do not know about
> color.ui=auto, and may not discover it by themselves, hence live with
> black&white outputs while they may have prefered colors.
>
> A few people (e.g. color-blind) prefer having no colors, but they can
> easily set color.ui=never for this (and googling "disable colors in git"
> already tells them how to do so).

The above two paragraphs do not make a good justification [*1*].
The former can just as easily websearch for "enable colours in git"
as the latter would for "disable" in order to avoid having to live
with distraction while they may have preferred monochrome.

The train of thought that is a sufficient justification for this
change is "Our document and third-party tutorials often start with
setting color.ui=auto configuration." leading to "Our recommendation
is to enable colour on terminals." which in turn leading to "Why is
our default monochrome, against our own recommendation?".  Saying
anything more, like who are the majority or how easily the default
can be overridden, is unnecessary, I think [*2*].

As this is purely a UI thing, and since daa0c3d97176 (color: delay
auto-color decision until point of use, 2011-08-17), the logic to
decide when "auto colouring" is triggered is centrary controlled
(hence it is much less likely than before that color.ui=auto could
misfire when it shouldn't), I agree that this does not even deserve
a warning. You could even sell it as a pure bugfix ("we recommend
users to use auto colouring but we did not set it up for users").

> The default value is changed, and the documentation is reworded to
> mention "color.ui=false" first, since the primary use of color.ui after
> this change is to disable colors, not to enable it.

Good.

> I'm starting to wonder why we didn't do this earlier ;-).
>
>  Documentation/config.txt | 11 ++++++-----
>  color.c                  |  2 +-
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1009bfc..97550be 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -913,11 +913,12 @@ color.ui::
>  	as `color.diff` and `color.grep` that control the use of color
>  	per command family. Its scope will expand as more commands learn
>  	configuration to set a default for the `--color` option.  Set it
> +	to `false` or `never` if you prefer Git commands not to use
> +	color unless enabled explicitly with some other configuration
> +	or the `--color` option. Set it to `always` if you want all
> +	output not intended for machine consumption to use color, to
> +	`true` or `auto` (this is the default since Git 2.0) if you
> +	want such output to use color when written to the terminal.

OK, so this is planned for 2.0?


[Footnote]

*1* Unless you have some statistical fact to demonstrate that
beginners who prefer colours are of lessor intelligence than
those who do not, that is.

*2* It unnecessarily muddies the water to bring up "which is
majority?".  A poll might reveal more people prefer monochrome, but
in that case, either we keep the default monochrome *and* fix the
tutorial not to suggest auto, or we stick to the recommendation to
use auto colouring.  In other words, I see this change as merely
making the code in line with the spirit of the documentation.
