From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/6] tag: read signature
Date: Sun, 22 Feb 2009 10:18:24 -0800
Message-ID: <7vskm6xrm7.fsf@gitster.siamese.dyndns.org>
References: <e29894ca0902221006y4b0e29e7ucc8a04e8e6e42f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 19:20:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbIvo-000828-UL
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbZBVSSc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 13:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbZBVSSb
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:18:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbZBVSSa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 13:18:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 900049CF70;
	Sun, 22 Feb 2009 13:18:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8AC359CF6F; Sun,
 22 Feb 2009 13:18:26 -0500 (EST)
In-Reply-To: <e29894ca0902221006y4b0e29e7ucc8a04e8e6e42f4@mail.gmail.com>
 (=?utf-8?Q?Marc-Andr=C3=A9?= Lureau's message of "Sun, 22 Feb 2009 20:06:37
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 348EBC24-010D-11DE-95AC-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111040>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> diff --git a/tag.h b/tag.h
> index 7a0cb00..bc2cab3 100644
> --- a/tag.h
> +++ b/tag.h
> @@ -9,7 +9,7 @@ struct tag {
>  	struct object object;
>  	struct object *tagged;
>  	char *tag;
> -	char *signature; /* not actually implemented */
> +	char *signature;
>  };

I do not speak for Daniel, but I think the original intent of "signatur=
e"
is about the GnuPG signature, not the "tagger" field.

And this is not an objection.  The use of GnuPG is accidental and at th=
e
low level of the object layer like this codepath we would not necessari=
ly
want to be married to it.  Grabbing and parsing the tagger field like y=
our
patches 1/6 and 2/6 did would be more appropriate.

But then we would probably want to rename this field "tagger" (and then
the timestamp field you add in the next patch "tagger_date").
