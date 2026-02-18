Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761593009DE
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439720; cv=none; b=QX8N8g7dEb3LqmAQGmN0AKQ607KNQE3OfjJD1uBAv7A9tsHKqNlweZlDt/La5Cai618f/WsLKnZQ6pf/+7UZQhx7COE958CvU5DucsVPpne9/nuZywEpEWxx9/C24dEHjrKhtHLU5s0KfQ0oyNU5fpHKV3aSsNGl3bwEzngApSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439720; c=relaxed/simple;
	bh=t/sqtAhlp6FLzTKRKvWZQAHG42tNFwlumJVLXQHMs9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAwFJWwiJ/OdSfAjIkfcosoD9+GDFbdXZYqxEwaPjfJ2lQKmEBdabXvnJd9F8KzDgAUTMXx6v7qDi2g3jKxMTNIWIsEhKXEVVjrG8+UdV2pGX96nwtM8T/CoH0GBGHZyZUt1ThTGS/CDzqnSLRr6oCkop/22lfH4CkfCJDJSkKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrTy2J10; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrTy2J10"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-354b20c1112so41271a91.3
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 10:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771439719; x=1772044519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/sqtAhlp6FLzTKRKvWZQAHG42tNFwlumJVLXQHMs9o=;
        b=OrTy2J10vBE7OC8mDjO2yNEpuOkORCxzeFdn2BRCDBG/aAlZYORhUkKUWWYq4p+ZPx
         MBGj5yE6MnaFmHfB4bZNivqRhBdzWbYAlr0CDUOMKIAkfXeGI5BZuoBw9kxcgthFGPT/
         3RKGlwy2m2n/fsY/oA5aLbbw3FrnrHVlWIM9FVNX6Ovg26i6T4uQD6uCs3HADTFZAPRP
         lUyAXDZwpvQc9C9qwjEnnaOiIEqbWsbzdHmD+q/II5EyyyQKiVSohRvrbz7y4TeZIe1Z
         8wzvEp44xm11YRQFAz2ZRxPw+X9tIndtAFSSx/6jPz6ZvsjEkT8K8cLHmo5Gao8Midfi
         Ajew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771439719; x=1772044519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t/sqtAhlp6FLzTKRKvWZQAHG42tNFwlumJVLXQHMs9o=;
        b=IunnuCNMchPq4VqSFFCkNGqdxCw5Xqg1Y/2JAivvv8nWRr4su3R4Y4PIBjoI1jNDKm
         VNdfSJOEKeUZgAs6Sa+Ot6yps7ED+9KII/lsW3oFyGUUb7wnqgkcD6umVeGICPJfRSac
         4PObOykW7YUAxrHbpSIzVFa07SNnzlmy9FGhve0u2rHQZ6jKPysSMDQ8shgA8KQXchQ5
         A2UN0cZybI6wfKwzsBjPwQYNFdRtJqkDDUeF/RxnRLwlZUDyQeUhqzHadHoE1YsvJtpA
         ltMMrxVIPFpFr4VGQSg5UJf4OXhLMwsiDypWXXZGcUiiYuHXZCKP4CwkrLOZlls9jBBk
         M9yw==
X-Gm-Message-State: AOJu0YxJ8UBx/1hQ+DFxyBUckLTKGPu3bgVv3SfQyxUBLqG0zlvB4ReY
	/xNy6xovenRM6qWYDkvHieuMpmNr75ZTjZjxjMd0UOoAIlMqwjOK9Ram
X-Gm-Gg: AZuq6aKP08mfzN7xA1lmaweRit08m7QPvxsh15Z4aF88eH18ecFKPryIj5FlHTizoxx
	kSD5P0wbIHhHwycfFj1nWX3Wen24IyZnME20QiXvI+AQQpAkOMlOk1yZwZ9vZS+5JCFKpQEjQJu
	tjgI1INlUF1Ltz5iD0IGNfHed7epWmII91SEVkrI9U5A4BgXJWjSpc+AbyRILi9SzK3bkaXmdlI
	xImhjvNqeNMr4k6uHB1IsfjjjBilZpw7EYSG/XBNRia+fxrm9+AKid2Ln9lFtrfrN4wIb7NGB4B
	L8Owt2Pulfrmpt6FvC2e/4Xxv+PRufw8cOH8OySpWEy8OVwq3Y56S5dXwPVDOFCumKnJ3hRjH/W
	0ByAkg2ENcsMu9s5uufe0w13fZrTM6Rwa7DETgUrK/acRNq6dOvwKxq/WERxTPUY+hVUEBSJqnd
	4srta49m1L258hvFGAEzU9OI39KTrum/6NVPCUpbHJY717YLdfycCPigE=
X-Received: by 2002:a17:90b:1dd2:b0:356:1f96:9fdd with SMTP id 98e67ed59e1d1-356a7aa5137mr16760430a91.33.1771439718761;
        Wed, 18 Feb 2026 10:35:18 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662f6b84dsm32708402a91.10.2026.02.18.10.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:35:18 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	karthiknayak@gmail.com,
	lucasseikioshiro@gmail.com,
	peff@peff.net,
	pushkarkumarsingh1970@gmail.com
Subject: Re: [RFC] git repo info: exposing repository paths
Date: Wed, 18 Feb 2026 18:35:11 +0000
Message-ID: <20260218183511.17195-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aYxzmjoxQHccqTAl@pks.im>
References: <aYxzmjoxQHccqTAl@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Wed, Feb 11, 2026 at 01:18:34PM +0100, Patrick Steinhardt wrote:
> git-rev-parse(1) has been growing functionality over time that
> simply doesn't have anything to do with revisions, so I think it's good
> to give such functionality a new home in git-repo(1).

I spent some time going through the initial git-repo implementation
thread [1], as well as Lucas's recent WIP series [2] adding
"--format=default" and "--keys" support to "git repo info".

Looking at the current implementation, it seems that adding new values
is primarily done by extending repo_info_fields[]. With the recent
"--keys" support in place, that mechanism feels like the natural place
to expose additional repository metadata.

In that direction, I would like to explore extending the existing
"path.*" namespace with a few additional stable repository paths that
are currently obtained through "git rev-parse", namely:

- path.git-dir
- path.common-dir
- path.objects-dir

These correspond to well-defined repository state and are already
available via helpers such as repo_get_git_dir() and
repo_get_common_dir(). The idea would be to add them as new entries in
repo_info_fields[], reusing the existing output handling, without
introducing new flags or changing the current structure.

For now, I am intentionally avoiding invocation-dependent values such
as "git-prefix" or "is-inside-work-tree", and focusing only on paths
derived directly from the repository instance.

Regarding relative versus absolute semantics, I would follow the
direction of the ongoing "--path-format" discussion and align with
whatever default behavior is agreed upon there.

If this sounds reasonable, I can prototype support for
"path.git-dir" and "path.common-dir" first as a minimal step and
continue the discussion based on that.

Thanks,
Pushkar

[1] Initial git-repo introduction thread:
https://public-inbox.org/git/20250610152117.14826-1-lucasseikioshiro@gmail.com/t/#u

[2] repo: add --format=default and --keys series:
https://lore.kernel.org/git/aZLARuSCuy8wYLUA@pks.im/T/#u
