Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE73F1F991
	for <e@80x24.org>; Sun,  6 Aug 2017 19:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbdHFT63 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Aug 2017 15:58:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36223 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbdHFT62 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2017 15:58:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id d40so11582269wma.3
        for <git@vger.kernel.org>; Sun, 06 Aug 2017 12:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VIX21NGb1UMurcXGuGwQMzSHN0000FelK+PWyMr39Ew=;
        b=N8bLlIorUfTif+bAy21Gyxu3WBrWtdDzpqnKT+KrTqdbRm8MVmDNw+o28Pibv9zvcb
         nK5GFDOAiSHUV9K9+VkH7BlJL4n9zF2DuD8XS09fBPacGgRaHrYn0dTXgQfNjrF3OFK0
         gQSLdMNQyjcqnLIryrwo9A+T6ZfRBHdw2tmzia7CiEk0fxrsXow+xbG6JvWzjbNRP0UY
         6Y8wCsk+G/4ykS9fNv4Vh5BB2qOvRs+hUMYl/N5Qf1ANKfp3KLGHmqoN+wvM9J6maEvE
         w5JMiK+0fQYrbp/5kEJo9X9zMWFC9chi+ZfpdPGtgUcCfBnHWP5ZG1iWbEGd1kOM7CQF
         7PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VIX21NGb1UMurcXGuGwQMzSHN0000FelK+PWyMr39Ew=;
        b=oYP3VVjEViHv2EgSuw2OO6KN8NEWHZegr+xgNH1rm1vbxcKNJjg8+BX5DN6BDk0x2w
         cu9aQ+zCqGCRzejtXdDjJzztT7HJdgRuMZwX9OOPUSHmnJW+DtY8YYEtReFCrPQY0Bc2
         RiP6f00E5ZNiT/8ZwZmtz9Mqxg1GIrXdhR92hqV3hCC0i5EAw2xyzm0WZba9cn4hFAJP
         lf9IeJPchxOzt/+rZCWSrFtI5oMwORiOWAwHBJJG/4Wo4sYvO2x6KTCUz1wn8G9r2Jlh
         RVhX/8ecyuGd0mob8JhpVXznhyhPmX2zNCdFanIQKBWROqSRYOZcn2kRNG7oXpdx8QE8
         EWCQ==
X-Gm-Message-State: AHYfb5j2GEfysHM90X/A4/YhRPALUkicX7HsfDfiZf4+u6zBwcxKcdtp
        o3gV+SvLZcp5tQ==
X-Received: by 10.28.212.10 with SMTP id l10mr5064910wmg.40.1502049506923;
        Sun, 06 Aug 2017 12:58:26 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB6221.dip0.t-ipconnect.de. [93.219.98.33])
        by smtp.gmail.com with ESMTPSA id t125sm6572867wmt.20.2017.08.06.12.58.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Aug 2017 12:58:26 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH for NEXT v3 2/2] sub-process: refactor handshake to common function
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <6327579311fdb941a11b6d452318777a3c42ee65.1501092795.git.jonathantanmy@google.com>
Date:   Sun, 6 Aug 2017 21:58:24 +0200
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <323E470B-994B-4AD8-9F30-588C2B97A845@gmail.com>
References: <cover.1501092795.git.jonathantanmy@google.com> <20170724213810.29831-1-jonathantanmy@google.com> <cover.1501092795.git.jonathantanmy@google.com> <6327579311fdb941a11b6d452318777a3c42ee65.1501092795.git.jonathantanmy@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 26 Jul 2017, at 20:17, Jonathan Tan <jonathantanmy@google.com> =
wrote:
>=20
> Refactor, into a common function, the version and capability =
negotiation
> done when invoking a long-running process as a clean or smudge filter.
> This will be useful for other Git code that needs to interact =
similarly
> with a long-running process.
>=20
> As you can see in the change to t0021, this commit changes the error
> message reported when the long-running process does not introduce =
itself
> with the expected "server"-terminated line. Originally, the error
> message reports that the filter "does not support filter protocol
> version 2", differentiating between the old single-file filter =
protocol
> and the new multi-file filter protocol - I have updated it to =
something
> more generic and useful.
>=20
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> convert.c             |  75 ++++--------------------------------
> pkt-line.c            |  19 ----------
> pkt-line.h            |   2 -
> sub-process.c         | 103 =
++++++++++++++++++++++++++++++++++++++++++++++++++
> sub-process.h         |  26 +++++++++++++
> t/t0021-conversion.sh |   2 +-
> 6 files changed, 137 insertions(+), 90 deletions(-)
>=20
> diff --git a/convert.c b/convert.c
> index dbdbb24e4..1012462e3 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -513,78 +513,17 @@ static struct hashmap subprocess_map;
>=20
> static int start_multi_file_filter_fn(struct subprocess_entry =
*subprocess)
> {
> -	int err, i;
> -	struct cmd2process *entry =3D (struct cmd2process *)subprocess;
> -	struct string_list cap_list =3D STRING_LIST_INIT_NODUP;
> -	char *cap_buf;
> -	const char *cap_name;
> -	struct child_process *process =3D &subprocess->process;
> -	const char *cmd =3D subprocess->cmd;
> -
> -	static const struct {
> -		const char *name;
> -		unsigned int cap;
> -	} known_caps[] =3D {
> +	static int versions[] =3D {2, 0};
> +	static struct subprocess_capability capabilities[] =3D {
> 		{ "clean",  CAP_CLEAN  },
> 		{ "smudge", CAP_SMUDGE },
> 		{ "delay",  CAP_DELAY  },
> +		{ NULL, 0 }
> 	};
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
> -	for (i =3D 0; i < ARRAY_SIZE(known_caps); ++i) {
> -		err =3D packet_write_fmt_gently(
> -			process->in, "capability=3D%s\n", =
known_caps[i].name);
> -		if (err)
> -			goto done;
> -	}
> -	err =3D packet_flush_gently(process->in);
> -	if (err)
> -		goto done;
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
> -		i =3D ARRAY_SIZE(known_caps) - 1;
> -		while (i >=3D 0 && strcmp(cap_name, known_caps[i].name))
> -			i--;
> -
> -		if (i >=3D 0)
> -			entry->supported_capabilities |=3D =
known_caps[i].cap;
> -		else
> -			warning("external filter '%s' requested =
unsupported filter capability '%s'",
> -			cmd, cap_name);
> -
> -		string_list_clear(&cap_list, 0);
> -	}
> -
> -done:
> -	sigchain_pop(SIGPIPE);
> -
> -	return err;
> +	struct cmd2process *entry =3D (struct cmd2process *)subprocess;
> +	return subprocess_handshake(subprocess, "git-filter", versions, =
NULL,
> +				    capabilities,
> +				    &entry->supported_capabilities);

Wouldn't it make sense to add `supported_capabilities` to `struct =
subprocess_entry` ?


> }
>=20
> static void handle_filter_error(const struct strbuf *filter_status,
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
> index 6cbffa440..37b4bd0ad 100644
> --- a/sub-process.c
> +++ b/sub-process.c
> @@ -108,3 +108,106 @@ int subprocess_start(struct hashmap *hashmap, =
struct subprocess_entry *entry, co
> 	hashmap_add(hashmap, entry);
> 	return 0;
> }
> +
> +static int handshake_version(struct child_process *process,
> +			     const char *welcome_prefix, int *versions,

Maybe it would be less ambiguous if we call it `supported_versions` ?=20


> +			     int *chosen_version)
> +{
> +	int version_scratch;
> +	int i;
> +	char *line;
> +	const char *p;
> +
> +	if (!chosen_version)
> +		chosen_version =3D &version_scratch;

I am not an C expert but wouldn't 'version_scratch' go out of scope as =
soon
as the function returns? Why don't you error here right away?


> +	if (packet_write_fmt_gently(process->in, "%s-client\n",
> +				    welcome_prefix))
> +		return error("Could not write client identification");

Nit: Would it make sense to rename `welcome_prefix` to `client_id`?
Alternatively, could we rename the error messages to "welcome prefix"?


> +	for (i =3D 0; versions[i]; i++) {
> +		if (packet_write_fmt_gently(process->in, "version=3D%d\n",=

> +					    versions[i]))
> +			return error("Could not write requested =
version");

Maybe: "Could not write supported versions"?


> +	}
> +	if (packet_flush_gently(process->in))
> +		return error("Could not write flush packet");

I feel this error is too generic.
Maybe: "Could not finish writing supported versions"?


> +
> +	if (!(line =3D packet_read_line(process->out, NULL)) ||
> +	    !skip_prefix(line, welcome_prefix, &p) ||
> +	    strcmp(p, "-server"))
> +		return error("Unexpected line '%s', expected %s-server",
> +			     line ? line : "<flush packet>", =
welcome_prefix);
> +	if (!(line =3D packet_read_line(process->out, NULL)) ||
> +	    !skip_prefix(line, "version=3D", &p) ||
> +	    strtol_i(p, 10, chosen_version))

Maybe `strlen("version=3D")` would be more clear than 10?


> +		return error("Unexpected line '%s', expected version",

Maybe "... expected version number" ?


> +			     line ? line : "<flush packet>");
> +	if ((line =3D packet_read_line(process->out, NULL)))
> +		return error("Unexpected line '%s', expected flush", =
line);
> +
> +	/* Check to make sure that the version received is supported */
> +	for (i =3D 0; versions[i]; i++) {
> +		if (versions[i] =3D=3D *chosen_version)
> +			break;
> +	}
> +	if (!versions[i])
> +		return error("Version %d not supported", =
*chosen_version);
> +
> +	return 0;
> +}
> +
> +static int handshake_capabilities(struct child_process *process,
> +				  struct subprocess_capability =
*capabilities,
> +				  unsigned int *supported_capabilities)

I feel the naming could be misleading. I think ...
`capabilities` is really `supported_capabilities`=20
and=20
`supported_capabilities` is really `negiotated_capabilties` or =
`agreed_capabilites`


> +{
> +	int i;
> +	char *line;
> +
> +	for (i =3D 0; capabilities[i].name; i++) {
> +		if (packet_write_fmt_gently(process->in, =
"capability=3D%s\n",
> +					    capabilities[i].name))
> +			return error("Could not write requested =
capability");

I think this should be "Could not write supported capability", no?


> +	}
> +	if (packet_flush_gently(process->in))
> +		return error("Could not write flush packet");

Maybe " "Could not finish writing supported capability" ?


> +	while ((line =3D packet_read_line(process->out, NULL))) {
> +		const char *p;
> +		if (!skip_prefix(line, "capability=3D", &p))
> +			continue;

Shouldn't we write an error in this case?


> +		for (i =3D 0;
> +		     capabilities[i].name && strcmp(p, =
capabilities[i].name);
> +		     i++)
> +			;
> +		if (capabilities[i].name) {
> +			if (supported_capabilities)
> +				*supported_capabilities |=3D =
capabilities[i].flag;
> +		} else {
> +			warning("external filter requested unsupported =
filter capability '%s'",
> +				p);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int subprocess_handshake(struct subprocess_entry *entry,
> +			 const char *welcome_prefix,
> +			 int *versions,
> +			 int *chosen_version,
> +			 struct subprocess_capability *capabilities,
> +			 unsigned int *supported_capabilities) {
> +	int retval;
> +	struct child_process *process =3D &entry->process;
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
> +	retval =3D handshake_version(process, welcome_prefix, versions,
> +				   chosen_version) ||
> +		 handshake_capabilities(process, capabilities,
> +					supported_capabilities);
> +
> +	sigchain_pop(SIGPIPE);
> +	return retval;
> +}
> diff --git a/sub-process.h b/sub-process.h
> index d37c1499a..6857eb1b5 100644
> --- a/sub-process.h
> +++ b/sub-process.h
> @@ -29,6 +29,16 @@ struct subprocess_entry {
> 	struct child_process process;
> };
>=20
> +struct subprocess_capability {
> +	const char *name;
> +
> +	/*
> +	 * subprocess_handshake will "|=3D" this value to =
supported_capabilities
> +	 * if the server reports that it supports this capability.
> +	 */
> +	unsigned int flag;
> +};
> +
> /* subprocess functions */
>=20
> /* Function to test two subprocess hashmap entries for equality. */
> @@ -62,6 +72,22 @@ static inline struct child_process =
*subprocess_get_child_process(
> 	return &entry->process;
> }
>=20
> +/*
> + * Perform the version and capability negotiation as described in the =
"Long
> + * Running Filter Process" section of the gitattributes documentation =
using the
> + * given requested versions and capabilities. The "versions" and =
"capabilities"
> + * parameters are arrays terminated by a 0 or blank struct.

Should we reference the "gitattributes docs" if we want to make this =
generic?
I thought "technical/api-sub-process.txt" would explain this kind of =
stuff
and I was surprised that you deleted it in an earlier patch.


> + *
> + * This function is typically called when a subprocess is started (as =
part of
> + * the "startfn" passed to subprocess_start).
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
> index eb3d83744..46f8e583c 100755
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

The generalization of this protocol is nice to see.

Thanks for working on it,
Lars



