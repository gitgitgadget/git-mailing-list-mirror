Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4226BE6C
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393514; cv=none; b=A6/eVyMc7mwuRNP9jeO/cYznoLihYW0iPEuNgWvxrtAhTNm0TI9XBhIGkM9Wl3WQo/1H+w7L+ANep2P/f7bwdxZ7qpqJWquccOWxpSKQ0gUzH9tkvhgzTJ+EqcSDe3NujVubov+hmkk6f6yA9IOXw1DcgJpvr1zRqJDBQfI3qpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393514; c=relaxed/simple;
	bh=R4NDZXiZG86BYuUtGQ79rUFN61MLxrWGOb3jhBsZkOM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gWbZylwI8D1uZMyyHdwuZZ0SYBqrN4WOzzs/7ypHgXxnHbROwzIg6Bsjk9NwAOZMpDwq96/gg28gyhuobANeL3qXV8uSfDQLGx0UA6eRjKYVs6tvaF67HHKYP8U3mqWUBVAiIJOGVY/ajbPD6Nmuw4C2bOVpClA6XBncl6SM6PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI1auh8W; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI1auh8W"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f754678c29so79235727b3.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 07:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742393511; x=1742998311; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w1H8lQWvi9UgTrI5SdL6x1CFclzRpfwSYzpPm6YTxvs=;
        b=bI1auh8WKzzFZQN9Ah26cdjCuTthDpCQ1AkvMbUkgiVRYABjirD9Ap1uJDcTXYzgz6
         KWZuTKQW4POamRUfU5h3jUGryxvMX+H9fYdGtNQ9VI09W46foch8FoXJlM0QIesybalB
         Hyb0HBRelN/ovzJqAAmLRuhwMQSSDGn9yYmYMd4W6K7oQ4xi7jsvkfchFOeO1ur5F7JY
         JAIRz+frKaUE2HkFXA0bvVBvuOikrwCrqU6LQUXlDNV2zrsHeLrODZjh/SGILqZLayxB
         E3mc1OnFHnvhQDjpGxYbJ8BzG/T/nGldLAoccAS9fxcRgBoJ+8nYQHhXySD1WKMqQFFx
         RXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742393511; x=1742998311;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1H8lQWvi9UgTrI5SdL6x1CFclzRpfwSYzpPm6YTxvs=;
        b=PnO5srS2PMkweqdp72VhGU78z8tsjbFKTnPuwwOpoNrY1MdBzhXAezXYsMeouky2gB
         TvCGDGzEp3nX+99E2dO0tV08pZ06+zIp68T+3wmoTG5Ndiv+6cQV/PL+I+W8mKUGfws7
         13TOaKKnt4MAmeWjJ4rdqWGsonQV7efik6sFc13CxIYTaX/losKIMkavZ6yXVNIV2Stj
         4uOQ8X+UMsMeA7fuiJ8n2vtCujMPvJ0JhABy/nRiTtYgEggoS/Uc0s0Apd2P2OldwJ3Y
         VDpxiP6TgXu8zm3WNvSEXmIIPBpR1z1vjXkcBPYr9JVY7YnXCH8FNyGWVXnHQ6DYX3cM
         /vrw==
X-Gm-Message-State: AOJu0YxKJfcwMkwB8lLyE5IqbzvnZ6NwKgoyV0C76TDxDoWtYTyokWgT
	XDd0/DvBrlJJD7EYvAcx/7sl+MgVHyveOLyVNdsli/I/wB6pVBSo9+sd8G/3RHVcdyWcX/zR2XQ
	ghwh3dIDFAvKW97EFMsmmHjKauLbBfWF0
X-Gm-Gg: ASbGncvFeM5Vh7PuTjsLB8BZMMr+d3Ld1EnZiuZ5Kv2YyKRNyvTqNDBqOKO7JmpUpyu
	PONlsbin3KqNux/VvV5z+/yWxYOFJDKH3VKQuYgM493lmN4AmNOpubzQBAa8Ba/L3JDC0vGooCT
	hwvN/KvLEMwPhhY2hrhL8VvgiK
X-Google-Smtp-Source: AGHT+IFvHQXkognZBgF+F/Y2TBw9sJkwCRIcQQ/IcFM35xjiJt3fe/UTvUCAs9EGq+oXnmP+8WRYKIk4+bporo7wf10=
X-Received: by 2002:a05:690c:c01:b0:6fd:385d:5f10 with SMTP id
 00721157ae682-7009c15b2b8mr41685517b3.35.1742393511311; Wed, 19 Mar 2025
 07:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: jim.cromie@gmail.com
Date: Wed, 19 Mar 2025 08:11:24 -0600
X-Gm-Features: AQ5f1JofUvzN1QkOIHJcdMw5xGu3cpymKGeTtjJ8LqidwRU9-LQSJBHM56KYhMI
Message-ID: <CAJfuBxyUvvmevCC7bqLNJM-kTRVtMEhF4rSgf_1OQxezCOLSHg@mail.gmail.com>
Subject: RFC: git bisect worktrees ../wk-A:../wk-B
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

hello all,

it would be super convenient if git bisect was able
to flip-flop between 2 (or more) worktrees while bisecting.

This would leave both A, B in re-test-able states,
allowing detailed forensics on the differences.

if this were a well-known feature, I could imagine that
tools like rr would be enhanced to exploit it,
due to the lure of a tightly controlled A-B test environment,
maybe even doing side by side record & replay
to find where things go differently.

and perhaps:

git bisect try <commit>   # go with a hunch

this would check out the commit,
then testing would determine good/bad
sort of the opposite of skip.

git bisect try HEAD~20 bad [ HEAD ]

here bisect doesnt pick the next, it follows your hunch

thanks for your consideration,
~jimc
