Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935F118AF9
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708885490; cv=none; b=BNv7fpgOi3LP3K3M0YYLAyrDS0CbhW7XRKR45tbgOceX8g40EkeL1xVwduZatTDy+JAiu9YqZJo71BNrQGj88N9amqoqfMwTGQAfYeO9QtVl6YLbhGMBvm9weK5wOF5uOZ8e7FHoWbX05N4EsNMwETjaws/EO1xijnBMBaWjyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708885490; c=relaxed/simple;
	bh=EVt3x/92a/lZBoPGP/zmEOqlAd2d2CzJuFGlNm7ez3Y=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=OcwFmZxeRcAyrp1cjlmgpsc+F18UKSqmHxMxZ92eOHnn7f1LyEbZNJnqZZkgwwXE8i6AJXItTBd4kqOr1golBLyBZEtLUlbNMhjCV2Ka9i4cxfqMvFGjTRNFl6FJdekK+9knn4fSGIAvnlhu/9eGCSWrDrQaBRE7x8VPnRYbhWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=uiIzgZ1U; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="uiIzgZ1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708885480; x=1709490280; i=l.s.r@web.de;
	bh=EVt3x/92a/lZBoPGP/zmEOqlAd2d2CzJuFGlNm7ez3Y=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=uiIzgZ1UD386rT2WjRpzuuTO/ParBz3pH9reZBhbqhyS9b+o3rgeuzLj5Q59P4MR
	 TuZxh/GRIpBHbVmSDoctUIefATcDrAzXuL2VgjP2Dzgmdur33aN0b2etlnUX+u4fR
	 aq1IJyEK0ZHNgTJZrvJB1q05jY0pH0kvUFMYmxShhu5kB6PTmgFDngBmdT0RSD9Vt
	 c54/WJGcVYpByZqNZp64E6aqR4PpxMZyawLeX+vZnsXismtC3/cP0URmFf/46ATDA
	 h5pppZN7mgVpqWFcq20F+kahw+wXnYR0a8Q0liABh1ipVFh5TeGovM0swP+TMSach
	 28szOeHhrYY9sjpicA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSZHv-1rT90L08Px-00SnQw for
 <git@vger.kernel.org>; Sun, 25 Feb 2024 19:24:40 +0100
Message-ID: <8cd983fb-32b9-41c6-a9e7-a485b190488c@web.de>
Date: Sun, 25 Feb 2024 19:24:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] submodule: use strvec_pushf() for --submodule-prefix
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2fHVHL6X+Tk7ih+XnlxAuJB09Uo0PBj3frs4XbGa/jJDULsnyuV
 wGnsCGJRldO2hTVgudkuRv2Rn6UdvddO1+O2npVORrfnIRalBi+CrYFeiKC5qDb60R3ZhfN
 SvmzPVA8/WzWYXQsAkSkatevicQYzxsxsceLsu3+BGthlOdROr4Aayn6qGpbh3aECJutUt5
 xQL5GNl/WC6IWxPVdv2hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G7dsZRwJet8=;v9EGNSfsGQtdutS3qEBw62V/1HB
 u0s7MqOl2EMELaXzOToxsbwqndqv9GYOVXT0NtwD/Hyb4Er6tuzQoPbLiX8yqS0YecXUb9VMA
 3yQEieCOi5zQlkCXIPkx9LjwHpsegOQLa7ltJ1Z0BvFfib6x3s9k6RXZU4sjrQFIFh2xQrVmS
 bppXSDLmKo7kWpkqzpDhkm3Vg1OxsipujzMnk3pk2cqFE33+5ib8Ws+XvZAAGLzYA5YyGwHXv
 5jMahUGXVb8mBjR2e1gyC1u2MmuyldgzMsp4uwormfT4JtaTpmOHDzxcaobcLgmLb5gXEPKL7
 51ZrxNB+DMCsNqJK0FCP5n8E5ai4HBEVMl/WyffZNQFfq9DoF3058EOpfjzcfH8cVTGMo5w2O
 l+y1tAV+Bfkm9mTnKjrA/Wla1yVxeNV7Y04W7j7MTM2nISG/j3Lme+OnPoPOjiDoTmvkB2Qzg
 sJ/mJTuRmWSw0rQOxXZLFHOrb3hDt7jrJDEi2cv/YVHjcROKAvC6D33I7051xEjOxffz7zaDK
 a5Nqtd18dqp8+sOGzm3MwXTZWcnGmOi+iLF3DhnId9zaVYVgy5Gn2V1+MzgZDHHeVWuajN0Pz
 r/D2kTYOpMEYGflLKEUWmNwXjU6jgK3Z1tQOth2Hu8RlojLW2It4ZnASJ6DNIdgY08mFSVOW6
 wsEvz1c2IL+OiW4e5iTanL3YdrCf/Z2eg56ar27Eq1dZN0Nw5BJYOe3LpGA+LPqMDZGhR5QUz
 EZ33JZKque3V0hl2kWpkXrLPbWFXs0zCyXgrMUKh1UB/soHihLDVnuTA/W2Nq+hWEakHGYOi1
 IhfQMd7jeODNFFnz7j7Q/Y/7rxaDqgr1r4gpZBi6Zv44M=

Add the option --submodule-prefix and its argument directly using
strvec_pushf() instead of via a detour through a strbuf.  This is
shorter, easier to read and doesn't require any explicit cleanup
afterwards.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 submodule.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/submodule.c b/submodule.c
index 213da79f66..40f13a3685 100644
=2D-- a/submodule.c
+++ b/submodule.c
@@ -1687,8 +1687,6 @@ static int get_next_submodule(struct child_process *=
cp, struct strbuf *err,
 		task =3D get_fetch_task_from_changed(spf, err);

 	if (task) {
-		struct strbuf submodule_prefix =3D STRBUF_INIT;
-
 		child_process_init(cp);
 		cp->dir =3D task->repo->gitdir;
 		prepare_submodule_repo_env_in_gitdir(&cp->env);
@@ -1698,15 +1696,11 @@ static int get_next_submodule(struct child_process=
 *cp, struct strbuf *err,
 			strvec_pushv(&cp->args, task->git_args.v);
 		strvec_pushv(&cp->args, spf->args.v);
 		strvec_push(&cp->args, task->default_argv);
-		strvec_push(&cp->args, "--submodule-prefix");
+		strvec_pushf(&cp->args, "--submodule-prefix=3D%s%s/",
+			     spf->prefix, task->sub->path);

-		strbuf_addf(&submodule_prefix, "%s%s/",
-						spf->prefix,
-						task->sub->path);
-		strvec_push(&cp->args, submodule_prefix.buf);
 		*task_cb =3D task;

-		strbuf_release(&submodule_prefix);
 		string_list_insert(&spf->seen_submodule_names, task->sub->name);
 		return 1;
 	}
@@ -1714,12 +1708,8 @@ static int get_next_submodule(struct child_process =
*cp, struct strbuf *err,
 	if (spf->oid_fetch_tasks_nr) {
 		struct fetch_task *task =3D
 			spf->oid_fetch_tasks[spf->oid_fetch_tasks_nr - 1];
-		struct strbuf submodule_prefix =3D STRBUF_INIT;
 		spf->oid_fetch_tasks_nr--;

-		strbuf_addf(&submodule_prefix, "%s%s/",
-			    spf->prefix, task->sub->path);
-
 		child_process_init(cp);
 		prepare_submodule_repo_env_in_gitdir(&cp->env);
 		cp->git_cmd =3D 1;
@@ -1728,8 +1718,8 @@ static int get_next_submodule(struct child_process *=
cp, struct strbuf *err,
 		strvec_init(&cp->args);
 		strvec_pushv(&cp->args, spf->args.v);
 		strvec_push(&cp->args, "on-demand");
-		strvec_push(&cp->args, "--submodule-prefix");
-		strvec_push(&cp->args, submodule_prefix.buf);
+		strvec_pushf(&cp->args, "--submodule-prefix=3D%s%s/",
+			     spf->prefix, task->sub->path);

 		/* NEEDSWORK: have get_default_remote from submodule--helper */
 		strvec_push(&cp->args, "origin");
@@ -1737,7 +1727,6 @@ static int get_next_submodule(struct child_process *=
cp, struct strbuf *err,
 					  append_oid_to_argv, &cp->args);

 		*task_cb =3D task;
-		strbuf_release(&submodule_prefix);
 		return 1;
 	}

=2D-
2.44.0
