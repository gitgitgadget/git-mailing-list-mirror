Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4072C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 00:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiK2A5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 19:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiK2A5P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 19:57:15 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A372210B6C
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 16:57:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y17so3992291plp.3
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 16:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOJ7gd0pPia9HD1u2/Kd2aHA+6gvFoppKWPI93ShbM8=;
        b=KpYozso4P92DELgUDneoyTq4hfkxuRz5SbW9LT69RsT/TtngchwLFYANrJQJVxahHh
         sJh+TlzNhmDCwkvtLLTLqqkmfcqKBhbibuT3XXfOqK2dxLtS8fujw0xwQrh6YNwUQkcs
         f9imPvPVl2WUq5gdbpoo/92YZTzjDFzh2beLgO5u88tEns+MwbuejH/OPySd5O3IaW1x
         yM6focYuy5mn9qxAQ/4Ae0IFN+JMCeELGtutehV1elcgT6KmT/F1kIxr+4wAnQ+UWSgP
         mE6pRzaz8RBsl6RmNoS3tWqJX8L3rIg7kqBy7G/E2GZPyYgNj2iDaU2Rt0SzDqVLe67g
         L5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOJ7gd0pPia9HD1u2/Kd2aHA+6gvFoppKWPI93ShbM8=;
        b=POx/9J+6by/iR7QpfoPnnZRqhFMXfC9gL9iB6gu84OC7cr4ecEwvETpeg2MGqCPG1d
         HWzWIUl+vNYOMmgLE9EjAzNa5oB3O8XsWi4QcnYb6n3CJIXf49crEOI3X1o17kDHzhSk
         TL5cioo9Xz+X0/FcruQwTe5Cm3We6UKdPk/DHRuPJpQ29+lfmMDw+5zNaL734NdntoUL
         YQ03Q3hDpS+E2ymw+i5T5xuMgyCAtLywUHEfLQiFxqm69wMoyCBLC2SQkuD0m5252KQf
         HqmiPRXcoMSJHrvnBxmwjvirI5HLLG04pjBRTwVu4HXYEI7Mr/VJeL5VSplYnUHCye77
         u+qg==
X-Gm-Message-State: ANoB5plq+Aqyy5lIvALDBB6y2dcuY90obKn6UDX/x3SGOK2qIRUv8Xdv
        3zqOZDa80TG2d+8F+ECXQ1fw
X-Google-Smtp-Source: AA0mqf5BSx7SY8VzRxIXaJxwNFZ+qenSLMCPhznGR6AUMaYuOaKl82ot+7A+CKidd5j6/ZOlexZ96w==
X-Received: by 2002:a17:903:300c:b0:185:44df:d904 with SMTP id o12-20020a170903300c00b0018544dfd904mr40287564pla.120.1669683432974;
        Mon, 28 Nov 2022 16:57:12 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id y16-20020a170902b49000b0016d72804664sm9299949plr.205.2022.11.28.16.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 16:57:12 -0800 (PST)
Message-ID: <ca410bed-e8d1-415f-5235-b64fe18bed27@github.com>
Date:   Mon, 28 Nov 2022 16:57:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/9] bundle-uri client: add minimal NOOP client
Content-Language: en-US
To:     =?UTF-8?Q?=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <0d85aef965d62a684b25f388a946abd3c17809fc.1668628303.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <0d85aef965d62a684b25f388a946abd3c17809fc.1668628303.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason via GitGitGadget wrote:
> From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
>  <avarab@gmail.com>
> 
> Set up all the needed client parts of the "bundle-uri" protocol
> extension, without actually doing anything with the bundle URIs.
> 
> I.e. if the server says it supports "bundle-uri" we'll issue a
> command=bundle-uri after command=ls-refs when we're cloning. We'll
> parse the returned output using the code already tested for in
> t5750-bundle-uri-parse.sh.
> 
> What we aren't doing is actually acting on that data, i.e. downloading
> the bundle(s) before we get to doing the command=fetch, and adjusting
> our negotiation dialog appropriately. I'll do that in subsequent
> commits.

Makes sense.

> 
> There's a question of what level of encapsulation we should use here,
> I've opted to use connect.h in clone.c, but we could also e.g. make
> transport_get_remote_refs() invoke this, i.e. make it implicitly get
> the bundle-uri list for later steps.

I'm not sure I follow what this sentence is saying. Looking at the
implementation below [1], you've added a call to
'transport_get_remote_bundle_uri()' in 'clone.c', but that's defined in
'transport.h' (which is already included in 'clone.c'). Why is 'connect.h'
needed at all?

> 
> This approach means that we don't "support" this in "git fetch" for
> now. I'm starting with the case of initial clones, although as noted
> in preceding commits to the protocol documentation nothing about this
> approach precludes getting bundles on incremental fetches.

This explanation seems more complicated than necessary. I think it's
sufficient to say "The no-op client is initially used only in 'clone' to
test the basic functionality. The bundle URI client will be integrated into
fetch, pull, etc. in later patches".

> 
> For the t5732-protocol-v2-bundle-uri-http.sh it's not easy to set
> environment variables for git-upload-pack (it's started by Apache), so
> let's skip the test under T5730_HTTP, and add unused T5730_{FILE,GIT}
> prerequisites for consistency and future use.

"skip the test" doesn't explain *which* test is skipped (and it doesn't look
like you skip all of them). I think you're referring to "bad client with
$T5730_PROTOCOL:// using protocol v2" specifically?

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/clone.c                        |   7 ++
>  bundle-uri.c                           |   4 +
>  connect.c                              |  47 ++++++++
>  remote.h                               |   5 +
>  t/lib-t5730-protocol-v2-bundle-uri.sh  | 148 +++++++++++++++++++++++++
>  t/t5730-protocol-v2-bundle-uri-file.sh |  36 ++++++
>  t/t5731-protocol-v2-bundle-uri-git.sh  |  17 +++
>  t/t5732-protocol-v2-bundle-uri-http.sh |  17 +++
>  transport-helper.c                     |  13 +++
>  transport-internal.h                   |   7 ++
>  transport.c                            |  55 +++++++++
>  transport.h                            |  19 ++++
>  12 files changed, 375 insertions(+)
>  create mode 100644 t/lib-t5730-protocol-v2-bundle-uri.sh
>  create mode 100755 t/t5730-protocol-v2-bundle-uri-file.sh
>  create mode 100755 t/t5731-protocol-v2-bundle-uri-git.sh
>  create mode 100755 t/t5732-protocol-v2-bundle-uri-http.sh
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 547d6464b3c..edf98295af2 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -27,6 +27,7 @@
>  #include "iterator.h"
>  #include "sigchain.h"
>  #include "branch.h"
> +#include "connect.h"
>  #include "remote.h"
>  #include "run-command.h"
>  #include "connected.h"
> @@ -1266,6 +1267,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	if (refs)
>  		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
>  
> +	/*
> +	 * Populate transport->got_remote_bundle_uri and
> +	 * transport->bundle_uri. We might get nothing.
> +	 */
> +	transport_get_remote_bundle_uri(transport);

[1] 

> +
>  	if (mapped_refs) {
>  		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
>  
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 32022595964..2201b604b11 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -571,6 +571,10 @@ int bundle_uri_advertise(struct repository *r, struct strbuf *value)
>  {
>  	static int advertise_bundle_uri = -1;
>  
> +	if (value &&
> +	    git_env_bool("GIT_TEST_BUNDLE_URI_UNKNOWN_CAPABILITY_VALUE", 0))
> +		strbuf_addstr(value, "test-unknown-capability-value");

It looks like 'GIT_TEST_BUNDLE_URI_UNKNOWN_CAPABILITY_VALUE' is being used
to "mock" server responses to test certain behavior on the client side. I'm
somewhat uncomfortable with how this mixes test-specific code paths with
application code, and AFAICT nothing similar is done for other
advertise/command functions in protocol v2. Is there a way to set up tests
to intercept the client requests and customize the response? 

> +
>  	if (advertise_bundle_uri != -1)
>  		goto cached;
>  
> diff --git a/connect.c b/connect.c
> index 5ea53deda23..d39effb7492 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -15,6 +15,7 @@
>  #include "version.h"
>  #include "protocol.h"
>  #include "alias.h"
> +#include "bundle-uri.h"
>  
>  static char *server_capabilities_v1;
>  static struct strvec server_capabilities_v2 = STRVEC_INIT;
> @@ -491,6 +492,52 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
>  	}
>  }
>  
> +int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
> +			  struct bundle_list *bundles, int stateless_rpc)
> +{
> +	int line_nr = 1;
> +
> +	/* Assert bundle-uri support */
> +	server_supports_v2("bundle-uri", 1);
> +
> +	/* (Re-)send capabilities */
> +	send_capabilities(fd_out, reader);
> +
> +	/* Send command */
> +	packet_write_fmt(fd_out, "command=bundle-uri\n");
> +	packet_delim(fd_out);
> +
> +	/* Send options */
> +	if (git_env_bool("GIT_TEST_PROTOCOL_BAD_BUNDLE_URI", 0))
> +		packet_write_fmt(fd_out, "test-bad-client\n");

Same comment as on 'GIT_TEST_BUNDLE_URI_UNKNOWN_CAPABILITY_VALUE'. There's
no precedent that I can find for a test variable like this in 'connect.c', and
"in the middle of client code" doesn't seem like an ideal place for it. 

If there really isn't another way of doing this, could the addition of these
'GIT_TEST' variables and their associated tests be split out into a
dedicated commit? That would at least separate the test code paths from the
application code in the commit history.

> +	packet_flush(fd_out);
> +
> +	/* Process response from server */
> +	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
> +		const char *line = reader->line;
> +		line_nr++;
> +
> +		if (!bundle_uri_parse_line(bundles, line))
> +			continue;
> +
> +		return error(_("error on bundle-uri response line %d: %s"),
> +			     line_nr, line);
> +	}
> +
> +	if (reader->status != PACKET_READ_FLUSH)
> +		return error(_("expected flush after bundle-uri listing"));
> +
> +	/*
> +	 * Might die(), but obscure enough that that's OK, e.g. in
> +	 * serve.c we'll call BUG() on its equivalent (the
> +	 * PACKET_READ_RESPONSE_END check).
> +	 */
> +	check_stateless_delimiter(stateless_rpc, reader,
> +				  _("expected response end packet after ref listing"));
> +
> +	return 0;

The rest of this looks fine to me.

> +}
> +
>  struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
>  			     struct ref **list, int for_push,
>  			     struct transport_ls_refs_options *transport_options,
> diff --git a/t/lib-t5730-protocol-v2-bundle-uri.sh b/t/lib-t5730-protocol-v2-bundle-uri.sh
> new file mode 100644
> index 00000000000..27294e9c976
> --- /dev/null
> +++ b/t/lib-t5730-protocol-v2-bundle-uri.sh

nit: this set of tests is used in more than just 't5730', so the name is
somewhat misleading. It also seems a bit overly-specific to include
"protocol-v2" in the filename (the tests themselves mention "protocol v2"
when it's relevant). What about something like 'lib-proto-bundle-uri.sh'
(using "proto" to mimic 'lib-proto-disable.sh')?

> @@ -0,0 +1,148 @@
> +# Included from t573*-protocol-v2-bundle-uri-*.sh
> +
> +T5730_PARENT=
> +T5730_URI=
> +T5730_BUNDLE_URI=

Similar to the filename nit - these variables are used in tests outside of
't5730', so their names are not quite accurate to their usage. 

> +# Poor man's URI escaping. Good enough for the test suite whose trash
> +# directory has a space in it. See 93c3fcbe4d4 (git-svn: attempt to
> +# mimic SVN 1.7 URL canonicalization, 2012-07-28) for prior art.
> +test_uri_escape() {
> +	sed 's/ /%20/g'
> +}

This is a good opportunity to unify on a single implementation rather than
to have multiple similar ones floating around. Can this be moved into
'test-lib.sh' (or 'test-lib-functions.sh'?), with 't9119' and 't9120'
updated to use the new 'test_uri_escape()'?

> diff --git a/t/t5730-protocol-v2-bundle-uri-file.sh b/t/t5730-protocol-v2-bundle-uri-file.sh
> new file mode 100755
> index 00000000000..89203d3a23c
> --- /dev/null
> +++ b/t/t5730-protocol-v2-bundle-uri-file.sh
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +
> +test_description="Test bundle-uri with protocol v2 and 'file://' transport"
> +
> +TEST_NO_CREATE_REPO=1
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +# Test protocol v2 with 'file://' transport
> +#
> +T5730_PROTOCOL=file
> +. "$TEST_DIRECTORY"/lib-t5730-protocol-v2-bundle-uri.sh
> +
> +test_expect_success "unknown capability value with $T5730_PROTOCOL:// using protocol v2" '

Why is this test only run for the 'file://' transport protocol? And, why
isn't it in 'lib-t5730-protocol-v2-bundle-uri.sh'? If nothing else, moving
this test to that file (even if it needs to be conditional on a specific
protocol) puts the '$T5730_PARENT', '$T5730_BUNDLE_URI_ESCAPED' and
'$T5730_URI' variables in scope for better readability.

> +	test_when_finished "rm -f log" &&
> +
> +	test_config -C "$T5730_PARENT" \
> +		uploadpack.bundleURI "$T5730_BUNDLE_URI_ESCAPED" &&
> +
> +	GIT_TRACE_PACKET="$PWD/log" \
> +	GIT_TEST_BUNDLE_URI_UNKNOWN_CAPABILITY_VALUE=true \
> +	git \
> +		-c protocol.version=2 \
> +		ls-remote --symref "$T5730_URI" \
> +		>actual 2>err &&

This test never does anything with the content of 'actual' or 'err'. Should
it? If not, they probably shouldn't be redirected from stdout/stderr, since
the messages might be valuable when debugging.

> +
> +	# Server responded using protocol v2
> +	grep "< version 2" log &&
> +
> +	grep "> bundle-uri=test-unknown-capability-value" log
> +'
> +
> +test_done
> diff --git a/transport-helper.c b/transport-helper.c
> index e95267a4ab5..3ea7c2bb5ad 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -1267,9 +1267,22 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
>  	return ret;
>  }
>  
> +static int get_bundle_uri(struct transport *transport)
> +{
> +	get_helper(transport);
> +
> +	if (process_connect(transport, 0)) {
> +		do_take_over(transport);
> +		return transport->vtable->get_bundle_uri(transport);
> +	}
> +
> +	return -1;
> +}
> +
>  static struct transport_vtable vtable = {
>  	.set_option	= set_helper_option,
>  	.get_refs_list	= get_refs_list,
> +	.get_bundle_uri = get_bundle_uri,
>  	.fetch_refs	= fetch_refs,
>  	.push_refs	= push_refs,
>  	.connect	= connect_helper,
> diff --git a/transport-internal.h b/transport-internal.h
> index c4ca0b733ac..90ea749e5cf 100644
> --- a/transport-internal.h
> +++ b/transport-internal.h
> @@ -26,6 +26,13 @@ struct transport_vtable {
>  	struct ref *(*get_refs_list)(struct transport *transport, int for_push,
>  				     struct transport_ls_refs_options *transport_options);
>  
> +	/**
> +	 * Populates the remote side's bundle-uri under protocol v2,
> +	 * if the "bundle-uri" capability was advertised. Returns 0 if
> +	 * OK, negative values on error.

Double-checked the call stack to make sure this is true, and it is (the
return value is always either a hardcoded '0' or 'error()'.

> +	 */
> +	int (*get_bundle_uri)(struct transport *transport);
> +
>  	/**
>  	 * Fetch the objects for the given refs. Note that this gets
>  	 * an array, and should ignore the list structure.
> diff --git a/transport.c b/transport.c
> index e7b97194c10..a020adc1f56 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -902,6 +922,7 @@ static int disconnect_git(struct transport *transport)
>  
>  static struct transport_vtable taken_over_vtable = {
>  	.get_refs_list	= get_refs_via_connect,
> +	.get_bundle_uri = get_bundle_uri,
>  	.fetch_refs	= fetch_refs_via_pack,
>  	.push_refs	= git_transport_push,
>  	.disconnect	= disconnect_git
> @@ -1054,6 +1075,7 @@ static struct transport_vtable bundle_vtable = {
>  
>  static struct transport_vtable builtin_smart_vtable = {
>  	.get_refs_list	= get_refs_via_connect,
> +	.get_bundle_uri = get_bundle_uri,
>  	.fetch_refs	= fetch_refs_via_pack,
>  	.push_refs	= git_transport_push,
>  	.connect	= connect_git,

I think I follow what this is doing (if I'm reading correctly) - add
'get_bundle_uri' to all of the vtables (including in 'transport-helper.c')
*except* 'bundle_vtable', since we aren't requesting bundle URIs from an
already-identified bundle URI.

> @@ -1482,6 +1507,34 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
>  	return rc;
>  }
>  
> +int transport_get_remote_bundle_uri(struct transport *transport)
> +{
> +	const struct transport_vtable *vtable = transport->vtable;
> +
> +	/* Check config only once. */
> +	if (transport->got_remote_bundle_uri++)
> +		return 0;

We're only ever going to read the bundle list once per command (or, at least
once per 'transport' instance), so if 'transport_get_remote_bundle_uri()'
has already been called, we can safely assume the correct results (if any)
are in the 'transport' structure.

> +
> +	/*
> +	 * "Support" protocol v0 and v2 without bundle-uri support by
> +	 * silently degrading to a NOOP.
> +	 */
> +	if (!server_supports_v2("bundle-uri", 0))
> +		return 0;
> +
> +	/*
> +	 * This is intentionally below the transport.injectBundleURI,
> +	 * we want to be able to inject into protocol v0, or into the
> +	 * dialog of a server who doesn't support this.
> +	 */
> +	if (!vtable->get_bundle_uri)
> +		return error(_("bundle-uri operation not supported by protocol"));
> +
> +	if (vtable->get_bundle_uri(transport) < 0)

As you noted earlier, 'get_bundle_uri()' always returns a value <= 0, so
this check works.

> +		return error(_("could not retrieve server-advertised bundle-uri list"));
> +	return 0;
> +}
> +
>  void transport_unlock_pack(struct transport *transport, unsigned int flags)
>  {
>  	int in_signal_handler = !!(flags & TRANSPORT_UNLOCK_PACK_IN_SIGNAL_HANDLER)
