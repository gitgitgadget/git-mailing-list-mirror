Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C7EC433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 14:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D61560C41
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 14:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhJZOCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbhJZOCj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 10:02:39 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB41FC061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 07:00:15 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y11so13511796qtn.13
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8tnxK1WwlUMtRcUhv3r5ZhNzS5YLoCJ8/3/vaNey7BQ=;
        b=lzNcdOlVQwKBxSuAmatmsW2l237brjzVLs1omHa1GnJwV70vci9cMcCJeSd9radCDM
         FU0ny0XC+BVxqrfj7GxeFujRuiEIhTvBZt18yht8RmLYq/zL1TmVfGWN1LnLQvGDqlPI
         NFa5b1mW8/FgO6jVzNTpU5/5tAwfiCUyFFT00q4Awo4HyTLniY3q7RRTU7IuCnUXWrSz
         wqN2+3GJViI4W2Uu9HhKlC/tmhyl+xLwdnNCpoX2ESJ1+OsSS93iHCeXOnAGt1yoHlBT
         NCgdj/XBLa90VW8pARnnqUiUwF3vtLAQk39M/E+zjs5m8oRKxuOrYh6no52Y+zp/js3w
         8hjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8tnxK1WwlUMtRcUhv3r5ZhNzS5YLoCJ8/3/vaNey7BQ=;
        b=RiBwMtjsjtYAtHOb0dRpgbmc4hEItInj9kYnWJHWWbsMaxG9lXNCYYDeFQBp+V0TkX
         UYyzUfDpcc3xC2FToMJ+JVJS6tYu8HV29Ju6FE3QBndTjo93rosaHy3tlHNkOlz9xP9c
         PG6fC5Z/30jb4xLj9T/zA+BNI78FbtsdhowIAjAIo4ZsjRpfJ5dV712Bp1wDzEZvqCIM
         c8Y6zNYONV9Q9bXGTuehR3qxtv9hkhkaAENClAN1TKHreWtySQqmsN+kqwgLpqGXSQT9
         QOV8BUoKdjRHWCLKkuHkEpIYZ8pURmIneFYOONi4KQZPwEUrxicu7FYoyJBTn1Ul6aoa
         6xdg==
X-Gm-Message-State: AOAM530/nfDYyPCVmmmZ4738CoIHVKDY/cB4r6wJSSfEBGERTCc4eP4M
        toAASH2xd1bhQ1m4I5gZ4Nw=
X-Google-Smtp-Source: ABdhPJw8aNpRHLbYSmyieZ27K90C4RVlTQmFUZrrPyNVyyF+1F0C+at4XB9Z4d8WCLUSU3usYnx+eQ==
X-Received: by 2002:ac8:5e4e:: with SMTP id i14mr24873553qtx.129.1635256813890;
        Tue, 26 Oct 2021 07:00:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:86f:cede:45bc:10f6? ([2600:1700:e72:80a0:86f:cede:45bc:10f6])
        by smtp.gmail.com with ESMTPSA id h20sm10878184qtx.10.2021.10.26.07.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:00:13 -0700 (PDT)
Message-ID: <f2269fc7-1688-d62e-02bb-01c5b5e33143@gmail.com>
Date:   Tue, 26 Oct 2021 10:00:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 2/3] protocol v2: specify static seeding of clone/fetch
 via "bundle-uri"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Robin H . Johnson" <robbat2@gentoo.org>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
 <patch-2.3-3ac0539c053-20211025T211159Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <patch-2.3-3ac0539c053-20211025T211159Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/25/2021 5:25 PM, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> +bundle-uri CLIENT ERROR RECOVERY
> +++++++++++++++++++++++++++++++++
> +
> +A client MUST above all gracefully degrade on errors, whether that
> +error is because of bad missing/data in the bundle URI(s), because
> +that client is too dumb to e.g. understand and fully parse out bundle
> +headers and their prerequisite relationships, or something else.

"too dumb" seems a bit informal to me, especially because you
immediately elaborate on its meaning. You could rewrite as follows:

  ...because
  that client can't understand or fully parse out bundle
  headers and their prerequisite relationships, or something else.

> +Server operators should feel confident in turning on "bundle-uri" and
> +not worry if e.g. their CDN goes down that clones or fetches will run
> +into hard failures. Even if the server bundle bundle(s) are
> +incomplete, or bad in some way the client should still end up with a
> +functioning repository, just as if it had chosen not to use this
> +protocol extension.

Also, insertions of "e.g." in the middle of a sentence don't flow well.

  Server operators should feel confident in turning on "bundle-uri" and
  not worry that failures such as the CDN being unavailable will cause
  clones or fetches to have hard failures. Even if the server bundle(s)
  are invalid, the client should still end up with a functioning
  repository, just as if it had chosen not to use this protocol extension.

(Note: I also removed a "bundle bundle(s)" that was split across a line
break.)

> +bundle-uri SERVER TO CLIENT
> ++++++++++++++++++++++++++++
> +
> +The ordering of the returned bundle uris is not significant. Clients

I'm late to noticing, but shouldn't "URI" be all-caps when not used in
the literal capability string "bundle-uri"?

> +bundle-uri CLIENT TO SERVER
> ++++++++++++++++++++++++++++
> +
> +The client SHOULD provide reference tips found in the bundle header(s)
> +as 'have' lines in any subsequent `fetch` request. A client MAY also
> +ignore the bundle(s) entirely if doing so is deemed worse for some
> +reason, e.g. if the bundles can't be downloaded, it doesn't like the
> +tips it finds etc.

I would just stop after "is deemed worse for some reason." because one
example is obvious and the other is unclear how the client would detect
that situation. (Maybe: tip commit timestamps are really old?)

> +
> +WHEN ADVERTISED BUNDLE(S) REQUIRE NO FURTHER NEGOTIATION
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> +
> +If after issuing `bundle-uri` and `ls-refs`, and getting the header(s)
> +of the bundle(s) the client finds that the ref tips it wants can be
> +retrieved entirety from advertised bundle(s), it MAY disconnect. The

s/entirety/entirely/

> +results of such a 'clone' or 'fetch' should be indistinguishable from
> +the state attained without using bundle-uri.
> +
> +EARLY CLIENT DISCONNECTIONS AND ERROR RECOVERY
> +++++++++++++++++++++++++++++++++++++++++++++++
> +
> +A client MAY perform an early disconnect while still downloading the
> +bundle(s) (having streamed and parsed their headers). In such a case
> +the client MUST gracefully recover from any errors related to
> +finishing the download and validation of the bundle(s).
> +
> +I.e. a client might need to re-connect and issue a 'fetch' command,
> +and possibly fall back to not making use of 'bundle-uri' at all.

Use "For example," over starting a sentence with "i.e.". The examples
of "i.e." and "e.g." already in this document show proper use, which
involves parentheses.

> +This "MAY" behavior is specified as such (and not a "SHOULD") on the
> +assumption that a server advertising bundle uris is more likely than
> +not to be serving up a relatively large repository, and to be pointing
> +to URIs that have a good chance of being in working order. A client
> +MAY e.g. look at the payload size of the bundles as a heuristic to see

Again, here, the entire sentence is an example. This "e.g." can be
removed with no loss of meaning.

> +if an early disconnect is worth it, should falling back on a full
> +"fetch" dialog be necessary.


> +While no per-URI key-value are currently supported currently they're
> +intended to support future features such as:
> +
> + * Add a "hash=<val>" or "size=<bytes>" advertise the expected hash or
> +   size of the bundle file.

I suppose if one wanted to add this server-to-bundle coupling, then some
clients might appreciate it.

> + * Advertise that one or more bundle files are the same (to e.g. have
> +   clients round-robin or otherwise choose one of N possible files).

  * Advertise that one or more bundle files are the same, to allow for
    redundancy without causing duplicated effort.

> +static void send_bundle_uris(struct packet_writer *writer,
> +			     struct string_list *uris)
> +{
> +	struct string_list_item *item;
> +
> +	for_each_string_list_item(item, uris)
> +		packet_writer_write(writer, "%s", item->string);
> +}
> +
> +static int advertise_bundle_uri = -1;
> +static struct string_list bundle_uris = STRING_LIST_INIT_DUP;

I see you put send_bundle_uris() before the global bundle_uris so
it can be independent, but do you expect anyone to call send_bundle_uris()
via a different list?

Should we find a different place to store this data?

> +static int bundle_uri_config(const char *var, const char *value, void *data)
> +{
> +	if (!strcmp(var, "uploadpack.bundleuri")) {
> +		advertise_bundle_uri = 1;
> +		string_list_append(&bundle_uris, value);
> +	}
> +
> +	return 0;
> +}

Here, we are dictating that the URI list is available as a multi-valued
config "uploadpack.bundleuri".

1. Should this be updated in Documentation/config/uploadpack.txt?

2. This seems difficult to extend to your possible future features as
   listed in the protocol docs, mainly because this can only store the
   flat URI string. To add things like hash values, sizes, and prereqs,
   you would need more data included and grouped on a per-URI basis.
   What plans do you have to make extensions here while remaining
   somewhat compatible with downgrading Git versions?

> @@ -136,6 +137,11 @@ static struct protocol_capability capabilities[] = {
>  		.advertise = always_advertise,
>  		.command = cap_object_info,
>  	},
> +	{
> +		.name = "bundle-uri",
> +		.advertise = bundle_uri_advertise,
> +		.command = bundle_uri_command,
> +	},
>  };

I really appreciate that it is this simple to extend protocol v2.

> +test_expect_success 'basics of bundle-uri: dies if not enabled' '
> +	test-tool pkt-line pack >in <<-EOF &&
> +	command=bundle-uri
> +	0000
> +	EOF
> +
> +	cat >err.expect <<-\EOF &&
> +	fatal: invalid command '"'"'bundle-uri'"'"'
> +	EOF
> +
> +	cat >expect <<-\EOF &&
> +	ERR serve: invalid command '"'"'bundle-uri'"'"'
> +	EOF
> +
> +	test_must_fail test-tool serve-v2 --stateless-rpc <in >out 2>err.actual &&
> +	test_cmp err.expect err.actual &&
> +	test_must_be_empty out
> +'
> +
> +

hyper-nit: double newline.

The implementation seems simple enough, which I like. I'm a bit
your current use of Git config as the back-end, only because it is
difficult to be future-proof. As the functionality stands today, the
current config design works just fine. Perhaps we don't need to
worry about the future, because we can design a new, complementary
storage for that extra data. It seems worth exploring for a little
while, though. Perhaps we should take a page out of 'git-remote'
and how it stores named remotes with sub-items for metadata. The
names probably don't need to ever be exposed to users, but it could
be beneficial to anyone implementing this scheme.

[bundle "main"]
	uri = https://example.com/my-bundle
	uri = https://redundant-cdn.com/my-bundle
	size = 120523
	sha256 = {64hexchars}

[bundle "fork"]
	uri = https://cdn.org/my-fork
	size = 334
	sha256 = {...}
	prereq = {oid}

This kind of layout has an immediate grouping of data that should
help any future plan. Notice how I included multiple "uri" lines
in the "main", which helps with your plan for duplicate URIs.

Thanks,
-Stolee
