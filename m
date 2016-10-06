Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63280207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 19:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933468AbcJFTp2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 15:45:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62049 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933376AbcJFTp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 15:45:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E20F343E49;
        Thu,  6 Oct 2016 15:44:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dVr0mVWcrKQq
        1h7oU6IkXHYp8y0=; b=M9HjCSqeNcMn94Arhxi/lxBVszbExrKid3yt+OhVINt6
        g0zMXPZLQsllopUNU16mkIL5k5ukdC0mOYzmgYucSey4s9yGR9IsgFr5cseVmwPN
        OPh3YpqQ1ld4P1LtW60n7kkQsN4qoP1fJsFV00R98eB5iltDh1X2x1snEZ5GgzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vVob1Y
        8NRycjyZkeFYFzRRTvoMzVaJ2vGY7exLdIHKr4mSVStOQfjM2WgKFAMRQdFx77BC
        mCYWtiV7lEA3AUBxxQI+BkcUjsUOAkeD4aue/culWEvOc0HJFQSzX0TIC7TW+5vV
        bJGAlrJhnKZYioqQT9OwgbbCV9mWrgn9WCOTk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D68D343E47;
        Thu,  6 Oct 2016 15:44:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54CFF43E45;
        Thu,  6 Oct 2016 15:44:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 2/3] gitweb: Link to 7-char+ SHA1s, not only 8-char+
References: <20161006091135.29590-1-avarab@gmail.com>
        <20161006091135.29590-3-avarab@gmail.com>
Date:   Thu, 06 Oct 2016 12:44:57 -0700
In-Reply-To: <20161006091135.29590-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 6 Oct 2016 09:11:34 +0000")
Message-ID: <xmqq37k9jm86.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5D890CFA-8BFD-11E6-B39B-F99D12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the minimum length of an abbreviated object identifier in the
> commit message gitweb tries to turn into link from 8 hexchars to 7.
>
> This arbitrary minimum length of 8 was introduced in bfe2191 ("gitweb:
> SHA-1 in commit log message links to "object" view", 2006-12-10), but
> the default abbreviation length is 7, and has been for a long time.
>
> It's still possible to reference SHA1s down to 4 characters in length,
> see v1.7.4-1-gdce9648's MINIMUM_ABBREV, but I can't see how to make
> git actually produce that, so I doubt anyone is putting that into log
> messages in practice, but people definitely do put 7 character SHA1s
> into log messages.
>
> I think it's fairly dubious to link to things matching [0-9a-fA-F]
> here as opposed to just [0-9a-f], that dates back to the initial
> version of gitweb from 161332a ("first working version",
> 2005-08-07). Git will accept all-caps SHA1s, but didn't ever produce
> them as far as I can tell.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---

s/SHA1/SHA-1/g.  I agree that A-F are dubious.

>  gitweb/gitweb.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index cba7405..92b5e91 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2036,7 +2036,7 @@ sub format_log_line_html {
>  	my $line =3D shift;
> =20
>  	$line =3D esc_html($line, -nbsp=3D>1);
> -	$line =3D~ s{\b([0-9a-fA-F]{8,40})\b}{
> +	$line =3D~ s{\b([0-9a-fA-F]{7,40})\b}{
>  		$cgi->a({-href =3D> href(action=3D>"object", hash=3D>$1),
>  					-class =3D> "text"}, $1);
>  	}eg;
