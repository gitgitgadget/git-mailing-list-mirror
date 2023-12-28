Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F13163
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B1OfNgYr"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D468C18918;
	Wed, 27 Dec 2023 19:10:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gDTGFKfsxq79
	GUkK9uizCX4cRTdDCnjeT433KGrcUDQ=; b=B1OfNgYrzDE0H7NubNrL/bUDCe9E
	lLx6A3YhD6PCoaEzNCbEYNFE95opbMCZXdvVYYvPxT/tzbyL0qYAb0GBbCE5QWn+
	0YPNINf2ln8p4tFA2GVuG3Ngiw+UxIXK6TSWGQ/kKetlRsRBRioNT1q5cIEfYXKx
	XmlUrKqV7n/DrdQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CC1BC18917;
	Wed, 27 Dec 2023 19:10:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4952A18916;
	Wed, 27 Dec 2023 19:10:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Britton Leo Kerin <britton.kerin@gmail.com>,  git@vger.kernel.org,
  Britton L Kerin <britton.kergin@gmail.com>
Subject: Re: [PATCH 1/1] doc: use singular form of repeatable path arg
In-Reply-To: <CAPig+cShsSSd-jpvSW_sq3-R++zjtHU-m2PmTsz-Nx9YVRStug@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 27 Dec 2023 17:29:20 -0500")
References: <20231227205340.9886-1-britton.kerin@gmail.com>
	<3d46bca1-96d4-43ba-a912-1f7c76942287@smtp-relay.sendinblue.com>
	<CAPig+cShsSSd-jpvSW_sq3-R++zjtHU-m2PmTsz-Nx9YVRStug@mail.gmail.com>
Date: Wed, 27 Dec 2023 16:10:50 -0800
Message-ID: <xmqq5y0jkwz9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8FF4F292-A515-11EE-8A9F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Dec 27, 2023 at 3:55=E2=80=AFPM Britton Leo Kerin
> <britton.kerin@gmail.com> wrote:
>> This is more correct because the <path>... doc syntax already indicate=
s
>> that the arg is "array-type".  It's how other tools do it.  Finally, t=
he
>> later document text mentions 'path' arguments, while it doesn't mentio=
n
>> 'paths'.
>
> Yep, makes sense.
>
>> Signed-off-by: Britton L Kerin <britton.kergin@gmail.com>

Micronit.  This should be identical to how From: line identifies the
author.  s/L/Leo/ should be sufficient, I presume?

>> ---
>> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.t=
xt
>> @@ -17,7 +17,7 @@ The command takes various subcommands, and different=
 options depending
>>   git bisect start [--term-(new|bad)=3D<term-new> --term-(old|good)=3D=
<term-old>]
>> -                 [--no-checkout] [--first-parent] [<bad> [<good>...]]=
 [--] [<paths>...]
>> +                 [--no-checkout] [--first-parent] [<bad> [<good>...]]=
 [--] [<path>...]
>
> Looking good.
>
> In builtin/bisect.c, the "usage" string says "[<pathspec>...]" rather
> than "[<path>...]". Perhaps it makes sense to unify these?

Yup, and that would be a good thing to do in a single patch, and
also it would be a good place to stop.  Further clean-up you
suggested below are very much worth doing, but it probably is good
to leave out of this single focused fix we are reviewing here and
instead be done as separate patch(es).

Thanks.

> Also, there are a few more documentation files that could use the
> "<paths>" to "<path>..." fixup (though not always in the synopsis). A
> 'grep' indicates that git-checkout.txt, git-diff.txt, and
> git-rev-list-options.txt also mention "<paths>". Those may be outside
> the scope of this patch, although they could easily be included, as
> well, or made part of a patch series if you feel inclined.
