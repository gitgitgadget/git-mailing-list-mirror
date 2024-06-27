Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D436B4C9A
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510624; cv=none; b=PgMATPSl30nUyv3BM9ykCOzW8khBEQyysXjKRpFlA2uuZUmPQlybdIPWjRu7JUagrDAPT4WevbwaYB6e1u8hcaPMK5q5FjDDYtoTOWSVHmnpSwnt1deC5AJ2goM8QZyaMPJu+iaDD/ddJHLuq4oD7zza2XZSuOyqNJLEA9vguNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510624; c=relaxed/simple;
	bh=odQWsovbg3kYWS+E6t3NVLPoHWIbkPvZ/ubAG8Pi4y8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gm8axsY15XZBmGJlAsgCZZRd1jSHB1QHu3YvGxb5prkyUj5jxJSsdiKToIJhwIt0M/kALVsa4VEEHZuj6DnXkzgoeJprpEjlFUvZhdrZN7Kwh7cZt2s56De3fJuvQpkjOI3LBN9atWPAgtPG+zm0qLt2guY0xXt3TSdLicxE0ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALAooj+P; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALAooj+P"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso2328526a12.2
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719510620; x=1720115420; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=odQWsovbg3kYWS+E6t3NVLPoHWIbkPvZ/ubAG8Pi4y8=;
        b=ALAooj+PaZ/8qvNkCrHot+hXUzqRuAGe/RxLrc8n+CD9XkrLQt+GiTBRrQnIwJDIvj
         9xs5cKBe9a7Oj2YLtPwkA5TnC4RXYG9Ki2hcLeTw6iDalahdmu5xy6s2UT9Mg2XaCEfj
         o4IIwHwc8kvS7m1ySgjI3OhKPgDEJwVMwGhe6g5msCXM0TQLJW8e3bCgXhRqZDA6dH8m
         p57TeIIUTbAxLdFJBGjyBJ8RhSAQvFZ49IYYJQXD4BLeH6kqBeuALgquOOCFVmtq9tZP
         McDJTGJcrlr9IjXsl4lC9Qe5jIiW4iXzXAeGbUx2UVfepTo9foSuejCFSVIsbSEdZLDl
         9yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719510620; x=1720115420;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odQWsovbg3kYWS+E6t3NVLPoHWIbkPvZ/ubAG8Pi4y8=;
        b=Xr/BBeumn0DI6b8jbWy1HH5VKUOYiheMOzCAl238M0pMF0LH0y1H2EAXHNfwnOWYim
         VTX/CgwDnE3QSXAoVUK7h6S4AIWYXeSEi4SWgUR7uBg2RwfyFwX7wLmmgpTooMqL9PsB
         rURCShmGxje7ZurDXjdiLa8pSThQPQUiIKX1zuCFNKZQ6gijtv6J22sYVkwwxi0L2CBR
         5rfL2nFOo0o458/H19cXHy0yITReAOTmnlKLjeGpOOKISTjfwOrXeK16lNwy6kU01sjQ
         wq78SBTFtKwyrGotKE5EHG8b4it2wFbEsd1xXjr/nllp+KGkQEZpovAoN+YQ1eAglpNH
         OrBg==
X-Gm-Message-State: AOJu0YwL+gvIWysmtJGuquOXXPL9SGLgbNVFnFW/Gu9FgwYFJrAk4uh6
	irgE9xdIpzBGkWQUwvX7LId6Om4KvAZl4BhAnB71OJEf2F1vWjScLIvJd0dBqB1Th+Z5bPeKLh/
	4N+hxj/t8otkQ6lhTpxMhTMo5z5fUJ2NttZs=
X-Google-Smtp-Source: AGHT+IFya2sRjOyiSQn7oOpPlhozLei2s5IXehSSSe1oRMZ1MFf7RNEyBi5SpXB/uytVVfvoMwgN8H2M4FfWDrCUQQ8=
X-Received: by 2002:a50:c081:0:b0:57d:519:ba3c with SMTP id
 4fb4d7f45d1cf-57d7004c60emr8327243a12.24.1719510620368; Thu, 27 Jun 2024
 10:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date: Thu, 27 Jun 2024 10:50:07 -0700
Message-ID: <CAE1pOi2ia9DTo6XkHF7-D7QJxiPhd6emEmRz+ZoQ1iUyiNJtPA@mail.gmail.com>
Subject: Find commit of currently included subtree?
To: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I have a subtree (from repo "Tools") included in our Git repo ("App")
using "git subtree ...". This is all working fine.

The next step is to automate checking whether that subtree (in "App")
needs to be updated. Checking the remote "Tools" repo for its latest
commit is easy with "git ls-remote" but I did not find an (obvious)
way to check what subtree is currently part of our repo ("App").

It looks like I could parse the message of the commit where the
subtree was last updated. It contains a line like "git-subtree-split:
1234..cdef" that appears to match the included commit in "Tools". That
seems rather fragile and relatively complex.

Or I could just run "git subtree" and parse its output (as it seems to
notice if there is nothing to do)?

Any suggestions for a better/simpler way?

Cheers,
Hilco
