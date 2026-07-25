Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F70F3C9886
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995411; cv=none; b=l9Etcb589EZCbIJNIPJ3Kil+pas9GvFGbIqOZd5cXhNdK0Ii18ntjGiGPJn4u6P1LmlAZJtEBbGMrqH6eaqY3ZdfaSa1Rw4pS1WEqVaHDdQtmVVaiaIx0vPBZuAE8ldYz/jJvW3kY3qht67AeLWxBNilnaFIlaAfgwo6UQGlQ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995411; c=relaxed/simple;
	bh=SUrJKt+cQx8XJ5wKnESF22TKxG9Kmve4IgzRxaIhOxQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NJKKxffedRv/4jVfsdXI820XZfkcvUoIGqyUSW8bC2do6Ah+0XyMZ52f6/4dI3osqxpQdfxujeKT7/s84WwU5Bqh/eufTlB8m3xxgLqPordlipmGGScAhzJydYlILJG+AwJQSp5KZbSrvbDHBC9EEwmiLIyhz5WusMicNAvTEss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jK34pOvj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TTFxjWHG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jK34pOvj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TTFxjWHG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5273FEC00FB;
	Sat, 25 Jul 2026 12:03:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 25 Jul 2026 12:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784995406; x=1785081806; bh=1PbhaL/beG
	2JkTmlY9zlr8GjMZVMvsnhfFNrd6nG95Q=; b=jK34pOvjHLvprSAFlVnz6waPcg
	YM54XaKFVe+3zm/hxTzpz1qQrYWLobCv1YOsLORoNy/fhNilipNSx3W/NY8igmZR
	Y99i/WMyCp6RbE7k3WMw7CDhIXKFNO9fjCBXVe7UttTW8POfd4CtrMso5DDFIdVd
	3sXi/F5xfI2rzgkWUSbPIC3t26KoSm3f15+oDku+LHXQ+xObKmTiYdoi8YoGvPu7
	ntn1pqLNW8N8lxjgwDJ/ssk2JwcU324PQ6OWqNfTY/ztpBaH4LT8ffw1bLYKOaoW
	j7CO6jyNIt2v8Yx3Qkk4CrNEZilmpJ6fsd+0K+MxSQhelja1Ye9PW4JSuJtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784995406; x=1785081806; bh=1PbhaL/beG2JkTmlY9zlr8GjMZVMvsnhfFN
	rd6nG95Q=; b=TTFxjWHGiWwfhtqQOJS41q+41ChQVLO9zzzUffC5lCItTSAw61J
	0iiuOyivSBi2SeBulrrCbK9nkb2EWlo9eTGRJz4ZC+XGgBwBq52+fQ+N7DS4FN8P
	UepJTJ3pi0C/YmjqF5ft+s83McEduSfbHcKRftbm9V0amQ4tO7wiSKzu+VFamK5/
	WpCGpNYHfEBzUCVDXQtMGQD+zybOYijnT3LcP0doGQMFprD7LD4uG6iBQMq93ZCF
	GpflaIxsON3a8O1hqzVijUyFA9uusRc7qsl6bxprZCL2WBICpKdoi7PgRK4hw9pa
	1JEq8n2k2xRY2omgjzOIUsfLRfZjcLOWEQQ==
X-ME-Sender: <xms:Tt5kaua157qkhwXhg_AtccPnNdCFSrkso0J6TZB8e6iFz1ZTlYq71A>
    <xme:Tt5kana2sL5DiomFa4BPBu27RROHAoSwON3Q50t3xKALsO0rd2oj4ydHMeCUpRS4i
    rakO_bkAhqdkbvhtUgWkRiwQu2k7_MWpsSDlD3qmYAP0IhSGn0w>
X-ME-Received: <xmr:Tt5kammqPLJshALoe9tO6sdCkKbmDZ4lMcetPW1a1RffDrRlI--OIcuvfpBfWrsM6A0eWE4CNFbBl8Yc3UPCZ8YgkMQEIKdMeQ>
X-ME-Proxy-Cause: dmFkZTEwObfLX9M7HxrR8EOUTO5jc9MQWOBtTcTLnA1CfReVErnKMITAyyJLgB+ARZ5+8n
    8OPKPIOAT9XfZqmP1AqHi5lrenOVJnF3TD2mU2485Uh1xlNND/KiMhFe+/qiYJJmRMNjY2
    e4Dt0T2OChij/gEVlrJijMjA46rIamo6oRCxY+LTHYXYsfOEOXv376yh5F6Losxcty5MnM
    9ZI0X4+sJJUiFd7SHf8nyEcclJET+MoIGC+w8B2weccZdUxUKZg0Hs/Idfl6H6FETZenDi
    BvU1a7mn7cqP90/SO/xgXfvVGMh01wrVdYsTf2bNbth43UoViPdirE5qeCJGd0d2LY4dBt
    0n6LiwKTtii8hvhljuJxKYt511vpUhDQzsGfc1Q6vgbQZCkxzeQymxaShauwW1CZ2nU0t5
    T6aadXH2uXU5a0WDgSppN+qutwsN2gRZCkgXhOk5wZ5ZuVA4Q2HriksWkJ4aVjVLXdW2Xe
    /mZ2nYMh8oWePYU+aeftFts1YSoiSgqVkMXNh43pVpelJIaBxnIdBKUj41ffXg7MXUQsUM
    k1OntS87U5GrdfddK6Hs2NkIbZ1ViMOIq5f00GhNA2xllBMqoGpkZm+A/etFHZ9GCcIihM
    hdXpHHWMl9UCjibnHpnPlKWkBCdiNYXyWwWrZFhcxCt8xJqZCM0ypTeI80VA
X-ME-Proxy: <xmx:Tt5karwtlbMAm0hOlglQi1Xtx5EJMr9aWqNkgrhTUXmIdQ8bsdlwSg>
    <xmx:Tt5kasPesZgS8txO8pyX4jINhHNfu5KDO6i73xcS6jk45IjSvuwtWA>
    <xmx:Tt5kanT2OuWiisTsLMx5VkgYcBECNTuGUybnPx80OeUWq1QTiWGmkQ>
    <xmx:Tt5kaibaCzphKP3SQomxb9Yt07S2UyQFPZnO7vxkGYNSXMIw9sa1Kw>
    <xmx:Tt5kahyvO9ETlh4uYJ75xTQMef4BnVeoD0MdzddEdu5QxrGY96VtPety>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jul 2026 12:03:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2] remote: plug memory leaks
In-Reply-To: <xmqqv7a33nm9.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	24 Jul 2026 17:43:26 -0700")
References: <xmqqv7a33nm9.fsf@gitster.g>
Date: Sat, 25 Jul 2026 09:03:24 -0700
Message-ID: <xmqqpl0b12gj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The in-core data structure used to keep track of
'url.<real>.{insteadOf,pushInsteadOf} = <alias>' settings is not
properly cleaned up when the process is done with it.

'struct rewrites' is embedded in 'remote_state' and serves as the
top level of the rewrite data.  This holds an array of a variable
number of pointers to 'struct rewrite' allocated individually on the
heap.  Each 'struct rewrite' holds a '.base' string and an array of
'struct counted_string' called '.instead_of', which is allocated
contiguously on the heap.  Each 'struct counted_string' has a
pointer to a string allocated on the heap.

Amid these pointers, rewrites_release() fails to free everything
other than 'struct rewrite''s '.base' member and the 'struct rewrite'
instances themselves.

Fix rewrites_release() to also free the contiguous array storing
'.instead_of', the string pointers within each '.instead_of' element,
and each 'struct rewrite' instance individually allocated on the heap.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

* The initial iteration relied on the assumption that strings
  borrowed from the configset subsystem will not go away, attempting
  to plug the leak of 'instead_of[n].s' pointers without making
  copies.  However, it turns out that all existing users other than
  a select few make copies and do not rely on that assumption.  In
  this version, I decided to simply follow suit, which might be
  slightly inefficient but is vastly safer.
---
 remote.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index a664cd166a..6c84adb36a 100644
--- a/remote.c
+++ b/remote.c
@@ -304,8 +304,15 @@ static struct rewrite *make_rewrite(struct rewrites *r,
 
 static void rewrites_release(struct rewrites *r)
 {
-	for (int i = 0; i < r->rewrite_nr; i++)
-		free((char *)r->rewrite[i]->base);
+	for (int i = 0; i < r->rewrite_nr; i++) {
+		struct rewrite *rewrite = r->rewrite[i];
+
+		free((char *)rewrite->base);
+		for (int j = 0; j < rewrite->instead_of_nr; j++)
+			free((char *)rewrite->instead_of[j].s);
+		free(rewrite->instead_of);
+		free(rewrite);
+	}
 	free(r->rewrite);
 	memset(r, 0, sizeof(*r));
 }

Range-diff:
1:  19a305bd22 ! 1:  3bd8668117 remote: plug memory leaks
    @@ Commit message
         'url.<real>.{insteadOf,pushInsteadOf} = <alias>' settings is not
         properly cleaned up when the process is done with it.
     
    -    Fix the rewrites_release() function to free not just the 'struct
    -    rewrites' instance itself, but also allocated structures that are
    -    pointed at by the 'struct rewrites' instance.  One of the embedded
    -    structures holds a 'const char *' to point at a borrowed constant
    -    string from a configuration callback.  Since the code does not
    -    modify this string, stop copying the value (alias URL) before
    -    registering it in 'struct rewrite', as nobody is freeing this
    -    member, to avoid leaking the extra copy.
    +    'struct rewrites' is embedded in 'remote_state' and serves as the
    +    top level of the rewrite data.  This holds an array of a variable
    +    number of pointers to 'struct rewrite' allocated individually on the
    +    heap.  Each 'struct rewrite' holds a '.base' string and an array of
    +    'struct counted_string' called '.instead_of', which is allocated
    +    contiguously on the heap.  Each 'struct counted_string' has a
    +    pointer to a string allocated on the heap.
    +
    +    Amid these pointers, rewrites_release() fails to free everything
    +    other than 'struct rewrite''s '.base' member and the 'struct rewrite'
    +    instances themselves.
    +
    +    Fix rewrites_release() to also free the contiguous array storing
    +    '.instead_of', the string pointers within each '.instead_of' element,
    +    and each 'struct rewrite' instance individually allocated on the heap.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    ---
    +
    +    * The initial iteration relied on the assumption that strings
    +      borrowed from the configset subsystem will not go away, attempting
    +      to plug the leak of 'instead_of[n].s' pointers without making
    +      copies.  However, it turns out that all existing users other than
    +      a select few make copies and do not rely on that assumption.  In
    +      this version, I decided to simply follow suit, which might be
    +      slightly inefficient but is vastly safer.
     
      ## remote.c ##
     @@ remote.c: static struct rewrite *make_rewrite(struct rewrites *r,
    @@ remote.c: static struct rewrite *make_rewrite(struct rewrites *r,
      static void rewrites_release(struct rewrites *r)
      {
     -	for (int i = 0; i < r->rewrite_nr; i++)
    +-		free((char *)r->rewrite[i]->base);
     +	for (int i = 0; i < r->rewrite_nr; i++) {
    - 		free((char *)r->rewrite[i]->base);
    -+		free(r->rewrite[i]->instead_of);
    -+		free(r->rewrite[i]);
    ++		struct rewrite *rewrite = r->rewrite[i];
    ++
    ++		free((char *)rewrite->base);
    ++		for (int j = 0; j < rewrite->instead_of_nr; j++)
    ++			free((char *)rewrite->instead_of[j].s);
    ++		free(rewrite->instead_of);
    ++		free(rewrite);
     +	}
      	free(r->rewrite);
      	memset(r, 0, sizeof(*r));
      }
    -@@ remote.c: static int handle_config(const char *key, const char *value,
    - 				return config_error_nonbool(key);
    - 			rewrite = make_rewrite(&remote_state->rewrites, name,
    - 					       namelen);
    --			add_instead_of(rewrite, xstrdup(value));
    -+			add_instead_of(rewrite, value);
    - 		} else if (!strcmp(subkey, "pushinsteadof")) {
    - 			if (!value)
    - 				return config_error_nonbool(key);
    - 			rewrite = make_rewrite(&remote_state->rewrites_push,
    - 					       name, namelen);
    --			add_instead_of(rewrite, xstrdup(value));
    -+			add_instead_of(rewrite, value);
    - 		}
    - 	}
    - 
-- 
2.55.0-570-g266ec51bf1

