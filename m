Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3D536B
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 00:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lW+Il/bz"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D03112
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 17:35:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CA7501B93B5;
	Sun, 22 Oct 2023 20:35:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8AvY9Xv/V9JR
	o3AejVWImN2hjj1Wf2Fy7IGMrF03Mq0=; b=lW+Il/bzjW087k1AF0IYqcC6g7TU
	eNCUtWNy2dsgc2g+JDvti1Sot10ndTT6T90k2FufoHpdEqNXxNMCI4c2dgPJ6u8J
	7G16U4vigYrQAeMyCz0J1ndBTtySNH50hvLaxRpDTLaXXNKhSJkg7HpnIFCxTVP6
	PfAVNro5wvJNXHU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C03BF1B93B4;
	Sun, 22 Oct 2023 20:35:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 365B11B93B3;
	Sun, 22 Oct 2023 20:35:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: cousteau via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Javier Mora <cousteaulecommandant@gmail.com>
Subject: Re: [PATCH] doc/git-bisect: clarify `git bisect run` syntax
In-Reply-To: <CAPig+cS4J-L44a-fjQ=2bXxRj6e1qdQK8705K3NPqmTsWXBQsw@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 22 Oct 2023 17:32:45 -0400")
References: <pull.1602.git.1698004968582.gitgitgadget@gmail.com>
	<CAPig+cS4J-L44a-fjQ=2bXxRj6e1qdQK8705K3NPqmTsWXBQsw@mail.gmail.com>
Date: Sun, 22 Oct 2023 17:35:41 -0700
Message-ID: <xmqqa5sap44i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 18C19E26-713C-11EE-8FF7-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Oct 22, 2023 at 4:03=E2=80=AFPM cousteau via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> The description of the `git bisect run` command syntax at the beginnin=
g
>> of the manpage is `git bisect run <cmd>...`, which isn't quite clear
>> about what `<cmd>` is or what the `...` mean; one could think that it =
is
>> the whole (quoted) command line with all arguments in a single string,
>> or that it supports multiple commands, or that it doesn't accept
>> commands with arguments at all.
>>
>> Change to `git bisect run <cmd> [<arg>...]` to clarify the syntax.
>
> Okay, makes sense.
>
>> Signed-off-by: Javier Mora <cousteaulecommandant@gmail.com>
>> ---
>> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.t=
xt
>> @@ -26,7 +26,7 @@ on the subcommand:
>> - git bisect run <cmd>...
>> + git bisect run <cmd> [<arg>...]
>
> The output of `git bisect -h` suffers the same problem. Perhaps this
> patch can fix that, as well?

Good eyes.

Not a new problem and obviously can be left outside of this simple
update, but I wonder if we should eventually move these into the
proper SYNOPSIS section.  Other multi-modal commands like "git
checkout", "git rebase", etc. do list different forms all in the
SYNOPSIS section.

I also thought at least some commands we know the "-h" output and
SYNOPSIS match, we had tests to ensure they do not drift apart.  We
would probably want to cover more subcommands with t0450.

Thanks.
