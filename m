Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F94363C5E
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773039138; cv=none; b=MR+Aes2kjAsi2THs7BtDuo92EqZdSrbUCD6/lJgc/33QP07A5dySNBkk+cxnXtAesxkknqlDNPp2fonJy8AVWVSpw9ZVb22eqLI89wC/UCBAjbfIbz/AEf0hcpRczpCB2P4XKIvwUruDY+Ti3+xXSTm3ruYU3gqSXiWVrDHrY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773039138; c=relaxed/simple;
	bh=aAt6SkO4rJxjI54Y6Ie0XSqEx8qnAcbrxHJxethzwDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P47hHk4gC330rOHxTSc+YnR3ku9nzC4OFU4I4v6bfGoYn6+n9/1dZWjMtVu/aci0shiJ6KH5pb+yVRIfzyxjBZqr6VnFamuzK1PU8WahyQxxNwMve4ArO1t/XpsBolbyWHfnQ1gM5gcT/W88gJVxJ7ytyIlHtXEw3lqdTMaNsPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=ifIBTENp; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=MZ4Jw71h; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="ifIBTENp";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="MZ4Jw71h"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=ifIBTENpMlxyioOhLoi5Jm5MtImc1meuaSo/Z6SOqs90tFqVYd5tmEpKNZU5q2PVQ/CO6ZkCLnpe6ehYHNtccoRlylbC+qOpybfvVFtabsKwfT9mZWh8i+0kJmy0Q+c8YHp9jpLYY3ehe8eH4wXK6igFHolvwfTVK8hSp01eaC1i/sOZ5oouogW2YKE/Wud5cLAi+0NfM647feait2ttZaR5XQ5qmlGo9wQIPQ+Bb/zUzsVciCCC3JgpQfH+Xx7rTqeyk1Rz9Spq2tSJ4bfNmGhcBAnyhL3LjKMrR4jvdRr5oqlC7QoSalDTeC02ODNPW8LJzTnV0fCMMppV7xDoOg==; s=purelymail1; d=malon.dev; v=1; bh=aAt6SkO4rJxjI54Y6Ie0XSqEx8qnAcbrxHJxethzwDk=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=MZ4Jw71hhOKaRxu0HNz0wkd0QPofBmfZ8818aCuPoi18VmDPdODIVrRXQbIK2B7dleSdQjeoSA1cqWbtItewmogdt31ncWPHqxY7r8/OIxXDUtwXfgef499HnTHgajZEICTvHp95Gn4q0AFHQcg1ZVmDe2v6uZfsqc7JtrRTlaJoEydoFw/tcYmByAc25JoWsp+bQqsGfsrNavLzNKm3PbEKMYvj6OScv4hr5AKXgS+Ed5g2XsD6GePnkdNpawKfG/W7KiPnYzye8jIWWt6yDh9gpk4EKoip2TUeibrF6ghr/HduBPTtAWc9imJqscORsG/aMjexsqEynRb2U0TCGw==; s=purelymail1; d=purelymail.com; v=1; bh=aAt6SkO4rJxjI54Y6Ie0XSqEx8qnAcbrxHJxethzwDk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -688524607;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 09 Mar 2026 06:52:05 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v3] patch-ids: document intentional const-casting in patch_id_neq()
Date: Mon,  9 Mar 2026 14:51:40 +0800
Message-ID: <20260309065140.108644-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260308150203.86299-1-cat@malon.dev>
References: <20260308150203.86299-1-cat@malon.dev>
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
demand. As established in b3dfeebb (rebase: avoid computing unnecessary
patch IDs, 2016-07-29), this avoids unnecessary work since not all
objects in the hashmap will eventually be compared.

Remove the ten-year-old "NEEDSWORK" comment and formally document
this intentional design trade-off.

Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 patch-ids.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/patch-ids.c b/patch-ids.c
index a5683b462c..1fbc88cbec 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -41,7 +41,14 @@ static int patch_id_neq(const void *cmpfn_data,
 =09=09=09const struct hashmap_entry *entry_or_key,
 =09=09=09const void *keydata UNUSED)
 {
-=09/* NEEDSWORK: const correctness? */
+=09/*
+=09 * We drop the 'const' modifier here intentionally.
+=09 *
+=09 * Even though eptr and entry_or_key are const, we want to
+=09 * lazily compute their .patch_id members; see b3dfeebb (rebase:
+=09 * avoid computing unnecessary patch IDs, 2016-07-29). So we cast
+=09 * the constness away with container_of().
+=09 */
 =09struct diff_options *opt =3D (void *)cmpfn_data;
 =09struct patch_id *a, *b;
=20
--=20
2.43.0

