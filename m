Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F123D2B5
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751457077; cv=none; b=rcP0v8ZycGb2DwzYqNWrRTIjO20dqDv6aIag7qdF4Rc/8H4Lry/9gXoTc3oscy67yLkkpR6lPDEgJ6Oxiy9Yg8QCLDpQGijmIRrdcOfLlJyl1IjZmaLRQiGUqHZbnVY4ZXl8BLMMNjJKqhMxiBSAENb0juM0Pg7WUtfo+VzNZG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751457077; c=relaxed/simple;
	bh=i4rrRPBJbbKyh82zz4hGq+R4/yKP5irIChP89tbNi5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i1lJIKVRKcxSvckQqFDPK5EhMBdnHlCXQDbiFrhlrnTjMvni+Qi7IGsJ7yjckh8fub7KjmVwL+roQCFYAjvbe8ey/C0BeZi5V+2YNVxMQO/LW2bMDfVgG/3YUP1nTw0J5VKbPPeBsOll0ScbM6sLZPC6PD2nInOepDVe4KB7ab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoz7NPEv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoz7NPEv"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23694cec0feso66628665ad.2
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 04:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751457074; x=1752061874; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f75V6xUxVSB5X8/M4gjlmJez4/WDInHJLsq1SEMKfcY=;
        b=hoz7NPEvwwzGopHn5Bwrj/OH60itMhqIgtPpisrEjARnDuJmpIxONSWMQXmJvcbxFM
         IgM+PLFOphj7A6HjI2a2Z51zzTErZpVBr1ZQF6ikR0OsyOr1oU/KRKfTFOw2MYl0++GE
         DVyTQsu0MnALnnu1qOGTVYSfykXUjpZPE8NkoQTz4WYx+VievYo9kXKXdSljbxeKoiXL
         +f+hJBqNx5i6Mo3CPzlrjpA/k7AXe3NDNPsib/wMfhbgukEBN3VCQD2NJI2CuorI3Hee
         GJeK/QJacY5MkaMkFVPnpQwryuBqnfdjIpIY6t/sH4p3xN1xBum3fyvtHZBzURZF3ze2
         zK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751457074; x=1752061874;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f75V6xUxVSB5X8/M4gjlmJez4/WDInHJLsq1SEMKfcY=;
        b=YMFH6sJ+1qBVg2lmjR4QU1UdkNRGALqSTouGuHIoXo7Az7CB9Vw5AnsjWB/Cpyg9l5
         5O8juqMBwwvseEkHMOyBSBGmNej584vutqg7+G4bAuFLhh8lo6aDxArRS7+hVSHnciGQ
         GXfCirYT+d4G1cujBr9mRNoTGoZCyvBxiXURA1H9eoSBcjRMci3ySBunR7TbgxfMIkle
         CBxj4LeYJARCRSpisW0D2teFBmpK1ZqpdCi2Au25Nw1x4GZ2oOIU71wo4acDn1z1shTN
         YgGmRhgr/Bi7bINntus9fi/hEsZxVM8+HkQHCiLeXJcdTThD9/KrnW6OfVWR9JhckfTZ
         lEKA==
X-Gm-Message-State: AOJu0YxrpzC69KemMa5f6azlUBD1J9dkQoDxmD+5NueJEwlOnmVUEyJk
	k6TADK/iHAVjtIAG6KCK+7eETXfQITuUD7y9WtwqwZ++IvKjBSY/2LLm
X-Gm-Gg: ASbGncsTi7eoCThnqaLO/wsbtyZ3kF4MaZXa1J8UvXDb/TUo4XfyQFnUkJ6+cFAJn5Y
	dFWVUlXj3taRzT2KtLp4HjeGr//L5j7Z2mk+1M9+r7etggoVhAarOtpQAxUfpXpc/yzesxTH07G
	YOijEL2DTfL/227wyhr/wYWhBevAqnYR1pTdWAssZks3O69BeU1AUhqpPZEZ6t3g6nh3RFJKMDH
	fpwij6Q+GF/yY6HGTUrKKhGmQPaSDh9rhFRisetpkiUY0EbZGpolK8g+mTiWtEIjmNPOXNr+TsZ
	0RocwAXDH7ZFg+Lh1iLqNMmX9XUiGBedc8NdxNGKiggTu/Ljuu+2sdrEJvoP5r5FyY1r+CAHDdR
	ghkNpwfLs2ZkppCNuEGBSWphwYdY=
X-Google-Smtp-Source: AGHT+IFulD5D/Zy+ZyisXsAbgPm7HLZBPW1pANY3M9+91Zkbgxg4j8dbsFFeil+/r09r0tRe/wQ9hQ==
X-Received: by 2002:a17:902:d4d2:b0:234:9374:cfae with SMTP id d9443c01a7336-23c6e5023ecmr45050375ad.19.1751457074179;
        Wed, 02 Jul 2025 04:51:14 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3b8be5sm127586865ad.189.2025.07.02.04.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:51:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>,  Derrick Stolee <stolee@gmail.com>,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC v3 1/3] last-modified: new subcommand to show when
 files were last modified
In-Reply-To: <20250630-toon-new-blame-tree-v3-1-3516025dc3bc@iotcl.com> (Toon
	Claes's message of "Mon, 30 Jun 2025 20:49:23 +0200")
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
	<20250630-toon-new-blame-tree-v3-1-3516025dc3bc@iotcl.com>
Date: Wed, 02 Jul 2025 04:51:12 -0700
Message-ID: <xmqqa55mg6a7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> new file mode 100644
> index 0000000000..4ff058c302
> --- /dev/null
> +++ b/builtin/last-modified.c
> @@ -0,0 +1,44 @@
> +#include "git-compat-util.h"
> +#include "last-modified.h"
> +#include "hex.h"
> +#include "quote.h"
> +#include "config.h"
> +#include "object-name.h"
> +#include "parse-options.h"
> +#include "builtin.h"

Apparently "parse-options.h" is included but is never used.
How much of these include do you truly use in this step?

I was looking at the code, since I was wondering why you forgot to
handle "-h", which comes absolutely for free when you use the
parse-options API in the most natural way.

> +int cmd_last_modified(int argc,
> +		   const char **argv,
> +		   const char *prefix,
> +		   struct repository *repo)
> +{
> +	struct last_modified lm;
> +
> +	repo_config(repo, git_default_config, NULL);
> +
> +	if (last_modified_init(&lm, repo, prefix, argc, argv))
> +		die(_("error setting up last-modified traversal"));
> +
> +	if (last_modified_run(&lm, show_entry, &lm) < 0)
> +		die(_("error running last-modified traversal"));
> +
> +	last_modified_release(&lm);
> +
> +	return 0;
> +}

It is a bit unusual for the top-legvel cmd_foo() to totally give up
the responsibility of command line parsing, and let a helper
function take over everything.

Is the idea that the family of last_modified_foo() functions wants
to form a library-ish API?  I think the primary reason I find the
arrangement a bit unusual is that such a library interface would not
deal with end-user interactions like command line parsing.  Even
commands that let setup_revisions() slurp the command line arguments
typically does necessary set-up (like discoverying the git directory
and reading the configuration files) on the side of the caller.
