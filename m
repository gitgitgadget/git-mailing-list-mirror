Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F03828750A
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772982144; cv=none; b=EAPOzGsE0ddH3ET7vb5Xr6liio6uHUxhuU9uUcoVrOZXCp3E730P4Kpgnv+HzQkwj6sK92KShNcLArIfwut3vcbO2auz7UIL49qhhQif+yqQlNvmEJ+1MTL7rM8HVnpG8A60wF1TJxsffFb8VGIvGryK/WHI0u1pKyQgPdMZvOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772982144; c=relaxed/simple;
	bh=C76/+NB5PTpBwnt8gslgzJQeowQ8fpCI/5zx2dVVQFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNUppeYlno9ZJDTUBv8dK/VAkYXG+ZbehcdbDcmqjdmVQeptVSDn+f2S0BAQbNk3GHQ9AV3UtWGH5VMav1IMieV++Ahqu5DRDglva4v8Ni2uHmjEktgWxQwL2KYHSKBK0dR8JMYFIPuWZyri4tueNLG2tLVKPTD04PV0ED3ODPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=s6TsHGlV; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=f6zHxEeP; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="s6TsHGlV";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="f6zHxEeP"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=s6TsHGlVg9s7RYJbk6Z/uNv0vCW2LUBAHg35r0JnLaRli+HlNyltpxZvzLCw6Sh9EVtYrFBj1tbgOeJkK+W3NTAgdVrakhMv0Da9b2hjBcNika4ZxCAIg5+/hImXXrADHcEZ8QgiMxkd990+dMWG/levXeh78GYY76u0kVYvMiOlyv6EfPNcWgqG5TW0HvjXu2U7rNZpg6n2VC4IQMh4CP8fEE6HDoTAtNTzLgGqf5VDBOMblpmoZEpiwEbNPUZGAbb5OYiQOx3Daf57kuOMw7qPL2D2MoRfZkBnwz1yMAWAlF1BNXGNYAYJQ0rhOEwpoWl39Pw5I7c/MpgQy7BRMA==; s=purelymail1; d=malon.dev; v=1; bh=C76/+NB5PTpBwnt8gslgzJQeowQ8fpCI/5zx2dVVQFM=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=f6zHxEePsrMYCsEMOn+mcKnUpzKT9vWhUNeXNPFyQv0prXssAs2eKkN56/jDL9NhB5jrEL5RyIQ8i17LXQIyX2mwcWpZRKsFafHWYwnhcMWlLO0WwLTrz9cJW7zgrQPJena19WaV8WtTU41sQ5hw+/SL5HFCTviRF3ItdwQl74+GujPClS7GAT71oT9QfH935WQ8yD9kNafA9R5KUGcWO98IMSxbPhE0uo9vn/J/vrhEqRgF7zYJeqU6dKfA1Vo6UXtwwcyf77JTnb5R7v59yxHQzHfAepGIRexfYPRpHFs8+SSHadsA3jVzeBy6EGE2rhWLJVuB0ti+2hEWW0r1Ig==; s=purelymail1; d=purelymail.com; v=1; bh=C76/+NB5PTpBwnt8gslgzJQeowQ8fpCI/5zx2dVVQFM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 787998619;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 08 Mar 2026 15:02:19 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v2] patch-ids: document intentional const-casting in patch_id_neq()
Date: Sun,  8 Mar 2026 23:02:03 +0800
Message-ID: <20260308150203.86299-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260308043131.77782-1-a3205153416@gmail.com>
References: <20260308043131.77782-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The hashmap API requires the comparison function to take const pointers.
However, patch_id_neq() uses lazy evaluation to compute patch IDs on
demand.

Pre-calculating all patch IDs to achieve true const correctness would
introduce an unacceptable performance penalty.

Remove the eight-year-old "NEEDSWORK" comment and formally document
this intentional design trade-off.

Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 patch-ids.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/patch-ids.c b/patch-ids.c
index a5683b462c..35e6a974f1 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -41,7 +41,15 @@ static int patch_id_neq(const void *cmpfn_data,
 =09=09=09const struct hashmap_entry *entry_or_key,
 =09=09=09const void *keydata UNUSED)
 {
-=09/* NEEDSWORK: const correctness? */
+=09/*
+=09 * We drop the 'const' modifier here intentionally.
+=09 *
+=09 * The hashmap API requires us to treat the entries as const.
+=09 * However, to avoid performance regression, we lazily compute
+=09 * the patch IDs inside this comparison function. This fundamentally
+=09 * requires us to mutate the 'struct patch_id'. Therefore, we use
+=09 * container_of() to cast away the constness from the hashmap_entry.
+=09 */
 =09struct diff_options *opt =3D (void *)cmpfn_data;
 =09struct patch_id *a, *b;
=20
--=20
2.43.0

