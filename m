Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEFFC433E0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 00:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85D722073B
	for <git@archiver.kernel.org>; Sat, 30 May 2020 00:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J/ayW5fr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgE3APM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 20:15:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63185 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE3APL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 20:15:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 842AD53010;
        Fri, 29 May 2020 20:15:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=osnESqlA8OX4wamQtudmIr5swDg=; b=J/ayW5
        frPGOTeo5NPmFoNoRoBx+UHuiAw5gF+xXwjHC2BnlEbfKTwVpx7rrvj2lnh00NlB
        IpRAxDvkA6zFFV+VoPc0iAyDkxky6NJGByuOIdGyXFVdld5UZT+NLEvu2++9Fqzf
        XSbZGEShM2qugRCwtOcI7nn6BPSTf7VYCt5jI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ri3siCl/j+EI+DaW+Pin2a4L88yVaOEK
        t8wTQGwHfGrF0RxOf06z8uWqwWS52dGS1FfU0DcxHH9C3/IWr92xYJgBtcwjf4VX
        0TT/T0Xp2Omv3Yed2CZRGZEaNyFDQNaHABCxx8P2ASJ559YEiTlMQmjIDIkt81SJ
        QVq/Ixgcxws=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5867C5300F;
        Fri, 29 May 2020 20:15:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B0A25300B;
        Fri, 29 May 2020 20:15:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/8] Documentation: add Packfile URIs design doc
References: <cover.1590789428.git.jonathantanmy@google.com>
        <4eea9d927af1df11cdb0342e969b293a6e317d46.1590789428.git.jonathantanmy@google.com>
Date:   Fri, 29 May 2020 17:15:01 -0700
In-Reply-To: <4eea9d927af1df11cdb0342e969b293a6e317d46.1590789428.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 29 May 2020 15:30:17 -0700")
Message-ID: <xmqq5zcexoqi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B263FA2-A20A-11EA-A2BA-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/technical/packfile-uri.txt | 78 ++++++++++++++++++++++++
>  Documentation/technical/protocol-v2.txt  | 28 ++++++++-
>  2 files changed, 105 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/technical/packfile-uri.txt
>
> diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
> new file mode 100644
> index 0000000000..6a5a6440d5
> --- /dev/null
> +++ b/Documentation/technical/packfile-uri.txt
> @@ -0,0 +1,78 @@
> +Packfile URIs
> +=============
> +
> +This feature allows servers to serve part of their packfile response as URIs.
> +This allows server designs that improve scalability in bandwidth and CPU usage
> +(for example, by serving some data through a CDN), and (in the future) provides
> +some measure of resumability to clients.
> +
> +This feature is available only in protocol version 2.

Yay.

> +Protocol
> +--------
> +
> +The server advertises `packfile-uris`.

Is this a new "protocol capability"?  There are multiple things that
are "advertised" over the wire (there is "reference advertisement")
and readers would want to know if this is yet another kind of
advertisement or a new variety of the "capability".

> +If the client then communicates which protocols (HTTPS, etc.) it supports with
> +a `packfile-uris` argument, the server MAY send a `packfile-uris` section
> +directly before the `packfile` section (right after `wanted-refs` if it is
> +sent) containing URIs of any of the given protocols. The URIs point to
> +packfiles that use only features that the client has declared that it supports
> +(e.g. ofs-delta and thin-pack). See protocol-v2.txt for the documentation of
> +this section.
> +
> +Clients then should understand that the returned packfile could be incomplete,

I am guessing that this merely mean that the result of downloading
and installing the packfile does not necessarily make the resulting
repository up-to-date with respect to the "want" the "fetch" command
requested.  But the above can easily be misread that the returned
packfile is somewhat broken, corrupt or missing objects that it
ought to have (e.g. a deltified object lacks its base object in the
file). [#1]

> +and that it needs to download all the given URIs before the fetch or clone is
> +complete.

So if I say "I want history leading to commit X", and choose to use
the packfile-uris that told me to fetch two packfiles P and Q, does
it mean that I need to only fetch P and Q, index-pack them and store
the resulting two packfiles and their idx files in my repository, do
I have the history leading to commit X?

I would have guessed that the resulting repository after fetching
these URIs can still be incomplete and the "packfile" section of the
response needs to be processed before the fetch or clone is complete,
but the above does not say so.

> +Server design
> +-------------
> +
> +The server can be trivially made compatible with the proposed protocol by
> +having it advertise `packfile-uris`, tolerating the client sending
> +`packfile-uris`, and never sending any `packfile-uris` section. But we should
> +include some sort of non-trivial implementation in the Minimum Viable Product,
> +at least so that we can test the client.
> +
> +This is the implementation: a feature, marked experimental, that allows the
> +server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
> +<uri>` entries. Whenever the list of objects to be sent is assembled, a blob
> +with the given sha1 can be replaced by the given URI. This allows, for example,
> +servers to delegate serving of large blobs to CDNs.

Let me see if the above is understandable.

Does "git cat-file blob <sha1>" come back when we try to "wget/curl"
the <uri>?

> +Client design
> +-------------
> +
> +While fetching, the client needs to remember the list of URIs and cannot
> +declare that the fetch is complete until all URIs have been downloaded as
> +packfiles.

Same question again.  As URIs are allowed to be incomplete (point #1 above),
it is still too early to declare success after all URIs have been downloaded
as packfiles, isn't it?  Shouldn't the "latest bits" need to be extracted
out of the usual "packfile" section of the protocol?

> +The division of work (initial fetch + additional URIs) introduces convenient
> +points for resumption of an interrupted clone - such resumption can be done
> +after the Minimum Viable Product (see "Future work").
> +
> +The client can inhibit this feature (i.e. refrain from sending the
> +`packfile-uris` parameter) by passing --no-packfile-uris to `git fetch`.

By default, as long as the other side advertises packfile-uris, the
client automatically attempts to use it and users need to explicitly
disable it?  

It's quite different from the way we introduce new features and I am
wondering if it is a good approach.

> + * On the server, a long-running process that takes in entire requests and
> +   outputs a list of URIs and the corresponding inclusion and exclusion sets of
> +   objects. This allows, e.g., signed URIs to be used and packfiles for common
> +   requests to be cached.

Did we discuss "inclusion and exclusion sets" whatever they are?

> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index ef7514a3ee..7e1b3a0bfe 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -325,13 +325,26 @@ included in the client's request:
>  	indicating its sideband (1, 2, or 3), and the server may send "0005\2"
>  	(a PKT-LINE of sideband 2 with no payload) as a keepalive packet.
>  
> +If the 'packfile-uris' feature is advertised, the following argument
> +can be included in the client's request as well as the potential
> +addition of the 'packfile-uris' section in the server's response as
> +explained below.
> +
> +    packfile-uris <comma-separated list of protocols>
> +	Indicates to the server that the client is willing to receive
> +	URIs of any of the given protocols in place of objects in the
> +	sent packfile. Before performing the connectivity check, the
> +	client should download from all given URIs. Currently, the
> +	protocols supported are "http" and "https".

Ah, I think the puzzlement I repeatedly expressed above is starting
to dissolve.  You are assuming that the receiving end would remember
the URIs but the in-protocol packfile data at the end is handled
first, and then before the final connectivity check is done,
packfiles are downloaded from the URIs.  If you spelled out that
assumption early in the document, then I wouldn't have had to ask
all those questions.  I was assuming a different order (i.e. CDN
packfiles first to establish the baseline, and then in-protocol
packfile to fill the "latest bits", the last mile to reach the tips
of requested refs).

In practice, I suspect that these fetches would go in parallel with
the processing of the in-protocol packfile, but spelling it out as
if these are done sequencially would help establishing the right
mental model.  

"(1) Process in-protocol packfiles first, and then (2) fetch CDN
URIs, and after all is done, (3) update the tips of refs" would
serve as a base to establish a good mental model.  It would be even
better to throw in another step before all that: (0) record the
wanted-refs and CDN URIs to the safe place.  If you get disconnected
before finishing (1), you have to redo from the scratch, but once
you finished (0) and (1), then (2) and (3) can be done at your
leisure using the information you saved in step (0), and (1) can be
retried if your connection is lousy.

>  The response of `fetch` is broken into a number of sections separated by
>  delimiter packets (0001), with each section beginning with its section
>  header. Most sections are sent only when the packfile is sent.
>  
>      output = acknowledgements flush-pkt |
>  	     [acknowledgments delim-pkt] [shallow-info delim-pkt]
> -	     [wanted-refs delim-pkt] packfile flush-pkt
> +	     [wanted-refs delim-pkt] [packfile-uris delim-pkt]
> +	     packfile flush-pkt
>  
>      acknowledgments = PKT-LINE("acknowledgments" LF)
>  		      (nak | *ack)
> @@ -349,6 +362,9 @@ header. Most sections are sent only when the packfile is sent.
>  		  *PKT-LINE(wanted-ref LF)
>      wanted-ref = obj-id SP refname
>  
> +    packfile-uris = PKT-LINE("packfile-uris" LF) *packfile-uri
> +    packfile-uri = PKT-LINE(40*(HEXDIGIT) SP *%x20-ff LF)

40* 

>      packfile = PKT-LINE("packfile" LF)
>  	       *PKT-LINE(%x01-03 *%x00-ff)
>  
> @@ -420,6 +436,16 @@ header. Most sections are sent only when the packfile is sent.
>  	* The server MUST NOT send any refs which were not requested
>  	  using 'want-ref' lines.
>  
> +    packfile-uris section
> +	* This section is only included if the client sent
> +	  'packfile-uris' and the server has at least one such URI to
> +	  send.
> +
> +	* Always begins with the section header "packfile-uris".
> +
> +	* For each URI the server sends, it sends a hash of the pack's
> +	  contents (as output by git index-pack) followed by the URI.

OK.  This allows the URI that feeds us the packfile contents to have
any name, and still lets us verify the contents match what the other
end wanted to feed us.

Thanks.

>      packfile section
>  	* This section is only included if the client has sent 'want'
>  	  lines in its request and either requested that no more
