From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9700: fix test for perl older than 5.14
Date: Fri, 04 Mar 2016 10:15:49 -0800
Message-ID: <xmqqwppiyuqy.fsf@gitster.mtv.corp.google.com>
References: <CAP8UFD1z9H=SygaMVzpc__mXTbnFc2XiW0LZ+sfzdCPmrnXW6g@mail.gmail.com>
	<20160304085649.GA29752@sigill.intra.peff.net>
	<1457089104.2660.79.camel@kaarsemaker.net>
	<20160304114321.GA569@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 19:16:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abuGo-0004jT-WB
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 19:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759517AbcCDSPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 13:15:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56248 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758917AbcCDSPx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 13:15:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC163462C0;
	Fri,  4 Mar 2016 13:15:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PlwKJsnO2r24JWlYcEZIcDEsa6A=; b=HtOLbZ
	9oJQwvNcqfXMp7M4f2Fcr8ovtpjCctDtUGn8hH/zDiwGUXLcJTcEblNXfDgyEcGu
	4RCuNJGqFtqMQG3GCMCtSjJE9oPJoo68uHMynTFQnP9gUdMPuGKxWfIqH/O4UIBm
	FoOkvOSpj48Ir77tnEaSVUSdkembwuzbj+9jY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QK4VQ9Ru+ogXdPD9vuZfIHNzUwZLBR/4
	ePUgmbZIBbaonwQEgsJQyqvrwwLFSXdn7Nk29DOykcGrfAtxOjAf5RxoVh0ZmcMq
	ps0xefW38WZdMuLPGJvZ+6d2cKFQauA1l3KpZxp66+Y0+pn2mihDwvtAS5m7xrQx
	g4x7ym1SxDw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 96EA3462BF;
	Fri,  4 Mar 2016 13:15:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F060D462BD;
	Fri,  4 Mar 2016 13:15:50 -0500 (EST)
In-Reply-To: <20160304114321.GA569@sigill.intra.peff.net> (Jeff King's message
	of "Fri, 4 Mar 2016 06:43:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 206FC038-E235-11E5-B307-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288264>

Jeff King <peff@peff.net> writes:

> One workaround would therefore be for him to tweak PERL_PATH, but
> obviously that does not help anyone else. I think we should do this:
>
> -- >8 --
> Subject: t9700: fix test for perl older than 5.14
>
> Commit d53c2c6 (mingw: fix t9700's assumption about
> directory separators, 2016-01-27) uses perl's "/r" regex
> modifier to do a non-destructive replacement on a string,
> leaving the original unmodified and returning the result.

Will apply on js/mingw-tests and merge to 'master' before -rc1.
Thanks.

>
> This feature was introduced in perl 5.14, but systems with
> older perl are still common (e.g., CentOS 6.5 still has perl
> 5.10). Let's work around it by providing a helper function
> that does the same thing using older syntax.
>
> While we're at it, let's switch to using an alternate regex
> separator, which is slightly more readable.
>
> Reported-by: Christian Couder <christian.couder@gmail.com>
> Helped-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> And yes, before anyone checks, the alternate separators are available
> even in ancient versions of perl. :)
>
>  t/t9700/test.pl | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/t/t9700/test.pl b/t/t9700/test.pl
> index 7e8c40b..1b75c91 100755
> --- a/t/t9700/test.pl
> +++ b/t/t9700/test.pl
> @@ -17,6 +17,12 @@ BEGIN {
>  use Cwd;
>  use File::Basename;
>  
> +sub adjust_dirsep {
> +	my $path = shift;
> +	$path =~ s{\\}{/}g;
> +	return $path;
> +}
> +
>  BEGIN { use_ok('Git') }
>  
>  # set up
> @@ -33,7 +39,7 @@ is($r->config_int("test.int"), 2048, "config_int: integer");
>  is($r->config_int("test.nonexistent"), undef, "config_int: nonexistent");
>  ok($r->config_bool("test.booltrue"), "config_bool: true");
>  ok(!$r->config_bool("test.boolfalse"), "config_bool: false");
> -is($r->config_path("test.path") =~ s/\\/\//gr, $r->config("test.pathexpanded"),
> +is(adjust_dirsep($r->config_path("test.path")), $r->config("test.pathexpanded"),
>     "config_path: ~/foo expansion");
>  is_deeply([$r->config_path("test.pathmulti")], ["foo", "bar"],
>     "config_path: multiple values");
