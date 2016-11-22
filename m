Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 256E61FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 17:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932721AbcKVRnY (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 12:43:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51296 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755448AbcKVRmr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 12:42:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8994A4F73C;
        Tue, 22 Nov 2016 12:42:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BJ16/evLu+rG
        T9spwV4i/bfWLno=; b=TlCe8yjy0FnMUJ2ylLrYESMMZHmBrAHEMuXGVgn/5m36
        It1z61DynHYh1wx2KJr/bIv5+LmeN7BELPWljfGuL6nAHaceaQ5fncsm7V5h3MDM
        pKA8oj8BWdjs5VjxUBQDMHGIcsQqGgzTDVUP96N68bRZ9rf1TyL7HLeoybbmIOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oHMVqa
        5PadVnN4lGPsfOpxc56QkQI8b2jHyVCEOxXModyRBzHQ6IxB5CFP0Z6jzT95eQzr
        YKYP9TSTMK2dr3HluycRjzEw5aCNTmM1IthEPj79ZA40P2z1kzvh+FVNzWG49I+a
        uQju2pNgrn7KUJX9vqK4TEev56c4D05ggoJm0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81C704F73B;
        Tue, 22 Nov 2016 12:42:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E25D34F73A;
        Tue, 22 Nov 2016 12:42:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Jakub =?utf-8?Q?Na?= =?utf-8?Q?r=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v6 01/16] Git.pm: add subroutines for commenting lines
References: <20161111124541.8216-1-vascomalmeida@sapo.pt>
        <20161111124541.8216-2-vascomalmeida@sapo.pt>
        <1479823833.1956.7.camel@sapo.pt>
Date:   Tue, 22 Nov 2016 09:42:39 -0800
In-Reply-To: <1479823833.1956.7.camel@sapo.pt> (Vasco Almeida's message of
        "Tue, 22 Nov 2016 13:10:33 -0100")
Message-ID: <xmqqoa17quls.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 10F2F3A8-B0DB-11E6-98FC-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> A Sex, 11-11-2016 =C3=A0s 11:45 -0100, Vasco Almeida escreveu:
>> +=3Ditem comment_lines ( STRING [, STRING... ])
>> +
>> +Comments lines following core.commentchar configuration.
>> +
>> +=3Dcut
>> +
>> +sub comment_lines {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0my $comment_line_char =3D c=
onfig("core.commentchar") || '#';
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return prefix_lines("$comme=
nt_line_char ", @_);
>> +}
>> +
>
> In light of the recent "Fix problems with rebase -i when
> core.commentchar is defined" [1], I realized that this patch does not
> handle the 'auto' value of core.commentchat configuration variable.
>
> I propose to do the patch below in the next re-roll.
>
> [1] http://www.mail-archive.com/git@vger.kernel.org/msg107818.html

The incremental update below looks sensible.  We'd also want to
protect this codepath from a misconfigured two-or-more byte sequence
in core.commentchar, I would suspect, to be consistent.

> -- >8 --
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 3a6d846..8d33634 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1073,6 +1073,7 @@ sub edit_hunk_manually {
>  	my $is_reverse =3D $patch_mode_flavour{IS_REVERSE};
>  	my ($remove_plus, $remove_minus) =3D $is_reverse ? ('-', '+') : ('+',=
 '-');
>  	my $comment_line_char =3D Git::config("core.commentchar") || '#';
> +	$comment_line_char =3D '#' if ($comment_line_char eq 'auto');
>  	print $fh Git::comment_lines sprintf(__ <<EOF, $remove_minus, $remove=
_plus, $comment_line_char),
>  ---
>  To remove '%s' lines, make them ' ' lines (context).
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 69cd1dd..47b5899 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -1459,6 +1459,7 @@ Comments lines following core.commentchar configu=
ration.
> =20
>  sub comment_lines {
>  	my $comment_line_char =3D config("core.commentchar") || '#';
> +	$comment_line_char =3D '#' if ($comment_line_char eq 'auto');
>  	return prefix_lines("$comment_line_char ", @_);
>  }
