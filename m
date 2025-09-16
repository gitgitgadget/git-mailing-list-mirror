Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AEC1A8F84
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757985274; cv=none; b=QBeDvhAhlb2/TH0tY4MQdZT/+1xYYuMPy7i9ZV4O2I1ch4Hr6NzN0c8OB/2kiDQES2t+K80ZYHWnnw2GzaWz3GxBH4vjY47ltrgV97xFUJ/yE6TEPXjmr2fSMVWJjfhekYZJJ5NqUQPYydVs99EyD2HiS4X8hGURSJuP3MoFceU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757985274; c=relaxed/simple;
	bh=PvDxu6kUwYG6FMqF39looTi3ud61MT6T9B56VQItdFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZIK7LRiP0Fuue+Rvgq5JMG2TUIWLO6bzDL+9sO5GmEGKOtV7r6ayJZ/iVZUX+eb6RxlG0vRGEqqz9zzW/GBxCh/6e2msETeGdteg3J28PZO/jFxxsgkQ00BUYYaoPJ/HmmMIywqO8/o4Gtk/o7EKhiJ0iuK2mAyGdeisfD+f8q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=06AC+veP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YteDk0St; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="06AC+veP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YteDk0St"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 225641D00232;
	Mon, 15 Sep 2025 21:14:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 15 Sep 2025 21:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757985269; x=1758071669; bh=VHlrCyjBeT
	1GKPmn9uSPrnwDH6QKTx5RQ/FGtnpx4tw=; b=06AC+veP33l7KlmjSohmTLl9Po
	5GK2/W85+nV/AQKQ8qUoLwdXM2zGXC1y5iMzuCurJfyimxjmV8oMBD8McMq4eHhP
	u3CuRgDoa4KhhzKB1rdusVI4Eh5BD3KMcMKC1BRpOm+EjhP78rbixOkX66AAjOmk
	41u3GTnb+iTjFPkXw2dC+qI3ro1bKSPpZdzMHpt17qc0GN+tVTxPiUebvFzvtLrI
	ZS9zhuqzu75UbhqpzvVWYyXWZi2elUrDhP6LadJFMcQVbxuhpxhvfqIroS7/r6xk
	rZmx7npWoMk0rimxz4302QhPRg6SN0S70Bm17fdmv/qj1OAr/TJ3dN17FwZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757985269; x=1758071669; bh=VHlrCyjBeT1GKPmn9uSPrnwDH6QKTx5RQ/F
	Gtnpx4tw=; b=YteDk0StUZZeFn2NthRG6BQou3DLVEM8aXMYNfBRT+hUkmVJZvx
	4sWnFDPtjdYIEH2CgOXHRXar2i/4dF96xmf8Ugk3cucAu1pfIVdRpWZXBhsvaG5c
	I2u/IESHwjShMnyWMKbofXa46BCveMbrjeEvTsCWUERINV2G1LJ0dLyc+ZTRAySn
	H3jxMPRuqUol7jGbDJdSH12N8nTQjuA4oxbkFXDMB3+TtbPTmUik0DzQlK/3NvZk
	Ox2UV4Mt2cdr50rPKxdlmY5VBPxMNWRbv8C+WuXzH1ij5McSDXWhk8WIae/FmfTo
	bATCT/if9stnSDA7pfuofgBL4fauP2i6tbw==
X-ME-Sender: <xms:9bnIaGhpSWqmgHvf8kSQenyGPdDCRZkGX9PobbvMkZ-NG9-SDcocuw>
    <xme:9bnIaKRZU8bHDSRnuiWTr1e13TS_h8CjEr9KrgfX8AjlzFjHmVXAxBeWXnkKuLOiJ
    ztQ6l3a_1DjOuYULw>
X-ME-Received: <xmr:9bnIaHgGARiXX2BFmfNrcz6Q5QFm9uuGF9BFITRPN4DoM41eabH-sDCEQyLzBhO3Zf1bCdq3UqWSOO1CznYsM5CXS9eFHmu9MlNtdfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefledvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsges
    ohifnhhmrghilhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9bnIaK4MQZXxVfPgS_Mytf5hx0wmVANQcIpdOYN5raJVM_ZL3NSoKQ>
    <xmx:9bnIaEA7EJ1Rl_Bkxg1m8uFfrbCzdpQQN1NM1Y905yLNjAD3tDSXgw>
    <xmx:9bnIaBbE9wHTOCFnnpSdzjmPloZRindGb4ZREKa3Dkww_vY9MF31XA>
    <xmx:9bnIaPYBIazWMoAkxNAgaO3u3_gT5hCN_nGMs5TcM0gqZPD4OrxI1Q>
    <xmx:9bnIaJ3GudZwAvWoyylOdJUVA4SSYxP_lhfvkRNx7WkY5Gqib5-nTj64>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 21:14:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: NeilBrown <neilb@ownmail.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] send-email: don't duplicate Reply-to:
In-Reply-To: <175790952167.1696783.4795702220839036460@noble.neil.brown.name>
	(NeilBrown's message of "Mon, 15 Sep 2025 14:12:01 +1000")
References: <175790952167.1696783.4795702220839036460@noble.neil.brown.name>
Date: Mon, 15 Sep 2025 18:14:28 -0700
Message-ID: <xmqqbjnbci6j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thanks for sending a patch.  

NeilBrown <neilb@ownmail.net> writes:

> If I run
>   git send-email --compose --reply-to 'ME <my@address.net>' .....
>
> and edit the intro message, then the message will get two copies of the
> Reply-To field.  gmail.com rejects such messages.

A commit log message that begins with such a clearly written problem
description is always welcome.

> This happens because a Reply-To is inserted into the intro message
> template, and then the intro message headers are copied and another
> Reply-to is added.

OK.

It took me a few minutes to follow the code based on the above three
lines to figure out exactly what is going on.  The key realization I
needed was that the if/elsif/... chain being touched is sifting the
e-mail headers that appear in the message being sent into two kinds,
ones whose values are understood and parsed into individual variables
that have their own meaning (like $reply_to), and others that are
not understood by the code and thrown into @xh array to be blindly
replayed into the resulting message later.

By parsing the "Reply-To:" header into $reply_to, the code with your
patch stops throwing it in @xh and that is how duplicate headers are
prevented.

> This patch fixes the problem by noticing the Reply-To: header when the
> intro is parsed, and using it to assign $reply_to rather than blindly
> coping it into the new headers.

And what I thought missing is mentioned as part of the solution
here.  I would have preferred to see some more described in the
second paragraph that analyses how the breakage happens---it would
have saved me a few minutes ;-).

A few issues in the log message.

 * The commit, when prosessed by "git am", will record your name as
   "NeilBrown <neilb@ownmail.net>" because that is the name and
   address used on the "From:" header of the e-mail I am responding
   to.  It does not match the name/address used for sign-off below,
   which is not right.  If <neil@brown.name> is the address you want
   to be known as to this project, you'd need to override the author
   name by inserting a line "From: NeilBrown <neil@brown.name>" at
   the very beginning of the e-mail body, plus a blank line to
   separate it from the body of the message.

 * We prefer to see the solution described as if you are giving an
   order to somebody sitting on the keyboard to "make the code look
   like so", e.g.

     Fix the problem by parsing Reply-To: header into $reply_to
     variable, to be reproduced on a single header line later,
     instead of getting passed unrecognised and left in @xh to be
     copied into the outgoing message.

   or something like that.

> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  git-send-email.perl | 3 +++
>  1 file changed, 3 insertions(+)

Thanks.

>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 437f8ac46a85..e2248c223119 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1931,6 +1931,9 @@ sub pre_process_file {
>  					$in_reply_to = $1;
>  				}
>  			}
> +			elsif (/^Reply-To: (.*)/i) {
> +				$reply_to = $1;
> +			}
>  			elsif (/^References: (.*)/i) {
>  				if (!$initial_in_reply_to || $thread) {
>  					$references = $1;
