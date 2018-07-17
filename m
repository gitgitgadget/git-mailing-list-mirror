Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6306C1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 21:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbeGQWGN (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 18:06:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32899 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbeGQWGN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 18:06:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so2605534wrp.0
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 14:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cC7AuOVuwNiKHwuyJLYlF0HaLe45UURmi60WXouBAjw=;
        b=YebvmGwc7xjn1GKfJ75OrhC5fZaZryUJCPOOFXRbhE4kZbgODr4DSqjOij1LScVeRr
         ukqTK6tEBHSk390TabCsHqQi2Os+pTPWlyS5GACO9D75vqvz+5oIi2tSb4OvSHTp/itn
         YM30kfPK0IIFvcghhJOU5+Na2cIihdTfFcrygUGUzkWJp+4IoUTT0tBGpNAxHpYLhvOk
         5ctsrpyFk9XfwuX3nD5XDfFogiptnAU4PdLkcth1TGzVl8SDgSnJ31FWMzjhgtT46TGi
         jXZXlPIXxTHV7KNW0ERXLbw6i9IOk9/RAuC9BYydHa20iejeIiSonrD3SnoVLLrAMQxp
         pmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cC7AuOVuwNiKHwuyJLYlF0HaLe45UURmi60WXouBAjw=;
        b=R+3iUYklmlqWxhxD38RBYXQcaVxeGzk+KCdUbGggTuExiy5rBd6JRD1bpY3FxV60to
         24NbX51+4eDSSYqpUFaVplnepf8vDqVI3xmmYNmOPu1oodmdei2hJQ1tyTeviD9ef2Q0
         /Z7/WmrTZuvl/3Dhs07Zv9zYLgEzLBjDwGnPTqEVOyILkBR6+eMiMwbrj3UP/Y65k1YE
         1ZG3yIhwqhUCoKfx9jOFWwb5ca/CuxNnGnylz1Q8J+cmvOyMznX0ofYZOo2C3XM0PJrS
         UN32GrEf5NFkm6SnmE4sMldXYjHdnpqyEm/NkWS+V3VM7ScjbBTfTs3+9ZKdverwMme6
         K7Dg==
X-Gm-Message-State: AOUpUlEewADlqx1e/stO2Fmk67Wh8POPtenew/hK7cDxKSR8emMElmtG
        R+fgN+fVDLUFHkwZYjdT0OhS79Un
X-Google-Smtp-Source: AAOMgpeAf0Xxi3T7rnzDEmy5G3i7trxsZdrbdiQlgywHEEEFGcJOwdxJN6E70X2lKfM2p6W552G23g==
X-Received: by 2002:adf:b2a7:: with SMTP id g36-v6mr2453244wrd.218.1531863098224;
        Tue, 17 Jul 2018 14:31:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s13-v6sm380168wmc.34.2018.07.17.14.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 14:31:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 7/7] gpg-interface t: extend the existing GPG tests with GPGSM
References: <cover.1531831244.git.henning.schild@siemens.com>
        <cover.1531831244.git.henning.schild@siemens.com>
        <74d979ec0779b60d04e5dc7d2351783451e30eb4.1531831244.git.henning.schild@siemens.com>
Date:   Tue, 17 Jul 2018 14:31:36 -0700
In-Reply-To: <74d979ec0779b60d04e5dc7d2351783451e30eb4.1531831244.git.henning.schild@siemens.com>
        (Henning Schild's message of "Tue, 17 Jul 2018 14:50:13 +0200")
Message-ID: <xmqqefg1mtvr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index a5d3b2cba..3fe02876c 100755
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -38,7 +38,33 @@ then
>  			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
>  		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null 2>&1 \
>  			--sign -u committer@example.com &&
> -		test_set_prereq GPG
> +		test_set_prereq GPG &&

We do not mind making GPGSM dependent on GPG, hence this && is justified.

> +		# Available key info:
> +		# * see t/lib-gpg/gpgsm-gen-key.in
> +		# To generate new certificate:
> +		#  * no passphrase
> +		#	gpgsm --homedir /tmp/gpghome/ \
> +		#		-o /tmp/gpgsm.crt.user \
> +		#		--generate-key \
> +		#		--batch t/lib-gpg/gpgsm-gen-key.in
> +		# To import certificate:
> +		#	gpgsm --homedir /tmp/gpghome/ \
> +		#		--import /tmp/gpgsm.crt.user
> +		# To export into a .p12 we can later import:
> +		#	gpgsm --homedir /tmp/gpghome/ \
> +		#		-o t/lib-gpg/gpgsm_cert.p12 \
> +		#		--export-secret-key-p12 "committer@example.com"
> +		echo | gpgsm --homedir "${GNUPGHOME}" 2>/dev/null \
> +			--passphrase-fd 0 --pinentry-mode loopback \
> +			--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
> +		gpgsm --homedir "${GNUPGHOME}" 2>/dev/null -K \
> +			| grep fingerprint: | cut -d" " -f4 | tr -d '\n' > \
> +			${GNUPGHOME}/trustlist.txt &&
> +		echo " S relax" >> ${GNUPGHOME}/trustlist.txt &&
> +		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
> +		echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
> +			-u committer@example.com -o /dev/null --sign - 2>&1 &&
> +		test_set_prereq GPGSM

And when any of the above fails, we refrain from setting GPGSM
prereq.  Otherwise we are prepared to perform tests with gpgsm
and get the prereq.

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 25b1f8cc7..f57781e39 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1556,12 +1556,28 @@ test_expect_success GPG 'setup signed branch' '
>  	git commit -S -m signed_commit
>  '
>  
> +test_expect_success GPGSM 'setup signed branch x509' '
> +	test_when_finished "git reset --hard && git checkout master" &&
> +	git checkout -b signed-x509 master &&
> +	echo foo >foo &&
> +	git add foo &&
> +	test_config gpg.format x509 &&
> +	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
> +	git commit -S -m signed_commit
> +'

OK.

> +test_expect_success GPGSM 'log --graph --show-signature x509' '
> +	git log --graph --show-signature -n1 signed-x509 >actual &&
> +	grep "^| gpgsm: Signature made" actual &&
> +	grep "^| gpgsm: Good signature" actual
> +'

OK.

> @@ -1581,6 +1597,29 @@ test_expect_success GPG 'log --graph --show-signature for merged tag' '
>  	grep "^| | gpg: Good signature" actual
>  '
>  
> +test_expect_success GPGSM 'log --graph --show-signature for merged tag x509' '
> +	test_when_finished "git reset --hard && git checkout master" &&
> +	test_config gpg.format x509 &&
> +	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
> +	git checkout -b plain-x509 master &&
> +	echo aaa >bar &&
> +	git add bar &&
> +	git commit -m bar_commit &&
> +	git checkout -b tagged-x509 master &&
> +	echo bbb >baz &&
> +	git add baz &&
> +	git commit -m baz_commit &&
> +	git tag -s -m signed_tag_msg signed_tag_x509 &&
> +	git checkout plain-x509 &&
> +	git merge --no-ff -m msg signed_tag_x509 &&
> +	git log --graph --show-signature -n1 plain-x509 >actual &&
> +	grep "^|\\\  merged tag" actual &&
> +	grep "^| | gpgsm: Signature made" actual &&
> +	grep "^| | gpgsm: Good signature" actual &&
> +	git config --unset gpg.format &&
> +	git config --unset user.signingkey

You are using test_config early enough in this test; doesn't that
take care of the last two steps for you, even when an earlier step
failed?  If that is the case, then remove the last two line (and &&
at the end of the line before).

> diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
> index 1cea758f7..a3a12bd05 100755
> --- a/t/t5534-push-signed.sh
> +++ b/t/t5534-push-signed.sh
> @@ -218,4 +218,56 @@ test_expect_success GPG 'fail without key and heed user.signingkey' '
>  	test_cmp expect dst/push-cert-status
>  '
>  
> +test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
> +	test_config gpg.format x509 &&
> +	env | grep GIT > envfile &&

The "envfile" is unused, no?  Remove this line.

> +	prepare_dst &&
> +	mkdir -p dst/.git/hooks &&
> +	git -C dst config receive.certnonceseed sekrit &&
> +	write_script dst/.git/hooks/post-receive <<-\EOF &&
> +	# discard the update list
> +	cat >/dev/null
> +	# record the push certificate
> +	if test -n "${GIT_PUSH_CERT-}"
> +	then
> +		git cat-file blob $GIT_PUSH_CERT >../push-cert
> +	fi &&
> +
> +	cat >../push-cert-status <<E_O_F
> +	SIGNER=${GIT_PUSH_CERT_SIGNER-nobody}
> +	KEY=${GIT_PUSH_CERT_KEY-nokey}
> +	STATUS=${GIT_PUSH_CERT_STATUS-nostatus}
> +	NONCE_STATUS=${GIT_PUSH_CERT_NONCE_STATUS-nononcestatus}
> +	NONCE=${GIT_PUSH_CERT_NONCE-nononce}
> +	E_O_F
> +
> +	EOF

OK, so up to this are what is done by post-receive, including the
overwriting of ../push-cert (which is one level above the receiving
repository's .git/, i.e. dst/push-cert) and ../push-cert-status.

> +	unset GIT_COMMITTER_EMAIL &&
> +	git config user.email hasnokey@nowhere.com &&
> +	git config user.signingkey "" &&
> +	test_must_fail git push --signed dst noop ff +noff &&

This is OK for a test that is known to be always at the end, but
also forbids others to further update this script to add more tests
at the end, as the standard setting of environment is blown away
(the config is probably OK, but test_config to arrange them to be
cleaned up would have been nicer), which is not very nice.  I think
it should be easy to fix it when it becomes necessary, but at the
same time if it is easy to fix, then probably we shouldn't introduce
a breakage in the first place, so I am on the fence.

> +	git config user.signingkey committer@example.com &&
> +	git push --signed dst noop ff +noff &&

So,... this is run without resetting user.email and demonstrates
that signingkey is the only thing that matters, which makes sense.

> +	(
> +		cat <<-\EOF &&
> +		SIGNER=/CN=C O Mitter/O=Example/SN=C O/GN=Mitter
> +		KEY=
> +		STATUS=G
> +		NONCE_STATUS=OK
> +		EOF
> +		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
> +	) >expect.in &&
> +	key=$(cat "${GNUPGHOME}/trustlist.txt" | cut -d" " -f1 | tr -d ":") &&
> +	sed -e "s/^KEY=/KEY=${key}/" expect.in > expect &&

s/> expect/>expect/;

> +	noop=$(git rev-parse noop) &&
> +	ff=$(git rev-parse ff) &&
> +	noff=$(git rev-parse noff) &&
> +	grep "$noop $ff refs/heads/ff" dst/push-cert &&
> +	grep "$noop $noff refs/heads/noff" dst/push-cert &&
> +	test_cmp expect dst/push-cert-status
> +'
> +
> +
>  test_done
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index d7b319e91..2147938aa 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1354,6 +1354,19 @@ test_expect_success GPG \
>  	'test_config gpg.program echo &&
>  	 test_must_fail git tag -s -m tail tag-gpg-failure'
>  
> +# try to sign with bad user.signingkey
> +test_expect_success GPGSM \
> +	'git tag -s fails if gpgsm is misconfigured (bad key)' \
> +	'test_config user.signingkey BobTheMouse &&
> +	 test_config gpg.format x509 &&
> +	 test_must_fail git tag -s -m tail tag-gpg-failure'
> +
> +# try to produce invalid signature
> +test_expect_success GPGSM \
> +	'git tag -s fails if gpgsm is misconfigured (bad signature format)' \
> +	'test_config gpg.x509.program echo &&
> +	 test_config gpg.format x509 &&
> +	 test_must_fail git tag -s -m tail tag-gpg-failure'

I can see that it is a gpgsm parallel of the earlier test we can see
in the precontext of this hunk done for gpg, but how does the last
one (and the original this one was modeled after) fail?

We say "echo" is the program that signs for the chosen format, "tag
-s" tries to run "echo" instead of "gpgsm" with "--status-fd=2
-bsau" or whatever args we usually give, and...?

I would guess you would either get "I don't know what you wanted me
to do with --status-fd=2 option, I am erroring out" from "echo", or
the "echo" command exiting without consuming any input, causing the
feeder in "tag -s" to get SIGPIPE (or write(2) error), but the latter
happens only when the payload to be signed is large enough.  On a
platform whose "echo" pays no attention to unknown option, "echo"
itself may not even error out.  And then we try to read from "echo"
and we do not get anything (which is expected).  

And then who in "git tag -s" notice the breakage?

	... goes and looks at gpg-interface.c::sign_buffer() ...

Ah, we check the status-fd output for "[GnuPG:] SIG_CREATED", which
would never happen if we are talking to "echo".  OK, that is how
this thing is expected to fail.

What I have been getting at is if this is really trying to trigger
the "(bad signature format)" breakage.  The test uses a wrong
program to simulate the case where a configured gpg/gpgsm failed to
report "SIG_CREATED".  "bad signature format" does not sound exactly 
like that, but you inherited the badness from the original, so let's
leave it as is.

Thanks.  Modulo a few nits I pointed out above, buried in all the
other good bits, this looks reasonable to me.

