Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C2B25A343
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090073; cv=none; b=ZpsIYabCTYHZ74SH4gKS454CODItcfNWbdmK9s5DzhlhL7HQmX/nDA0zTgoRduHCSDbE+4eaZULm1CQwbn9cnIYvUSJno+EIpoHTANgFak7Mjm8h+NO32yHOVV+heiHXvJ9lViaMy0+D3yF8mnQxXBLOP3kGaUNmCsU6Vw903FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090073; c=relaxed/simple;
	bh=I0TjbuJINY61ZRydjKmO6n9xAkgrGlpepQCfAoUVkcM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cQ+SejWJ4SiAwK1T21GRe0kOQl43Wd/HFmULyXRGUgDKvoRQ/N+gfJ2rsHQorUrJXdkAMAChEzadXxKf2s2GZt1ack0lKlM+gNVEUoqoFRTgNq6IQWGswl9rctGtOFHX7TR1oQw0EUaN7RAvb6rb3j4wXa8OiD8ljd67STGyeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ZWSf4Yz+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TsLthIth; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ZWSf4Yz+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TsLthIth"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8855AEC018B;
	Wed, 17 Sep 2025 02:21:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 17 Sep 2025 02:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758090067;
	 x=1758176467; bh=Bif2A3a8eDjs6NSDIdF4mwE0vpU5Ea6sLbIR7ZF4j6c=; b=
	ZWSf4Yz+9A4JfvOg++Rtw8QyjzDq29kvgIqCgg934AqGJdu/mkfYg+/f8oOCvI8E
	fTSRycUO9ox1B2ey2H6kBesuigSk0Sy5B8WFLcQ+u91sbd0HIWq0Mpfn75YPcDB7
	DvBI3yvuWppDx8+6ALcF7BoB4rsex9QQd5Wzk46WwNEC2UNcMapPtKCj3C5XB0i1
	cMraaORVGgKNBhDAMGjsXYXx4eb0msKXKHrjyzEiWPKlnZaVGHopEzoAE90QMp5x
	1/U3uuXchW7EPSa4sNqgK583WwGFyO+w3PtbXyQgk/xD53ZwoK2OqKOTCighBkSf
	/YzIBegtWJHMgOQ89WOlxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758090067; x=
	1758176467; bh=Bif2A3a8eDjs6NSDIdF4mwE0vpU5Ea6sLbIR7ZF4j6c=; b=T
	sLthIthnQElxwtHlbIqP43yaCyUlmlU27g3Jf31e0rGSxyMHxrIyP+4lKzdMsB+S
	e6CzKXrqpfElbBt73FGjh8lMpm1wdZtqMoANquPIblWdI/Zge123phc0rl8JZ8u9
	32i11rynFblbkm9Up6Y7v5deJ1sEUJQBE8VhPQisFQOQl+xt0bLdX+zqG++2utB1
	tcpXuGLG3SEVyWHJazGX9I1l2QjyWCw/wpSHJ3eafWZIfH4TfgZfHj8bpfbC6H3u
	UDJG0bSrnM+I4SYOuCXVEOBhCKMu3jiM+ui9V3HZrLlemh5BWiMtWBub4mXNzwdS
	0pZacbPOhIIamQmEXs9DQ==
X-ME-Sender: <xms:U1PKaK9Dw_65K4zDJAMHnXGGosRjv1MytnFjyIgeqwnobzQDJmV5hg>
    <xme:U1PKaK4BkEMl7icTd79cLlZBP_k8UV0MvwcFuSerBK1YDhm0G2GvyIuhl-oVQhaq6
    YQS_SlCImKspQ>
X-ME-Received: <xmr:U1PKaB1UFb6sYtHJO7wHodYfN6ROSjOZNPwPtyDH48Kj437k-4wUDytKBJWMLtOOl78NNxQaCYRTETHm4FGNS6wmSr6Yvjlzk_USyVJCtLjp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegvdejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurheptgfgggfhvfevufgjfhffkfesthejredttd
    dtjeenucfhrhhomhepfdfpvghilheurhhofihnfdcuoehnvghilhgssehofihnmhgrihhl
    rdhnvghtqeenucggtffrrghtthgvrhhnpefffeehheeuveejgfeivdeutdejfefgffegue
    ffgeegkefgjedtieeftefgtdehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggprhgtph
    htthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:U1PKaBBcKbO3ynV1sW_iXFBqwtSBfW9hAB5pTu1dfHO9aZNeA2KjNg>
    <xmx:U1PKaD1-qs3LUYe_79e4IoA8EUTn_rqToo_prkgVB-SR_RoZnQo9yA>
    <xmx:U1PKaLtA0-C_oYTWL8kZlmUK_R3PVRiQXtO79hzmlAmE_U-lZycVXA>
    <xmx:U1PKaD6JUA6NPWnTM1Ses4OsdDUX3j35Ik8EjpAq7WHyporCoVHkgg>
    <xmx:U1PKaNjCYm7n9KR7FHBwOj__P94iHPvLr6jOvzOrMvApgkisG3Oe0G_J>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 02:21:06 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@ownmail.net>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] send-email: don't duplicate Reply-to:
In-reply-to: <xmqqbjnbci6j.fsf@gitster.g>
References: <175790952167.1696783.4795702220839036460@noble.neil.brown.name>,
 <xmqqbjnbci6j.fsf@gitster.g>
Date: Wed, 17 Sep 2025 16:21:01 +1000
Message-id: <175809006105.1696783.12105140613644905214@noble.neil.brown.name>

On Tue, 16 Sep 2025, Junio C Hamano wrote:
> Thanks for sending a patch.  

and thanks for the review.
It all makes - I've made some changes and will resend.

NeilBrown


> 
> NeilBrown <neilb@ownmail.net> writes:
> 
> > If I run
> >   git send-email --compose --reply-to 'ME <my@address.net>' .....
> >
> > and edit the intro message, then the message will get two copies of the
> > Reply-To field.  gmail.com rejects such messages.
> 
> A commit log message that begins with such a clearly written problem
> description is always welcome.
> 
> > This happens because a Reply-To is inserted into the intro message
> > template, and then the intro message headers are copied and another
> > Reply-to is added.
> 
> OK.
> 
> It took me a few minutes to follow the code based on the above three
> lines to figure out exactly what is going on.  The key realization I
> needed was that the if/elsif/... chain being touched is sifting the
> e-mail headers that appear in the message being sent into two kinds,
> ones whose values are understood and parsed into individual variables
> that have their own meaning (like $reply_to), and others that are
> not understood by the code and thrown into @xh array to be blindly
> replayed into the resulting message later.
> 
> By parsing the "Reply-To:" header into $reply_to, the code with your
> patch stops throwing it in @xh and that is how duplicate headers are
> prevented.
> 
> > This patch fixes the problem by noticing the Reply-To: header when the
> > intro is parsed, and using it to assign $reply_to rather than blindly
> > coping it into the new headers.
> 
> And what I thought missing is mentioned as part of the solution
> here.  I would have preferred to see some more described in the
> second paragraph that analyses how the breakage happens---it would
> have saved me a few minutes ;-).
> 
> A few issues in the log message.
> 
>  * The commit, when prosessed by "git am", will record your name as
>    "NeilBrown <neilb@ownmail.net>" because that is the name and
>    address used on the "From:" header of the e-mail I am responding
>    to.  It does not match the name/address used for sign-off below,
>    which is not right.  If <neil@brown.name> is the address you want
>    to be known as to this project, you'd need to override the author
>    name by inserting a line "From: NeilBrown <neil@brown.name>" at
>    the very beginning of the e-mail body, plus a blank line to
>    separate it from the body of the message.
> 
>  * We prefer to see the solution described as if you are giving an
>    order to somebody sitting on the keyboard to "make the code look
>    like so", e.g.
> 
>      Fix the problem by parsing Reply-To: header into $reply_to
>      variable, to be reproduced on a single header line later,
>      instead of getting passed unrecognised and left in @xh to be
>      copied into the outgoing message.
> 
>    or something like that.
> 
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  git-send-email.perl | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Thanks.
> 
> >
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index 437f8ac46a85..e2248c223119 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1931,6 +1931,9 @@ sub pre_process_file {
> >  					$in_reply_to = $1;
> >  				}
> >  			}
> > +			elsif (/^Reply-To: (.*)/i) {
> > +				$reply_to = $1;
> > +			}
> >  			elsif (/^References: (.*)/i) {
> >  				if (!$initial_in_reply_to || $thread) {
> >  					$references = $1;
> 

