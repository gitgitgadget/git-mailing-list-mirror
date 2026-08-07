Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768813B1B3
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 00:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786062661; cv=none; b=Da7jb9FqEf5O+GeMd/veIuzrzlK/uroaP2QhP+Bt+vOqnfE7bzfL3uYdDwJ5AZvlkRaHIZLq2KBbfTBX8LQyPo/GTGIeD3fx/RUwXIPkYNB/Cw0A3BMYR8WlNYGqjhiAquwRyEGAK4dICc0HHVjCp4MGY7y3jRpHZ1/Ix3pNtxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786062661; c=relaxed/simple;
	bh=Rr+GNsqWNWzbuTwCzO/UqWo4axijE/5UipmXqaVSc84=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=pvPFV7cujFSJlFcStnYRdV9/0t6+lsS1OObc5pJDH3eEzeXQjDXbCQmWmW1+ighGwLyLhVZRrdBPieM+mbJ5NK6JnyUNpbTps4ktxMsjqqD/WIwN11Agem2pgg/NrHTkOk20GwsCxjzoHz2jdVEa27uxzT5a+9RtJ5F9ELIi5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWPDzZGF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWPDzZGF"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47fe89fb333so1688958f8f.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 17:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786062657; x=1786667457; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zmnrSdqJzWvAUolxoMnsJeWG8nwAiHMD4qK06wzMkXY=;
        b=gWPDzZGF9LqC0wPikP1E5xnMsavBLOMNR9URBJcZoiOJ7nMnvC5Gp/xfY0bQ2AA2Xy
         hAqJ2p4y7G2bzrqVv+fqXOAYOuP4uYA9o77qWJePdrHvcyUDLbHKiVA8HYN/GFEUMDOx
         2wz8tynVQRlzuxK/1Gs8buKKGB2fU7zLSZsdvcVnSeXVrCIicHKLE5goKJ6w17arde1z
         t1lFql5RdnGH3VrwaFs3NZWItcrdPQ3kbx9B/lQndgZ61wKbetCTKMJHB5ZVc3GZeBEu
         1nRx3zbiqbcJOUzKK8MNzNq9tNN9tv1lzjwMpuvq1I3Rk9Kd2I8E81Y8r4PrThHwxUeE
         szxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786062657; x=1786667457;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmnrSdqJzWvAUolxoMnsJeWG8nwAiHMD4qK06wzMkXY=;
        b=KiHu4HScFNiZxM7vDpU6jVGAdrk2+nqeUYObZYqXAH8joN6TV4iFAwt57dH1ndxUFu
         inBlZ4YXSullDCmng7wgBovT6lEfQoocvQl1suSs6SgM1OryztyRy4QRy9eWwXGGPlMw
         xiBgllRnrAdnYkC81YPw3BJdLCpg1p7d9OYzSzVElL5y4EDhRtLLbf6/5RC8fiRLvAdn
         mtq9qnNpcU5ONR0sgm6pYA8GM6HpTU7gL9pTrFEnB4URqu8VO5o3Qf3AetkQiIlF1c5Y
         9giC6rBL4AJRe2+3eYhsMJRePClCSbSfu0nVqujTunwjcc4LgTYWBJbkjj/Aswnvj5cx
         dTzw==
X-Gm-Message-State: AOJu0YwbAxHS7kTQcpcFMidcXdAmAepL7ooqbmUDnhwPv48pTbpVD9Fy
	o9lt3GUBImUhXA63k2tNiu/rtIsy7IQ02xoe2yVWPi20wBGSFTbWDAKq
X-Gm-Gg: AR+sD13C7uHyDIdQQAsbb0SYdcEbC/0KAVffYGf+ywKHb30cK5Y3UmN21wdraL5Q15s
	R9bFlcIOC8fAW5A9zz2+pRV3kUIr6PN82gQtU/LlhmDCuUg2zkPk2ZB3PcafdJ/LPpGWYIHNv3O
	WtLCI+w5LzPkES32eTVWl1lpifI0/upmzJ4dOYjDslFSijjjQ8dSy9vqzgD7aoN4AqHuafJWtci
	2NMR06mLKGgwFUDf33bMhitdc6hQM3VBI5y5Wq64VZ0/soSJfwOic/mdnzuZQ9fp3ruaEuqjNRZ
	CMYlzZeGk5Vl2ERLekF7f+t3dlkh7TiERF0qWVZm3541rw0KGV2ibQrgypnBn6wEXwpBu/mUyB2
	RIGY9vhfmq5nIzDZVYxR0NLGG7496XzfzSh4xUwJzuhWG3Klk5V3YwSf1ChDZTxlAYcUBpkGv4F
	aavmG5oTSpSd+oSv91yG9tFQ9FoN5bc5nmJx/hY9uB0FOsiu5OrdI9kr3HFzBS6P3JZDjvR0DxI
	EyM3obAT47yqasPE8oYIUn3TFgvLediYLHVF3jpvO/yXV1QE4J89f6Mg6rPxa1+04nk4kxr+nYH
	CY43CajgbAN2+IDxvdfC/cBbtHLchQpIWlj3OmqR+TjxlEZo/iM+NiJ6DEpYKrPh9npGwXmDvuk
	=
X-Received: by 2002:adf:f082:0:b0:47f:e729:c588 with SMTP id ffacd0b85a97d-47fec5224abmr24840438f8f.14.1786062657297;
        Thu, 06 Aug 2026 17:30:57 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm451329f8f.1.2026.08.06.17.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 17:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 02:30:55 +0200
Message-Id: <DKIADCID62IW.1MII8E3AYCI6F@gmail.com>
Subject: Re: [PATCH GSoC v4 0/9] cat-file: extend remote-object-info to
 support %(objecttype)
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Jeff King" <peff@peff.net>, "Pablo Sabater" <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>, <chandrapratap3519@gmail.com>,
 <karthik.188@gmail.com>, <gitster@pobox.com>
X-Mailer: aerc 0.21.0
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
 <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
 <20260806171714.GA1632126@coredump.intra.peff.net>
In-Reply-To: <20260806171714.GA1632126@coredump.intra.peff.net>

On Thu Aug 6, 2026 at 7:17 PM CEST, Jeff King wrote:
> On Tue, Aug 04, 2026 at 08:42:54PM +0200, Pablo Sabater wrote:
>
>> Patches 1-5 are preparatory. They don't change what the command does:
>> - [1/9] is a test cleanup.
>> - [2/9] fixes a possible bug in case of a malformed response.
>> - [3/9] and [4/9] refactor how the object data is stored and handled. Th=
e
>>   why about this refactor comes from [2].
>
> Thanks, I think these refactors in patches 3 and 4 make sense and
> address the issues raised in the earlier thread. I'd actually take patch
> 3 just a step further, as below (which you are welcome to put on top of
> your series, or work it into the middle, or even take as inspiration and
> rewrite as part of another patch).

Wow, thanks a lot for getting so involved, I think I'll place it as is.

>
> -- >8 --
> Subject: transport: drop remote object-info fields from transport struct
>
> A remote object-info request needs three things: the transport for
> contacting the remote, the list of oids to request, and a place to store
> the output.
>
> Rather than take these as function parameters, we take only the
> transport object, and expect the caller to have placed the other two
> into special fields in the transport struct. But this doesn't make much
> sense. The set of oids and results are really only valid for one
> request. There is no reason the transport would need to hang on to them
> outside of the single function call.
>
> Even though we save a few lines passing the parameters around through
> the various vtable functions, the result is harder to understand (for
> example, who is responsible for cleaning up results, and when shoudl it
> happen?). It also opens up the possibility of a subtle bug. A caller is
> likely to point those fields to stack variables which could go out of
> scope, and the transport struct would be left holding invalid pointers.
>
> This is mostly harmless now, as we disconnect the transport immediately
> after the sole caller of transport_fetch_object_info(). But conceptually
> we could keep we could keep the transport open and make multiple fetch
> calls (and reuse the same connection to the helper, to a remote HTTP
> server, and so on).
>
> So let's pull these out of the struct and pass them as function
> parameters. It's a little more verbose, but I think more clearly
> illustrates the intent. I've also tweaked a few function signatures to
> mark the input oid array as const, since it is purely an input to the
> function.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I do think the concept of reusing the transport will become useful
> later. We limit a single request to 10,000 objects, so it is quite
> conceivable a caller would want to make several. That can mostly come
> later on top, though I think the design of the remote-object-info
> command makes it awkward. Each invocation provides a remote by name,
> which is then resolved to a transport. But a given caller is likely
> going to provide the same remote over and over again.
>
> We probably could get away with just caching the last-used transport and
> reusing it when fed the same remote name again. But we could perhaps
> also change the protocol (which AFAICT is not yet in any released
> version, so still available for changes) to specify the two
> independently, like:
>
>    remote https://example.com/foo.git
>    remote-object-info objA objB objC...
>    remote-object-info objX objY objZ
>
> And then it is more clear that setting "remote" is stateful, and will be
> used for subsequent remote-* commands. But maybe that statefulness is
> something we don't want. I dunno.

Yeah, I think it is not in any released version yet as the
ps/cat-file-remote-object-info (the one that precedes this series)
landed in 'master' the first What's cooking of August [1].

Given that, I think that it could be a good idea to have both, if a user
foresees that he's only going to make one 'remote-object-info' command
he can write it as it is now:

  remote-object-info <remote> objA objB

But if a user foresees that he will have to make multiple ones, we can
make what you suggested:

>    remote https://example.com/foo.git
>    remote-object-info objA objB objC...
>    remote-object-info objX objY objZ

We would have to make the remote optional, if there's no remote die(),
etc. We would also have to tell apart a remote from an OID in the first
argument, but full OIDs and remote URLs are not very similar so that
should not be hard haha.

I do like the idea, but I see it more as a follow-up series after this
one, as the topic of this series is type support.
Also, I'm biased as I have little time before my deadline ends.

I'm happy to keep doing things and there are more things related to the
object-info protocol that I'd like to keep working on after finishing
GSoC.

>
> Anyway, either way I think the cleanup below is worth doing in the short
> term.
>
>  builtin/cat-file.c   |  6 ++----
>  fetch-object-info.c  |  4 ++--
>  fetch-object-info.h  |  2 +-
>  transport-helper.c   |  7 +++++--
>  transport-internal.h |  4 +++-
>  transport.c          | 14 +++++++++-----
>  transport.h          |  7 +++----
>  7 files changed, 25 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 950d9f237f..4f4d791821 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -730,10 +730,8 @@ static int get_remote_info(int argc,
>  		goto cleanup;
>  	}
>
> -	gtransport->smart_options->object_info_oids =3D object_info_oids;
> -
> -	gtransport->smart_options->object_info_results =3D results;
> -	retval =3D transport_fetch_object_info(gtransport);
> +	retval =3D transport_fetch_object_info(gtransport, object_info_oids,
> +					     results);
>  cleanup:
>  	transport_disconnect(gtransport);
>  	return retval;
> diff --git a/fetch-object-info.c b/fetch-object-info.c
> index ad27b1e4ca..385462c707 100644
> --- a/fetch-object-info.c
> +++ b/fetch-object-info.c
> @@ -12,7 +12,7 @@
>  /* Sends object-info command and its arguments into the request buffer. =
*/
>  static void send_object_info_request(const int fd_out,
>  				     const struct string_list *server_options,
> -				     struct oid_array *oids,
> +				     const struct oid_array *oids,
>  				     unsigned ask_size,
>  				     unsigned ask_type)
>  {
> @@ -54,7 +54,7 @@ static int parse_object_size(const char *s, size_t *res=
)
>
>  void fetch_object_info(enum protocol_version version,
>  		       const struct string_list *server_options,
> -		       struct oid_array *oids,
> +		       const struct oid_array *oids,
>  		       struct packet_reader *reader,
>  		       struct fetch_object_info_results *results,
>  		       int stateless_rpc,
> diff --git a/fetch-object-info.h b/fetch-object-info.h
> index 10b3641f7c..2fba96c6f7 100644
> --- a/fetch-object-info.h
> +++ b/fetch-object-info.h
> @@ -29,7 +29,7 @@ struct oid_array;
>   */
>  void fetch_object_info(enum protocol_version version,
>  		       const struct string_list *server_options,
> -		       struct oid_array *oids,
> +		       const struct oid_array *oids,
>  		       struct packet_reader *reader,
>  		       struct fetch_object_info_results *results,
>  		       int stateless_rpc,
> diff --git a/transport-helper.c b/transport-helper.c
> index f3cb8f8662..d5a064d386 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -786,11 +786,14 @@ static int fetch_refs(struct transport *transport,
>  	return -1;
>  }
>
> -static int fetch_object_info_helper(struct transport *transport)
> +static int fetch_object_info_helper(struct transport *transport,
> +				    const struct oid_array *oids,
> +				    struct fetch_object_info_results *results)
>  {
>  	get_helper(transport);
>  	if (process_connect(transport, 0))
> -		return transport->vtable->fetch_object_info(transport);
> +		return transport->vtable->fetch_object_info(transport, oids,
> +							    results);
>
>  	die(_("object-info requires protocol v2"));
>  }
> diff --git a/transport-internal.h b/transport-internal.h
> index 60db0bedcd..e7ead5d785 100644
> --- a/transport-internal.h
> +++ b/transport-internal.h
> @@ -51,7 +51,9 @@ struct transport_vtable {
>  	 *
>  	 * Uses object-info capability of v2 protocol.
>  	 */
> -	int (*fetch_object_info)(struct transport *transport);
> +	int (*fetch_object_info)(struct transport *transport,
> +				 const struct oid_array *oids,
> +				 struct fetch_object_info_results *results);
>
>  	/**
>  	 * Push the objects and refs. Send the necessary objects, and
> diff --git a/transport.c b/transport.c
> index 35acdf71a2..25e2c14a7b 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -433,7 +433,9 @@ static int get_bundle_uri(struct transport *transport=
)
>  				     transport->bundles, stateless_rpc);
>  }
>
> -static int fetch_object_info_via_pack(struct transport *transport)
> +static int fetch_object_info_via_pack(struct transport *transport,
> +				      const struct oid_array *oids,
> +				      struct fetch_object_info_results *results)
>  {
>  	int ret =3D 0;
>  	struct git_transport_data *data =3D transport->data;
> @@ -450,9 +452,9 @@ static int fetch_object_info_via_pack(struct transpor=
t *transport)
>
>  	fetch_object_info(data->version,
>  			  transport->server_options,
> -			  transport->smart_options->object_info_oids,
> +			  oids,
>  			  &reader,
> -			  data->options.object_info_results,
> +			  results,
>  			  transport->stateless_rpc, data->fd[1]);
>
>  	close(data->fd[0]);
> @@ -465,11 +467,13 @@ static int fetch_object_info_via_pack(struct transp=
ort *transport)
>  	return ret;
>  }
>
> -int transport_fetch_object_info(struct transport *transport)
> +int transport_fetch_object_info(struct transport *transport,
> +				const struct oid_array *oids,
> +				struct fetch_object_info_results *results)
>  {
>  	if (!transport->vtable->fetch_object_info)
>  		die(_("remote does not support object-info"));
> -	return transport->vtable->fetch_object_info(transport);
> +	return transport->vtable->fetch_object_info(transport, oids, results);
>  }
>
>  static int fetch_refs_via_pack(struct transport *transport,
> diff --git a/transport.h b/transport.h
> index 6948b65db9..39193d0077 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -57,9 +57,6 @@ struct git_transport_options {
>  	 * common commits to this oidset instead of fetching any packfiles.
>  	 */
>  	struct oidset *acked_commits;
> -
> -	struct oid_array *object_info_oids;
> -	struct fetch_object_info_results *object_info_results;
>  };
>
>  enum transport_family {
> @@ -317,7 +314,9 @@ int transport_fetch_refs(struct transport *transport,=
 struct ref *refs);
>  /*
>   * Fetch the object info from remote
>   */
> -int transport_fetch_object_info(struct transport *transport);
> +int transport_fetch_object_info(struct transport *transport,
> +				const struct oid_array *oids,
> +				struct fetch_object_info_results *results);
>
>  /*
>   * If this flag is set, unlocking will avoid to call non-async-signal-sa=
fe

I see everything all right.

There's two typos on the patch's commit message:
- s/shoudl/should/
- a duplicated "we could keep"

I will fix them, so if you see anything changed in your patch it's just
that. If I end up changing anything else, I'll let you know.

[1]: https://lore.kernel.org/git/xmqqldanxbq9.fsf@gitster.g/T/#t

Thanks, a lot,
Pablo

