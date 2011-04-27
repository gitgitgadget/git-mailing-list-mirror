From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] inconsistent error messages for translation
Date: Wed, 27 Apr 2011 10:17:30 -0700
Message-ID: <7vr58n8vh1.fsf@alter.siamese.dyndns.org>
References: <20110427122250.GA10919@jakstys.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Motiejus =?utf-8?Q?Jak=C5=A1tys?= <desired.mta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 19:17:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF8N2-0002sv-8T
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 19:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759607Ab1D0RRn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 13:17:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236Ab1D0RRm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 13:17:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 22C8B4891;
	Wed, 27 Apr 2011 13:19:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xmXokLkKcOPW
	9pz+oRBmac6zPvE=; b=FnpwN8DgJYzsfsIvNFNwv56UjTW91KsbdwnDsSYyh3ca
	Py3h04FXkf/paiIcYGUJx/fygkzNWrqfQqPGwYHYMJFkm4ENJPp/hOn5QPlb4kA3
	TB7nhl8bedHJdEYIKJsQ4UL4uvSR6mC+eRS48+dzgCYh/gVZHXEveFqPcDu/n4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=h8fGna
	f+fHt8YQHRWb5MyO51zrJNRNUnI9iTOLo8YXns0gUs13s0Rf0/oJI7h5uZz5B43Q
	+MetunGcCtTioA7ImP0tdY58NnoTtC0Nux1byx2ReT90g7nzkFbcEA67vCTZlBpD
	IOQqmd1Qz8UMO9UQTUPZBEKN/At1tqUCXf6lo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DEADB488D;
	Wed, 27 Apr 2011 13:19:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A32EA4888; Wed, 27 Apr 2011
 13:19:33 -0400 (EDT)
In-Reply-To: <20110427122250.GA10919@jakstys.lt> (UTF's message of "Wed, 27
 Apr 2011 13:22:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87784278-70F2-11E0-9A09-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172247>

Motiejus Jak=C5=A1tys <desired.mta@gmail.com> writes:

> There are lots of variants of the same message:
>
> msgid "cannot stat '%s'"
> msgid "failed to stat '%s'"
> msgid "failed to stat %s\n"
> msgid "Could not stat '%s'"

I am not sure what to do with the trailing LF (it may be a bug in the
message written without being aware that die/warn will give their own L=
=46
at the end), but the first one ("cannot $verb '$name'") is preferred.

> Also same trivial fix:
> -		return error(_("path '%s' does not have all three versions"),
> +		return error(_("path '%s' does not have all 3 versions"),

I would not call this a "fix", though.  What problem does it solve?

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 10a1f65..24d19b8 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -413,7 +413,7 @@ static void *load_file(const char *filename, size=
_t *sz)
>  	if (lstat(filename, &st) < 0) {
>  	err_ret:
>  		if (errno !=3D ENOENT)
> -			error(_("'%s': %s"), filename, strerror(errno));
> +			error("'%s': %s", filename, strerror(errno));
>  		return NULL;
>  	}
>  	if (!S_ISREG(st.st_mode))

This hunk is a fix for mismarked message and is unrelated to the error
message unification, no?  I prefer to have only this part as a separate
patch.
