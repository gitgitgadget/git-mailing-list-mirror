Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF18E2C9D
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 00:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272133; cv=none; b=syPgyf+1Ol1htrYy0a4SV5pzzWPE75lXFRNi9Z01XUk0KKinE+wcBOm+9vvSW9EAn1bIPbbFTvlNofp48LotBeVvYx0uoHn2cWXP7Yd+G6TIK0k1e2okTxFc4/jjyXeWHgdheF8f88ziwA3R40Q8sJYsB3xLuH5OFROxmjkisaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272133; c=relaxed/simple;
	bh=Zat/kHwxxxf2lcYcozCE4PlvO68lXbJWDtyinw/H7to=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QENwAc8liKBjB+26YSeG2G5NYeTpjOu1lTokeThYfSWRNuQpv7SBv8dnRB8DxKyncfnpNbccgyQIZaHZ5yfzt7xTPX5OXXQBSXZuZvcEDe1lz87QhRyCg6dEjfneatYDuGQkT7oAWDIdkQPIF2mtsq5Sjms0NaMZirRULGhI61w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=gg09v62b; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="gg09v62b"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 64VNkjRX030903-64VNkjRZ030903
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 1 Jun 2026 02:46:45 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wTprh-00Bhje-4n;
	Mon, 01 Jun 2026 02:46:45 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 02:46:44 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id d4276b58;
	Sun, 31 May 2026 23:46:44 +0000 (UTC)
Date: Mon, 1 Jun 2026 02:46:44 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: Jacob Keller <jacob.e.keller@intel.com>, <git@vger.kernel.org>, Jacob
 Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] describe: fix --exclude, --match with --contains and
 --all
Message-ID: <20260531234644.97LRl%taahol@utu.fi>
In-Reply-To: <xmqqo6hwcves.fsf@gitster.g>
References: <20260528232950.187002-2-jacob.e.keller@intel.com>
 <xmqqo6hwcves.fsf@gitster.g>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-14.utu.fi (130.232.247.54) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhcSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFpcSAIJCwcK
 Rg1GAw0EBA0aKAEGHA0ERgsHBUhYSFpaSAIJCwcKRgMNBAQNGigPBQkBBEYLBwVIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=oSdfCzSeVl4j4iWKCVTDnT9YnSe5DTTuM6zHL+0Nsa4=;
 b=gg09v62bEkip9Dk7oLlC7ZxebtqffXaK19vJf6fX0aDQxMXs3S3lHGWGHVq5HRIFhrQpEBQ99AKE
	5bQnK5ki2sPPpNeQTEOU9F7uf8OlAomMQIwAObUMvVxDB2PaaP+2QsUcB6EPmbN8kQuiiH4hSwXT
	YG3PIWTKWp7hRfFXqawNCXZcQeFr6Y+e3bW/QXeBrNRaqGpi1mXoPuN5HaQWPxuTVFjNh8AI8x+u
	9WovFZnqt1aYtWgHkVSo4KKrZ77aLzfqn8ghDYI7RJbLyCBrsy0i3TChUCB30FcgfUt0oDT/Xoxb
	knquUPcSffZV2Sf8XWJjBFyXeC7lhKtdMxKiRA==

Junio C Hamano <gitster@pobox.com> wrote:

> It is curious that this fails in some but not all CI jobs, and even
> more curious that these failures look the same.
> 
> e.g., https://github.com/git/git/actions/runs/26671595367/job/78615760984#step:4:1984
> 
>   +++ diff -u expect actual
>   --- expect	2026-05-30 02:21:23
>   +++ actual	2026-05-30 02:21:23
>   @@ -1 +1 @@
>   -branch_A
>   +remotes/origin/remote_branch_A
>   error: last command exited with $?=1
>   not ok 70 - describe --contains --all --exclude
>   #	
>   #		echo "branch_A" >expect &&
>   #		tagged_commit=$(git rev-parse "refs/tags/A^0") &&
>   #		git describe --contains --all --exclude="A" --exclude="c" --exclude="test*" $tagged_commit >actual &&
>   #		test_cmp expect actual
> 
> Rings any bell?

That's way out of my wheelhouse but this seems to fix the failure
for Alpine at least:

-----8<-----

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index d6594ada53..1776ffab46 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -416,7 +416,7 @@ static void name_tips(struct mem_pool *string_pool)
 	 * Try to set better names first, so that worse ones spread
 	 * less.
 	 */
-	QSORT(tip_table.table, tip_table.nr, cmp_by_tag_and_age);
+	STABLE_QSORT(tip_table.table, tip_table.nr, cmp_by_tag_and_age);
 	for (i = 0; i < tip_table.nr; i++) {
 		struct tip_table_entry *e = &tip_table.table[i];
 		if (e->commit) {
