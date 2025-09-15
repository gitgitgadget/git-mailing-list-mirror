Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6E5C96
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 01:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757901098; cv=none; b=tCIpVAFKYwJiSlBwu+8Wj/MXaruWmeO684rd2BTLxvVhxKAQdhaxr5LeI5uFeb7wmriAyPoTI29H/vlzv4tqeD422zhZbco29Lk7ziSDjklcsbOXQDVq5uETJiIbxgCFYGvgISfv8iuajbYK+u4YA6lYu24DNsTIK7snTnry5AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757901098; c=relaxed/simple;
	bh=kdldX80usR2hV1Qp/PSyUL+g6e7YUu+U8vmJmA4tPjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbcgIuOHGmDynh3VUufDdmsgax+lKNjSWrTLARZnHZnAvFzfhLJSOkatDADVIAUYZ6xbM/MB5m6CnW0gj0CFcvG0UP91DHiJ+r5CmYG7BRxuJIgQSzyyfJvoovcOoqIAqOWGjjwGze8oiX2djIfYFuPBKMgBjBasN3DgCF6CWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PMXgR2YI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PMXgR2YI"
Received: (qmail 83474 invoked by uid 109); 15 Sep 2025 01:44:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=kdldX80usR2hV1Qp/PSyUL+g6e7YUu+U8vmJmA4tPjQ=; b=PMXgR2YIulY3hJ06rAb/+j7zwgzyu6HeGULk39jv5bdBoyqtwl2xMzZ171Meo11IikMT3nRWLsKT2UxHBJrDDx3bgdQO0ihA0bAeUTKjQRqcMz9iGiE1SUnG4XJjp+jiAg3H1VrtOZU2pR+yE53bUPIH8nTcKuO1NbPLGpoyqW43UqvXBcsETdaZV9fCOCj0TlHRWhIfuS5Go61hO7IRXwITIgQ2FHRY/HkPn4ZCTVEMxJVp/Ojo+BnVaacKZZKUD3dnigBzl1kwgfBVppT0WS5EmLRiFA45wYjQrbUJw6R+BIWc4MBuLkL5U+GMUOM00Z/OAdvLpXw1GrLI9Ic0gw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Sep 2025 01:44:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 140224 invoked by uid 111); 15 Sep 2025 01:44:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 14 Sep 2025 21:44:52 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 14 Sep 2025 21:44:51 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 2/7] git: allow alias-shadowing deprecated builtins
Message-ID: <20250915014451.GA44900@coredump.intra.peff.net>
References: <20250910051347.GA556174@coredump.intra.peff.net>
 <20250910154859.GB562601@coredump.intra.peff.net>
 <b39ba543-24ad-4bd6-be6e-dc1b8a416eb0@app.fastmail.com>
 <20250910183418.GA1157772@coredump.intra.peff.net>
 <eefc3524-9ecf-44e5-a6ba-1b4a0aff3158@app.fastmail.com>
 <20250911203256.GA1894340@coredump.intra.peff.net>
 <20250911204302.GA1907101@coredump.intra.peff.net>
 <98d206ca-3dc1-42cc-9f01-e3241d5a24af@app.fastmail.com>
 <20250913220609.GA435444@coredump.intra.peff.net>
 <eb7e569a-b297-41d2-82b0-956210292b64@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb7e569a-b297-41d2-82b0-956210292b64@app.fastmail.com>

On Sun, Sep 14, 2025 at 07:24:14PM +0200, Kristoffer Haugsbakk wrote:

> > If you want to get rid of that last paragraph, I think it really is as
> > simple as checking the expanded alias new_argv[0] as soon as we see it,
> > like:
> 
> I tried using both of these changes (the patches) but the `alias...`
> test suite started failing.

Hmm, it still passes for me. If I do just this on top of your v5, it
likewise passes (except for your new test which expects the redundant
line).

diff --git a/git.c b/git.c
index 10315742f8..c5fad56813 100644
--- a/git.c
+++ b/git.c
@@ -425,7 +425,10 @@ static int handle_alias(struct strvec *args, struct string_list *expanded_aliase
 		if (!strcmp(alias_command, new_argv[0]))
 			die(_("recursive alias: %s"), alias_command);
 
-		seen = unsorted_string_list_lookup(expanded_aliases, args->v[0]);
+		string_list_append(expanded_aliases, alias_command);
+		seen = unsorted_string_list_lookup(expanded_aliases,
+						   new_argv[0]);
+
 		if (seen) {
 			struct strbuf sb = STRBUF_INIT;
 			for (size_t i = 0; i < expanded_aliases->nr; i++) {
@@ -441,8 +444,6 @@ static int handle_alias(struct strvec *args, struct string_list *expanded_aliase
 			      " not terminate:%s"), expanded_aliases->items[0].string, sb.buf);
 		}
 
-		string_list_append(expanded_aliases, args->v[0]);
-
 		trace_argv_printf(new_argv,
 				  "trace: alias expansion: %s =>",
 				  alias_command);

> I ended up with not changing it for v5.  I missed the first time around
> that this informational message is only “logged” in the specific case of
> `<git cmd> -h`.  In turn you only get one more line of output when you
> are (1) chaining deprecated aliases, and (2) making a loop.

I don't think (1) is necessary. With your v5 I get:

  $ ./git -c alias.one=two -c alias.two=one one -h
  'one' is aliased to 'two'
  'two' is aliased to 'one'
  'one' is aliased to 'two'
  fatal: alias loop detected: expansion of 'one' does not terminate:
    one <==
    two ==>

So the extra line is printed even without deprecated aliases.

-Peff
