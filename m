Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D916A2A
	for <git@vger.kernel.org>; Sun, 17 Mar 2024 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710708443; cv=none; b=mbFAc54AA70iapLWUYnGQf/h3htYNX+efgDsttecYqRaO73dhM8w0Z/j8b3JRHobApiyKDVEjHOtupNDLD94r/ghA1xPKvyi71AFQW0HEqnPGD5ITQ7lYXE2Po9IXBDymmSZA22TBiWics/XPdoSbYFSqs+D3CkdWxpouUoSW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710708443; c=relaxed/simple;
	bh=xY7UKCCeI/qRwWCXnigLPtw3EAIELojjfa2JKg7PS50=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=k6l8WclNsVFcnhnBpnzX4W2tuWM0D5oTG/ENpKD+Z8owYRFArsAK12kvbdOXg3TpXrT4DlfZx84xgUNglCSI/guTiaspp320x5K0bYAJm4DMyOtdRGwxzzPgRaB0pPGFDm6EcQwgPw/6pMFTZzaFEHgVqvU7ziMyCMiZCs1Ww1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKtKG63l; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKtKG63l"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c8713acecfso66600539f.0
        for <git@vger.kernel.org>; Sun, 17 Mar 2024 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710708440; x=1711313240; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OtzblcLzt8z/47FBWVvgSW4at9oGpD6nFtRlJHitVtk=;
        b=IKtKG63lQjZcM9LlMJ2fGipX5NHbEwjpfY7HhTXQYMb617/l2Quz6dPpUdY3uiMh2P
         ZOAWTazJhtDCcbe5ne2onmfqTk1wDT+3ygeBIwGRJHwP19KulTXDO5DxVo42qYhSXTzY
         DziPSx3UsicqNHyRE+mYcpt7qJ6ss00DJdDRWcFO6JKRkbWwqArsieyX9IvdDRfIWCZa
         X7NKJkCSq9IXSvgp8BtarWKFPL+BT6N6UsaBKiyRGndMVEPii/M9LW45eDY2vrJFCJgn
         jRJYMVyg4UHPJLeTL46u6wkiHHKw8DMp1um2yb7v69/BKUy9yN0wc5j8SsVvMOTWxAPc
         Qoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710708440; x=1711313240;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtzblcLzt8z/47FBWVvgSW4at9oGpD6nFtRlJHitVtk=;
        b=YbnL5NRDvxgbzM1G/47MpPFqK4Z3EYjvvhmSitk4y/+rXdpckJcZRCDWr+pKb5EiFn
         AvtSzcU7fltVSKzuVxn8vBkyvj/og/w/P2cuLadpdPrPc9vSDx8NRTAS6JW4dGMCAyZy
         /M2FeyhTYRveqhKcgY+85YxgoDwrHw3Ld25SrBY7TWWDcyldIjksHu7qq4CTFXHG4piD
         V8dfbqHyKLLi2rVKGgNOcaVFTCUcfLkZUBRqnrcn0r2C5CfTXWjfUqMQIk19WEIfESP7
         /XaSiEcvm/MnoHLPkFnFVa0TLQ/oTWrA8Iap1HV3kXETk9E/wB1VrnZv1aPY5xr6I82z
         Dy3A==
X-Forwarded-Encrypted: i=1; AJvYcCVGRWsIABxBbTH1mn11QwSSHCdxkKCTRvqk+NzLKlrul/kuAbH0uXB9qqWnxfxuNBvfpIOLAQfS5xAZmQseGtiauEY1
X-Gm-Message-State: AOJu0YysC54BkmO4vWaXcA2+WGXbnDUgMMwFKLw16gMSw46UGLjE8Sw2
	l+ndRw1MkDv0OIlXa48u8hAsjPYm2nKbZdnHzDmiFfCgmr3Pflf9cF1uXPUy
X-Google-Smtp-Source: AGHT+IF5eQ7U5lXmNoD6hqWPgSWFkZY+k8EuBwR1B7LJ+THlEpqC2JgB5KVH7Jsh9yZJuzREwRIaZg==
X-Received: by 2002:a05:6602:330b:b0:7cc:1393:1bd with SMTP id b11-20020a056602330b00b007cc139301bdmr3030582ioz.1.1710708440413;
        Sun, 17 Mar 2024 13:47:20 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id eq4-20020a0566384e2400b00474f719b8c3sm1926398jab.33.2024.03.17.13.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 13:47:19 -0700 (PDT)
From: "Eric W. Biederman" <ebiederm@gmail.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc/gitremote-helpers: match object-format option
 docs to code
References: <20240307084735.GA2072130@coredump.intra.peff.net>
	<20240307085632.GB2072294@coredump.intra.peff.net>
	<Zeo9oAkL6kxZRugN@tapette.crustytoothpaste.net>
	<20240312074513.GA47852@coredump.intra.peff.net>
	<ZfIWkJieqcPv5jA8@tapette.crustytoothpaste.net>
	<87ttl99e0b.fsf@gmail.froward.int.ebiederm.org>
	<ZfNqVowQBy47_92m@tapette.crustytoothpaste.net>
	<87msqzo63f.fsf@gmail.froward.int.ebiederm.org>
	<20240316060427.GB32145@coredump.intra.peff.net>
Date: Sun, 17 Mar 2024 15:47:18 -0500
In-Reply-To: <20240316060427.GB32145@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 16 Mar 2024 02:04:27 -0400")
Message-ID: <87v85k4mcp.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Mar 15, 2024 at 10:41:24AM -0500, Eric W. Biederman wrote:
>
>> I see you saying and a quick grep through the code supports that the
>> object-format extension is implemented, and that the primary problem
>> is that the Documentation varies slightly from what is implemented.
>> 
>> 
>> Looking at the code I am left with the question:
>>  Is the object-format extension properly implemented in all cases?
>> 
>> 
>> If the object-format extension is properly implemented such that a
>> client and server mismatch can be detected I am for just Documenting
>> what is currently implemented and calling it good.
>> 
>> The reason for that is
>> Documentation/technical/hash-function-transition.txt does not expect
>> servers to support more than hash function.  I don't have a perspective
>> that differs.  So detecting what the client and server support and
>> failing if they differ should be good enough.
>
> AFAIK the code all works correctly, and there are no cases where we fail
> to notice a mismatch. The two code/doc inconsistencies (and bearing in
> mind this is for the transport-helper protocol, not the v2 protocol
> itself)

Thank you for the explanation of the transport-helper vs the v2 helper
protocol explanation below.

> are:
>
>   - the docs say "object-format true", but the code just says
>     "object-format". They're semantically equivalent, so it's just a
>     minor syntax issue.

I am a bit confused on this point after having read the code.  It
appears that when "object-format" is sent remote-curl
experiences "object-format true".

Assuming remote-curl is the only remote helper that currently implements
the object-format capability.  I think we ant to fix transport-helper to
send "object-format true" just to be consistent with all of the other
options.

Among other things that will allow using the set_helper_option helper
function, and it will generally keep the code robust as then the code
doesn't develop a special case for the one option that doesn't take an
option value.

>   - the docs say that Git may write "object-format sha256" to the
>     helper, but the code will never do that.

It looks like remote_curl will get confused in that case when it
processes "object-format sha256" as well.  As it stores that value in
options.hash_algo, which in all other cases is used to store what the
hash algorithm computed from the remote side.

> So my big question is for the second case: is that something that we'll
> need to be able to do (possibly to support interop, but possibly for
> some other case)? If not, we should probably just fix the docs. If so,
> then we need to either fix the code, or accept that we'll need to add a
> new capability/extension later.

Since this is the transport helper understanding this enough
to give a good reply is challenging.

As I read things the happy path for most connections is either going to
turn into git protocol v2, git-fast-export, or git-fast-import.
Unless I am misunderstanding something all of those will bypass
the code paths the remote helper object-format capability affects.
It is only when the remote helper send "fallback" during connect
that the remote helper format capability might be used.

The only practical need I can imagine for this is if the client
is going to send oids before asking the remote side what it's oids
are.  The only case I can imagine doing this is the initial push
of a repository.

My sense is that unless we can find a current case that was overlooked
during the initial conversion we should remove "object-format
<hash-function>" support from the code and the documentation.

Any new cases that are not currently implemented will almost
certainly be handled by the "smart" protocols.

Looking at the code in transport-helper.c:push_refs it appears the one
use case I can think of is explicitly not supported. The code says:
>	if (!remote_refs) {
>		fprintf(stderr,
>			_("No refs in common and none specified; doing nothing.\n"
>			  "Perhaps you should specify a branch.\n"));
>		return 0;
>	}


>> I think I see some omissions in updating the protocol v2 Documentation.
>
> If you mean from the commits listed above, I don't think so; they are
> just touching the transport-helper protocol, not the v2 wire protocol.

This just proves I haven't dug through these protocol bits enough to
have a good understanding of how they operate yet.

So I think at the end of the day we just want to do something
the diff below.

Mostly it deletes and simplifies code, but I found one case where
a malfunctioning remote helper could confuse us, so I added a check
to ensure :object-format is sent when we expect it to be sent.

Does that jive with how you are reading the situation?

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index ed8da428c98b..47e5bb2cc925 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -542,7 +542,7 @@ set by Git if the remote helper has the 'option' capability.
 	transaction.  If successful, all refs will be updated, or none will.  If the
 	remote side does not support this capability, the push will fail.
 
-'option object-format' {'true'|algorithm}::
+'option object-format' {'true'}::
 	If 'true', indicate that the caller wants hash algorithm information
 	to be passed back from the remote.  This mode is used when fetching
 	refs.
diff --git a/remote-curl.c b/remote-curl.c
index 1161dc7fed68..6f4cb3467458 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -213,12 +213,8 @@ static int set_option(const char *name, const char *value)
 	} else if (!strcmp(name, "object-format")) {
 		int algo;
 		options.object_format = 1;
-		if (strcmp(value, "true")) {
-			algo = hash_algo_by_name(value);
-			if (algo == GIT_HASH_UNKNOWN)
-				die("unknown object format '%s'", value);
-			options.hash_algo = &hash_algos[algo];
-		}
+		if (strcmp(value, "true"))
+			die("unknown object format '%s'", value);
 		return 0;
 	} else {
 		return 1 /* unsupported */;
diff --git a/transport-helper.c b/transport-helper.c
index b660b7942f9f..e648f136287d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1206,13 +1206,13 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 	struct ref **tail = &ret;
 	struct ref *posn;
 	struct strbuf buf = STRBUF_INIT;
+	bool received_object_format = false;
 
 	data->get_refs_list_called = 1;
 	helper = get_helper(transport);
 
 	if (data->object_format) {
-		write_str_in_full(helper->in, "option object-format\n");
-		if (recvline(data, &buf) || strcmp(buf.buf, "ok"))
+		if (set_helper_option(transport, "object-format", "true"))
 			exit(128);
 	}
 
@@ -1236,9 +1236,13 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 					die(_("unsupported object format '%s'"),
 					    value);
 				transport->hash_algo = &hash_algos[algo];
+				received_hash_algo = true;
 			}
 			continue;
 		}
+		else if (data->object_format && !received_object_format) {
+			die(_("missing :object-format"));
+		}
 
 		eov = strchr(buf.buf, ' ');
 		if (!eov)

Eric
