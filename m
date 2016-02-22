From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 4/4] config: add '--show-origin' option to print the origin of a config value
Date: Mon, 22 Feb 2016 09:43:25 -0800
Message-ID: <xmqq4md08wua.fsf@gitster.mtv.corp.google.com>
References: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com>
	<1455873362-66998-5-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, ramsay@ramsayjones.plus.com,
	Johannes.Schindelin@gmx.de
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 22 18:43:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXuWQ-0002or-OW
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 18:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbcBVRn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 12:43:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64407 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751096AbcBVRn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 12:43:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F08F945892;
	Mon, 22 Feb 2016 12:43:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kTslA26z5/XkE7G9K/sRRk6AfNo=; b=g/0Svk
	L/b4Y7wZaF0otQiBQj/nNjImrwNiWhqmkRMAuBrbwrWtlES2Vg6nmrAGqs9+RJ72
	eGCFpmgniB5O4SuQp261V5xtX4UY7tP+B7HAJIUfdHwAGXt0HaJL/ktGHHNzNFiV
	X5iLfOt7MIGmFTTtYghivofLBlIFj0YG2cTwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O5MCKcniD9R8SUZfZtItmKLa0hj9gB59
	Cce4ZLI/BoY+752S+93TWIWVobLYyq5phmc9FILJe8gsi445m5UoCSMPIFlfzKzv
	pRB4nPb3NZ7ZyZKL+Ez5iOLLRFhZmRdufqnMFux9m9tONoCR3DC/Modbi4NEVZkt
	FIoQKgr5z1s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E63A745891;
	Mon, 22 Feb 2016 12:43:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5595245890;
	Mon, 22 Feb 2016 12:43:26 -0500 (EST)
In-Reply-To: <1455873362-66998-5-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Fri, 19 Feb 2016 10:16:02
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C6D71852-D98B-11E5-8D71-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286935>

larsxschneider@gmail.com writes:

> +test_expect_success '--show-origin with --list' '
> +	cat >expect <<-EOF &&
> +		file:$HOME/.gitconfig	user.global=true
> +		file:$HOME/.gitconfig	user.override=global
> +		file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
> +		file:$INCLUDE_DIR/absolute.include	user.absolute=include
> +		file:.git/config	user.local=true
> +		file:.git/config	user.override=local
> +		file:.git/config	include.path=../include/relative.include
> +		file:.git/../include/relative.include	user.relative=include
> +		cmdline:	user.cmdline=true
> +	EOF
> ...
> +test_expect_success '--show-origin stdin' '
> +	cat >expect <<-\EOF &&
> +		stdin:	user.custom=true
> +	EOF

I do recall there was some bikeshedding^Wdesigning discussion, in
which I chose not to participate, on the output format, how
origin-type and origin-value are given in the output in an
unambiguous way that is easy to understand by the end users.

Does the above reflect the concensus from the discussion?  Just
double checking.
