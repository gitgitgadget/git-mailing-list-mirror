Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C8630595D
	for <git@vger.kernel.org>; Sat, 25 Oct 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409215; cv=none; b=HWP9wV7U5AFb/dcF5ZCLw5i3PSTXuTXD3QUztSxZwax76u0zUmPmT35wj2iGbtEU+fjZU2/PHSXle68dPjS9uuAafrRzrGQdBsOcAtpFsyzN0RzsZUgXwC3wG6FsAWUFfOvndCx/LnGNf73ehyIng2Cw/haGqUTw2AgfyIVD644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409215; c=relaxed/simple;
	bh=VlfuD/INSVDqlDaHFKeqr/OOYotIsEQKQnuq8LYue4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QYvWf7dUa9E6RDrSRtfmJN0aZ/BfP6guAOUHVGAdXFt+1eE39KeOKf9az+cen+V69mr5/15lS46MhetUlVSCaTZetXD/YTcrW4J0JfOs/fvFjpKtLLhMbOkJtCbGGQb75pFi0/zPPrJsm6rd+BsWAxQtLXWDRMgUgRC63Wlw4ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Rw1HlAt/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JVCi0ldo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rw1HlAt/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JVCi0ldo"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 453D5EC0326;
	Sat, 25 Oct 2025 12:20:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 25 Oct 2025 12:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1761409212;
	 x=1761495612; bh=NDYbDtdBuZXx8XFRdXFZj/KYAe5VgDaeO9i0xdIMnas=; b=
	Rw1HlAt/1Wr9NKerLRYFyj2ojTlBkNCZdI7aS37bUaZJs69AX4r1jZ/LbRxhU1au
	6KFdZ4e+plHidK4OBVvmjvTWAMlhUE0zd54JIkEKsJtg6hKdTJTCvtXea/iHPIWp
	2bcvZIPMNaE67HLeHTk6M3YblqRjMYTZDL9Nx6SRmgmiUL0mxvHcX1z+qIGaQ5N9
	luerxmxya/WKLlRWQmnh68Pem31tymayJfxuGuFfREJ3+tBNVlzPFuRhe6G7VqFB
	PgYN2f6umbooc4Iq9YbhcBnFMjF9kFC31r6j/s/hXeGuuAYVWCjTmC36NDbEbuuj
	SQSl4NH6kYDw/K6uarSpmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761409212; x=
	1761495612; bh=NDYbDtdBuZXx8XFRdXFZj/KYAe5VgDaeO9i0xdIMnas=; b=J
	VCi0ldoCWDEzjSzjei9e2XU3BZajI/CT8uzMqKpnCzQ5x2yILYDssKW2kkd47cTO
	ogHIDvEkfZj6pX1nT7HRZpT3tUi2yZggIkJMw6zh++PxNRvUshQWfMTdm9nm3n0r
	zvSEw4MGMKhve6y9iWCF9dX9DiHP9gUcZqzNHzkdrxxd4YltC/zy4ViUX2d3uyeV
	O8qhOkuS76tSU+BlzMgLKdM9/nYbbC36PzaDsECyz+THrZbJulmAb1RUS5+H591N
	/hPixeoX46ATUA+SmUd1vkkYAeDyn165zmsvRUuqx5If7UMKcS3S3SeN+D/EMpb0
	b0Hbngfe7fb4XKMDfF4CA==
X-ME-Sender: <xms:vPj8aDzSEMLlAqYj5uhxBn-2OOs1bno5oaQhqFsPDaR6x-UOlG_YHw>
    <xme:vPj8aCtjLUeNLpKijn9krIV05xD8WAD6pwP2l2Q-9Wqh6KhlXQGfUGJKGM-H8ZYTZ
    -0iOZS_bq-9VbEId0_CY3MGjWaQjTnYDIWISW0AiK3Id9DsiR8iYQU>
X-ME-Received: <xmr:vPj8aKvjjf-ywWmu97JQniSRwoVvVQY3LJXggU1rwUnhxixI_4A6XJahZutbFPfHjg5zVdYzHlpoYyeOMnG3Ck8uBmm6QTizBFx1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedvieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnhepieeihfdufeefueeiheffffevtd
    fhteevueehudfhheetgedukeffheejgeejveevnecuffhomhgrihhnpegrugguqdhprght
    tghhrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vPj8aHMVZF7n37SwDKyfREQZ96aqYuKuBkyDeUmgGXi7yMHzlIVoug>
    <xmx:vPj8aI3vRwZoPCPJUy6l9GFytpp2n9Bbua1TEcLbwBed_1-tFhqm1w>
    <xmx:vPj8aDMuZ3SiOmLzCEm4sURr9ScK37MbiSS_DcLeQCwdBQC5O6wMiQ>
    <xmx:vPj8aI2HR4J8KmaHG27g5oQhe1QcPGm6QES8bbmP7ynpp_P_GtAhNQ>
    <xmx:vPj8aJWKLfqX90APuJ0CiIhmGoaJtebx6onGPmQwIZYJ9Gbq9YkYRR5V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Oct 2025 12:20:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] add-patch: quit on EOF
In-Reply-To: <13529bee-1e02-4c20-9461-6569312bfe4f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 25 Oct 2025 07:48:28 +0200")
References: <0985f775-fb01-4de0-99a8-4775b602829a@web.de>
	<13529bee-1e02-4c20-9461-6569312bfe4f@web.de>
Date: Sat, 25 Oct 2025 09:20:10 -0700
Message-ID: <xmqqfrb7nebp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> If we reach the end of the input, e.g. because the user pressed ctrl-D
> on Linux, there is no point in showing any more prompts, as we won't get
> any reply.  Do the same as option 'q' would: Quit.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  add-patch.c                |  4 +++-
>  t/t3701-add-interactive.sh | 11 +++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)

The code breaks out of the loop (either with or without setting the
'quit' flag), after which there is "which hunks are going to be
used?"  check, followed by "apply the selected hunks".  So the new
ctrl-D behaviour does not change the end-result left in the files.
The effect of the hunks chosen for application will not be abandoned.

If you are one of those unfortunate folks living dangeously with
interactive.singlekey set to true, your ctrl-D would have given you

    Unknown command '' (use '?' for help)

in the code before this change, so, this would give them strict
improvement.

The current code happens to *work* for those without the single key
setting, in the sense that when we move to subsequent files, the
first call to read_single_character() in patfch_update_file() for
them immediately return EOF, breaking out of the loop before any
hunks for the file gets marked for application, so we'll iterate
through the remaining files without doing anything to these files.

But we do show the first hunk of all of them before quitting.  And
this patch squelches these useless output.

OK.  This makes sense and makes the change in this patch worthwhile.

I wonder if we want to 'echo" something in this case, though.  If I
say 'q', whether interactive.singlekey is active or not, I see

    (1/1) Stage this hunk [y,n,q,a,d,s,e,p,P,?]? q

on the last line before getting the shell prompt back.  With this
change, I won't see anything after the prompt.  Perhaps it is OK?  I
dunno.  Perhaps we want to pretend as if 'q' were given instead of
EOF, like the following?  I dunno.

Will queue as-is.

Thanks.

 add-patch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/add-patch.c w/add-patch.c
index cd71a0359a..f201ead08e 100644
--- c/add-patch.c
+++ w/add-patch.c
@@ -1558,8 +1558,8 @@ static int patch_update_file(struct add_p_state *s,
 			fputs(s->s.reset_color_interactive, stdout);
 		fflush(stdout);
 		if (read_single_character(s) == EOF) {
-			quit = 1;
-			break;
+			puts("q");
+			strbuf_addch(&s->answer, 'q');
 		}
 
 		if (!s->answer.len)
