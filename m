Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B328207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 19:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933626AbcJFTvM (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 15:51:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55920 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933299AbcJFTvL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 15:51:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DFB743F73;
        Thu,  6 Oct 2016 15:51:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WMjnDbOdw59E
        UImmcHdEHuAR7cU=; b=uuKHi/UGswzT55xiM4zqSR/nPp1yVDEM7ykKsHBuVqPY
        fRsHO3xxWQywdvTY34L9B9H6RD8nlJ2l7vK5rulhWQz7IbE1xEszzikuwWXkOnVg
        ZFzozwP6JhXQPpmTiH9FNS7r3k+gb4nmQSeH3dh6by5aJu+l2zfj/o9o5xjYaSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XNrZa9
        VM/UPmHGJpBD8hys3McmnwcWiZrTlnUetZ41f1dYgjTDYe+id9IxZDeN51oH+45W
        Z3TP04TpzsxBwn2DNwrVBTNAQBgyh6B/IoNW4z3rVZUVlVjxEoobNgEbXwDEOG4v
        POkw45e0xCc0Xwu9cTpdmiJ0Q3HEQDqHmfjCw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2603E43F72;
        Thu,  6 Oct 2016 15:51:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 939A343F71;
        Thu,  6 Oct 2016 15:51:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 3/3] gitweb: Link to "git describe"'d commits in log messages
References: <20161006091135.29590-1-avarab@gmail.com>
        <20161006091135.29590-4-avarab@gmail.com>
Date:   Thu, 06 Oct 2016 12:51:07 -0700
In-Reply-To: <20161006091135.29590-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 6 Oct 2016 09:11:35 +0000")
Message-ID: <xmqqy421i7dg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3A394A70-8BFE-11E6-930A-F99D12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the log formatting function to know about "git describe" output
> such as "v2.8.0-4-g867ad08", in addition to just plain "867ad08".
>
> There are still many valid refnames that we don't link to
> e.g. v2.10.0-rc1~2^2~1 is also a valid way to refer to
> v2.8.0-4-g867ad08, but I'm not supporting that with this commit,
> similarly it's trivially possible to create some refnames like
> "=C3=A6/var-gf6727b0" or which won't be picked up by this regex.

Not a serious counter-proposal or suggestion, and certainly not an
objection to the patch I am responding to, but I wonder if it is so
bad if we made the 867ad08 into link when showing v2.8.0-4-g867ad08.

IOW, in addition to \b followed by [0-9a-f]+ followed by \b, if we
allowed an optional 'g' in front of the hex, e.g.

-	$line =3D~ s{\b([0-9a-fA-F]{7,40})\b}{
+	$line =3D~ s{\bg?([0-9a-fA-F]{7,40})\b}{

wouldn't that be much simpler, covers more cases and sufficient?

> There's surely room for improvement here, but I just wanted to address
> the very common case of sticking "git describe" output into commit
> messages without trying to link to all possible refnames, that's going
> to be a rather futile exercise given that this is free text, and it
> would be prohibitively expensive to look up whether the references in
> question exist in our repository.
>
> There was on-list discussion about how we could do better than this
> patch. Junio suggested to update parse_commits() to call a new
> "gitweb--helper" command which would pass each of the revision
> candidates through "rev-parse --verify --quiet". That would cut down
> on our false positives (e.g. we'll link to "deadbeef"), and also allow
> us to be more aggressive in selecting candidate revisions.
>
> That may be too expensive to work in practice, or it may
> not. Investigating that would be a good follow-up to this patch.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  gitweb/gitweb.perl | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 92b5e91..7cf68f0 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2036,10 +2036,24 @@ sub format_log_line_html {
>  	my $line =3D shift;
> =20
>  	$line =3D esc_html($line, -nbsp=3D>1);
> -	$line =3D~ s{\b([0-9a-fA-F]{7,40})\b}{
> +	$line =3D~ s{
> +        \b
> +        (
> +            # The output of "git describe", e.g. v2.10.0-297-gf6727b0
> +            # or hadoop-20160921-113441-20-g094fb7d
> +            (?<!-) # see strbuf_check_tag_ref(). Tags can't start with=
 -
> +            [A-Za-z0-9.-]+
> +            (?!\.) # refs can't end with ".", see check_refname_format=
()
> +            -g[0-9a-fA-F]{7,40}
> +            |
> +            # Just a normal looking Git SHA1
> +            [0-9a-fA-F]{7,40}
> +        )
> +        \b
> +    }{
>  		$cgi->a({-href =3D> href(action=3D>"object", hash=3D>$1),
>  					-class =3D> "text"}, $1);
> -	}eg;
> +	}egx;
> =20
>  	return $line;
>  }
