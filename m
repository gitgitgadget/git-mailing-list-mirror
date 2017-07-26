Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8917A2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 16:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751022AbdGZQwd (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 12:52:33 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36437 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbdGZQwc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 12:52:32 -0400
Received: by mail-wm0-f43.google.com with SMTP id t201so78117800wmt.1
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Hnjfc283Y/fOEwFF7LKy2XpDulZ4T24ovbBrW7cji3A=;
        b=CiAz9iq8+mYmqwA6H8XG7AYzkP8kJWb6EX72i1QFvyTiSuo9l3WXhSAQDOuQVWLCXy
         sMYi6s5DqRLpZ/eRf+p+FHovZz+1X6NQSgQ4YEDa5iAlQ6KCoYlE61qry0TQ8qDEwB2O
         5qpOUrziUXFzQ6nKVzic6TOCQhi0uiVzW2PPaMiAiUrSRCqGDpZLmnKPiHDCRFrbLcv8
         0OEsX41HiWZAVOEP5tVs2+/1IxLDawd8XmvD2v9wfLkKfAxVIQjerf6tQEx3ixnIkBe4
         MUnM8NH7Kgyacihce83m33JXCq2fZkvut8i6e9+Bz18hFMe9TagUb7cWt8Imt7+x7lBV
         jzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Hnjfc283Y/fOEwFF7LKy2XpDulZ4T24ovbBrW7cji3A=;
        b=WsC4OF9GCgqzRQjK4YrijMSMN4nGDEXpX/jnIlSMrM7SqEX1NwpV8o7iYtVbGLfjm5
         ZNYxxjK3cjq1vykSVhywStEXddnV2aktmS4GmwuhZ6IZO4pY0n/xYnZqs3p0+mkVEITG
         nO5Ml/YVFeogstCzeEH3YklBSi1doNoEqsjHQXx5dAqccwH72fsTcjYb7gOKu2XKxDFw
         XL6Ka5AnN1TKLfyOw9/HLEYy9R39Vu5reaZg1e2QLoKBkIeu8mLmLENQC9IPn+SC4ekZ
         BEtMDBM1sA1g2VpTp09mreIKdQKG3n8s+AQYi1M8EuHtj07D1ZjXm4FxhOhK0Yj0zMuv
         D/qQ==
X-Gm-Message-State: AIVw111z1m37tLQstzrRK7cmWZUPgo5jNs4ci44DrwK7fOdGHtzitSHa
        6Pl8yIF9ODmIhA==
X-Received: by 10.28.9.19 with SMTP id 19mr1253311wmj.61.1501087951154;
        Wed, 26 Jul 2017 09:52:31 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id i26sm13126350wmc.34.2017.07.26.09.52.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jul 2017 09:52:30 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] sub-process: refactor handshake to common function
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170724213810.29831-1-jonathantanmy@google.com>
Date:   Wed, 26 Jul 2017 18:52:29 +0200
Cc:     git@vger.kernel.org, benpeart@microsoft.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB54F0E5-E555-40BF-8AA7-7CB3174FE22C@gmail.com>
References: <20170724213810.29831-1-jonathantanmy@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 24 Jul 2017, at 23:38, Jonathan Tan <jonathantanmy@google.com> =
wrote:
>=20
> Refactor, into a common function, the version and capability =
negotiation
> done when invoking a long-running process as a clean or smudge filter.
> This will be useful for other Git code that needs to interact =
similarly
> with a long-running process.
>=20
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This will be useful for anyone implementing functionality like that in
> [1].
>=20
> It is unfortunate that the code grew larger because it had to be more
> generic, but I think this is better than having (in the future) 2 or
> more separate handshake functions.
>=20
> I also don't think that the protocol should be permissive - I think
> things would be simpler if all protocol errors were fatal errors. As =
it
> is, most parts are permissive, but packet_read_line() already dies
> anyway upon a malformed packet, so it may not be too drastic a change =
to
> change this. For reference, the original protocol comes from [2].
>=20
> [1] =
https://public-inbox.org/git/20170714132651.170708-2-benpeart@microsoft.co=
m/
> [2] edcc858 ("convert: add filter.<driver>.process option", =
2016-10-17)

Thanks for this refactoring! That's great!

Please note that I've recently refactored the capabilities negotiation a =
bit:
=
https://github.com/git/git/commit/1514c8edd62d96006cd1de31e906ed5798dd4681=


This change is still cooking in `next`. I am not sure how this =
should/could
be handled but maybe you can use my refactoring as your base?

Thanks,
Lars


> ---
> convert.c             | 61 ++++-----------------------------
> pkt-line.c            | 19 -----------
> pkt-line.h            |  2 --
> sub-process.c         | 94 =
+++++++++++++++++++++++++++++++++++++++++++++++++++
> sub-process.h         | 18 ++++++++++
> t/t0021-conversion.sh |  2 +-
> 6 files changed, 120 insertions(+), 76 deletions(-)
>=20
> diff --git a/convert.c b/convert.c
> index deaf0ba7b..ec8ecc2ea 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -512,62 +512,15 @@ static struct hashmap subprocess_map;
>=20
> static int start_multi_file_filter_fn(struct subprocess_entry =
*subprocess)
> {
> -	int err;
> +	static int versions[] =3D {2, 0};
> +	static struct subprocess_capability capabilities[] =3D {
> +		{"clean", CAP_CLEAN}, {"smudge", CAP_SMUDGE}, {NULL, 0}
> +	};
> 	struct cmd2process *entry =3D (struct cmd2process *)subprocess;
> -	struct string_list cap_list =3D STRING_LIST_INIT_NODUP;
> -	char *cap_buf;
> -	const char *cap_name;
> -	struct child_process *process =3D &subprocess->process;
> -	const char *cmd =3D subprocess->cmd;
> -
> -	sigchain_push(SIGPIPE, SIG_IGN);
> -
> -	err =3D packet_writel(process->in, "git-filter-client", =
"version=3D2", NULL);
> -	if (err)
> -		goto done;
> -
> -	err =3D strcmp(packet_read_line(process->out, NULL), =
"git-filter-server");
> -	if (err) {
> -		error("external filter '%s' does not support filter =
protocol version 2", cmd);
> -		goto done;
> -	}
> -	err =3D strcmp(packet_read_line(process->out, NULL), =
"version=3D2");
> -	if (err)
> -		goto done;
> -	err =3D packet_read_line(process->out, NULL) !=3D NULL;
> -	if (err)
> -		goto done;
> -
> -	err =3D packet_writel(process->in, "capability=3Dclean", =
"capability=3Dsmudge", NULL);
> -
> -	for (;;) {
> -		cap_buf =3D packet_read_line(process->out, NULL);
> -		if (!cap_buf)
> -			break;
> -		string_list_split_in_place(&cap_list, cap_buf, '=3D', =
1);
> -
> -		if (cap_list.nr !=3D 2 || =
strcmp(cap_list.items[0].string, "capability"))
> -			continue;
> -
> -		cap_name =3D cap_list.items[1].string;
> -		if (!strcmp(cap_name, "clean")) {
> -			entry->supported_capabilities |=3D CAP_CLEAN;
> -		} else if (!strcmp(cap_name, "smudge")) {
> -			entry->supported_capabilities |=3D CAP_SMUDGE;
> -		} else {
> -			warning(
> -				"external filter '%s' requested =
unsupported filter capability '%s'",
> -				cmd, cap_name
> -			);
> -		}
> -
> -		string_list_clear(&cap_list, 0);
> -	}
> -
> -done:
> -	sigchain_pop(SIGPIPE);
>=20
> -	return err;
> +	return subprocess_handshake(subprocess, "git-filter-", versions, =
NULL,
> +				    capabilities,
> +				    &entry->supported_capabilities);
> }
>=20
> static int apply_multi_file_filter(const char *path, const char *src, =
size_t len,
> diff --git a/pkt-line.c b/pkt-line.c
> index 9d845ecc3..7db911957 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -171,25 +171,6 @@ int packet_write_fmt_gently(int fd, const char =
*fmt, ...)
> 	return status;
> }
>=20
> -int packet_writel(int fd, const char *line, ...)
> -{
> -	va_list args;
> -	int err;
> -	va_start(args, line);
> -	for (;;) {
> -		if (!line)
> -			break;
> -		if (strlen(line) > LARGE_PACKET_DATA_MAX)
> -			return -1;
> -		err =3D packet_write_fmt_gently(fd, "%s\n", line);
> -		if (err)
> -			return err;
> -		line =3D va_arg(args, const char*);
> -	}
> -	va_end(args);
> -	return packet_flush_gently(fd);
> -}
> -
> static int packet_write_gently(const int fd_out, const char *buf, =
size_t size)
> {
> 	static char packet_write_buffer[LARGE_PACKET_MAX];
> diff --git a/pkt-line.h b/pkt-line.h
> index 450183b64..66ef610fc 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -25,8 +25,6 @@ void packet_buf_flush(struct strbuf *buf);
> void packet_buf_write(struct strbuf *buf, const char *fmt, ...) =
__attribute__((format (printf, 2, 3)));
> int packet_flush_gently(int fd);
> int packet_write_fmt_gently(int fd, const char *fmt, ...) =
__attribute__((format (printf, 2, 3)));
> -LAST_ARG_MUST_BE_NULL
> -int packet_writel(int fd, const char *line, ...);
> int write_packetized_from_fd(int fd_in, int fd_out);
> int write_packetized_from_buf(const char *src_in, size_t len, int =
fd_out);
>=20
> diff --git a/sub-process.c b/sub-process.c
> index a3cfab1a9..1a3f39bdf 100644
> --- a/sub-process.c
> +++ b/sub-process.c
> @@ -105,3 +105,97 @@ int subprocess_start(struct hashmap *hashmap, =
struct subprocess_entry *entry, co
> 	hashmap_add(hashmap, entry);
> 	return 0;
> }
> +
> +int subprocess_handshake(struct subprocess_entry *entry,
> +			 const char *welcome_prefix,
> +			 int *versions,
> +			 int *chosen_version,
> +			 struct subprocess_capability *capabilities,
> +			 unsigned int *supported_capabilities) {
> +	int version_scratch;
> +	unsigned int capabilities_scratch;
> +	struct child_process *process =3D &entry->process;
> +	int i;
> +	char *line;
> +	const char *p;
> +
> +	if (!chosen_version)
> +		chosen_version =3D &version_scratch;
> +	if (!supported_capabilities)
> +		supported_capabilities =3D &capabilities_scratch;
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
> +	if (packet_write_fmt_gently(process->in, "%sclient\n",
> +				    welcome_prefix)) {
> +		error("Could not write client identification");
> +		goto error;
> +	}
> +	for (i =3D 0; versions[i]; i++) {
> +		if (packet_write_fmt_gently(process->in, "version=3D%d\n",=

> +					    versions[i])) {
> +			error("Could not write requested version");
> +			goto error;
> +		}
> +	}
> +	if (packet_flush_gently(process->in))
> +		goto error;
> +
> +	if (!(line =3D packet_read_line(process->out, NULL)) ||
> +	    !skip_prefix(line, welcome_prefix, &p) ||
> +	    strcmp(p, "server")) {
> +		error("Unexpected line '%s', expected %sserver",
> +		      line ? line : "<flush packet>", welcome_prefix);
> +		goto error;
> +	}
> +	if (!(line =3D packet_read_line(process->out, NULL)) ||
> +	    !skip_prefix(line, "version=3D", &p) ||
> +	    strtol_i(p, 10, chosen_version)) {
> +		error("Unexpected line '%s', expected version",
> +		      line ? line : "<flush packet>");
> +		goto error;
> +	}
> +	for (i =3D 0; versions[i]; i++) {
> +		if (versions[i] =3D=3D *chosen_version)
> +			goto version_found;
> +	}
> +	error("Version %d not supported", *chosen_version);
> +	goto error;
> +version_found:
> +	if ((line =3D packet_read_line(process->out, NULL))) {
> +		error("Unexpected line '%s', expected flush", line);
> +		goto error;
> +	}
> +
> +	for (i =3D 0; capabilities[i].name; i++) {
> +		if (packet_write_fmt_gently(process->in, =
"capability=3D%s\n",
> +					    capabilities[i].name)) {
> +			error("Could not write requested capability");
> +			goto error;
> +		}
> +	}
> +	if (packet_flush_gently(process->in))
> +		goto error;
> +
> +	while ((line =3D packet_read_line(process->out, NULL))) {
> +		if (!skip_prefix(line, "capability=3D", &p))
> +			continue;
> +
> +		for (i =3D 0; capabilities[i].name; i++) {
> +			if (!strcmp(p, capabilities[i].name)) {
> +				*supported_capabilities |=3D =
capabilities[i].flag;
> +				goto capability_found;
> +			}
> +		}
> +		warning("external filter requested unsupported filter =
capability '%s'",
> +			p);
> +capability_found:
> +		;
> +	}
> +
> +	sigchain_pop(SIGPIPE);
> +	return 0;
> +error:
> +	sigchain_pop(SIGPIPE);
> +	return 1;
> +}
> diff --git a/sub-process.h b/sub-process.h
> index 96a2cca36..a72e7f7cf 100644
> --- a/sub-process.h
> +++ b/sub-process.h
> @@ -18,6 +18,11 @@ struct subprocess_entry {
> 	struct child_process process;
> };
>=20
> +struct subprocess_capability {
> +	const char *name;
> +	unsigned int flag;
> +};
> +
> /* subprocess functions */
>=20
> extern int cmd2process_cmp(const void *unused_cmp_data,
> @@ -41,6 +46,19 @@ static inline struct child_process =
*subprocess_get_child_process(
> 	return &entry->process;
> }
>=20
> +/*
> + * Perform the handshake to a long-running process as described in =
the
> + * gitattributes documentation using the given requested versions and
> + * capabilities. The "versions" and "capabilities" parameters are =
arrays
> + * terminated by a 0 or blank struct.
> + */
> +int subprocess_handshake(struct subprocess_entry *entry,
> +			 const char *welcome_prefix,
> +			 int *versions,
> +			 int *chosen_version,
> +			 struct subprocess_capability *capabilities,
> +			 unsigned int *supported_capabilities);
> +
> /*
>  * Helper function that will read packets looking for "status=3D<foo>"
>  * key/value pairs and return the value from the last "status" packet
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 161f56044..d191a7228 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -697,7 +697,7 @@ test_expect_success PERL 'invalid process filter =
must fail (and not hang!)' '
>=20
> 		cp "$TEST_ROOT/test.o" test.r &&
> 		test_must_fail git add . 2>git-stderr.log &&
> -		grep "does not support filter protocol version" =
git-stderr.log
> +		grep "expected git-filter-server" git-stderr.log
> 	)
> '
>=20
> --=20
> 2.14.0.rc0.400.g1c36432dff-goog
>=20

