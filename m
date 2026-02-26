Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8001A38756B
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131516; cv=none; b=NDdcIkQ2U6t9W9B3GzyNYPa7hd5VUPrDmLeiGs2R608gT7udOc8XQ5HmNl4Z+NVZzr0nG/jQZqIqQarMVEqStC7f5DWbcAdQQQP9796jOL7EUZxlXvkAgi+MidybS2AYIXk3WTi8BdmDDbY0BzTXBIgUqoYuj83C7TFc2aSDetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131516; c=relaxed/simple;
	bh=NNJtXvV0QCXjMAVf5ZYkVhzIyXpGNxZKETdzLxOqNkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S5kF+M/yucid4QQnnqzPbC4YG2eA69niWU8Q9l+TFB4O0qgN6tGu7Iuxg+a18vhtPvU5kDEop88bFy0wDCn/3Efc6ZrNzWP37/g3nO4XniJV4Ch6z0aJBAplWClCScziwss+wbJIeOqDLVA0oe5b5BlwP/DnUCQFPpcXhqAJXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=w1MCr0e6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c0irsN7X; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="w1MCr0e6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c0irsN7X"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 436761D0002A;
	Thu, 26 Feb 2026 13:45:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 26 Feb 2026 13:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772131513; x=1772217913; bh=u8GHd1Dj8K
	brUm5yprKYTkW0NJGdD0xRr7zDCM1Bqq8=; b=w1MCr0e6oHc315fzKpAoFoCT6X
	Rpn1/3+seXMXCPlzdPRMsUL2rdAvTpsiDC2Q6OJ0/cf5YImwfkeU7hHtB+Dl2d8i
	oizDqdQ0olioiG96M8ruJmV970CRqz5y8Ztq5koMFtLLYAZ7ixMrqb7wK1aIR2Ur
	gDhCXdEQoxdXjz4F/2Bl4Vb7M8xpCCdGZPgD+sufPJqj5t6kFmRTt8YuIrSkMikm
	SCOTttXcLA0at1DGV8HjPelB83WX5oCdGQ3zVp1exelDZqH55oQa5iV+OFjebun+
	bkLnf3/mRYGChMrLqPtx4KqNvpO0gdheXT37kcgZtmDYX4wzydVdVx50/YVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772131513; x=1772217913; bh=u8GHd1Dj8KbrUm5yprKYTkW0NJGdD0xRr7z
	DCM1Bqq8=; b=c0irsN7XqDJWCbnILbOUBERrVHE6MOmljLNyLSSpDUTCi+Wro5l
	59tdLmbzczvqhrOsZD1QRrfpigfr1nb2WKO1yiYGVqU7btzuC7oMDBj81ikccT9O
	SpzNAUi22h/oHNMYhiokgsN4oBr7jq/r1g03P1NzU4oZEJaxtJ7vXf+jRPYxfWwr
	rJWGXwcWW8dFcAOsJCx+uVCtMZvDW7e9/gfQf0HRvIHsBj4qvwVJI7qGxh5CLIG3
	k0y4y4+FXEgNKeTrgNpd0hh8xdXqmSUFAjcI7FqtKXByJZls9gFmlgdUNiROPV1w
	vOOyvrng4DD0dMnbTDISOHgT4MDgZuIe37A==
X-ME-Sender: <xms:uJSgaSUHvs2QMX1d-DH7iwDGeOw7HN3tB0XOmQb6h5U7QF7NayaBwA>
    <xme:uJSgaVcvnRuYi-5n4qPAJyHWvGDy2igYZ00q4ZQv_tEyzqVjHmRypDLniP4yEqUoP
    Ylm_Ha02CcDI3_qJbGxDPgCKB9neTAjcfwhRuk_o4vCii2hHgMnrA>
X-ME-Received: <xmr:uJSgaevku7N7WttxPEXrGAU_ocC7kolKVEqyrKWLf_KtVueGJ73uesVx1YoIS-chin0DRD7W0MCMRUH-wJpYdbd6gWPxYoh3Eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeijeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghl
    vgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhiphhorghklhgvhiesihgvvg
    drvghmrghilhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uJSgaU_E8K7OgjwR874Fw-Rt92p3Li-ao2bDb1xt0wGOrG9vX88xNg>
    <xmx:uJSgaZ1MzHwThG0igrbuYZ-K0lDAUGuP_9aK0ZzOuCV1HF4nugPZrA>
    <xmx:uJSgaZAGinrClafqUJGr_SQLKSf7U7dFAcFDAX8TFzdpUPdPSyfsVg>
    <xmx:uJSgaVdzo3HC62Js9B09XI5Q9hKwHwRkFyS_DLtLl7oQ1sTLfTTKeg>
    <xmx:uZSgaTXpcQ_zW5Rv4JY3RQ2ne6e2muuVvmEBOFLTlJrQLuZ3ueiWLbay>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 13:45:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  ben.knoble@gmail.com,  philipoakley@iee.email
Subject: Re: [PATCH v3] send-email: validate charset name in 8bit encoding
 prompt
In-Reply-To: <20260226165559.187261-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Thu, 26 Feb 2026 21:46:34 +0530")
References: <20260224143624.23678-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260226165559.187261-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Thu, 26 Feb 2026 10:45:11 -0800
Message-ID: <xmqq8qcf2vk8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index cd4b316ddc..3230b80701 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -23,6 +23,7 @@
>  use Git::LoadCPAN::Error qw(:try);
>  use Git;
>  use Git::I18N;
> +use Encode qw(find_encoding);

I wonder how common is this module already installed on users'
systems (not asking "how widely available"---which is "can users
easily make it work?", but asking "would this work out of box with
what users already have?").

> +sub confirm_ask {
> +	my ($resp) = @_;
> +	my $term = term();
> +	return 0
> +		unless defined $term->IN and defined fileno($term->IN) and
> +		       defined $term->OUT and defined fileno($term->OUT);
> +	my $yesno = $term->readline(
> +		# TRANSLATORS: please keep [y/N] as is.
> +		sprintf(__("Are you sure you want to use <%s> [y/N]? "), $resp));
> +	return defined $yesno && $yesno =~ /y/i;
> +}

This is a bit incosistent with what "sub ask" (the only caller of
this sub) does, isn't it?  Before entering the loop that makes a
call into this, it does this:

        sub ask {
                my ($prompt, %arg) = @_;
                my $valid_re = $arg{valid_re};
                my $default = $arg{default};
                my $confirm_only = $arg{confirm_only};
                my $resp;
                my $i = 0;
                my $term = term();
                return defined $default ? $default : undef
                        unless defined $term->IN and defined fileno($term->IN) and
                               defined $term->OUT and defined fileno($term->OUT);

If $term is not usable for interactive prompt, it uses the default
setting.  But the new confirm_ask always says "no".

confirm_ask does its own "check term() to see it is usable" because
it is called from another code path which does not have its own
logic, but it may be a wrong abstraction to give uneven interface.
It would make it more clear what is going on if you just do the
interactive $term->readline() thing in "sub ask", instead of calling
"sub confirm_ask" that does tghe $term thing redundantly.

Can't the other confirm_ask() caller call a normal "sub ask"?  

I am not sure why we want to add a dedicated sub, just to ask "are
you sure you want to use X [y/N]? ".

> The intended flow is,
>
>         Declare which 8bit encoding to use [default: UTF-8]? foobar
>         warning: 'foobar' does not appear to be a valid charset name.
>         Are you sure you want to use <foobar> [y/N]?

It somehow looks uneven to have three lines, two of them
capitalizing their first word while the other one is all lowercase.
I wonder if this would be simpler?

    Declare which 8bit encoding to use [default: UTF-8]?  foobar<RET>
    Do you really mean 'foobar', not a valid charset name [y/N]?



So, taking all of the above together, perhaps:

 * Discard changes to "sub ask" and addition of "sub confirm_ask".

 * Tweak this part a bit to call ask().

> +	while(1) {

Style.  missing SP before "(".

> +		my $encoding = ask(__("Declare which 8bit encoding to use [default: UTF-8]? "),

Overly long line.

> +		valid_re => qr/^\S+$/,
> +		default  => "UTF-8");
> +		next unless defined $encoding;
> +		if (find_encoding($encoding)) {
> +			$auto_8bit_encoding = $encoding;
> +			last;
> +		}

> +		printf STDERR __("warning: '%s' does not appear to be a valid charset name.\n"), $encoding;
> +		if (confirm_ask($encoding)) {

Use ask() to ask 

    Do you really mean 'foobar', not a valid charset name [y/N]?

here, perhaps?

> +			$auto_8bit_encoding = $encoding;
> +			last;
> +		}
> +	}
>  }
