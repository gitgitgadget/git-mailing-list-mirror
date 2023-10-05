Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4530AE92730
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 14:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbjJEOnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjJEOiP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 10:38:15 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7023E4F6F4
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 07:02:53 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 961E13200BDC;
        Thu,  5 Oct 2023 07:31:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 05 Oct 2023 07:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696505469; x=1696591869; bh=0B
        S//cm37MbPv5qhC5yqegpah1S+NmxTYbdHLBHQOOs=; b=Crj8hxhxJsDkVHufEO
        e0Gya/qCIUSkv65OcmxRuh3u4v4IVRnXMH2uihR88ucDzRD4wnfSdyrELsVn6Df8
        baSVtS0xGdSn4K6p7k3sT7NKA7Q9vNE8SDl7jzmDW+Zg5+RsJnv69YCVUIVythyj
        mwWzRjsd+OtxmDZ1hjvj452KBRZNkYrF/OM4glFdQGKWo2liZIZcI8rUNcM8nh8b
        gq9Wy6ThCF8yz7PvRdLVVd8bvWNLoR/Chlu+Y1FNQKekoNYt2lLARHEZ8YIHvedH
        620ErtKOfkNKZzgKfdbewWVEjXP4VU6KT/Y8FPSSzbBTQRhCxqkhxLP8SzVlVTZw
        i3Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696505469; x=1696591869; bh=0BS//cm37MbPv
        5qhC5yqegpah1S+NmxTYbdHLBHQOOs=; b=ZWgxZ/jg7o/mmlLWWuuGhaX+isCUh
        jewP0iDcx2ecia9Oad0Uf1YWWV9JEdZX7T+kyyoaGNL3Z+2Trgc22WUah+E9FqYs
        eNoteNWQi3CfJ6SqnP1096irr3hnbdPeq/RwoLNq0zx/mzfDxmoi6HBGVcispnbf
        f1xCNIcEg+IFukLs+/V8XWUHxKd5+xBaxstJoELaFJg4mfRpnHTKkr3n1VgyYlMo
        XDi4UZN2SpUaI9rba7IEJQZKX3GBHdJghU6HYTy9r3r5317r2q6ft/DX31tjUCIe
        pt4v3RMg0niXDE08O4jpY2NjgOHR+C4A0Ro4VgLrFlQZvZSA+y5yMvEjg==
X-ME-Sender: <xms:fJ4eZbKINLTcuhOTfVaskzFEzBajuqI43zGlKd5hXMVZkWVEywgUZQ>
    <xme:fJ4eZfI7PJV7UXk8-Tm3k-7TtFqBaeXiRPKP-OX7rjGkaECxHeTC9_9YOUA0z-Tpn
    6vZha6tqG8Fox2yyw>
X-ME-Received: <xmr:fJ4eZTtK-b7zBKLuCE69vrKPsnA4k9JoJDTICzzoBQaXEUHPNKbtu6p8pKu5RI1yjnbeSKAAo4ejXW-PNTBXpTqNKTT1O4iJ5lFK-z6h_-Pekg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeggdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:fJ4eZUYJHSa5LjOiNEtcZrImaSOspK_bwwIlNecLcf7BFoCFfHyRMg>
    <xmx:fJ4eZSabfc3a1_6hI7ivV2sMKRAGeW_lv87Wtqrlvm6LL5rM5NnJWA>
    <xmx:fJ4eZYDPzdNemf4TuSdUfAWznQWnYxcU-BqrCkFUTE8-AMkZLg7rtg>
    <xmx:fZ4eZSGlkITya1qnb6nlpPKB1zNgMI1zgLG5Z7zyKwh3cbn8_HEBcA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Oct 2023 07:31:07 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id 209b7f77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Oct 2023 11:31:04 +0000 (UTC)
Date:   Thu, 5 Oct 2023 13:31:02 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] builtin/repack.c: parse `--max-pack-size` with
 OPT_MAGNITUDE
Message-ID: <ZR6ednOcuK6qizch@tanuki>
References: <cover.1694123506.git.me@ttaylorr.com>
 <cover.1696293862.git.me@ttaylorr.com>
 <9ec999882d790aa770aba8c0916b9260661af9be.1696293862.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DNLWcAMEG0eoKHvn"
Content-Disposition: inline
In-Reply-To: <9ec999882d790aa770aba8c0916b9260661af9be.1696293862.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DNLWcAMEG0eoKHvn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 08:44:29PM -0400, Taylor Blau wrote:
> The repack builtin takes a `--max-pack-size` command-line argument which
> it uses to feed into any of the pack-objects children that it may spawn
> when generating a new pack.
>=20
> This option is parsed with OPT_STRING, meaning that we'll accept
> anything as input, punting on more fine-grained validation until we get
> down into pack-objects.
>=20
> This is fine, but it's wasteful to spend an entire sub-process just to
> figure out that one of its option is bogus. Instead, parse the value of
> `--max-pack-size` with OPT_MAGNITUDE in 'git repack', and then pass the
> knonw-good result down to pack-objects.

Tiny nit: s/knonw/known.

Other than that this patch looks good to me.

Patrick

> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/repack.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 529e13120d..8a5bbb9cba 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -51,7 +51,7 @@ struct pack_objects_args {
>  	const char *window_memory;
>  	const char *depth;
>  	const char *threads;
> -	const char *max_pack_size;
> +	unsigned long max_pack_size;
>  	int no_reuse_delta;
>  	int no_reuse_object;
>  	int quiet;
> @@ -242,7 +242,7 @@ static void prepare_pack_objects(struct child_process=
 *cmd,
>  	if (args->threads)
>  		strvec_pushf(&cmd->args, "--threads=3D%s", args->threads);
>  	if (args->max_pack_size)
> -		strvec_pushf(&cmd->args, "--max-pack-size=3D%s", args->max_pack_size);
> +		strvec_pushf(&cmd->args, "--max-pack-size=3D%lu", args->max_pack_size);
>  	if (args->no_reuse_delta)
>  		strvec_pushf(&cmd->args, "--no-reuse-delta");
>  	if (args->no_reuse_object)
> @@ -946,7 +946,7 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix)
>  				N_("limits the maximum delta depth")),
>  		OPT_STRING(0, "threads", &po_args.threads, N_("n"),
>  				N_("limits the maximum number of threads")),
> -		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("bytes"),
> +		OPT_MAGNITUDE(0, "max-pack-size", &po_args.max_pack_size,
>  				N_("maximum size of each packfile")),
>  		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
>  				N_("repack objects in packs marked with .keep")),
> --=20
> 2.42.0.310.g9604b54f73.dirty
>=20

--DNLWcAMEG0eoKHvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUennYACgkQVbJhu7ck
PpQB0Q/+LJSmcRZn8m9LtQOCrj2/1JVXGu2h9xycx2+knFN+Zmt+jRgU+eLq/2t3
dZISWjyE1thbZpX0mwNZqCLlXkP3v8/EJVRe62DXteTZ963F+W0WZWVjk1DLgGNC
4bBpYSVrs/LQBEtntY6V27w2LLgaSptW7LuRDr+0lYQVdX9yxavPu9whmesl27jX
1J5mcDPd3fOg9rocSsLrP7TtNiaCDmIKUMDZqJEbBPNco7cxDqBbfIvfI6DMCFP9
PlPluQOaaYI8Q7RybjVwseqHiVa5Ya5ekIPAXYWPSw2/YPV0mfuzKmxSQFPxbIE1
29GpjxShibm3n3yrbuyUIRGMNPE2p6m6uTIkg3ueu0H+WkpTmokrVnf73108bEbI
BcsDBXknjXV/4j/jXSB5kP+SPP3rH3ZKOwqNY2KIb4nLIcWjjDTS2n+ae495l/Aj
xDBtbHWIqFNNxuOP6nA4aKuJUijvUgwrmKSVMJCG50slkdmIxHkc6jTe70JxyYri
UzXUvnE2XhAr7h0nuHIWjMYW/BuBxjWXBICdB5qhWdX2rTkcUdzCsNr/wvzTV/7V
8ayR7aXb2B++CBUMwfsNTaCnHb10eXTIMHj+scvZ8JdqdbPxXX5zV6ysvUjD+SzL
XBxpSWCf7RGEN+RBTiylGiOjoNHozdqetLowULWxEfDtjYv84+c=
=Z8qK
-----END PGP SIGNATURE-----

--DNLWcAMEG0eoKHvn--
