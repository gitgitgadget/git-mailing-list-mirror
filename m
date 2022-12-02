Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8CAC47088
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 15:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiLBPAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 10:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiLBPAk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 10:00:40 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C06EE2573
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 07:00:37 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id d13so3557874qvj.8
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 07:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Js0iwRy4F6CJL8Lz2/n5NLV0ovPGzjIcWqqwphJ3EB0=;
        b=itoddwNnjNFfN0CtWbPstQjEvbcXkbKunKF9PH8Exn3EeIg7AXqQ3DOD2eMv1CHmRH
         0LmfrZTcWu34o6B8F5rMDaQN+lAZfvwogbBpoePUG1iIT9b7eXpxA1gje3ctjyP8f7Pn
         QgMXY8Rlbc5sZUavHdU4Dn46Oi142cSt4EuoTxjcwrqT+mi/DR+uXfngXJxwCDJISsP2
         3qQL5G8wtb8UQTSI+whoBJ4gipwGfn8zTonE2aequx+tK7LHg4Zo+BAH7G4k6lG35rFB
         zCRgLbv7Sqr/VhMjmF3WLhMGXOGyF02YjSLjrYdOD5mpdSkKE/9jybp1pa2LtiD4Wqhk
         5rZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Js0iwRy4F6CJL8Lz2/n5NLV0ovPGzjIcWqqwphJ3EB0=;
        b=dw9GqAZNiwYvMIiZKPMXFlN6CoyoKaiDe39z7eIR7q12uV2iwKlEPTEE5iS3ZGw5Hx
         nX9+cGGIQQX0/AqLLyGe2nl7cC0DNd941IVN7ou2elOQ+4Jgpgy/lqOUAbNgzX6Bhf3i
         scf29K1cebgYglU1hiyfyQhPST5G/IMu8Qc3WPHTRPDV10Wy10Vw3+pZ9PnH1zHyR2OA
         aZkX0LMKpHuTQ6jY3UDqZ+yfO6+F4u5T5IrZsnPDKXTX8Rzqm8l+plpywK6f66LupmXj
         ucSAzLOiYHWsQScxkdIAJzXiHqgagI5NRGkfzWEBQLM9b1nhrv0XJcU2/L9Jgb/1tB5c
         YgqQ==
X-Gm-Message-State: ANoB5pkDUiU4MDu+6A8G+C6qKw24sI6FSzIezvXZPW11SBvr7PeXU9Uf
        eeEz7Ojfpgh2NSCrgk4TdjWT
X-Google-Smtp-Source: AA0mqf7YPswk+QbW+a8IJAlpEN9Ax/Ukh9M++DJTxx+YQYQCkL4jzzkBTAHCUR2ty7l1spLFP8PTXg==
X-Received: by 2002:a05:6214:4290:b0:4bb:5d3a:bdad with SMTP id og16-20020a056214429000b004bb5d3abdadmr46626111qvb.26.1669993236658;
        Fri, 02 Dec 2022 07:00:36 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:8051:a31f:2c93:87e9? ([2600:1700:e72:80a0:8051:a31f:2c93:87e9])
        by smtp.gmail.com with ESMTPSA id bs15-20020a05620a470f00b006fbdeecad51sm5574199qkb.48.2022.12.02.07.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 07:00:36 -0800 (PST)
Message-ID: <4ec12008-620d-c186-38ef-08ea87fec856@github.com>
Date:   Fri, 2 Dec 2022 10:00:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/9] bundle-uri client: add minimal NOOP client
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com, dyroneteng@gmail.com
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <0d85aef965d62a684b25f388a946abd3c17809fc.1668628303.git.gitgitgadget@gmail.com>
 <ca410bed-e8d1-415f-5235-b64fe18bed27@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ca410bed-e8d1-415f-5235-b64fe18bed27@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/28/2022 7:57 PM, Victoria Dye wrote:
> Ævar Arnfjörð Bjarmason via GitGitGadget wrote:
>> From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
>>  <avarab@gmail.com>

>> There's a question of what level of encapsulation we should use here,
>> I've opted to use connect.h in clone.c, but we could also e.g. make
>> transport_get_remote_refs() invoke this, i.e. make it implicitly get
>> the bundle-uri list for later steps.
>
> I'm not sure I follow what this sentence is saying. Looking at the
> implementation below [1], you've added a call to
> 'transport_get_remote_bundle_uri()' in 'clone.c', but that's defined in
> 'transport.h' (which is already included in 'clone.c'). Why is 'connect.h'
> needed at all?

It's not. Good catch!

>> This approach means that we don't "support" this in "git fetch" for
>> now. I'm starting with the case of initial clones, although as noted
>> in preceding commits to the protocol documentation nothing about this
>> approach precludes getting bundles on incremental fetches.
>
> This explanation seems more complicated than necessary. I think it's
> sufficient to say "The no-op client is initially used only in 'clone' to
> test the basic functionality. The bundle URI client will be integrated into
> fetch, pull, etc. in later patches".

Definitely can be reworded. Specifically, fetches need more functionality
(coming in part V) before there is value in that integration.

>> For the t5732-protocol-v2-bundle-uri-http.sh it's not easy to set
>> environment variables for git-upload-pack (it's started by Apache), so
>> let's skip the test under T5730_HTTP, and add unused T5730_{FILE,GIT}
>> prerequisites for consistency and future use.
>
> "skip the test" doesn't explain *which* test is skipped (and it doesn't look
> like you skip all of them). I think you're referring to "bad client with
> $T5730_PROTOCOL:// using protocol v2" specifically?

Will make the specific test to skip more clear.

>> diff --git a/bundle-uri.c b/bundle-uri.c
>> index 32022595964..2201b604b11 100644
>> --- a/bundle-uri.c
>> +++ b/bundle-uri.c
>> @@ -571,6 +571,10 @@ int bundle_uri_advertise(struct repository *r, struct strbuf *value)
>>  {
>>  	static int advertise_bundle_uri = -1;
>>
>> +	if (value &&
>> +	    git_env_bool("GIT_TEST_BUNDLE_URI_UNKNOWN_CAPABILITY_VALUE", 0))
>> +		strbuf_addstr(value, "test-unknown-capability-value");
>
> It looks like 'GIT_TEST_BUNDLE_URI_UNKNOWN_CAPABILITY_VALUE' is being used
> to "mock" server responses to test certain behavior on the client side. I'm
> somewhat uncomfortable with how this mixes test-specific code paths with
> application code, and AFAICT nothing similar is done for other
> advertise/command functions in protocol v2. Is there a way to set up tests
> to intercept the client requests and customize the response?

I'm going to investigate how we can test similar functionality within the
test-tool code instead, if possible.

>> +int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
>> +			  struct bundle_list *bundles, int stateless_rpc)
>> +{
>> +	int line_nr = 1;
>> +
>> +	/* Assert bundle-uri support */
>> +	server_supports_v2("bundle-uri", 1);
>> +
>> +	/* (Re-)send capabilities */
>> +	send_capabilities(fd_out, reader);
>> +
>> +	/* Send command */
>> +	packet_write_fmt(fd_out, "command=bundle-uri\n");
>> +	packet_delim(fd_out);
>> +
>> +	/* Send options */
>> +	if (git_env_bool("GIT_TEST_PROTOCOL_BAD_BUNDLE_URI", 0))
>> +		packet_write_fmt(fd_out, "test-bad-client\n");
>
> Same comment as on 'GIT_TEST_BUNDLE_URI_UNKNOWN_CAPABILITY_VALUE'. There's
> no precedent that I can find for a test variable like this in 'connect.c', and
> "in the middle of client code" doesn't seem like an ideal place for it.
>
> If there really isn't another way of doing this, could the addition of these
> 'GIT_TEST' variables and their associated tests be split out into a
> dedicated commit? That would at least separate the test code paths from the
> application code in the commit history.

I'll definitely split them out, making this change much more about the
test boilerplate. In addition, most of the test boilerplate actually works
without the 'git clone' update, so this can be split into three commits:

1. Create the test infrastructure to check that the server advertises
   the 'bundle-uri' command appropriately.

2. Implement the basic client that issues and parses the 'bundle-uri'
   command. Add the request to 'git clone' and add a test that verifies
   that the client makes the request.

3. Add the extra error condition tests.

>> +++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
>
> nit: this set of tests is used in more than just 't5730', so the name is
> somewhat misleading. It also seems a bit overly-specific to include
> "protocol-v2" in the filename (the tests themselves mention "protocol v2"
> when it's relevant). What about something like 'lib-proto-bundle-uri.sh'
> (using "proto" to mimic 'lib-proto-disable.sh')?

I agree. I think 'lib-bundle-uri-protocol.sh' is a clearer name.

>> +# Poor man's URI escaping. Good enough for the test suite whose trash
>> +# directory has a space in it. See 93c3fcbe4d4 (git-svn: attempt to
>> +# mimic SVN 1.7 URL canonicalization, 2012-07-28) for prior art.
>> +test_uri_escape() {
>> +	sed 's/ /%20/g'
>> +}
>
> This is a good opportunity to unify on a single implementation rather than
> to have multiple similar ones floating around. Can this be moved into
> 'test-lib.sh' (or 'test-lib-functions.sh'?), with 't9119' and 't9120'
> updated to use the new 'test_uri_escape()'?

Will move, although I was not able to find the use in t9120.

>> +test_expect_success "unknown capability value with $T5730_PROTOCOL:// using protocol v2" '
>
> Why is this test only run for the 'file://' transport protocol? And, why
> isn't it in 'lib-t5730-protocol-v2-bundle-uri.sh'? If nothing else, moving
> this test to that file (even if it needs to be conditional on a specific
> protocol) puts the '$T5730_PARENT', '$T5730_BUNDLE_URI_ESCAPED' and
> '$T5730_URI' variables in scope for better readability.

I think this is one of the tests that doesn't work in HTTP, but could be
skipped using a prereq if it is placed in the common test script.

I will rethink this test coverage to see if there is a different way to
check similar behavior without as much insertion into the client/server
code.

>> +int transport_get_remote_bundle_uri(struct transport *transport)
>> +{
>> +	const struct transport_vtable *vtable = transport->vtable;
>> +
>> +	/* Check config only once. */
>> +	if (transport->got_remote_bundle_uri++)
>> +		return 0;
>
> We're only ever going to read the bundle list once per command (or, at least
> once per 'transport' instance), so if 'transport_get_remote_bundle_uri()'
> has already been called, we can safely assume the correct results (if any)
> are in the 'transport' structure.

Yes, although it suffers from a mistake of this form I've seen before:
got_remote_bundle_uri is a single bit, so this only works every other time.
I will fix this.

Thanks for the detailed review!
-Stolee
