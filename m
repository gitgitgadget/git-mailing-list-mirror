Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE07A1F4B6
	for <e@80x24.org>; Mon,  1 Jul 2019 18:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfGASPp (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 14:15:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50806 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGASPp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 14:15:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9FEAB6C7C2;
        Mon,  1 Jul 2019 14:15:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SUZWoLNId2qH
        yJ0YZIJSUd4+gFA=; b=VyhUyvZw6JtfIaIbYP1pj3K6s6dWv63bdrnOOWbWsMnq
        KzIOUMyo2skMCKqL5YgJI+kZqFd31NTUGoJ4/5zT2PjjTOrFWVcf/q3tmupYYVuJ
        9yeTd7uths6wSUtUluxd+4c3fPZ7bhOE4JnHwCLG3PuE/3IJSp3NNDGo4AMxVUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mF2dPV
        WPUCcvLzcvaOkBMUhHGngoQfhT+z3vOZMxtCH2an1ummTwxV88srRERgqUZ/Gvlt
        zX67O6RAep4DRE13lr6Jh2jpqxC/uU/04FnyCPX9tM/Adisf/TplYuF8xb4suYJL
        1/agrGS008IJBcsXaTuYKxmYjDD6cFnEoL64M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 96FAD6C7C1;
        Mon,  1 Jul 2019 14:15:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C82E76C7C0;
        Mon,  1 Jul 2019 14:15:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Janos Farkas <chexum@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/1] repack: warn if bitmaps are explicitly enabled with keep files
References: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com>
        <875zow8i85.fsf@evledraar.gmail.com>
        <20190623180226.GA1100@sigill.intra.peff.net>
        <20190623180825.3ospajjgat3clwiu@dcvr>
        <20190623224244.GB1100@sigill.intra.peff.net>
        <20190628070211.hfweqcons6c6gy52@dcvr>
        <87zhm26uq9.fsf@evledraar.gmail.com>
        <20190629191600.nipp2ut37xd3mx56@dcvr>
Date:   Mon, 01 Jul 2019 11:15:38 -0700
In-Reply-To: <20190629191600.nipp2ut37xd3mx56@dcvr> (Eric Wong's message of
        "Sat, 29 Jun 2019 19:16:00 +0000")
Message-ID: <xmqq7e917h9x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3BDCFF70-9C2C-11E9-8E53-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> wrote:
>> I have the feedback I posted before this patch in
>> https://public-inbox.org/git/874l4f8h4c.fsf@evledraar.gmail.com/
>>=20
>> In particular "b" there since "a" is clearly more work. I.e. shouldn't
>> we at least in interactive mode on a "gc" print something about skippi=
ng
>> what we'd otherwise do.
>>=20
>> Maybe that's tricky with the gc.log functionality, but I think we shou=
ld
>> at least document this before the next guy shows up with "sometimes my
>> .bitmap files aren't generated...".
>
> I'm not sure if the warning should be present by default;
> because we'll silently stop using bitmaps, now.  But warning
> if '-b' is specified seems right:

Hmph...  write_bitmaps can come either from the command line or from
the configuration.  When repack.writebitmaps configuration is set,
and some .keep files exist, the user probably is not even aware of
doing something that is unsupported.

The keep_pack_list will not be empty only if the "--keep-pack"
option is explicitly given from the command line, so making it and
an explicit "-b" on the command line a condition to trigger the
warning (or even "fatal: can't do both at the same time") is safe
enough, I think.  But anything more than that, I am not so sure.

Also, is it safe to unconditionally emit strings to the standard
error stream from the gc codepath these days?  I recall that once we
had trouble with the logic to skip repeatedly failing "gc --auto"
vaguely, but maybe I am remembering something else.

Thanks.


> -------8<----------
> Subject: [PATCH] repack: warn if bitmaps are explicitly enabled with ke=
ep
>  files
>
> If a user explicitly enables bitmaps, we should warn if .keep
> files exist or are specified via --keep-pack
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  builtin/repack.c  |  8 ++++++++
>  t/t7700-repack.sh | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 73250b2431..b1eeee88a7 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -359,7 +359,15 @@ int cmd_repack(int argc, const char **argv, const =
char *prefix)
>  				 is_bare_repository() &&
>  				 keep_pack_list.nr =3D=3D 0 &&
>  				 !has_pack_keep_file();
> +	} else if (write_bitmaps > 0) {
> +		if (keep_pack_list.nr)
> +			fprintf(stderr,
> +				_("WARNING: --keep-pack is incompatible with bitmaps\n"));



> +		if (has_pack_keep_file())
> +			fprintf(stderr,
> +				_("WARNING: .keep files are incompatible with bitmaps\n"));
>  	}
> +
>  	if (pack_kept_objects < 0)
>  		pack_kept_objects =3D write_bitmaps;
> =20
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 0e9af832c9..839484c7dc 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -249,4 +249,20 @@ test_expect_success 'no bitmaps created if .keep f=
iles present' '
>  	test_must_be_empty actual
>  '
> =20
> +test_expect_success '-b warns with .keep files present' '
> +	pack=3D$(ls bare.git/objects/pack/*.pack) &&
> +	test_path_is_file "$pack" &&
> +	keep=3D${pack%.pack}.keep &&
> +	>"$keep" &&
> +	git -C bare.git repack -adb 2>err &&
> +	test_i18ngrep -F ".keep files are incompatible" err &&
> +	rm -f "$keep"
> +'
> +
> +test_expect_success '-b warns with --keep-pack specified' '
> +	keep=3D$(cd bare.git/objects/pack/ && ls *.pack) &&
> +	git -C bare.git repack -adb --keep-pack=3D"$keep" 2>err &&
> +	test_i18ngrep -F "keep-pack is incompatible" err
> +'
> +
>  test_done
