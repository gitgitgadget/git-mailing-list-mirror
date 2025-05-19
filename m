Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645481C8604
	for <git@vger.kernel.org>; Mon, 19 May 2025 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747683960; cv=none; b=ScpS9frjj0harLOv1Lc13Hdtt1FJMfU8hzOWmP3OOfERlpzTwHJnATgDKDZjHCzpBTP6bIJjIf2Hv9nyUBYiHLQQM8Yyy8U3LfoNChXTHtG3/zj7/VUP1wYv01HRnsBJAUmuwI/ZkjHzaZXIXl6OvOT3YQgIAAWrqWotyOGUB6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747683960; c=relaxed/simple;
	bh=bkKPe5m/Zo8Z8vjR7PMBEpU/izsnD/rlKBqe0cwLBew=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZC/SKx3EDzE71wi9uJA6hPqP4y7Yr1coX2rmFo1NWZoMqxi46gJtItzro6lcFZ+t1nyzz4HQJsBbjTu1YP+aMPw7scISTmbuoTqUIZE8Z5T9WK+vprcpHkWfqbZNJvPDRRio0TUbiPcA+X/B8f5h/j8fJKg0c40Djqb5yOk5GGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPoOh/5h; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPoOh/5h"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70cb334de0cso24070937b3.0
        for <git@vger.kernel.org>; Mon, 19 May 2025 12:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747683958; x=1748288758; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bkKPe5m/Zo8Z8vjR7PMBEpU/izsnD/rlKBqe0cwLBew=;
        b=jPoOh/5heYmzqXuaH4ivmh0fcinNRn5fwTHhatIQcYoVVSKrnD2eos1HLreniNHXGE
         d0hTArVYdWux0eFPqPiMukNwPU/t1azJrg86j6FTSKY1zQKkQIpAdxjXhsbOQ5cyOLdz
         7WpyBFF9dDKYTWOHY4hGFC3+SMXgT7J8fS9Gw4x/5Zp3eb2DmkNkdeCq7VXgQ5VfvBNS
         zsyg4cKclEtWWFJq3JEifnsaND5k6rXn1+Vx4xlqZzfVKKfSt4Ed44sZHO5xlCWmQrYK
         OiqupM9H8QzdiGx+0q7jLXUfAYTcAXA6oLI3td0fwv3L3qYdx85jmiELpQDYIxMrfKJg
         MSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747683958; x=1748288758;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkKPe5m/Zo8Z8vjR7PMBEpU/izsnD/rlKBqe0cwLBew=;
        b=N81Ju+52+E61wRIhgSU5EWnUWC+WSLJNO9JdXk2IEkEYljTx+se2VlKPMLd1ZpXqTK
         VjteEiEPQUDb5NJ6hTlDoF3Eh73NGq+5JB+aKXHZzNGL0rtKS5WiwUMybFej8Es4XQBa
         W/8hsBOd0uSbvtMK1e4UyWiveW1udBqDBNXPjviwAud8dV0JXXpwJoWk8RO0y2UK9x3I
         bRr7lfKToyl8zNMG4qpZHNWPH35uCtjLXHbR48GN2Hlfue8pQHaTt3vQhOilMXqRdzxC
         wTrRCoe7kDyT8e3J4Pzr8wh8qP6pN/c1uXnuqScf+eYsFVs1rvYV7tHLKoYsaNIqGL5m
         Fz/g==
X-Gm-Message-State: AOJu0YzXPsgH59qZ7/53VAgmvxk+PAbJIqfBwYKS9kwC2SLmtlMg9zJv
	3SpL74kWmX24AlgzjSC06gpeKQBpigWcgrycjUqk3BmuwGE41vSUNfdDGeJVM+/848cR77qsF9q
	G8f4IyEYMdhLVyvXJqm4aJ6ASz5hkglh9FdLaILQ=
X-Gm-Gg: ASbGncuqtr6U2LzpVfeOXsapatXgsXb5kDX++i73/9cOX947PWnfDn610Rrk8EGh8O/
	EkOLm1JPO6Bdj439v6MeCMagBckxRmK1X7DdnfDh9IhtK6xJiEZFcW/oEiuf8vkGblEM6z8c8Zq
	Pt1udbya+lJmn3cOduh/mICZH7k6ZODjTr
X-Google-Smtp-Source: AGHT+IHLhQUILj4+ciap9JgvNDNdmPSs+xMLyRipnEO12u9izrr4dvwac2y3IGOheZt3c3Tl0UbXSaEZ4VxwVFi020I=
X-Received: by 2002:a05:690c:6385:b0:709:164a:fec with SMTP id
 00721157ae682-70ca79fa08fmr186683087b3.17.1747683957962; Mon, 19 May 2025
 12:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Josh Bleecher Snyder <josharian@gmail.com>
Date: Mon, 19 May 2025 12:45:21 -0700
X-Gm-Features: AX0GCFsKRNlj08rfcMVrp4QQMudsltPeec5ZvKUKfKljipAuLGyhbGYh9uNM_aE
Message-ID: <CAFAcib_PV4EB-i4PUmTxCx_6LX=8aWDNT_ZPrN0-EDsRwRfi4g@mail.gmail.com>
Subject: Feature request: make reset --hard add something to the reflog
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi!

A feature request:

I git reset --hard a lot. Every once in a while, it hurts, just
infrequently enough that I forget the pain and do it again.

I wish that git reset --hard would silently stash, add to reflog,
stash drop (or the moral equivalent) and then do the reset. That way I
could always recover my state post-facto.

Thanks,
Josh
