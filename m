Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD41BC9EE
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567091; cv=none; b=TeDuwipkb8kAvr03fGJEMfWzXTHVwY0WBH3ws78ItLadUsIpVyhSieSwbPLBAEZTyDHGuMlPPeBrbBCeALjxgJbJF4xYLyqDNIbzNCx/N9+1ggvnU2JMYsKw1japsE2GqKOjTUlIuLmKv6WQeMK4A3n83Ad0mo5XEuuELH2HV0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567091; c=relaxed/simple;
	bh=KjLrT6AtkPAaW/T4+4fKwyhi9iL8bnzuiatHCasR57M=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=Q8YLKmoWlsYAcDePJmfRNfKF9lOGeqOEhHnxuZpOZET+YnUoB4aSG5YeI61hGPA1pd2Gm+ACgveYWdki/esbKn8XaJqmdLjOfpyIWlguIWzCU7F1sMTlH95mCAZTg6E9ooXbIB6Yf/hhY1k0PbPPwONCutQJ0BRcOUjWmp8YNLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=YtwxTyCH; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="YtwxTyCH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=E4jh3raTHhR1HY2eZIFVgcPEBvjlZZxGN7Ryaj9pfww=;
 b=YtwxTyCHZMqN0ugK4E/u4/Bz4+I36EkJOru22Sl6JXa7quU8JB041JTBrt3HUjzqAh1PmjbdaDSD
   YyVW8PClI6T7RBVQTGaslsZTgDkWqGDN82Tk5ORjqm2ozjd8ZBowjBOMKXkMN+d+dpNEXBLF4M02
   lVPaXK3UqRBhf1T5FS3Uf0UP5JvZLjMJj5vlyNZfNOcw66min4M/xwT7snaxHIsA9mY8zocL5yZU
   yp0pjQGGN/bXh5Fly8fdVx9VmKstn1wncztg6aqp+kjo8C316VwfA42AHEoLRsaCnnUoIdzIyjjv
   r3PivtLCK6EL7Wu9yqCtpCbeyHVgFyQ4CfWFvQ==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL500HWI6WAMCB0@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 10 Oct 2024 13:31:22 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v6 2/6] set-head: add new variable for readability
Date: Thu, 10 Oct 2024 15:29:57 +0200
Message-id: <20241010133022.1733542-2-bence@ferdinandy.com>
In-reply-to: <20241010133022.1733542-1-bence@ferdinandy.com>
References: <xmqqzfndndfm.fsf@gitster.g>
 <20241010133022.1733542-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFkClu7NkgDEEonQIdFjym5PUIXUg+VdM8Ay2cp+dCBY9xLP4cUVO/XMVf0/mOI
 U+17Ngn0FwXy+vKWWKc6Fb+bdkNajqEU0GQyBNntafcINY7bVXWrZ9CAdA5WzP3H
 leLdmCMuJaeCj2G2ySwBLD7yboqXRvrmXqNNM+5GBfMuC71QNyBe/1r858ibfSNu
 0m/fLDOXkzB4fhfaKSYn+2B5/ln9xrENKSq1ARx/746nd+JRZhaBoooBMSCEFqAE
 3SG+wCKM4J8Jz8PTOBwJyJGaqH4ICduULnkz2LY0eXuXa3emymrZekJbHM6PpzXF
 xXPmXJZBfJ0ViDjbGcCSLPlBm8KjD6286YxIcNfeqrvpKg80tD0ojmFbXpk0qmKV
 ZZq/FpSY0u4Fw7rjCNB5eDzZ3HZHd7aaZCvPCz4SEkSxhqgSePhOopWaLbT1bbZw
 EIlvzTm4z+i1mY6h2LEbl2OHufKF6yo6iX3n6U2XHLj9+IikuT8hyjM=

Instead of calling get_main_ref_store(the_repository) multiple times,
call it once and store in a new refs variable. Although this change
probably offers some performance benefits, the main purpose is to
shorten the line lengths of function calls using this variable for
better readability.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v5: new patch (split from the next patch as a preparatory step)
    
    v6: no change

 builtin/remote.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d8ff440027..353ffd2c43 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1404,6 +1404,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 	int i, opt_a = 0, opt_d = 0, result = 0;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
 	char *head_name = NULL;
+	struct ref_store *refs = get_main_ref_store(the_repository);
 
 	struct option options[] = {
 		OPT_BOOL('a', "auto", &opt_a,
@@ -1434,7 +1435,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 			head_name = xstrdup(states.heads.items[0].string);
 		free_remote_ref_states(&states);
 	} else if (opt_d && !opt_a && argc == 1) {
-		if (refs_delete_ref(get_main_ref_store(the_repository), NULL, buf.buf, NULL, REF_NO_DEREF))
+		if (refs_delete_ref(refs, NULL, buf.buf, NULL, REF_NO_DEREF))
 			result |= error(_("Could not delete %s"), buf.buf);
 	} else
 		usage_with_options(builtin_remote_sethead_usage, options);
@@ -1442,9 +1443,9 @@ static int set_head(int argc, const char **argv, const char *prefix)
 	if (head_name) {
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
 		/* make sure it's valid */
-		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
+		if (!refs_ref_exists(refs, buf2.buf))
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
-		else if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head", NULL))
+		else if (refs_update_symref(refs, buf.buf, buf2.buf, "remote set-head", NULL))
 			result |= error(_("Could not setup %s"), buf.buf);
 		else if (opt_a)
 			printf("%s/HEAD set to %s\n", argv[0], head_name);
-- 
2.47.0.6.g07cb02250a

