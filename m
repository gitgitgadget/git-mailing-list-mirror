Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96124B26
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730865256; cv=none; b=sNkzjEPRc5XkDtuugu31P/PbTHUl4s9JIjXQB/T1fhy5AynzaLpNcM6oAY/J5D3rh8ltyHfQ0YjyMEKuEkgEutNQQGHHBmZoLrrnIktJxqToqHWDhlVccpPGdKUftB56L6MeRVECvgXREztSFlkXTR5F9Qzbj9AzTeal7Y6HrSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730865256; c=relaxed/simple;
	bh=MIatDJc0c/6GIJgGah8he4fksVUXwmf0REWsizvLVsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5Z8E06YrDfQceWwdHZBlBDbMA8aqLTAK7AdSYi61WXWksERIE2lww0Vknun0LHwM7HQpAtL5d/knneo9swErQ8CPo/QNc0TJbmMElkmGXm1dFaA8YpqtIVtBIvAhsmDEQSiO3QTXr7UgdRjAXYg+RhtKJtcQjbM3hsjrTHhwGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Guc62PZM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Guc62PZM"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720d01caa66so4474849b3a.2
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 19:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730865254; x=1731470054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hWhohHfv67b1snrsxLB2ZTXjJ4lhBX8Asr2jvvV5Qro=;
        b=Guc62PZM1rUa5vCW/UF6ZVUm5Wh+APUqM71vJs0ZMsEUbbd8PVi26XvwaM+V9w8csS
         3jyKtEU3CGJeLurTgy83KXVSCzIozWgF7T0Tbp2MdHlmXygFUBCMzYbJgCkVTlUsZruY
         gLb3S9zOSaZTx931DPcUIc0l5Lo5oqBIaD5reT40kW2CLpk/UL4vz7bBr7iWrsMNybpD
         +ZMBoUyaK3Qj8YKfhQJlufZ3bSYYvQmNSppmiaUziSPj0z7Qh1cC9YkA7niZu2m4i7m0
         AWfNxt7gmjTflKZ/stsiKO1Uc6nZs/drWcC+oHghVc9ljUMzTQcAj+g8qgLhOsbDV3G1
         f3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730865254; x=1731470054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWhohHfv67b1snrsxLB2ZTXjJ4lhBX8Asr2jvvV5Qro=;
        b=W3rgVWkfzVSxBOd4Ml0vTZ8CR2wY3YfT1qVFzqslGi17+UPuhnp1BY9ODS6lWYOPH3
         fblLmgkhV4fDWUvWns73kTh7FfB9KiVXPY49Pwm4vmuf2rmgA9G2tk+zGOZEVpgnxLCq
         xc603xxxBfh+qRmIqDvPvHDlDHi/47IsvrsFUADIEq2aA/EvASL0YPU6dH2NDLPc8TL2
         fDum9Yl1yBH0qJ75SAcqmI2zVxmYetCqgvSuRTjKUjv4fp5dMaW95HlRcSgGfIDVnyhZ
         D6FEXwqKRNxsL0b6fs0KR5UEEvCRiA9qtZyS5yhFDuHBhI1KGa82yuWpyBVGV9f93OEl
         wnXA==
X-Forwarded-Encrypted: i=1; AJvYcCWbMEoGvQ4bZbHKoUnsPcXSAPyR5TFHgNbeI4DdRQPuO2miZgrmLPu2VmciPwD9yqvAd4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Urp9eRf+pQWAdN3l7ONDQYg1u+9M5/olEeICFRXCWCnIFYu8
	Hg7sRaduBYDk9JAUvOrH8uqvj0VV1w8Raf40tLmC3AuFkeqODQlO
X-Google-Smtp-Source: AGHT+IGMAsFEv+qko9QyFHaB//WH8FVcu8RZzGLKtadHK6gesmS65YUEQUh5THBjlJ9+L/aAuATP5g==
X-Received: by 2002:a05:6a00:2e10:b0:71e:5a6a:94ca with SMTP id d2e1a72fcca58-720b9d94ab5mr27932948b3a.19.1730865253649;
        Tue, 05 Nov 2024 19:54:13 -0800 (PST)
Received: from five231003 ([2409:40f0:100c:725f:d50c:a7f0:19d8:cdf5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8cf3sm10697063b3a.20.2024.11.05.19.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 19:54:13 -0800 (PST)
Date: Wed, 6 Nov 2024 09:24:08 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t6300: values containing ')' are broken in ref formats
Message-ID: <ZyroYBwtQtgc6NoR@five231003>
References: <20241105190235.13502-1-five231003@gmail.com>
 <xmqqikt1qhwt.fsf@gitster.g>
 <20241106022552.GA816908@coredump.intra.peff.net>
 <xmqq8qtxqcye.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qtxqcye.fsf@gitster.g>

On Tue, Nov 05, 2024 at 07:05:13PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > I am tempted to say the solution is to expand that "equals" value, and
> > possibly add some less-arcane version of the character (maybe "%)"?).
> > But it be a break in backwards compatibility if somebody is trying to
> > match literal %-chars in their "if" block.
> 
> If they were trying to write a literal %, wouldn't they be writing
> %% already, not because % followed by a byte without any special
> meaning happens to be passed intact by the implementation, but
> because that is _the_ right thing to do, when % is used as an
> introducer for escape sequences?  So I do agree it would be a change
> that breaks backward compatibility but I do not think we want to
> stay bug to bug compatible with the current behaviour here.  I am
> not sure with the wisdom of %) though.  Wouldn't "%(foo %)" look as
> if %( opens and %) closes a group in our language?
> 
> So I am very much in favor of this "if condition should be expanded
> before comparison" solution.

I had worked on this "if condition should be expanded before comparison"
solution but Christian and I agreed that it would be better to open up
discussion incase there would be other possible and better solutions
which would also be viable in the long term.

This solution relies on how we parse out literals in ref-filter, so '%%'
would work as intended in the comparision string - ie if we want to
compare against "some%ref", we would do "%(if:equals=some%%ref)...".

Also it is obscure that someone will use this in practice as I myself
had discovered this when working on a corner case of some other
implementation related to parsing but way lower in the call-chain of
ref-filter ;) but here goes

(this applies on top of the current patch)

------------------------ >8 ------------------------
Subject: [PATCH] ref-filter: parse parentheses correctly in %(if) atoms

Having a ')' in "<string>" in ":equals=<string>" or
":notequals=<string>" wouldn't parse correctly in ref-filter as
documented in the previous commit.

One way to fix this is refactoring the way in which we parse our format
string.  Although this would mean we would have to do a huge refactoring
as this step happens very high up in the call chain.

Therefore, support including parenthesis characters in "<string>" by
instead giving their hexcode equivalents - as a for-now hack.

Do this by further abstracting "append_literal()" to "parse_literal()"
where the output is no longer stored into a ref formatting stack's
strbuf but a standard standalone strbuf.  append_literal would then
hence wrap appropriately around "parse_literal()".

Also introduce "convert_hexcode()" which also wraps around
"parse_literal()" and must be used to convert hexcode in a given string
and be silent when such a string doesn't contain hexcode or doesn't
exist (ie is NULL).

Using "convert_hexcode()" would mean that we now have an alloced string -
hence free() it once we are done with it to prevent any memory leaks.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 Documentation/git-for-each-ref.txt |  4 ++
 ref-filter.c                       | 76 +++++++++++++++++++++++-------
 t/t6300-for-each-ref.sh            |  6 ++-
 3 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index d3764401a2..ce12400040 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -221,6 +221,10 @@ if::
 	the value between the %(if:...) and %(then) atoms with the
 	given string.
 
+	Additionally, if `<string>` must contain parenthesis, then these
+	parentheses are spelled out as hexcode.  For e.g., `1)someref`
+	would need to be `1%29someref`.
+
 symref::
 	The ref which the given symbolic ref refers to. If not a
 	symbolic ref, nothing is printed. Respects the `:short`,
diff --git a/ref-filter.c b/ref-filter.c
index 84c6036107..ebdb2daeb7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1234,13 +1234,64 @@ static void if_then_else_handler(struct ref_formatting_stack **stack)
 	*stack = cur;
 }
 
+/*
+ * Parse out literals in the string pointed to by "cp" and store them in
+ * a strbuf - this would go on until we hit NUL or "ep".
+ *
+ * While at it, if they're of the form "%xx", where xx represents the
+ * hexcode of some character, then convert them into their equivalent
+ * characters.
+ */
+static void parse_literal(const char *cp, const char *ep,
+			  struct strbuf *s)
+{
+	while (*cp && (!ep || cp < ep)) {
+		if (*cp == '%') {
+			if (cp[1] == '%')
+				cp++;
+			else {
+				int ch = hex2chr(cp + 1);
+				if (0 <= ch) {
+					strbuf_addch(s, ch);
+					cp += 3;
+					continue;
+				}
+			}
+		}
+		strbuf_addch(s, *cp);
+		cp++;
+	}
+}
+
+/*
+ * Convert the string, pointed to by "cp", which might or might not
+ * contain hexcode (in the format of "%xx" where xx is the hexcode) to
+ * its character-equivalent string and return it.
+ *
+ * If the string does not contain any hexcode - then it is returned as
+ * is.
+ */
+static const char *convert_hexcode(const char *cp)
+{
+	struct strbuf s = STRBUF_INIT;
+
+	if (!cp)
+		return NULL;
+	/*
+	 * This has the effect of an in-place translation but
+	 * implementation-wise it is not.
+	 */
+	parse_literal(cp, NULL, &s);
+	return strbuf_detach(&s, NULL);
+}
+
 static int if_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state,
 			   struct strbuf *err UNUSED)
 {
 	struct ref_formatting_stack *new_stack;
 	struct if_then_else *if_then_else = xcalloc(1, sizeof(*if_then_else));
 
-	if_then_else->str = atomv->atom->u.if_then_else.str;
+	if_then_else->str = convert_hexcode(atomv->atom->u.if_then_else.str);
 	if_then_else->cmp_status = atomv->atom->u.if_then_else.cmp_status;
 
 	push_stack_element(&state->stack);
@@ -1296,6 +1347,9 @@ static int then_atom_handler(struct atom_value *atomv UNUSED,
 			if_then_else->condition_satisfied = 1;
 	} else if (cur->output.len && !is_empty(&cur->output))
 		if_then_else->condition_satisfied = 1;
+
+	if (if_then_else->str)
+		free((char *)if_then_else->str);
 	strbuf_reset(&cur->output);
 	return 0;
 }
@@ -3425,26 +3479,12 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 		QSORT_S(array->items, array->nr, compare_refs, sorting);
 }
 
-static void append_literal(const char *cp, const char *ep, struct ref_formatting_state *state)
+static void append_literal(const char *cp, const char *ep,
+			   struct ref_formatting_state *state)
 {
 	struct strbuf *s = &state->stack->output;
 
-	while (*cp && (!ep || cp < ep)) {
-		if (*cp == '%') {
-			if (cp[1] == '%')
-				cp++;
-			else {
-				int ch = hex2chr(cp + 1);
-				if (0 <= ch) {
-					strbuf_addch(s, ch);
-					cp += 3;
-					continue;
-				}
-			}
-		}
-		strbuf_addch(s, *cp);
-		cp++;
-	}
+	parse_literal(cp, ep, s);
 }
 
 int format_ref_array_item(struct ref_array_item *info,
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index ce5c607193..c9383d23a4 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -2141,7 +2141,7 @@ test_expect_success GPG 'show lack of signature with custom format' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'format having values containing ) parse correctly' '
+test_expect_success 'format having values containing ) parse correctly' '
 	git branch "1)feat" &&
 	cat >expect <<-\EOF &&
 	refs/heads/1)feat
@@ -2151,7 +2151,9 @@ test_expect_failure 'format having values containing ) parse correctly' '
 	not equals
 	not equals
 	EOF
-	git for-each-ref --format="%(if:equals=1)feat)%(refname:short)%(then)%(refname)%(else)not equals%(end)" \
+
+	# 29 is the hexcode of )
+	git for-each-ref --format="%(if:equals=1%29feat)%(refname:short)%(then)%(refname)%(else)not equals%(end)" \
 		refs/heads/ >actual &&
 	test_cmp expect actual
 '
-- 
2.47.0.230.g0cf584699a

