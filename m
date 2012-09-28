From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] revision: make --grep search in notes too if shown
Date: Fri, 28 Sep 2012 10:55:52 -0700
Message-ID: <7vmx0am3pz.fsf@alter.siamese.dyndns.org>
References: <1348745786-27197-1-git-send-email-pclouds@gmail.com>
 <1348815682-18696-1-git-send-email-pclouds@gmail.com>
 <1348815682-18696-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 19:56:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THenF-0003Wd-Aa
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 19:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758664Ab2I1Rz4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 13:55:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59745 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756672Ab2I1Rzz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Sep 2012 13:55:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 349CD8C7A;
	Fri, 28 Sep 2012 13:55:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=A/fKRI/NZMRO
	11OItZfkSF8TgZQ=; b=Mbmho+TQY2nCbplkgjnNqT66TZ7IE+qM08ovQUs9oMwx
	qadT143OebAPmppiaDyjaPpOu7E/2tacWdGKaXcHe7+ipsDNiD6geWzE+TtXWt2V
	N16hufsFFFa5gu31K9OcFxAOBzUCNpQTPC+JTC5IvZMvjRibhnBmkepmSdPdcGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mNupDn
	93GbEsrW+cIL6zNl51QJ797CXCWlTHRkOSJG5fr9bDVKutnKtya8NvFigpLQTGy9
	I3WYGbp3PGbxKt5qOyyE/wPXk/D1RDZxKshG4fYVjkSwfm64X9JFSOLgLaMr59lW
	mct13rCO7stY5DknJEZEsEAit9xAhvzoY93Ms=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E1A38C79;
	Fri, 28 Sep 2012 13:55:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 826618C78; Fri, 28 Sep 2012
 13:55:53 -0400 (EDT)
In-Reply-To: <1348815682-18696-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 28 Sep
 2012 14:01:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF194CD0-0995-11E2-A35E-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206589>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Notes are shown after commit body. From user perspective it looks
> pretty much like commit body and they may assume --grep would search
> in that part too. Make it so.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  On Fri, Sep 28, 2012 at 1:16 AM, Junio C Hamano <gitster@pobox.com>
>  wrote:
>  > The output from "log --show-notes", on the other hand, is even mor=
e
>  > conflated and a casual user would view it as part of the message,
>  > so
>  > I would imagine that if we ever do the extention to cover notes
>  > data, the normal "--grep" should apply to it.
>
>  Something like this?

Yes, that was what I had in mind.

>  revision.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index cfa0e2e..febb4d7 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2223,6 +2223,12 @@ static int commit_match(struct commit *commit,=
 struct rev_info *opt)
>  		strbuf_addch(&buf, '\n');
>  		strbuf_addstr(&buf, commit->buffer);
>  	}
> +	if (opt->show_notes) {
> +		if (!buf.len)
> +			strbuf_addstr(&buf, commit->buffer);
> +		format_display_notes(commit->object.sha1, &buf,
> +				     get_log_output_encoding(), 0);
> +	}
>  	if (buf.len)
>  		retval =3D grep_buffer(&opt->grep_filter, buf.buf, buf.len);
>  	else
