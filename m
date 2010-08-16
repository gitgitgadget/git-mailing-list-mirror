From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] reset: Better warning message on git reset --mixed
 <paths>
Date: Sun, 15 Aug 2010 20:39:12 -0700
Message-ID: <7vmxsndy5b.fsf@alter.siamese.dyndns.org>
References: <20100814210505.GA2372@burratino>
 <1281861800-424-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ralf Ebert <info@ralfebert.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 05:39:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkqXt-00059x-1m
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 05:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959Ab0HPDj0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 23:39:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab0HPDjZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 23:39:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F373CD5BC;
	Sun, 15 Aug 2010 23:39:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=YW+lvMpDbz8Z16d6npjOjLGgd
	9E=; b=rdC0ZVoRJx5HB9etkZPlmClAETyAyc+rDviAbtqVM9oXB/Yl4FHOegJ+X
	SOe7UfJHytcusSCOy6JDED4XMwHtca9rFpR9T30teg6fliSECGyuRi9lMFvKnr8Q
	JyClBs2nYKh08VpvK/24gaO13HP3UIuTolyWmrxO7Q/jKgk/K8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=L9efHS99Y/xAtvAYKx0
	eplIuCNa29oZTJ85mZcz4i+l2LzKYaxW+4iAi2SwD5tzUkEPfwrVhXUe/X4jRjbr
	6sfKTD745Q+YxPf3GTScyqe+msKOrXmneRKQc8oA4jUYLXpMussNPg+bZ5seBVIs
	RzcITyLIf+l5Ja8Cy5fsEuOQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 20607CD5B9;
	Sun, 15 Aug 2010 23:39:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24970CD5B4; Sun, 15 Aug
 2010 23:39:13 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D9E07946-A8E7-11DF-B159-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153645>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> When you call "git reset --mixed <paths>" git will complain that usin=
g
> mixed with paths is deprecated:
>
>     warning: --mixed option is deprecated with paths.
>
> That doesn't tell the user why it's deprecated, or what he should use
> instead. Expand on the warning and tell the user to just omit --mixed=
:
>
>     warning: --mixed with paths is deprecated; use 'git reset -- <pat=
hs>' instead
>
> The exact wording of the warning was suggested by Jonathan Nieder.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>
> On Sat, Aug 14, 2010 at 21:05, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>> Maybe:
>>
>> =C2=A0warning: --mixed with paths is deprecated; use 'git reset -- <=
paths>' instead
>
> That's better, thanks. Here's an amended version, and with tests this
> time.

While the new message is an improvement, I do not think the added test
that checks the exact wording is good.

Think for 5 seconds what the expected code change would be to break tha=
t
test.  I can only think of two realistic cases.  (1) Command line parsi=
ng
is broken and "reset --mixed <pathspec>" does not go through the codepa=
th
that produces this warning anymore; (2) we deem that we had the
deprecation long enough and error out on this usage; or (3) Somebody co=
mes
up with an even better wording but the string in this test still expect=
s
suboptimal warning.

When we change this to an error, that is a behaviour change (it will
change the exit status as well), and it would be Ok to force the person
who does such a change to update the test.  But (3) shows that this tes=
t
is making it harder for people to improve the wording than necessary;
isn't it sufficient to check if any warning is issued at all?

I personally do not think this deserves to consume a new test number,
which is rather a scarce resource.

> diff --git a/t/t7112-reset-messages.sh b/t/t7112-reset-messages.sh
> new file mode 100755
> index 0000000..6f2669b
> --- /dev/null
> +++ b/t/t7112-reset-messages.sh
> @@ -0,0 +1,33 @@
> ...
> +test_expect_success 'git reset --mixed <paths> warning' '
> +	# Not test_commit() due to "ambiguous argument [..] both revision
> +	# and filename"

Huh?
