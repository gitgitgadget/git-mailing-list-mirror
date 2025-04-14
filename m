Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1730E1AF0AE
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744658446; cv=none; b=uk1OZEC91/kz/wFk5WRXVbn0QrJ3vURjKQADQFy16E7dP1BuDhEzEbmpcyllzKLuYESPY1ew18yx4ey5B/8jjSDXspozkzadViwF+bZThOtCWveQveLG9Jo6SeMgceBBzdvMkzLB+2Pxjj8AlqRYr22huGTE0944FrDlY0qLviM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744658446; c=relaxed/simple;
	bh=zUcMpt9XKf57VBL1Zgvv7L4VndK54ia4S053pmh2z/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iK4PaWy1snfdIGNHKWfk2vJsPeMcS+eiRdqEsypq4ARoGmeJZrxgxPwH5D1hIaxrHh9s3uuhFvxU74Ge1VyqqxvekIatFkWicUkmW5FMQ4zUJmkS4ybMiH0TuD/on+2JzZ3s1VRGBwUCVg18kaCQKToss2Ry2vSdtgSLEE1yfLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XABi+kUC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PZMsN5ie; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XABi+kUC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PZMsN5ie"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 035481380774;
	Mon, 14 Apr 2025 15:20:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 14 Apr 2025 15:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744658442; x=1744744842; bh=ylDurspAzq
	3D9GHUDmTlzdsvNCet/2TLlyUGfEIEkvs=; b=XABi+kUCp/irVhakceBHVe15Up
	uwHYFvAQqFhZzelhsSWOwrJEM01YMMf6z2CLgw0XbUAefq8OUqcwsk0uArDqbUkL
	rDmQ1QH989wa+1I4uZ84WUSRA/C7zPqHJjW4hIDs0WAUvzDU+UZYidtII+9lbcXr
	X9wjN2M8Ed9ZenUy/j9LbMhHGxyfOAmGNvRMCA9z096gzgVzxbLG9Juq6bgDdEFo
	ucHBji0ca5meczoGb6hitHGYTSSCc+Bfgjxj9wno6l4NJs86FtQeZBieQ+fhygOQ
	Ftzx2GrnPcMdiadCFZEcynt5BFaI8qtgj1hrAO0r9ZULlgxR2kOHWwhMg10Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744658442; x=1744744842; bh=ylDurspAzq3D9GHUDmTlzdsvNCet/2TLlyU
	GfEIEkvs=; b=PZMsN5ieSCwqd/xKU0mi9NCGEEjB87zHbZJYqYNVL8NgxjChuKk
	3h1DNgqHglKjVrWh79TEk9Sa0ZDSg7lV9p9zSVQL39RRQ1BWW1Gdf8a4CrLUvJdH
	0Hi8FT2TGx+sjR3BdQsvwoYezkW1ag2uWHW+FsoD8+9bqBB3I5hdXXruEUMpQCiP
	VpK7aWR+/FcE6oZNIs8KGLMQuZlBZWuvjsGXI41KEOQAW5hYE5IuiL93TMiSos8X
	VtN6QFw+JNu5LU44wU0xZRQf/4W72wVjw79KnC2TAiXZf0IdCndDnrImFxN/tV7Y
	+5WNTm3xnG5eAAwy3EXmoaHX5ydONTmuA6w==
X-ME-Sender: <xms:CmD9Z3WJtnuc-_DqNpUY6qvsPw_Nwm9D_wXr6s5nZzMT6ijP5ZwqGA>
    <xme:CmD9Z_nACSLskA16ICn2gnPxBKtCre2JJaPg8TObv41KwXW0wBt_Bvjh6HD-Msi4q
    em_GOatgXLyF7q0Ng>
X-ME-Received: <xmr:CmD9ZzY4cwy93GNXHSUp_yzAbKapxBqvDcSczKMcnhNNO-qoagwuD7xmWRNSH9D0JwZJse_M512uhLRmMH2HZidFxdYc8HFsazn0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddufeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:CmD9ZyXfOrz-Ns7BiWn7QoR3Pv97Lh5xXjth06Zhz5XOdbqqGAZElw>
    <xmx:CmD9ZxkF7BGlTxAtIozbMkikWTMlIpdFjjXa9auzDaD6es6AilMDew>
    <xmx:CmD9Z_c9BZC2OEY8IfvOoh2OaFTdm4hbXxdCsEKaIl2sDppcCyI0zg>
    <xmx:CmD9Z7HdOMyCvfWoUjgihbQuWVaKuoRy8n37OhJYNZjNmoGS8_5RpQ>
    <xmx:CmD9Z0ldxklsPHwm1wmtrvkiwFF0JV2dOvjScJ_N4owjoS6a8ghpdSMB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 15:20:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/5] t/perf: use configured PERL_PATH
In-Reply-To: <Z_ywLLN5xj6cYFN9@pks.im> (Patrick Steinhardt's message of "Mon,
	14 Apr 2025 08:50:20 +0200")
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
	<20250331-pks-meson-benchmarks-v1-2-b2ace85616a3@pks.im>
	<87semgdyxb.fsf@iotcl.com> <Z_ywLLN5xj6cYFN9@pks.im>
Date: Mon, 14 Apr 2025 12:20:40 -0700
Message-ID: <xmqq5xj6r1mf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > Use "PERL_PATH" to execute Perl scripts, which makes them work on more
>> > esoteric systems like NixOS.
>> 
>> I see in `t/perf/README` there's a mention of running `./aggregate.perl`
>> directly? Shall we inform the user to run that through their Perl as
>> well?
>> 
>> -    $ ./aggregate.perl . /path/to/other/git ./p0001-rev-list.sh
>> +    $ perl ./aggregate.perl . /path/to/other/git ./p0001-rev-list.sh

Good.

>> 
>> Or do we expect users to know what they are doing when they don't have
>> Perl installed at /usr/bin/perl?
>
> Another solution could be to switch the shebang to `#!/usr/bin/env
> perl`. We also do this for "t/chainlint.pl".

When you do not have perl installed anywhere, how does this fail?  I
think you would get

    $ ./aggregate.perl ...
    /usr/bin/env: 'perl': No such file or directory

and compared to that, 

    $ perl ./aggregate.perl ...
    bash: perl: command not found

I think it makes it slightly more obvious to those who lack perl on
their $PATH what is going wrong to explicitly tell them to run
"perl" like Toon's suggestion above (primarily because use of
/usr/bin/env is not obvious to those who are told to run
./aggregate.perl script).

