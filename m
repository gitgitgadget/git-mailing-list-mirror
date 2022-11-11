Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC8AC4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 01:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKKB7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 20:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiKKB7n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 20:59:43 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9566130F4D
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 17:59:42 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v28so3648344pfi.12
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 17:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wtf6Poj38Tte8XwO6PRQHqFzhrRp6Cb8ZyJm+C/jo9U=;
        b=FT/wrsFKuiZh2yrBMQtuG26MxsdieuAWB+/FXgcVVdrmDQ6yHVcx9kWG03nUdPXlCO
         /QTIGlnsEhroJsZxqztjv0Lbdyj38XTgMV49sZved+VTnusdhpqrPdLCkQAo2eH4hmVO
         wrA0MDec9SSnYvAWX+2oSns+/QyEfWnJ5vHYGx5t6SjIbU/YcojRyKwALb+/kHDj6GSx
         U9BSQGBN5wzMxb5amQ1zjV5L21PORDeKSxnfMUlrNT/FchfHu9AO77cd0esdML78iAhq
         wjs2F+m9ipWwGfxFEsPDb8PPvQ2EAIl/jp0LoxtF9g7mOOHXqJY6WVC3c8gxuPuxldNa
         HWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wtf6Poj38Tte8XwO6PRQHqFzhrRp6Cb8ZyJm+C/jo9U=;
        b=KEz639KMlLxD1fOAlPve1net6NRDt9PXu8pmxsltqYs2KcPVaSxdnJ+9NBWRm5IvY0
         Y5/TGC0TANQm3056BG4P1Os4kIcegxF4iiovaYJNUttB79X7YiCpkFlgXpMD2fEHj4SJ
         9xueNnZIflfUqNN8wZWe4mNCKRzt4CMDtEYVGAXWoAwsmiqNZ/xiDzE7OsfkP71oyE23
         he5hicqOeIEF820VqQQlQWyzuWNYSRmejlBn8/TVv43E7AJ03uA9rpGDMMIorc9fn9ms
         IkJpsDiDQPQOAwy3HNxc72f7smBb0CQC3nkp5tgzy1BLHo6RP6PgLM8J7LBNC8TFDxHg
         ozZw==
X-Gm-Message-State: ACrzQf1OR7SENrOv//OzEj3M2TwL2dRxGbiC1fUOlN9e231pAXK6MEb5
        f8CtRi4ebcCU83fB4YbAtwk+
X-Google-Smtp-Source: AMsMyM5iVJW9rKeuV9ohZnP3IgKJ5XBTh1CgdifxF99LbAynSkQMHKipPFkXqESohk5u0kCj56kWIQ==
X-Received: by 2002:a63:4b10:0:b0:459:5fef:a491 with SMTP id y16-20020a634b10000000b004595fefa491mr4278085pga.150.1668131981974;
        Thu, 10 Nov 2022 17:59:41 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id a2-20020aa78e82000000b0056bee23a80bsm322210pfr.137.2022.11.10.17.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 17:59:41 -0800 (PST)
Message-ID: <508ba524-09d2-81f1-c5f8-815ab766791a@github.com>
Date:   Thu, 10 Nov 2022 17:59:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 1/9] protocol v2: add server-side "bundle-uri" skeleton
Content-Language: en-US
To:     =?UTF-8?Q?=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <a02eee983185815d94ba1124b43eae43280aa963.1667264854.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <a02eee983185815d94ba1124b43eae43280aa963.1667264854.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason via GitGitGadget wrote:
> +
> +PROTOCOL for bundle-uri
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +A `bundle-uri` request takes no arguments, and as noted above does not
> +currently advertise a capability value. Both may be added in the
> +future.
> +
> +When the client issues a `command=bundle-uri` the response is a list of

nit: comma after `command=bundle-uri`

I misread this a couple times dropping the "the", so it read like the
`command=bundle-uri` was the *response*, not the request. I think the comma
would help avoid that?

> +key-value pairs provided as packet lines with value `<key>=<value>`. The
> +meaning of these key-value pairs are provided by the config keys in the
> +`bundle.*` namespace (see linkgit:git-config[1]).

What does this ("the meaning of these key-value pairs are provided by the
config keys...") mean? Are the response keys in the `bundle.*` namespace? Or
do the client-side `bundle.*` keys provide some kind of translation of what
the keys mean?

> +
> +Clients are still expected to fully parse the line according to the
> +above format, lines that do not conform to the format SHOULD be
> +discarded. The user MAY be warned in such a case.

Why "still" - is there some reason they *wouldn't* parse the response line? 

Is "the above format" referring to `<key>=<value>` in general, or restricted
to/guaranteed that the `<key>`'s defined by the `bundle.*` namespace? I'm
guessing "still expected to fully parse" == "MUST parse" (using
MUST/SHOULD/MAY nomeclature), it would help to call that out explicitly to
be consistent with the rest of this doc.

> +
> +bundle-uri CLIENT AND SERVER EXPECTATIONS
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +URI CONTENTS::
> +The advertised URIs MUST be in one of two possible formats.
> ++
> +The first possible format is a bundle file that `git bundle verify`

I don't think "format" is the right word to describe this (I'd reserve
"format" for the literal format of the URI string). Maybe something like
this?

	The advertised URIs MUST contain one of two types of content.

	The advertised URI may contain a bundle file that `git bundle
	verify` would accept...

	...
	
	Alternatively, the advertised URI may provide a plaintext file...

> +would accept. I.e. they MUST contain one or more reference tips for
> +use by the client, MUST indicate prerequisites (in any) with standard
> +"-" prefixes, and MUST indicate their "object-format", if
> +applicable. Create "*.bundle" files with `git bundle create`.

The last sentence doesn't add anything that you don't know from the `git
bundle verify` note in the first doesn't already tell you, and feels like a
bit of a non-sequitur as a result. Although, it tangentially raises a
question: do bundle files *have to* have the '.bundle' suffix to pass `git
bundle verify`? If not, are they expected to when coming from these URIs?

> ++
> +The second possible format is a plaintext file that `git config --list`
> +would accept (with the `--file` option). The key-value pairs in this list
> +are in the `bundle.*` namespace (see linkgit:git-config[1]).
> +
> +bundle-uri CLIENT ERROR RECOVERY::
> +A client MUST above all gracefully degrade on errors, whether that
> +error is because of bad missing/data in the bundle URI(s), because
> +that client is too dumb to e.g. understand and fully parse out bundle
> +headers and their prerequisite relationships, or something else.
> ++
> +Server operators should feel confident in turning on "bundle-uri" and
> +not worry if e.g. their CDN goes down that clones or fetches will run
> +into hard failures. Even if the server bundle bundle(s) are
> +incomplete, or bad in some way the client should still end up with a
> +functioning repository, just as if it had chosen not to use this
> +protocol extension.
> ++
> +All subsequent discussion on client and server interaction MUST keep
> +this in mind.
> +
> +bundle-uri SERVER TO CLIENT::
> +The ordering of the returned bundle uris is not significant. Clients
> +MUST parse their headers to discover their contained OIDS and
> +prerequisites. A client MUST consider the content of the bundle(s)
> +themselves and their header as the ultimate source of truth.
> ++
> +A server MAY even return bundle(s) that don't have any direct
> +relationship to the repository being cloned (either through accident,
> +or intentional "clever" configuration), and expect a client to sort
> +out what data they'd like from the bundle(s), if any.
> +
> +bundle-uri CLIENT TO SERVER::
> +The client SHOULD provide reference tips found in the bundle header(s)
> +as 'have' lines in any subsequent `fetch` request. A client MAY also
> +ignore the bundle(s) entirely if doing so is deemed worse for some
> +reason, e.g. if the bundles can't be downloaded, it doesn't like the
> +tips it finds etc.
> +
> +WHEN ADVERTISED BUNDLE(S) REQUIRE NO FURTHER NEGOTIATION::
> +If after issuing `bundle-uri` and `ls-refs`, and getting the header(s)
> +of the bundle(s) the client finds that the ref tips it wants can be
> +retrieved entirety from advertised bundle(s), it MAY disconnect. The

s/entirety/entirely

And to clarify, by "it MAY disconnect", you mean it may disconnect from the
main repository server? Or the bundle server? 

> +results of such a 'clone' or 'fetch' should be indistinguishable from
> +the state attained without using bundle-uri.
> +
> +EARLY CLIENT DISCONNECTIONS AND ERROR RECOVERY::
> +A client MAY perform an early disconnect while still downloading the
> +bundle(s) (having streamed and parsed their headers). In such a case
> +the client MUST gracefully recover from any errors related to
> +finishing the download and validation of the bundle(s).
> ++
> +I.e. a client might need to re-connect and issue a 'fetch' command,
> +and possibly fall back to not making use of 'bundle-uri' at all.
> ++
> +This "MAY" behavior is specified as such (and not a "SHOULD") on the
> +assumption that a server advertising bundle uris is more likely than
> +not to be serving up a relatively large repository, and to be pointing
> +to URIs that have a good chance of being in working order. A client
> +MAY e.g. look at the payload size of the bundles as a heuristic to see
> +if an early disconnect is worth it, should falling back on a full
> +"fetch" dialog be necessary.
> +
> +WHEN ADVERTISED BUNDLE(S) REQUIRE FURTHER NEGOTIATION::
> +A client SHOULD commence a negotiation of a PACK from the server via
> +the "fetch" command using the OID tips found in advertised bundles,
> +even if's still in the process of downloading those bundle(s).
> ++
> +This allows for aggressive early disconnects from any interactive
> +server dialog. The client blindly trusts that the advertised OID tips
> +are relevant, and issues them as 'have' lines, it then requests any
> +tips it would like (usually from the "ls-refs" advertisement) via
> +'want' lines. The server will then compute a (hopefully small) PACK
> +with the expected difference between the tips from the bundle(s) and
> +the data requested.
> ++
> +The only connection the client then needs to keep active is to the
> +concurrently downloading static bundle(s), when those and the
> +incremental PACK are retrieved they should be inflated and
> +validated. Any errors at this point should be gracefully recovered
> +from, see above.
> +
> +bundle-uri PROTOCOL FEATURES
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +As noted above the `<key>=<value>` definitions are documented by the
> +`bundle.*` config namespace.

Same comment as earlier - this is a confusing way to phrase this. If you
mean "the keys are part of the `bundle.*` namespace documented in
linkgit:git-config[1]", I think you can just say that directly. If not, it
would help to clarify the relationship between the `bundle.*` namespace and
these keys.

> +
> +In particular, the `bundle.version` key specifies an integer value. The
> +only accepted value at the moment is `1`, but if the client sees an
> +unexpected value here then the client MUST ignore the bundle list.
> +
> +As long as `bundle.version` is understood, all other unknown keys MAY be
> +ignored by the client. The server will guarantee compatibility with older
> +clients, though newer clients may be better able to use the extra keys to
> +minimize downloads.
> +
> +Any backwards-incompatible addition of pre-URI key-value will be
> +guarded by a new `bundle.version` value or values in 'bundle-uri'
> +capability advertisement itself, and/or by new future `bundle-uri`
> +request arguments.
> +
> +Some example key-value pairs that are not currently implemented but could
> +be implemented in the future include:
> +
> + * Add a "hash=<val>" or "size=<bytes>" advertise the expected hash or
> +   size of the bundle file.
> +
> + * Advertise that one or more bundle files are the same (to e.g. have
> +   clients round-robin or otherwise choose one of N possible files).
> +
> + * A "oid=<OID>" shortcut and "prerequisite=<OID>" shortcut. For
> +   expressing the common case of a bundle with one tip and no
> +   prerequisites, or one tip and one prerequisite.
> ++
> +This would allow for optimizing the common case of servers who'd like
> +to provide one "big bundle" containing only their "main" branch,
> +and/or incremental updates thereof.
> ++
> +A client receiving such a a response MAY assume that they can skip
> +retrieving the header from a bundle at the indicated URI, and thus
> +save themselves and the server(s) the request(s) needed to inspect the
> +headers of that bundle or bundles.

Overall, this document is quite thorough, especially with respect to edge
cases/error handling. I found it a bit confusing at times (at least
partially due to my unfamiliarity with protocol v2), including some
potentially ambiguous phrasing or scenarios (especially those in the
disconnection & error recovery sections) that are difficult to clearly
describe in generic terms.

I think some sections (especially "PROTOCOL for bundle-uri" and "bundle-uri
CLIENT AND SERVER EXPECTATIONS") would benefit from examples of what "good"
and "bad" request/response values & behaviors look like; they would help
illustrate some of those more complex situations. The rest of the patch (the
implementation & tests) looked good to me. 

Thanks for your continued work on this, I'm really excited to see the next
steps of bundle servers in this series!

