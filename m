From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/12] pretty: add %C(auto) for auto-coloring on the
 next placeholder
Date: Mon, 01 Apr 2013 11:26:48 -0700
Message-ID: <7vzjxihztj.fsf@alter.siamese.dyndns.org>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 20:27:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMjRw-0002zD-CD
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 20:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758099Ab3DAS0w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Apr 2013 14:26:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41417 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756501Ab3DAS0v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Apr 2013 14:26:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED427110AD;
	Mon,  1 Apr 2013 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EF0ebZ6bU2l8
	LEZt34CvScDxEgk=; b=eYoHZJBdjOWl2HAPYZx8x8otDxz2397VfHIB4dcA5hkW
	wEAnYndjbe1YJtcKPznwps0l6uGSxVN+F8l9C2q1ltI9i4+D/6XKXdPv/BKMJtJZ
	Kw3EPlXuKGeCKr6nyR2PI8Y4UEf6ACwk1kAVyWewqmpCyJopgUpwHaiwL49V72U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=s7bu4j
	j6vDOuSDRrsgmOVMWgxLppFDZVyJEXxWCQiikZfMbRVRa/GacbdNAg/H5HLikvpJ
	R3QrP5OVbfyaV7ERk/a4TTkbTurIlC6HUb+AELDiSopqS3qPnmRPcsC1wMXphRat
	8w+VEu0dfGrjzKR/qzj5AWli6yd+Q+qowSkiI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEE4E110AC;
	Mon,  1 Apr 2013 18:26:50 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DBDD110A5; Mon,  1 Apr
 2013 18:26:50 +0000 (UTC)
In-Reply-To: <1364636112-15065-10-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 30 Mar
 2013 16:35:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B83FDE92-9AF9-11E2-9709-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219698>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is not simply convenient over %C(auto,xxx). Some placeholders
> (actually only one, %d) do multi coloring and we can't emit a multipl=
e
> colors with %C(auto,xxx).
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/pretty-formats.txt |  3 ++-
>  pretty.c                         | 15 +++++++++++++--
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-=
formats.txt
> index 66345d1..8734224 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -154,7 +154,8 @@ The placeholders are:
>    adding `auto,` at the beginning will emit color only when colors a=
re
>    enabled for log output (by `color.diff`, `color.ui`, or `--color`,=
 and
>    respecting the `auto` settings of the former if we are going to a
> -  terminal)
> +  terminal). `auto` alone (i.e. `%C(auto)`) will turn on auto colori=
ng
> +  on the following placeholder.
>  - '%m': left, right or boundary mark
>  - '%n': newline
>  - '%%': a raw '%'

I like this at the conceptual level.

If you say "%C(auto)%C(red)Text%C(auto)%C(reset)", does it do the
right thing when the output is not capable of color?

I am a bit worried if the placement of the "grab c->auto_color to
decide if we paint for this round and reset it" is optimial and will
stay optimal as we enhance format_commit_one() later.  Is there a
reason why we do not do that at the beginning of the function,
before "these are independent of the commit" comment?

Side note.  Should the new field called "auto_color_next" or
something?
