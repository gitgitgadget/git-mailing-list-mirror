Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EF25D8E0
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FnSHKYRV"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d5a974d490so1238755ad.3
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 23:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705046198; x=1705650998; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oFfBlFE43muh0UKyFzSh5FAFm3/ZdRAFduiAq1Nnlig=;
        b=FnSHKYRV6N4EQp0caMFyTlMMq7x1VVFp/vQSz30hgqxks8vSoMK1v48WN5dLI1nNll
         zNkEPjWgaq9KG4kgM+pUF/AtxxIJr4axYP6bgeI+OWtEEVU9XGQ4disIuFIPxyHfNEBo
         p4Vo6xerRk4NZqe/RW1UJlpMdLbUajE7Q3okNQzp2BqfUhLeD7n9dn/HldHbLBtpWYaL
         gctn4prelE2kcl1ABgN3H43/j1hX2BefkG7lwMom37m3n04TaixnxBekXhbcfXTAzBPo
         trVGQQw9m8lSMcvOmht+w+dy/J9K3eYEPryno10DoK/jLkD5BB7zwMdSHC+5Txw9lhSv
         0isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705046198; x=1705650998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFfBlFE43muh0UKyFzSh5FAFm3/ZdRAFduiAq1Nnlig=;
        b=dc8M2fIlF20uTh8GMFmoJCaV2/ou0nTvEyF74Fz78qlJhG1AmTqlGfEMJiSSlIP9MT
         MauHeA/QbwhnZK0KSKXD0g7qe5EZwu18ReEvQYwtpkRurHR8gEPPKUg6YyUOvnbMlO4P
         0SHCLggNUvoEs/1UtMAseS82w7X0XfcDPrW1TEP10pA4hhWe9myhkTQdt6SIqxId9Jgd
         FEjNrBkXWMS/vXxUyQLsuYuntW9QsvHxiS4zS9cQYJ2/5g6aHTUaSSAdv55sRlP9y3Xr
         5964zlvUWTaxp+DKD/iQZY4spSogYdWLvK0dEmdlnkkUkBqGGpQk0ahuQMEaymfgoeik
         Ssow==
X-Gm-Message-State: AOJu0YygUaSaPqVJah0BNPk7UErIKCzzUXbv1L2e3NTrDfZzwkf1IzHo
	A/Dspss72PAKu8dRJCojmjbK5f+zSjPE37eUiw==
X-Google-Smtp-Source: AGHT+IH6tk07AuIUGQB0fGkwBJtbY426Q3RYvN73kgfz2Hk2P1aImVgzr53afTVGmT1E/kVUnuwT6bJQHhc=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90b:4ed0:b0:28d:c3ad:f557 with SMTP id
 ta16-20020a17090b4ed000b0028dc3adf557mr71596pjb.1.1705046198237; Thu, 11 Jan
 2024 23:56:38 -0800 (PST)
Date: Thu, 11 Jan 2024 23:56:36 -0800
In-Reply-To: <af8fd2a4eb8783be4a62973bfd2135da4568570e.1702562879.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
 <cover.1702562879.git.zhiyou.jx@alibaba-inc.com> <af8fd2a4eb8783be4a62973bfd2135da4568570e.1702562879.git.zhiyou.jx@alibaba-inc.com>
Message-ID: <owlyttnjhtmz.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 3/4] transport-helper: call do_take_over() in connect_helper
From: Linus Arver <linusa@google.com>
To: Jiang Xin <worldhello.net@gmail.com>, Git List <git@vger.kernel.org>, 
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> After successfully connecting to the smart transport by calling
> process_connect_service() in connect_helper(), run do_take_over() to
> replace the old vtable with a new one which has methods ready for the
> smart transport connection.
> 
>
> The connect_helper() function is used as the connect method of the
> vtable in "transport-helper.c", and it is called by transport_connect()
> in "transport.c" to setup a connection. The only place that we call
> transport_connect() so far is in "builtin/archive.c". Without running
> do_take_over(), it may fail to call transport_disconnect() in
> run_remote_archiver() of "builtin/archive.c". This is because for a
> stateless connection or a service like "git-upload-pack-archive", the

There is "git-upload-pack" and "git-upload-archive". Which one did you
mean here? Or did you mean both?

> remote helper may receive a SIGPIPE signal and exit early. To have a
> graceful disconnect method by calling do_take_over() will solve this
> issue.

Are you saying that this patch fixes an existing bug? That is, is this
patch independent of the first patch (transport-helper: no connection
restriction in connect_helper) in this series?

> The subsequent commit will introduce remote archive over a stateless-rpc
> connection.

Does the next commit depend on this patch? If not, I think you can drop
this paragraph.

> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  transport-helper.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 51088cc03a..3b036ae1ca 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -672,6 +672,8 @@ static int connect_helper(struct transport *transport, const char *name,
>  
>  	fd[0] = data->helper->out;
>  	fd[1] = data->helper->in;
> +
> +	do_take_over(transport);
>  	return 0;
>  }
>  
> -- 
> 2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev
