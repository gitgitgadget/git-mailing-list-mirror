From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/3] tests: adjust the configuration for Apache 2.2
Date: Tue, 10 May 2016 10:31:05 -0700
Message-ID: <xmqqd1otrfae.fsf@gitster.mtv.corp.google.com>
References: <cover.1462774709.git.johannes.schindelin@gmx.de>
	<cover.1462863934.git.johannes.schindelin@gmx.de>
	<10a0848e281bf8595c78d4e9f9a770fea9bc6ba8.1462863934.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 10 19:31:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0BV4-0003Qj-Ca
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 19:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbcEJRbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 13:31:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750922AbcEJRbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 13:31:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ECD4D19D48;
	Tue, 10 May 2016 13:31:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LGwvHXJVyxxv8WI1G2GLGJ2Pyy0=; b=v0VPKX
	uqU1gbX91Gkf8u6JOJdVebxTI0nFjqeJZuz+1efa6nBzhaLKm7Q8e7KF/OcGADAC
	GKMyH8aA5rffXmP2WnUD/2kwWq62seZVcx0THbIMKqGrGKcp8EWGOs2AjDbW2Uvv
	Wij26hSIn4NrfwO0RD3CkvXTwNczwNpZL548s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UMkGx/Q4IstxvWVUygJylF5D6Un4eeFZ
	zHczruWU5h3FLCxJUyqSCAZBroO2ulC9TusgTaRk9B40Cpa62NE+IERt5O3r7r3W
	GY5JXM43GgSWsvQ4pH72gJjsxKDwOhWAFYyzk1ZcWFb5MYeer4z2W5Nn9tVQqTN/
	3GZ1/osx3vU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E303C19D47;
	Tue, 10 May 2016 13:31:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6AE2E19D46;
	Tue, 10 May 2016 13:31:07 -0400 (EDT)
In-Reply-To: <10a0848e281bf8595c78d4e9f9a770fea9bc6ba8.1462863934.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 10 May 2016 09:08:27 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FA97E10E-16D4-11E6-98A0-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294161>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Lars Schneider noticed that the configuration introduced to test the
> extra HTTP headers cannot be used with Apache 2.2 (which is still
> actively maintained, as pointed out by Junio Hamano).
>
> To let the tests pass with Apache 2.2 again, let's substitute the
> offending <RequireAll> and `expr` by using old school RewriteCond
> statements.
>
> As RewriteCond does not allow testing for *non*-matches, we simply match
> the desired case first and let it pass by marking the RewriteRule as
> '[L]' ("last rule, do not process any other matching RewriteRules after
> this"), and then have another RewriteRule that matches all other cases
> and lets them fail via '[F]' ("fail").
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

I applied this and compared what was queued from the previous round.
It turns out that it is the same, except that I amended it with
"Tested-by:" from Lars', so I'll skip this and nothing is lost ;-)

Thanks for being thorough (the above is not a suggestion to omit
unchanged ones next time--quite the contrary, being able to verify
by comparing is a good thing).

>  t/lib-httpd/apache.conf | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index b8ed96f..018a83a 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -103,10 +103,6 @@ Alias /auth/dumb/ www/auth/dumb/
>  	Header set Set-Cookie name=value
>  </LocationMatch>
>  <LocationMatch /smart_headers/>
> -	<RequireAll>
> -		Require expr %{HTTP:x-magic-one} == 'abra'
> -		Require expr %{HTTP:x-magic-two} == 'cadabra'
> -	</RequireAll>
>  	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
>  	SetEnv GIT_HTTP_EXPORT_ALL
>  </LocationMatch>
> @@ -136,6 +132,18 @@ RewriteRule ^/ftp-redir/(.*)$ ftp://localhost:1000/$1 [R=302]
>  RewriteRule ^/loop-redir/x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-(.*) /$1 [R=302]
>  RewriteRule ^/loop-redir/(.*)$ /loop-redir/x-$1 [R=302]
>  
> +# Apache 2.2 does not understand <RequireAll>, so we use RewriteCond.
> +# And as RewriteCond does not allow testing for non-matches, we match
> +# the desired case first (one has abra, two has cadabra), and let it
> +# pass by marking the RewriteRule as [L], "last rule, do not process
> +# any other matching RewriteRules after this"), and then have another
> +# RewriteRule that matches all other cases and lets them fail via '[F]',
> +# "fail the request".
> +RewriteCond %{HTTP:x-magic-one} =abra
> +RewriteCond %{HTTP:x-magic-two} =cadabra
> +RewriteRule ^/smart_headers/.* - [L]
> +RewriteRule ^/smart_headers/.* - [F]
> +
>  <IfDefine SSL>
>  LoadModule ssl_module modules/mod_ssl.so
