Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B3317B402
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 20:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748894925; cv=none; b=QXOPFLqKiB2pYw4+WAxYPMB4XmTuFkTXOjc5FHeR222je5FnZs/UnDi2i77OsidVC8eAtW+oHm8AG304ejbU7tvB1TMQ97KobDYndIWS+w7pB8qQo8ESJIbrShaP8P/73SY9hX+lmOeNpSY5QzisJRc79XV+7kqsYRcGnhpT32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748894925; c=relaxed/simple;
	bh=zxwpYULjlFNvlD1XaCuPZjwAEHCQ1Gk+QbjNNNYkgB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OROjA9pe2Lt3dN0nTLUnhTO3I4BpN0uAJDd2iUSgyNMg7cuJ6yv7LYbMLHG61DtgY/geJDqBDCoEbCIgKOQMmprDTLSrRZa11zH4wwhcBTz74tgNH1W100MNwmG5CK991YLTnzfnkp5wC/U6FpuuL/ZwXnSL81PjpJtYU+revQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7/HAXBd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7/HAXBd"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-742c035f2afso3139158b3a.2
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748894922; x=1749499722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbYBMyT4iWrplrwl4bvF0GfI5bpIaL1lkFKJcjdduiE=;
        b=i7/HAXBdP2JMF7oF2IfWnV8nMRPVWA19Vps5qLlMCEwFdkKxw+iUNNRefhvHZzufO+
         f/A4xPsJVT1I6mmaRKv2QzOpEEN8SJGT69ETKVdKx06UxuE5YJuqXXvRB7IimGa61m5Y
         fzsSSYS3jPqoGWtHVP/BNaGCdiBh0ZbgcncIzshpnRAHr/nxaxc6hpRhZpP2MgrvF8nO
         LaxL21iiWi6K3/5GwtzLpVg6eIgDK8EkJkg5wAo54DLAJyMC7LBzkK3wAS6pFJEKA7Ws
         +Maf6HhPgCXP0yB1VY+PSyJ8x493hU1LERvy2PPOsQNX0WdNLB/7l1y8Sl/vqruklouB
         jHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748894922; x=1749499722;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RbYBMyT4iWrplrwl4bvF0GfI5bpIaL1lkFKJcjdduiE=;
        b=Jgp9gjoUR0A13HZdvBrmLXl4xFqf+2vACi5TXEg1m9whS2S+9P4Fg92vyjKEwJDdEW
         JmTESez8X/XARBFHv28PYtTXJgD+8iU7TWxgvjgaPGskrIpmB6KFAYLHL1anH57bodpH
         vvd0VF5jzgZf6UxDQRHHUQcWmuc7Fph1wsgwrCiMymZovdmK78aPAxidbHYtOVjFC/Og
         pL7LgA58MoB4b+hKBvSYmiEvQbelyjD0kjjzwhaNZs+9/y5pANplDsGMtbUK9oQjAJ5N
         WA0HLWRLY9nv5pFuMsmsc0VkiHI5jZ8hMwvh3HBrstogLhzgQTggDrMQH2enTqYx6TxE
         7/Vg==
X-Gm-Message-State: AOJu0YzDGSB7JFOy7SSkabC7NVEMBOyihEDwLm7axQ//haP7pc17kSAR
	6ziuu9VDI+5jodl1jCSpgAeG9c/+qs7Qq2wQlMPQMnfkWfI/oNMeB0/X
X-Gm-Gg: ASbGncupsDR1cPbMJSFVusg9QvPK0nfOhyBjRhLoDHaKJ8ZsflFCBPNg/ghSNRhwI5y
	NGYFhyf3EnQRa19x+rHHe+yLpFLHL9086MBBE24+y8eEumwohKn6FOWVtsTfysQzPl8pVm5HKOZ
	0h6wxfNw6IGOUh1z1QJFme1QZX/L2azRhvhWIM2UmKLBBKF1vLj0teIWTfKgTIeMBdSHJVaovBx
	vkd0/r8sxhcUw+zoRvZXIZ9zFdoi1w2AuK9EfrnJp9p23EjE53qTphGT44DsoGXl6A5P6t8Crak
	447cc0aoMtUXqKpYbGkNDGsANwKiKmvS5TOSQUqVkA==
X-Google-Smtp-Source: AGHT+IFD8fdFKc2FtoRe+M+b1NlqQrgKuJHfdaxKZJlWsPesvBuJdFq7BX1CNKxZ/cl/VJ2+tLEkXw==
X-Received: by 2002:a05:6a00:1782:b0:746:1b45:57a8 with SMTP id d2e1a72fcca58-747bda1a80amr19052563b3a.22.1748894921666;
        Mon, 02 Jun 2025 13:08:41 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::9eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affcf83esm7974715b3a.126.2025.06.02.13.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 13:08:41 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org,  Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] completion: Make sed command that generates
 config-list.h portable.
In-Reply-To: <3631972.iIbC2pHGDl@cayenne>
References: <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
	<1ff542bb1090cc5185644d6032addac5cd0df402.1748892261.git.collin.funk1@gmail.com>
	<3631972.iIbC2pHGDl@cayenne>
Date: Mon, 02 Jun 2025 13:08:40 -0700
Message-ID: <875xhducs7.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> Your commit message has some issues:
>
>  * upper case in "Make": prefixed commits message must be lower case
>  * to be correct, the bug was already there at the first introduction of =
the=20
> generate-configlist.sh script (3ac68a9). The '\n' was there, and the gene=
rated=20
> .h file had two wrong strings such as
> "gitcvs.dbUserngitcvs.dbPass" . My patch only put it in light by breaking=
 the=20
> build.

Thanks, I will keep that in mind for V3.

> Maybe an alternative way of fixing the issue is to just rework the=20
> documentation on the two spots where a comma is used and put each config=
=20
> variable on its own line.
>
> What do you think?

Regarding readability, it is not any worse than it was originally. But
maybe that is because you are much better at sed than me. :)

But we could put configurations on seperate lines like so:

diff --git a/Documentation/config/gitcvs.adoc b/Documentation/config/gitcvs=
.adoc
index 02da427fd9..31d7be3992 100644
--- a/Documentation/config/gitcvs.adoc
+++ b/Documentation/config/gitcvs.adoc
@@ -47,7 +47,8 @@ gitcvs.dbDriver::
        May not contain double colons (`:`). Default: 'SQLite'.
        See linkgit:git-cvsserver[1].
=20
-gitcvs.dbUser, gitcvs.dbPass::
+gitcvs.dbUser::
+gitcvs.dbPass::
        Database user and password. Only useful if setting `gitcvs.dbDriver=
`,
        since SQLite has no concept of database users and/or passwords.
        'gitcvs.dbUser' supports variable substitution (see
diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 67393282fa..9da5c298cc 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -289,7 +289,8 @@ for most push problems, but can increase memory consump=
tion
 significantly since the entire buffer is allocated even for small
 pushes.
=20
-http.lowSpeedLimit, http.lowSpeedTime::
+http.lowSpeedLimit::
+http.lowSpeedTime::
        If the HTTP transfer speed, in bytes per second, is less than
        'http.lowSpeedLimit' for longer than 'http.lowSpeedTime' seconds,
        the transfer is aborted.

This is similar to how options are documented, for example:

    $ head Documentation/pretty-options.adoc=20
    --pretty[=3D<format>]::
    --format=3D<format>::
=20=20=20=20
    	Pretty-print the contents of the commit logs in a given format,
    	where '<format>' can be one of 'oneline', 'short', 'medium',
    	'full', 'fuller', 'reference', 'email', 'raw', 'format:<string>'
    	and 'tformat:<string>'.  When '<format>' is none of the above,
    	and has '%placeholder' in it, it acts as if
    	'--pretty=3Dtformat:<format>' were given.

Then go back to the simpler sed expression before your most recent
commit. I will wait for others thoughts before posting v3.

Thanks,
Collin
