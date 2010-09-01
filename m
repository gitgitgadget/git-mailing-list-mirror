From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin: use builtin.h for all builtin/ commands
Date: Wed, 01 Sep 2010 10:43:19 -0700
Message-ID: <7vmxs15phk.fsf@alter.siamese.dyndns.org>
References: <AANLkTinHtvHt0q=dK9KHtCX6JzymB5dx1NuaAZN_uu2R@mail.gmail.com>
 <1283358207-3165-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 19:43:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqrLS-0002oD-OV
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 19:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789Ab0IARn3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 13:43:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300Ab0IARn3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 13:43:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CCC50D2695;
	Wed,  1 Sep 2010 13:43:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2duMZ1rxMi14
	jZZEMB/Wo8OkY+U=; b=IqBJUkObKVkQ2AX5HGCEnN+OMCVXmQQFTLh72tVHogbv
	4/lucaZAA0kIJuKe0QnE4Wm9mlU6NElJRv7p+N0eVQrF4R3lhTPhzu7LzfHovClj
	46hJrTALyqoYfVczpHigSViz8f3nd5nrv3296burNFo8XYUd2oz31wWCs6NzpP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BulTd9
	LlOcoz9jvO/RITFJw7tJWfavah5KscvMtKN8TY+OaTwUajo20YJyjFBA9DKXU83B
	hClrmhEGWEgYXigSSnc6WoMigMcMlv8oNMuYdDKQ/MTdyeDUwA8p9KpTDGEQ6Ej1
	d9ol8S2zqRQoriWiDky7bzVqAPz7OzxGwkeig=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 968D7D2694;
	Wed,  1 Sep 2010 13:43:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3D5AD2693; Wed,  1 Sep
 2010 13:43:20 -0400 (EDT)
In-Reply-To: <1283358207-3165-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed\,  1 Sep
 2010 16\:23\:27 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B90EE7E-B5F0-11DF-9DED-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155066>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Some builtin/*.c commands weren't using the builtin.h header, but
> instead manually imported headers like cache.h and commit.h which
> builtin.h would include for them.

> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index dbd8b7b..03abc30 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -1,7 +1,6 @@
> -#include "cache.h"
> +#include "builtin.h"
>  #include "refs.h"
>  #include "pkt-line.h"
> -#include "commit.h"
>  #include "tag.h"
>  #include "exec_cmd.h"
>  #include "pack.h"

Leveraging the fact that builtin.h includes git-compat-util.h and cache=
=2Eh
is fine and I think strbuf is also generic and pervasive enough to be
included in the mix, but in the longer term we would probably want to f=
ix
builtin.h not to include it itself does not need, notably commit.h and
notes.h.

=46or example, the header currently defines notes related stuff, such a=
s
notes_rewrite_cfg parse_combine_notes_fn, etc.  Shouldn't they belong t=
o
notes.h?  And if we lose them, do we still need to include commit.h and
notes.h in builtin.h?

And when that happens, the inclusion of commit.h needs to come back to
this file, I think.
