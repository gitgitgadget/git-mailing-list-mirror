Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9403748822D
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110501; cv=none; b=aWTcLpljyaAOjGf3QNJ+mkyBQaHmYcgE9Tf1ML77SCHOQhDspKO+b0V7olt/iP3lcnOo2w8GvDI8aAW4d0tcl3wg7qUhbYa6i4rTwL2DT7B90lhup7L5JpOgS5083dgnBlmPXNurimtB2T8vLZlqxGIa5Sm+DWCjF/TNe1pGpgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110501; c=relaxed/simple;
	bh=AoAhPHndRw8aH+RMhLDfMMqCxt+br/vRp7joiFCjpYI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ITgnxKOWD/1p0BcUvJQDjFpvFLBU5DZShnltPHTACHEfLCqxMe7SsHg8zRVqWjd1NURAJEdjuXDe9ZuvZxPaOq+7eIlyOoEss8/YxJqeEBGckPKUT+tPlzHpD+WS1ibt57RqENoO71OClOQZvmwPse4cF1uJ1lSzguWWQPfVYIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=j7N1sgkN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sRAyQnHM; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="j7N1sgkN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sRAyQnHM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 86186EC013B;
	Tue, 22 Sep 2026 16:54:37 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 22 Sep 2026 16:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790110477;
	 x=1790196877; bh=5uaqR/URpiWckAlz8CcPHyRXl9yqt0siqFYYkX5F/Qw=; b=
	j7N1sgkNsY70tlEl1Fword8FSb571sN03Ces+QM4vrUcoYHzKMGT9aZq3vOKAVaD
	vLJ87P/ua8wb6/6jrGz1vuT/dZo1kNfrYtubncyNGxt0eDSTckHyx0m3lNYt+XZJ
	DySguUhdlyqbWwCmnaaqoYDKY9/p/VjoA3uwKug5OgJCSBmimeA1j6b9fk9d0cIN
	gbcO2XyqtxIvdaMwK1qgTyWcy7GAt5ETlAGFOoz+M2bsaW10OB8uU+yEHyXomhNo
	u/4Yr9PCq8KIDmIbCXIELpV84zZxIINWgyVDX84S33ZlnZ0Ygh/fvBxn+hkj9uHf
	oaU14YC8T+ftr6fACP6PhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790110477; x=
	1790196877; bh=5uaqR/URpiWckAlz8CcPHyRXl9yqt0siqFYYkX5F/Qw=; b=s
	RAyQnHMlReGEU9UGQLqkn0SNp88L1QI3nM46r3mNylU1hnpHululf9vG/agctxcb
	fu4w2F9GKjatMA3oltv6DkNNjySzc+nm87iBJH9ENhxnv85fGL3cFQPL4Ot0ii63
	93HjraGxrH3gszLmOT1WykadQ7OmE7ewURigyaklgBruXdQ0m9TgYtSJYKx/4w8Q
	zPjCkHao0cE0K0K9UvtJzeUdUFIbOZ0Hq+4waqyO5QgEPhgc+VxQb5DiZZzd7YJM
	+88IgnVfmlleUcM2k0HO9sZg6m92rfDlIG6PSqkrwf8h4LoV8x+7LeyBslgXaAD+
	Gt3mA6TomPZ3NTFuAn/Vg==
X-ME-Sender: <xms:DeuyavN29SZH2SafzrOo2AgZjIXnvXN_F-LMfpPxYN9QakGrM3QhEg>
    <xme:DeuyakzL9Fzmge0Y6oamOeOrlGLUvYYbyBu8oHkaBKGtRJRoOIU1kku-GPbKTdcOB
    Q_X7uHPblxYVw2z3wyDTo86ZAxCG8uiV-eoAiv_v79i1rcrDXiAZrOA>
X-ME-Proxy-Cause: dmFkZTEQEkk1hgox4B7psGL7pF4ENWPZhjNiSU1CCbX6kpLQfMYl8HvsCZUHKiRte2sHNh
    4X3NxJ0Vls8aUQQGIqnFzMqwWAPd7KpC5g0zIzzcJoM0Ezzb250aT1+aht6IvdA+Cz+OXP
    ZQlL4LbbUvNx0aLVhdH7IwF+VBSSBobJYcUJGB5PK0/Thw9lNz1ILFpgC3KFCFIglLx7W9
    Z4zsvDWEOyHz6m6EZCH4oSG59bqOKpLIwEklnU9l9rHlv0XcdPqfZ+5cpG5WvQq2idnL0f
    atFenmEqAKX5Oq6qQjQ1YmPwtxftypSctJGkn9vWIZhhKnmDauoDajscz90ZykeqUdW/pV
    oMI+YCIPdqfw4OngPVU1OkfGxk1s9MRXtFhogzQ7ywZr95clcRflkZZCN/KursNriK9j5P
    aR+OmISb7MwdSwUR8mYie9VVucWG4/FLKg6uzt5QcaSghuTIjh8oJkm6FmSFPya60n6UuP
    kWBZHN85uM0PjZDPAhuejLMChyMw/EdGbWoJ4nzkgrROMljusgPR4cMS5mmOU1YGcRWnY0
    lDug+kudQKkIT6RvrSmygQ/b5mbf8NOO+m+KW7uRD3I4gIFA52BrT/mhDmusxGjseWnc6a
    iHeiO0+OVVFmJlqz/jh6MT4fLFtQw+/QJQ4r9muSNWnvojikIa6AnVYyzR/g
X-ME-Proxy: <xmx:DeuyanIxwRXZpdMlJk9bV5rOLtnkvE1QZd111UMD-KkueMEMuMq75g>
    <xmx:Deuyai79kC-Ik8njAvm_tuV5xazzobX1_Xe1oi9_uGPVzs_gC8SnaQ>
    <xmx:Deuyaiyc_DikAhW7N7Yx0zNFGKCgjY9Q4DK9IbObIsA_s_-eRAm8xQ>
    <xmx:DeuyauaH_2K-BdtGOKOJ3y835swWpwGy0iLZ9SPGlHOHMXdBClPNYQ>
    <xmx:DeuyauFafGB3w8QUDctwZxpj8J4i8h4shsMtnZlAjZ_qcEMKNqRQ6xse>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6631E780076; Tue, 22 Sep 2026 16:54:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFcAV8VPp38k
Date: Tue, 22 Sep 2026 16:54:17 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <665e8f8d-7bde-449b-a390-10875135cba2@app.fastmail.com>
In-Reply-To: <xmqq4ifhdon2.fsf@gitster.g>
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
 <xmqq4ifhdon2.fsf@gitster.g>
Subject: Re: [PATCH] doc: add more AsciiDoc cross-references
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Oh, I love a change that is so sharply focused on a single issue and
> describes what the problem being solved is.

:)

>>      * I tested it by running this script
>>        (https://gist.github.com/jvns/039c8ed0add092f2179f0dba52ebb896) which
>>        builds the previous and current views of all the man pages. I looked
>>        at the output to make sure there were no differences. You can see the
>>        output in that gist.
>>      * I believe that asciidoctor will automatically make sure that there
>>        are no broken links.
>>      * I also spot checked some of the HTML output to make sure it looked
>>        reasonable.
>
>> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
>> index 035f780e58..47dea1de8e 100644
>> --- a/Documentation/fetch-options.adoc
>> +++ b/Documentation/fetch-options.adoc
>> @@ -199,7 +199,7 @@ endif::git-pull[]
>>  	providing the tag refspec.
>>  ifndef::git-pull[]
>>  +
>> -See the PRUNING section below for more details.
>> +See the <<PRUNING,PRUNING>> section below for more details.
>
> OK, we already see an example of the <<double,double>> reference
> notation.  This needs to be in this form, intead of <<pruning>>,
> because it refers to the named section of a different file, namely
> git-fetch.adoc (I am just trying to make sure I understood your
> explanation correctly).

The reason I explained this in a bit of a confusing way is that I'm not
100% sure in which exact cases we need to use <<double,double>
instead of <<single>.

I double checked just now that if in `git-push.adoc`, I change:

	of a remote (see the section <<REMOTES,REMOTES>> below),

to:

	of a remote (see the section <<REMOTES>> below),

Then there's a problem where in the HTML version it displays as
"[REMOTES]" instead of just "REMOTES".

But in the <<PRUNING,PRUNING>> example, just using <<PRUNING>>
seems to work. I started working on this way back in December 2025 
so I assume that something in this patch was affected by this issue
and that's how I came across this problem but I'm not sure exactly
what it was.
