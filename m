Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673232BD016
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757801181; cv=none; b=RxcYOpcdTReym3nGJvAQBT+lhtoLa6zHm8QyHeyreflQjVx5ldbKdJ/R2mULzO02Aog35nnIfa6IbJPH1W432t3tBM384+E4RnHvnnvaCQbuVcpa7qm5VFqxGE0/xujjK3E+lU+Ch4p/aNFzhkDvg3Houx06AM66eZkCvaajK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757801181; c=relaxed/simple;
	bh=AgGp3zzpyCcAdRu0TjkefLOOogOyIsbVPtQuNAUFvz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+daL4w0cykA4oTIbnRKSsyxYMAUArED+ub61Gy6PZ5e6CzYqmyYUAZ7LFXrDQ8m0vwvOWT/6PwC79RHqiFfLt1erfukD90M3V6+iQKO+aXXyHlZGudRhUGojFTpoVEagAlKx+iA/B3RwbOoRm2sGYw9H0uAs7i/bISHqyKOSKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Tk2Z8CsK; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Tk2Z8CsK"
Received: (qmail 74996 invoked by uid 109); 13 Sep 2025 22:06:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=AgGp3zzpyCcAdRu0TjkefLOOogOyIsbVPtQuNAUFvz8=; b=Tk2Z8CsK+8Pm48MBtrBWGyo13ef9MsyXgZNN7TaN1H5ivELwHbyog0pz3bb47Z9UCBb5clbNV+zkCInoWHEQ4nYWPD62iGXgRuDoSartw/V0gLFUdIc1LIeZKstqP4ZAIFLk21Di327vpa4x/8Wa9KRFEgbrVDSZEugnhpslwAc7cYvWw14QFcWPh2hBmvFpu7HluVwioyKtAafzTuZGnVXrfKBUk18b1LWVMECRxcY+l/d8fUuhnZp8BLBnlfH4H5kV8T6beKeOmctVbw4/Qg8IH8Onva3uSG7T99VQOmnTx6xZ28dmz9o4lZx67uNusJHI0fX29kNtWFHREPQS4w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 13 Sep 2025 22:06:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 123416 invoked by uid 111); 13 Sep 2025 22:06:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 13 Sep 2025 18:06:09 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 13 Sep 2025 18:06:09 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 2/7] git: allow alias-shadowing deprecated builtins
Message-ID: <20250913220609.GA435444@coredump.intra.peff.net>
References: <cover.1757446619.git.code@khaugsbakk.name>
 <672253e0e7167c40290d1fef6d5076adfbe25d80.1757446619.git.code@khaugsbakk.name>
 <20250910051347.GA556174@coredump.intra.peff.net>
 <20250910154859.GB562601@coredump.intra.peff.net>
 <b39ba543-24ad-4bd6-be6e-dc1b8a416eb0@app.fastmail.com>
 <20250910183418.GA1157772@coredump.intra.peff.net>
 <eefc3524-9ecf-44e5-a6ba-1b4a0aff3158@app.fastmail.com>
 <20250911203256.GA1894340@coredump.intra.peff.net>
 <20250911204302.GA1907101@coredump.intra.peff.net>
 <98d206ca-3dc1-42cc-9f01-e3241d5a24af@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98d206ca-3dc1-42cc-9f01-e3241d5a24af@app.fastmail.com>

On Sat, Sep 13, 2025 at 04:10:57PM +0200, Kristoffer Haugsbakk wrote:

> The code in the `while(1)` speculatively adds commands to the list
> before finding out if it’s an alias.  Let’s instead move it inside
> `handle_alias(...)` and in turn only run this logic when we have found
> an alias.
> 
> This is not a refactor since the error output is changed; we will
> now print
> 
>     '<cmd1>' is aliased to '<cmd2>'
> 
> while iterating in addition to the final `fatal` message.

If you want to get rid of that last paragraph, I think it really is as
simple as checking the expanded alias new_argv[0] as soon as we see it,
like:

diff --git a/git.c b/git.c
index 06de0bacf3..f11ce416a3 100644
--- a/git.c
+++ b/git.c
@@ -425,7 +425,9 @@ static int handle_alias(struct strvec *args, struct string_list *cmd_list)
 		if (!strcmp(alias_command, new_argv[0]))
 			die(_("recursive alias: %s"), alias_command);
 
-		seen = unsorted_string_list_lookup(cmd_list, args->v[0]);
+		string_list_append(cmd_list, args->v[0]);
+
+		seen = unsorted_string_list_lookup(cmd_list, new_argv[0]);
 		if (seen) {
 			struct strbuf sb = STRBUF_INIT;
 			for (size_t i = 0; i < cmd_list->nr; i++) {
@@ -441,8 +443,6 @@ static int handle_alias(struct strvec *args, struct string_list *cmd_list)
 			      " not terminate:%s"), cmd_list->items[0].string, sb.buf);
 		}
 
-		string_list_append(cmd_list, args->v[0]);
-
 		trace_argv_printf(new_argv,
 				  "trace: alias expansion: %s =>",
 				  alias_command);

It is important to move the append of args->v[0] up (though arguably it
should be alias_command here, which is a local-variable alias that the
rest of the function uses). Adding it up-front is not needed for loop
detection, but it is shown as part of the output when we do find a loop.

You could _also_ ditch the "recursive alias" check above at that point,
though I think it produces a slightly nicer message:

  $ ./git -c alias.foo=foo foo
  fatal: recursive alias: foo

vs:

  $ ./git -c alias.foo=foo foo
  fatal: alias loop detected: expansion of 'foo' does not terminate:
    foo <==

Though perhaps if the output code marked it as both the start and end of
the loop it would be more sensible. Maybe like:

diff --git a/git.c b/git.c
index f11ce416a3..f1a83f2e6a 100644
--- a/git.c
+++ b/git.c
@@ -422,9 +422,6 @@ static int handle_alias(struct strvec *args, struct string_list *cmd_list)
 		if (count < 1)
 			die(_("empty alias for %s"), alias_command);
 
-		if (!strcmp(alias_command, new_argv[0]))
-			die(_("recursive alias: %s"), alias_command);
-
 		string_list_append(cmd_list, args->v[0]);
 
 		seen = unsorted_string_list_lookup(cmd_list, new_argv[0]);
@@ -436,8 +433,8 @@ static int handle_alias(struct strvec *args, struct string_list *cmd_list)
 				strbuf_addf(&sb, "\n  %s", item->string);
 				if (item == seen)
 					strbuf_addstr(&sb, " <==");
-				else if (i == cmd_list->nr - 1)
-					strbuf_addstr(&sb, " ==>");
+				if (i == cmd_list->nr - 1)
+					strbuf_addstr(&sb, item == seen ? ">" : " ==>");
 			}
 			die(_("alias loop detected: expansion of '%s' does"
 			      " not terminate:%s"), cmd_list->items[0].string, sb.buf);

I dunno. Maybe it is not worth tinkering with too much. But the "this
changes the output" justification from your proposed message seems to me
an indication that the refactor is a little iffy.

-Peff
