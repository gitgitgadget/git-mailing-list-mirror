From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/4] config: allow http.<url>.* any user matching
Date: Mon, 22 Jul 2013 14:51:46 -0700
Message-ID: <7v1u6qclfx.fsf@alter.siamese.dyndns.org>
References: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79>
	<7dfaadb69accede33b88ae2d9e47a48@f74d39fa044aa309eaea14b9f57fe79>
	<7vehaqcw66.fsf@alter.siamese.dyndns.org>
	<DF5B20F8-33C2-4F72-A78B-97EE1FB4A522@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 23:51:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1O1J-000774-BY
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 23:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933405Ab3GVVvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 17:51:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36939 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932873Ab3GVVvs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 17:51:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F3DB3325F;
	Mon, 22 Jul 2013 21:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F/UyrZciF1sXMzoKIe3n9Gz9Vq8=; b=SGFsvS
	T/fkkWYTNRzDYC3dQ9Lz6opYb7c7f3NZNU2aBMz9D4WZ3Ze/mNq4Q2P3G2TsEGqk
	2T3LUVmrx8rw10qpW3TRLLpBzLRHRnWdUHyw8Qb66oUF9s4Qle3f+AQRFAcf32E3
	5DqEkz2Da/KCYRrlv0HaEt6U0FMoeaDR3DHJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jw6ZYfdU+zk9JpRHlb4kG78mOV9nH2BY
	Vjn5kYVx2bazBUQAITOCO8m/Y+wOhc1poZbmML7uv9rd8QN2K61bq/OqKcp2QJ4+
	s0BMPBZrBju0b/eyf/Ii7kHrdDpgfiH7me0VwkqvklWyB6/54op4zroP7yUH9C3j
	kr1218GUDH0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 525513325E;
	Mon, 22 Jul 2013 21:51:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B7703325A;
	Mon, 22 Jul 2013 21:51:47 +0000 (UTC)
In-Reply-To: <DF5B20F8-33C2-4F72-A78B-97EE1FB4A522@gmail.com> (Kyle J. McKay's
	message of "Mon, 22 Jul 2013 13:24:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E84CADC8-F318-11E2-8172-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230996>

"Kyle J. McKay" <mackyle@gmail.com> writes:

>> A solid wall of text is somewhat hard to read, so I'd queue the
>> equivalent of the following "git diff -w" output on top.
>
> Can I send out the change as a 'fixup!' patch?  Or do I need to send a
> new v9 patch series with the documentation update?

If you are OK with splitting it into two paragraphs with the
"longest" clarification tweak (the "patch" I showed you), just
saying so and I can squash ;-) so there is no need to resend.

>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index c418adf..635ed5d 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1521,9 +1521,11 @@ http.<url>.*::
>> 	path portion is an exact match or a prefix that matches at a "/"
>> 	boundary.  If <url> does not include a user name, it will match a url
>> 	with any username otherwise the user name must match as well (the
>> -	password part, if present in the url, is always ignored).
>> Longer <url>
>> -	path matches take precedence over shorter matches no matter
>> what order
>> -	they occur in.  For example, if both
>> "https://user@example.com/
>> path" and
>> +	password part, if present in the url, is always ignored).  A <url>
>> +	with longer path matches take precedence over shorter matches
>> no matter
>> +	what order they occur in the configuration file.
>> ++
>> +For example, if both "https://user@example.com/path" and
>> "https://example.com/path/name" are used as a config <url> value and
>> then "https://user@example.com/path/name/here" is passed to a git
>> command, the settings in the "https://example.com/path/name" section
>
> OK.

... which essentially is your "OK" ;-)

>> I am not yet convinced that the precedence rule specified in this
>> what we want (I do not have an example why it is *not* what we want,
>> either).  Another definition could be "if user@ is present in the
>> request, give lower precedence to config entries for the site
>> without user@ than entries with user@", and I do not have a strong
>> opinion myself which one between the two is better (and there may be
>> third and other possible rule).
>>
>> Comments?
>
> Consider this site:
> ...
> So my thinking was that having user matches take precedence over path
> length matches can result in endless additions to the config file
> (because you have to list all the other users to override a sub area
> and that could be a large list) whereas having path length matches
> take precedence over user matches will only result in a few, finite
> additions to the config file (the number of already-configured items
> with a longer path).
