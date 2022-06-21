Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DB5C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 00:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbiFUAL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 20:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiFUAL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 20:11:28 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA4B639F
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 17:11:26 -0700 (PDT)
Received: from camp.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 297295A0E9;
        Tue, 21 Jun 2022 00:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1655770285;
        bh=0ZVRxfXpkPbhRIJOkpNGXcZWxwXocAIZVqe7OcpYrng=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=WI3q+PBsc42aYKyRSImyYiX5xU/zt43ICDRKdr2rLpfKpRcrD0FVMqZz7G2O+tqTd
         raCaAF05Zpfyi8mhPAKjVjIgyTOO05wACZeD3zp81lWRCYydrSKOz0T73oAaZwsoCd
         IEsByhfkFO4ldfsGXi87ITc7yUIW5zQegjVWRFRFfwUsVHnM471e+GYzWJzIdqMk3I
         NN2KJJKAKzeloVp1f7E2IMi6QVlxraWvFV4aj/1M/3g2duDMZfCgnlrKijMJr015/L
         3c7IIEhrCwPoAFaGYTtdEIwu1OXjhCop/4yEsk/RZV77/ZLl97mwm8fZRVHfFSFVWq
         yhre1UDULf1SpwbuXK3BwUg1H6KPGzxTXZiVzQqpORrqVfz9Gyt7WkwqCrtM19PtkM
         Qd8mI0rI36TbhB2ZKc/g7bwsPWujjrA6365mfQXKr8BV0tIvXJQ7LswNUva5E0s8xy
         SMKTU2/Lb7XqlnZcw7rT31wy9OEDSnDnsWoF34yNUv6IGq2BnPX
Date:   Tue, 21 Jun 2022 00:11:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stewart Smith <trawets@amazon.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] git-send-email: Add --no-validate-email option
Message-ID: <YrEMq+slLOHqw/hz@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stewart Smith <trawets@amazon.com>, git@vger.kernel.org,
        Todd Zullinger <tmz@pobox.com>
References: <20220620004427.3586240-1-trawets@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yEDNVYYQFdhfRwGN"
Content-Disposition: inline
In-Reply-To: <20220620004427.3586240-1-trawets@amazon.com>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yEDNVYYQFdhfRwGN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-20 at 00:44:27, Stewart Smith wrote:
> The perl Email::Valid module gets things right, but this may not always
> be what you want, as can be seen in
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2046203

You should explain this in the body of the message, since we generally
want to know the rationale behind the change even if RedHat moves away
=66rom Bugzilla in the future.

You could say something like this:

  The Perl Email::Valid module correctly checks whether an email address
  is syntactically valid.  However, in some cases, people have email
  addresses which are not syntactically valid, such as those where the
  local-part is more than 64 octets, and would like to use those
  addresses despite that fact.

> So, add a --validate-email (default, current behavior) and
> the inverse --no-validate-email option to be able to skip the check
> while still having the Email::Valid perl module installed.
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2046203

I don't believe we generally include Fixes headers for external bugs.

> Suggested-by: Todd Zullinger <tmz@pobox.com>
> Signed-off-by: Stewart Smith <trawets@amazon.com>
> ---
>  git-send-email.perl   | 9 +++++++++
>  t/t9902-completion.sh | 1 +
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 5861e99a6e..c75b08f9ce 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -103,6 +103,7 @@ sub usage {
>      --quiet                        * Output one line of info per email.
>      --dry-run                      * Don't actually send the emails.
>      --[no-]validate                * Perform patch sanity checks. Defaul=
t on.
> +    --[no-]validate-email          * Perform email address sanity checks=
=2E Default on.
>      --[no-]format-patch            * understand any non optional argumen=
ts as
>                                       `git format-patch` ones.
>      --force                        * Send even if safety checks would pr=
event it.
> @@ -281,6 +282,7 @@ sub do_edit {
>  my $chain_reply_to =3D 0;
>  my $use_xmailer =3D 1;
>  my $validate =3D 1;
> +my $validate_email =3D 1;
>  my $target_xfer_encoding =3D 'auto';
>  my $forbid_sendmail_variables =3D 1;
> =20
> @@ -293,6 +295,7 @@ sub do_edit {
>      "tocover" =3D> \$cover_to,
>      "signedoffcc" =3D> \$signed_off_by_cc,
>      "validate" =3D> \$validate,
> +    "validateemail" =3D> \$validate_email,
>      "multiedit" =3D> \$multiedit,
>      "annotate" =3D> \$annotate,
>      "xmailer" =3D> \$use_xmailer,
> @@ -531,6 +534,8 @@ sub config_regexp {
>  		    "no-thread" =3D> sub {$thread =3D 0},
>  		    "validate!" =3D> \$validate,
>  		    "no-validate" =3D> sub {$validate =3D 0},
> +		    "validate-email!" =3D> \$validate_email,
> +		    "no-validate-email" =3D> sub {$validate_email =3D 0},
>  		    "transfer-encoding=3Ds" =3D> \$target_xfer_encoding,
>  		    "format-patch!" =3D> \$format_patch,
>  		    "no-format-patch" =3D> sub {$format_patch =3D 0},
> @@ -1132,6 +1137,10 @@ sub extract_valid_address {
>  	# check for a local address:
>  	return $address if ($address =3D~ /^($local_part_regexp)$/);
> =20
> +	# Email::Valid isn't always correct, so support a way to bypass
> +	# See https://bugzilla.redhat.com/show_bug.cgi?id=3D2046203

Email::Valid is in fact correct.  However, the email which you want to
use doesn't conform to the RFC and isn't valid.  So this should probably
say something like, "Allow people to use an email address which is not
valid according to the RFCs if the server accepts it."

I think this patch would be fine as it stands with those changes. Unlike
=C3=86var, I don't think we should get rid of Email::Valid, just like I don=
't
think we should get rid of the transfer encoding checks.  I support
warning people before sending invalid emails, especially since I believe
the address in question would not be deliverable through some mail
servers (such as mine).
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--yEDNVYYQFdhfRwGN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYrEMqgAKCRB8DEliiIei
gcIzAP4rTf4NMnPzt8hNCxDNKuqMd9NrySwshGL7LVQ7ntP0rwEApbBzjW7SokSj
Mve1SUtZ8a1nnoU6NUGg5zmdD/3BTw0=
=rYEp
-----END PGP SIGNATURE-----

--yEDNVYYQFdhfRwGN--
