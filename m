Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D9199926
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482633; cv=none; b=PvqyGXyaeIF4ZPFuRGXH9E7XXbjLJZJodKgZKltL3b7ZJJ/2nV//qzC4RV3zWhjXdUVm87cYYp60GdOqURZb8y9QepT5vp9t0G0Kfn8e9z0bk/gqTbl0Ort7TzqOw9BC+X6AMY95hgdUcPHHdS+Sx9jdekmf1rjFbrtx+F94jCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482633; c=relaxed/simple;
	bh=0RWWWTBFNI5KZn9tQHuPU0N6n6ByWfMXYHx/c7IJXy0=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=d+HF1ZOj/Z0uPYV2fstEfofZEOmb232oRlCZ0cUqBAb+82F1ofqWRISUiv9eJs7qAJjVpi2LxeTUtCbwy2zJJ5LC6fkgoMk8Urbn9Qk48crnaAT1FAG0LCWkg7FhaoKhu2t+ig5DczlLqMUwC0EUriY4HIAw283nsTLAJ7aVckY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=hlq2qj+l; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="hlq2qj+l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=Mdg8+F+fWww4Uy/GwV6Y1ZrQrvhPt12+qWNggkub2Jg=;
 b=hlq2qj+lMsilMVOUSm+q9wUet2kfSzhNNaKoNUCORcY10DOVG7Wc5+fr/p/3dsV/i32r3hevetlf
   PFvBZUHt7Glrk1fOdo25QJqcNyYemJxdBZHnw4V8IHKefArQzaF7SlAIbrq5eW/92J7yKms6ekl8
   5zvYaAwz2mbdA4gCvJysIm8cbj/3eUI8Gw9bOGWMgh7pEPGUlCHJ4i0bDP+7LfLYA6y/VXSOJXat
   UYCSMCXxhPZnTt4478R1OT0rJOFvG9nYVrxEcE8grNS01qhV7Im0+8KAbfHyK/0WtWBAek0kQUMM
   6GQNdEyrwIcEd4lBfNm2ewGaIXxoNNQAbyuJTg==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL300MLXDHU8210@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 09 Oct 2024 13:58:42 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v5 2/6] set-head: add new variable for readability
Date: Wed,  9 Oct 2024 15:57:24 +0200
Message-id: <20241009135747.3563204-2-bence@ferdinandy.com>
In-reply-to: <20241009135747.3563204-1-bence@ferdinandy.com>
References: <xmqq1q0xhu13.fsf@gitster.g>
 <20241009135747.3563204-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAF/gFy7rF3qpJVocoHBXY8IwlLeex8cvVQrFbmvToqDrmT4W0E6keamp1HTeld0
 kVeUQO45w0JeS4c2yhzxxVyRlezQVY4mB06GP7/+5u9actNzec2WC5YKbGblbpZM
 5yRscu1zXmd5P0HY6GH1qvhGDMrHyNY8e8loppYd2zBmaiQcFYnS8m77okZmuMX3
 8h4h0xU3BI47fX/6inyLlRBGnyMw5x5sP1/9TL6va/nsRds389jAuid1DHR5ZvDW
 GTztSSllgSe3jbZq4xDICMczl9DOzl+NbSCgPQNH0IcnYxDl4edXwCaWeGJJ3YDH
 xcH4RuaBm1txjb/kflIP9+R9/WMFcSXDH44LwkLoD8XAGeCkDt4g953DHlFUUv8y
 BojPH1BR9w8j7uo0nVFzdp0u7tJ2ZDq2YVIDYncb1KLaxEqu9lXgH1Zxmu9Ivpda
 fYJLYztpEGuA2I1Q9o2dd0gmFPqDy1EAIQEU2DSMdIL55aCrziIUMPHS

Instead of calling get_main_ref_store(the_repository) multiple times,
call it once and store in a new refs variable. Although this change
probably offers some performance benefits, the main purpose is to
shorten the line lengths of function calls using this variable for
better readability.
---

Notes:
    v5: new patch (split from the next patch as a preparatory step)

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
2.47.0.6.g9542df9767

