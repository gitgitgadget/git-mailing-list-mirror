Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CDAC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E75B61377
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhGNULa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:11:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60753 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242650AbhGNUJz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:09:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9E63DF4B2;
        Wed, 14 Jul 2021 16:07:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0pyoHrD9EP0gMaxNuc9zkGQ+jNX28BGWWJqg6A
        /Cs4Q=; b=jWrICCdxCsz/dCwdd92sKh/eb+QP85Efq/fn3cnCw9uysYzRLComEf
        /ZtcvruTYbv6T/Np5T92eg/gtSi+jop98lg8w95wp1PsNtElThl2NjdrF/rppki9
        HNH2kuzUIwG4XSfWAbB/I1SUiMdHbljiEEEaypK8gG2PYkqY1Tbfg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1856DF4B1;
        Wed, 14 Jul 2021 16:07:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1761EDF4B0;
        Wed, 14 Jul 2021 16:07:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/9] ssh signing: add documentation
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
        <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
        <2f8452f6570b1811682863441020a6e43fc556c7.1626264613.git.gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:07:01 -0700
In-Reply-To: <2f8452f6570b1811682863441020a6e43fc556c7.1626264613.git.gitgitgadget@gmail.com>
        (Fabian Stelzer via GitGitGadget's message of "Wed, 14 Jul 2021
        12:10:06 +0000")
Message-ID: <xmqq35sgwtga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D8DAE3C-E4DF-11EB-88C8-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Fabian Stelzer <fs@gigacodes.de>
>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
>  Documentation/config/gpg.txt  | 35 +++++++++++++++++++++++++++++++++--
>  Documentation/config/user.txt |  6 ++++++
>  2 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
> index d94025cb368..16af0b0ada8 100644
> --- a/Documentation/config/gpg.txt
> +++ b/Documentation/config/gpg.txt
> @@ -11,13 +11,13 @@ gpg.program::
>  
>  gpg.format::
>  	Specifies which key format to use when signing with `--gpg-sign`.
> -	Default is "openpgp" and another possible value is "x509".
> +	Default is "openpgp". Other possible values are "x509", "ssh".

Makes sense.

>  gpg.<format>.program::
>  	Use this to customize the program used for the signing format you
>  	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
>  	be used as a legacy synonym for `gpg.openpgp.program`. The default
> -	value for `gpg.x509.program` is "gpgsm".
> +	value for `gpg.x509.program` is "gpgsm" and `gpg.ssh.program` is "ssh-keygen".

Again, makes sense.

Once the dust settles, we might want to move the hierarchy from
gpg.* to a more neutral name, with proper backward compatibility
migration plan, but there is no need to do so right away.

Below, I'll ask many questions.  They are mostly not rhetorical and
questions that you should anticipate readers of the documentation
will ask (hence, you would want to update your documentation in such
a way that future readers will not have to ask for clarification).

> @@ -33,3 +33,34 @@ gpg.minTrustLevel::
>  * `marginal`
>  * `fully`
>  * `ultimate`
> +
> +gpg.ssh.keyring::
> +	A file containing all valid SSH public signing keys.

Is "SSH public signing key" the phrase we want to use here?  At
first glance I mistakenly thought that I maintain a bag of my keys I
will use for signing, but from the mention of "authorized keys", it
apparently is the other way around, i.e. I have a bag of public keys
that I can use to _verify_ signatures other people made.

What do we exactly want to convey with the phrase "all valid" to our
readers?  Even if I have a valid SSH key that I could sign with, if
you and your project do not trust me enough, such a valid key of
mine would not be in your keyring, so the phrase "all valid keys" is
not all that meaningful without further qualification in the context
of this sentence.  A file containing ssh public keys, signatures
made with which you are willing to accept, or something?

> +	Similar to an .ssh/authorized_keys file.

It is unclear what "similarity" is of interest here.  Similar to
authorized keys file, meaning that presense of this file allows
holders of the listed ssh keys to remotely log-in to the repository?
I somehow doubt that it is what you meant, but then ...?  Did you
mean "Uses the same format as .ssh/authorized_keys file" or
something like that?

> +	See ssh-keygen(1) "ALLOWED SIGNERS" for details.
> +	If a signing key is found in this file then the trust level will
> +	be set to "fully". Otherwise if the key is not present
> +	but the signature is still valid then the trust level will be "undefined".

I tried to look up the "ALLOWED SIGNERS" section for details, but
failed to find what "trust level" is and how trusted "fully" level
is (is there higher or lower trust levels than that???).  Or is the
notion of "trust level" foreign to ssh signing world and the readers
are expected to read this description as "listed ones are treated as
having the same trust level as 'fully' trusted keys in the GPG/PGP
world"?

I suspect that the section is only useful to learn the details of
what the file looks like?  If so, perhaps instead of saying that the
keyring file looks similar to authorized-keys, be more direct and
say that the keyring file uses the "ALLOWED SIGNERS" file format
described in that manual page (i.e. bypassing the redirection of
authorized-keys)?

> +	This file can be set to a location outside of the repository
> +	and every developer maintains their own trust store.
> +	A central repository server could generate this file automatically
> +	from ssh keys with push	access to verify the code against.
> +	In a corporate setting this file is probably generated at a global location
> +	from some automation that already handles developer ssh keys.

OK.

> +	A repository that is only allowing signed commits can store the file

"is only allowing" -> "only allows".

> +	in the repository itself using a relative path.

It is unclear relative to what.  Relative to the top-level of the
working tree?

> +	This way only committers
> +	with an already valid key can add or change keys in the keyring.

OK.

> +	Using a SSH CA key with the cert-authority option
> +	(see ssh-keygen(1) "CERTIFICATES") is also valid.
> +
> +	To revoke a key place the public key without the principal into the
> +	revocationKeyring.

All of the above unfortunately would not format correctly with
multiple paragraphs.  The second and subsequent paragraphs are
preceded by a line with single '+' on it (instead of a blank line)
and not indented.

Mimick the way the entry for "ssh.variant" uses multiple paragraphs.

> +gpg.ssh.revocationKeyring::
> +	Either a SSH KRL or a list of revoked public keys (without the principal prefix).
> +	See ssh-keygen(1) for details.
> +	If a public key is found in this file then it will always be treated
> +	as having trust level "never" and signatures will show as invalid.
> diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
> index 59aec7c3aed..b3c2f2c541e 100644
> --- a/Documentation/config/user.txt
> +++ b/Documentation/config/user.txt
> @@ -36,3 +36,9 @@ user.signingKey::
>  	commit, you can override the default selection with this variable.
>  	This option is passed unchanged to gpg's --local-user parameter,
>  	so you may specify a key using any method that gpg supports.
> +	If gpg.format is set to "ssh" this can contain the literal ssh public
> +	key (e.g.: "ssh-rsa XXXXXX identifier") or a file which contains it and
> +	corresponds to the private key used for signing. The private key
> +	needs to be available via ssh-agent. Alternatively it can be set to
> +	a file containing a private key directly. If not set git will call
> +	"ssh-add -L" and try to use the first key available.

Thanks.
