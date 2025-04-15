Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7DC24B28
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744761502; cv=none; b=Hn+SnOSfWWhBNcK9iGFAGTaZuMmMRyAu3c6wl7EXeghVKVwxiSb5DiXMYCMhdvaWCR2i1sUc+XYssJmmLDmdVOKQFpBBp1Smq+naVkWBhqFc+bd3KlJLZ4YfcOsp+GIplKzEH9ZK183c9xmRrdMStKAGgd+KiY1ntFAooKhDHqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744761502; c=relaxed/simple;
	bh=7Dm46N8Wvc4k/MAiK7nDsjXLz1NZiO4i0v8GObd1JwU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jMPhg5kEDSPxda+iZ5u4RGIuXC1qNIjW8VmZ+mZ/ehwONLFbNgloMUu3QsdNs6ARx/yyVUoiZFFZ0fWX5TeN+smk6hjwgrpKZPphdVCCBliayhFiqbD1OgxF0DuP8XeahTFsgFK7en/6R9b4JH0+kigkTdWM7eqTwbMXntk8feI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ULkh40c6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LokBzq67; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ULkh40c6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LokBzq67"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 10335254020B;
	Tue, 15 Apr 2025 19:58:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 15 Apr 2025 19:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1744761498; x=1744847898; bh=6uXCz76cZFQ0OelBoFc/zZq4vjwKqDFu
	dH8r48O1luQ=; b=ULkh40c6JVSgEgIVIPfQq5YsZ/Cl2T+dX0eFrGFBMXyYBbp+
	E517wNSbKs7NSXBZJXkHQtUzKmYjSawVVJUmcepcG1kUSiBn3WfBu77rUATdhc+Y
	go9pyJbgO1Ru5B6ft8X47jc7GrPSqIEkNznFYbqOqiCP1HMLT7Y7N7zBSV+CkGNO
	vR+TIGitrggk8WZxzSmYC3dsMdGXJZbJQcuWwNBiGkMGwgnSU50Tm97cg7/RWR3K
	27I4ZDgY7WzhOGn3tJ0TfJW2VNYNehAKd64lq+gb0+nyn6H7b1xamyvps35AhE0E
	ggQeFkmITKRyU3081ccjc6154oVSoiSvMGZL+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744761498; x=
	1744847898; bh=6uXCz76cZFQ0OelBoFc/zZq4vjwKqDFudH8r48O1luQ=; b=L
	okBzq671Z1HvxtSFfEK2NCViBHX8na6SBIfHXLi8O8L15myJrtV9TMFjw7iGVYJu
	wD22fPpYbtowOBk88dUnVcls3bLRFyMcOu5kscMe4Zpq907hmeiWncxv33IQdarq
	6LZCLgQaR0cPREQu+YcXZ/4KYz1MZ/uQgdPbYWTEFmuPsVm6hrs2DL29Vn5JI+Pc
	R7uQoDvoBhHmMEknRlmlUjctqDTqTyWm2+hifUJ0rwgHKFdbGB4DLvn2EwtvgQpH
	UT0kfVjsM5TLFUaR9PUzysMzTYsEGvfyN6Ptz3nkP9EHfKJ8z6XM2gIai+92G59s
	OR704fpin3Pdaa+x21nDw==
X-ME-Sender: <xms:mvL-Z9zNNtp-8V2rrcSKab95lEl-u_ZxSmYpGUSe4FR1cJX4cLAMYA>
    <xme:mvL-Z9RqD_0XycobGUloGxPEzScsasceB-gkUPfoOokoYX9nb-sdi1srRxNjZf0AH
    ObHlfagG2iVhGDI5Q>
X-ME-Received: <xmr:mvL-Z3VMW-RhD8s3AiAwG2UP6B9Cpp0rRkGveQfkLPtNVic48bs5BaEUIE9VkrybP1I4Xu7uDkl9pVqagTWpyXHYs-IL4uyfAxAE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhephfelhe
    eujeelteelgfelieffleeikeevgedtieffleeghfeuteeugfefudfgjeelnecuffhomhgr
    ihhnpehthhhouhhghhdrtghipdhinhhsthgrlhhlqdguvghpvghnuggvnhgtihgvshdrsh
    hhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhi
    thhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mvL-Z_gXUHiXBQAebLLrFY_Fin8VP6iF4QyfUjxqGGZyGVwiC3t4pA>
    <xmx:mvL-Z_DIhpSb08BZ3G6BOKruleXwvcH-KIvBtMsubC8wnEPvyDMG7w>
    <xmx:mvL-Z4LKETTHk2ZM3FMlG1L9aL4BA6GRCVg1mEtCW0_VJ2fYGTVtPg>
    <xmx:mvL-Z-CW-QXALM64pWJH5BJl6GoFhx3jGBFFOFQ4sx3vTBklnM55pg>
    <xmx:mvL-ZxwGVPbZnGYA9zBGvBRduYcLL3M9HBqWYanU9yaqbU_vNhzCJIGe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 19:58:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [RFH] fedora: pedantic fails complaining that awk is missing
Date: Tue, 15 Apr 2025 16:58:16 -0700
Message-ID: <xmqq34e9kmef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

GitHub Actions CI started failing the pedantic (fedora) job at the
tip of 'master' few days ago, and the log claims the failure is due
to missing "awk".  Even though we have seen a few topics to rewrite
Perl scriptlet, and I think at least one of them uses awk, but they
haven't hit 'master' yet, so it is puzzling why this started failing
all of a sudden.

So here is a band-aid.  I wouldn't be surprised if the base image
was updated without telling us.  We have seen Ubuntu 20.04 base
image retired to cause CI failures as well.

Almalinux does not even seem to have awk available as a package
(or it may be called differently, but we are not suffering from
the lack of awk on that platform anyway), so make sure we ask for
awk only on fedora.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * As the scheduled retirement of U20.04 image broke CI jobs running
   for 'master', I started looking at making it pass again with the
   minimum change, i.e. by merging dd/sparse-glibc-workaround and
   js/ci-github-update-ubuntu topics.

   Then I somehow found that another job is broken.  And this patch
   seems to make it work.  Not knowing how it got broken is
   unsatisfactory, though.

 ci/install-dependencies.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 8700c0f292..a7c613ce4c 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -30,8 +30,10 @@ alpine-*)
 		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
 	;;
 fedora-*|almalinux-*)
+	awk=
+	case "$distro" in fedora-*) awk=awk ;; esac
 	dnf -yq update >/dev/null &&
-	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
+	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $awk >/dev/null
 	;;
 ubuntu-*|i386/ubuntu-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.
-- 
2.49.0-511-g173acbf1d8

