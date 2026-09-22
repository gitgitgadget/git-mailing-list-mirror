Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817249BD70
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108443; cv=none; b=Um2/wVRP7pP+dKBlyo6Pajk4LeLmoieNx6+7S/ktNQVj8ZY2xlsR05EPz7Bkciwhxh4zFc3Cobt3qa36lH66ZeJWnoFs1Jm0eRbZTEcztLqn7itfPAgAdnsdnyd2km5UAaikx04gtSMXFwQj3uTbsMgRhy8NF6Dm9sx0wJYorkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108443; c=relaxed/simple;
	bh=gPW9WjRD6QHV5oI8S2ptN3j7RvfiEkMvU6nrGyhPN3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hGr665CLB5aSUTnIRIDTHiab8ntf/IndtFm/sAHkHVlV6POrd4Sxb5hSQunXYZA3gDXqlzlgQU6KyhWJocosmZmvETw5em8rREkw9ssINwssP8CeuRn2T5NUYSEjsn8eG5UxtiJXOOCrMuYuNJaORSHSOzoThSUaVz0JAliyrZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r0JlWIaE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ckoIinBh; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r0JlWIaE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ckoIinBh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 71A51EC01F2;
	Tue, 22 Sep 2026 16:20:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 22 Sep 2026 16:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790108419; x=1790194819; bh=HkA4L5zGpS
	RGWy88x2r1lU4lhSthhPx+MP68GxYeyDA=; b=r0JlWIaE4jm+Q1BsvKf25W3MUe
	QHf2FChLUJVJ0ns9BRSyLAbKQHEUQgZtsqlQleK1+zv7fFy7yWgFoiXx4lT7DDKc
	gLredLfXqvTAx6s3MAacOrs4teYzFneXX5Pnd/5NRS/KonABVFVIG5ukxcXNgTYy
	xwGVDcp/UYPigiD+0r2U7cpD1V04JXOYx8fBviA47ASYw7YusYWx8r2OB8bgtBiX
	fs4v39GyAxnmdKgLGeOYsnqQIyq83lwiOPNYJ2hbPzB1ZPDMbGyC+aPjyEM0Mf67
	o6IHiU6dNmrwDr2ZTn6WVR5nWN7cX4hTlG0L9Rr4YkxsmJ2qLzXeLLaPljpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790108419; x=1790194819; bh=HkA4L5zGpSRGWy88x2r1lU4lhSthhPx+MP6
	8GxYeyDA=; b=ckoIinBhBpiGhPkiqABCjvsr4hTP7V7HOnqkj/gfwXd37CIuV1G
	c/J8EWxm4Ls6ttbVFYwxBKNjmGFzX6c9ENLr6jHKeZ//7UKMSM6My8TYou4RkP5r
	iWPQDPsVegIOsVdSvr7w1+MpVMVRE8PwlAcTbVGEdiGON77SJ91MfDNJ9sYxJEGq
	c+Cf4VdaoWqbGU4tp6i810a3+MobYXyd+Etph3CnQHli6+yEr4TN5z/S+0WxkHao
	f0xsHFOmZBYbnlXFUkK4SKKoVIyZ87F8qRgmiRJT0dpXCv6pk9u5ZRICgbxcQRg5
	TOaNWJNc8nteIHeEYZ2U4GnmewF3KifOBBQ==
X-ME-Sender: <xms:A-OyasqPz7LtRJBXOLt-3hYJY-l_MAgwAREtjQChZgl_RZcPkJsOyA>
    <xme:A-Oyapp19rrJNVTRlsiHIuCxeCfqYnrAsIFLrrEzzdav5_p-7tj5NjsP3PPcIS4xW
    vDhTZ7k-H0qAD3USsLDsosXmj4chPy-VZ4wloZqTOI9-jLA4Y8Pw-o>
X-ME-Received: <xmr:A-OyamN8emx0SYZdqnzki0xlrMxWkWBPUz-KRnfh75Zzdh4gIzXRK74Xp3sdVCjO7JcYPFV1jNK3o4V-_sJjRos9h50FNFD6Qx01>
X-ME-Proxy-Cause: dmFkZTEbs4eEwUfhCPeNrVe4Rf4VMoKLRX6Cp5PqjGMeeQcoHM43injNEXvIH+Bsb4i8Mv
    JfsmohrOkOu6JB0w08S5QhAp1LvLdaajxvatEv+kUlt/UFBT8vHVg3bYqrvwTqznzKwAVk
    COSQmXS6qXFNgbE1uOWT9noUDLq2MILu6pt/NTkpv3hvfkB1DVDbdWi42Fezk/ajx/ISXj
    v0EA+cFObwHZI3p3lth6YazpK1EOFFAfUZH6AB1JQMwuu2kPOHrmsIQN3cF9FqloRqxfOA
    QQeYPJRPeVYYJwmml9bXuDdq44Wg+TBr2oG/IdlmcU3g/84wEveJA+r1qJmcc5rw5bFUib
    KNlfqs6RWvV9A9s1qXtGmg3ZRpb8QQzZ6quu0O9omDBitLi6Ex+PvgUoR3QulWKKgbAxoV
    495VrYtXQ6d7RH2+/SUSETm3IF6F2OQdBYP1krY3BagXYcWIcdpm1sTlT4L60pHWz8DeI2
    QmjZOel2aptAwvp3MT7ipEfCZlpMuXTpbgYOAOn4SnYAU13Njpru54UKjjP3gWNzGtdQ76
    MudWx1pF+r37W4hLsxtZid9STU/wc6CRs0s0asm0M6LvT6huFM11KE+lpRxBgJFEcmGcYY
    CrTvIJX6ySSc/Eii+0ZaRcHnAyzdhIJxz0UOwkP4RU+h6b23yVt9TiEquJdw
X-ME-Proxy: <xmx:A-Oyaiz2S5r_E2D-652MeX-mX2M5q-_io1tgS3319EfoEb9xPNGIug>
    <xmx:A-OyanuOVLf9vWNKgfgr4maqXehGXbmJ5l88m-E8jt8riMAnrCfb9g>
    <xmx:A-Oyaj56_VgLY8IZZaOCfKuo-yQ8sVJstkArY-rK8eyeayQmXr5yJg>
    <xmx:A-OyauTT05w9R2hNvttL-i26oW2xTQHpgb9a4OipEQqKiInj3DesOw>
    <xmx:A-OyalvcLBoTWLOr68c-M_QzsBBuY86IaIQMNDAdriyiR7D-r9o54LV8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 16:20:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH] doc: add more AsciiDoc cross-references
In-Reply-To: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Tue, 22 Sep 2026 19:29:02 +0000")
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
Date: Tue, 22 Sep 2026 13:20:17 -0700
Message-ID: <xmqq4ifhdon2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> Instead of saying "see EXAMPLES below", say "see <<EXAMPLES,EXAMPLES>>
> below" to make the man pages easier to navigate on the web.
>
> The reason for using the more verbose <<EXAMPLES,EXAMPLES>>
> (instead of <<EXAMPLES>>) is that if the header that `<<EXAMPLES>>`
> is referring to is in an included page (for example `REMOTES` in the
> `git-push` man page), then AsciiDoc will think it's a broken link even
> though it isn't. So it's easier to just make all of the links use the
> form with two parts.
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---

Oh, I love a change that is so sharply focused on a single issue and
describes what the problem being solved is.

>      * I tested it by running this script
>        (https://gist.github.com/jvns/039c8ed0add092f2179f0dba52ebb896) which
>        builds the previous and current views of all the man pages. I looked
>        at the output to make sure there were no differences. You can see the
>        output in that gist.
>      * I believe that asciidoctor will automatically make sure that there
>        are no broken links.
>      * I also spot checked some of the HTML output to make sure it looked
>        reasonable.

> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> index 035f780e58..47dea1de8e 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -199,7 +199,7 @@ endif::git-pull[]
>  	providing the tag refspec.
>  ifndef::git-pull[]
>  +
> -See the PRUNING section below for more details.
> +See the <<PRUNING,PRUNING>> section below for more details.

OK, we already see an example of the <<double,double>> reference
notation.  This needs to be in this form, intead of <<pruning>>,
because it refers to the named section of a different file, namely
git-fetch.adoc (I am just trying to make sure I understood your
explanation correctly).

> @@ -210,7 +210,7 @@ See the PRUNING section below for more details.
>  	a shorthand for providing the explicit tag refspec along with
>  	`--prune`, see the discussion about that in its documentation.
>  +
> -See the PRUNING section below for more details.
> +See the <<PRUNING,PRUNING>> section below for more details.

Ditto.

> diff --git a/Documentation/git-bundle.adoc b/Documentation/git-bundle.adoc
> index 03cd36fe8d..cd722bd674 100644
> --- a/Documentation/git-bundle.adoc
> +++ b/Documentation/git-bundle.adoc
> @@ -94,7 +94,8 @@ unbundle <file>::
>  
>  <git-rev-list-args>::
>  	A list of arguments, acceptable to 'git rev-parse' and
> -	'git rev-list' (and containing a named ref, see SPECIFYING REFERENCES
> +	'git rev-list' (and containing a named ref, see
> +	<<SPECIFYING_REFERENCES,SPECIFYING REFERENCES>>
>  	below), that specifies the specific objects and references
>  	to transport.  For example, `master~10..master` causes the
>  	current master reference to be packaged along with all objects

This doubled reference is more for consistency (in other words, "it
is easier to just make all of the links use the form") than the
"cross references from/to included page" we saw earlier, since ...

> @@ -127,6 +128,7 @@ unbundle <file>::
>  	This flag makes the command not to report its progress
>  	on the standard error stream.
>  
> +[[SPECIFYING_REFERENCES]]
>  SPECIFYING REFERENCES
>  ---------------------

... the target happens to live in the same file.  It of course
future-proofs the reference in case the section gets split out of
the file into another included one.

Thanks, will queue.
