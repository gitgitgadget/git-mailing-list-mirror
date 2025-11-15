Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1EC1A275
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763225492; cv=none; b=EpR2kxL8HSD5uDKsjr6It3/n2VsWhBPlTqaoZdAJyR51zOghVh2k0T3nPQR+CslapLtdMYbnlFIFCF/oIL4hZLA0B4eSayPTP91LmmO7tdYblsN7+S15OPnxIHDyhBxyXve2vSSzlPvmozxLk3oHSwElJKvqM2e7aXI5U5XXR1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763225492; c=relaxed/simple;
	bh=SNYE1rZoE1yjv6VGGfvp9ZMCOip6WTQjMWi2+APjwV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLDDRufZtvLqckFgN9ffPkFiWRlzVMoIZ4dKCbTXbMgre1lO+aRMdE2FpgDY7CVzJ271pXXGXuT9jbURj/I5hhaBjamveNL/fjtT1kh9TxY9O0D01paE9LyaeTGJTOVv7WM4LkmF5xrS3OvDyP+mvQmt5gPjfv5XoUFbae1ZHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdYIhpp+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdYIhpp+"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34374febdefso3102058a91.0
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 08:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763225489; x=1763830289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Whi01gpUihVBhC4uzNXpsAJP1msdEqE4efOlFJYhRc=;
        b=JdYIhpp+AsblkTxME9l12FRg0moMXpnXb7IarPXrz7Kg31f8RvUG9t5r7utLc/Dg8v
         CqWrjC6ZDN70HlODFFz7aSaphDSkajIp8IKwVrgFKaa8bvXBzNtk8mKlOBS8NnOrxaUu
         AAnYBt6qK6a/yyH4gWajdjDHmVRc9x32coKYR+nPjgx2jkqQR2wsIFPQ43ZJM7srKjcl
         d71xQEZxhcrLEWrnuRWwWq14E9uLkoClh+PjlMWcnRMBb46s3G+NvynkJW62GADTd9pp
         /ZDhLPcgQl2i6FHAQo5MBa3Ep/DbFBVpZpGglrM06GnoShptNultcSgcZaw2cAv7qn6+
         6Mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763225489; x=1763830289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Whi01gpUihVBhC4uzNXpsAJP1msdEqE4efOlFJYhRc=;
        b=vRAssfcCdTVq7UBSLCoTyKXXD7cA+ZJHBGb3jJ+6mrqUKDDizmr/9UuURCLPb4Crri
         K+FS9je7bU9uW55G2EqoZ/m/JJJJ/P+kIsFngiDgBXniHkMUV8Wp1UpqdHSYnrvk4uyH
         Lx8GHA7c10flh92Ait7xq1hYFoRroWNDqetAh7EM83vv/0+fGyeFqBDP8yd3vNF9Lx/9
         fG715mq7HgxQr2YtPebpNV40QxBS1q412J1bXFw4SzX/Z9/d3zNgF20AfUBtz7ns7k5c
         3uJwACUSccXRnfT4ov52BdkwadImIt9Pk0Z6/GOsgInzSU8tNGu8iK2TG3ZCYwwxTQXC
         UpaA==
X-Gm-Message-State: AOJu0YxYmyPeQoaQlQQ/dmzhzYz+ZVdh/paUfutE/0GHtUbYDsq2OlbU
	DibVkXbG1K4HIM3E4Sx5uVQjkTy+SPzTWbrzXhfHw9GE7ljU0JKzK4nGeAC+MgUsu7FxGoRRit3
	OWEraIUYwRUZN55jrqA0RBYNISz0EkxI=
X-Gm-Gg: ASbGncuRqqZ3a+1zuTmicCglUrx2T+IyB9hU0YMjlKwKbofku9zf10yvnWqqVO2usUq
	WKqcEd3RqAB4+lzi4PSPeqlF13Wa+x2Khz8+G9zoxV9NPwA2iGDh+FrdAutLF2AUQvuC5oGmdIj
	FgSbIb/xdvNCsjGZtQRAF+a/906TrzMBmcPnzciP3SNqOfsdLDdcRffKL72FB+vgePW68Yv+q72
	j609upaGYYBx3HwMzatBIcZZFgz2ysPBjKuy0ajumxGir3uH60P20hm0rIsjK0XTZ/FuDqSjQnu
	qCDGonDQRbmq+c7P7bS2YjZl2DCM2MiEU+Hj9g0/
X-Google-Smtp-Source: AGHT+IHffrZfqLKIW/YkexkjWz7RXP5Ec5+HfQEIy8NdoSKD3scKe3BjdiFlfRMTm345eoEcicz6ho+jMD9wA/VFyaI=
X-Received: by 2002:a17:90a:da8d:b0:341:8b42:309e with SMTP id
 98e67ed59e1d1-343fa749adamr7398155a91.31.1763225489411; Sat, 15 Nov 2025
 08:51:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcy5kgsjk.fsf@gitster.g>
In-Reply-To: <xmqqcy5kgsjk.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 15 Nov 2025 11:51:18 -0500
X-Gm-Features: AWmQ_bkEYkOJVDzxvqcT07U-YO9HDhaNp3RgSjh48rUDPcW2qX9BFj4_g_3AcAE
Message-ID: <CALnO6CDCzNbYFC4BGmqC5bhou5rtie7K5OhR_cP1CXJfChim=A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2025, #04; Fri, 14)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 5:27=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> * ps/history (2025-10-27) 12 commits
>  - builtin/history: implement "split" subcommand
>  - cache-tree: allow writing in-memory index as tree
>  - add-patch: add support for in-memory index patching
>  - add-patch: remove dependency on "add-interactive" subsystem
>  - add-patch: split out `struct interactive_options`
>  - add-patch: split out header from "add-interactive.h"
>  - builtin/history: implement "reword" subcommand
>  - builtin: add new "history" command
>  - replay: stop using `the_repository`
>  - replay: extract logic to pick commits
>  - wt-status: provide function to expose status for trees
>  - Merge branch 'sa/replay-atomic-ref-updates' into ps/history
>  (this branch uses sa/replay-atomic-ref-updates.)
>
>  "git history" history rewriting UI.
>
>  Comments?
>  source: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>

I've been playing with this for a bit, and have really enjoyed the reword
command. I don't have much experience with the split subcommand.

I think I also vaguely recall some discussion about where these things shou=
ld
live?

But otherwise I generally am in favor of the idea and find it useful. I gav=
e an
early review of the code but haven't looked closely at the newest version.
