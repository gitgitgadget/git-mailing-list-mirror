Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF25E1F8691
	for <git@vger.kernel.org>; Tue, 19 May 2026 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779228674; cv=none; b=WFuKdeVrjQxjHItPXIwX06RPe3o+cq+Rc91f5Lw5CSo6xKiZBJZo5l0dYAkyWgEbwhyb6AhwcLGIfJGDMK0ZlduHrbXEiV1H9Rxp4V3vfym0ZBRwU5RjAwx9hE/DXTCVJXzxBpgm71cP8CVYIgxtcAAMJGYfufMn8cqqdumfCwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779228674; c=relaxed/simple;
	bh=yFU/5Zc0RBmEJXe/+P63/EQwHTB06kczUxR7Wmznk/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7fG0F1g9e2UthwJWqLfABMTfIoh3vtq98Xwx7SevjZ9sfC+UjKmclv2UR/21RV+mZYjd0tC2YybtosNKYDORgnZcr4j05H9wjLoFgK1TfkFtWpp17xpYLx5auZRbxi251gKneopsEEeaQKwbVUFHx4hQdFAfeOeM4GfrjMsSKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oejc/LVh; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oejc/LVh"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-479d37e7d7fso1228741b6e.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 15:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779228671; x=1779833471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Li0KRGknkc9VKKtgAJnLvjoE5mlmSIHzGd7BSYYgBao=;
        b=oejc/LVh6xt3mg6q+fEjHtzmWU2LmgViPL5aILZpFDVtmi+esFW2rQCMEpnwcXMjiS
         mB75SGFQNx3vkG20CAHUtHpeqFvitDwdDrTqQdtqau1SM9LsLGlE522CCOAX+1BUuTZj
         cN7y2yWCnvzGS7juosWumliezJKbLWSurARN3BGRER5RkbsqJyWp0uTB3QfvoVt1Yd+4
         9DfApXJY/whKjM6h6P4WQFHQtlHgYpT+OkTzI+esTRKbGCVUabcUUGeSpmCkL6wWBGjN
         41+mAClvaPvhRPTmct4v16kB8F7pzW5J7eW10JyZ9ZQEwtrY8mY8k50ISpVrso5pMef7
         zw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779228671; x=1779833471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Li0KRGknkc9VKKtgAJnLvjoE5mlmSIHzGd7BSYYgBao=;
        b=F2HHMXzozNDK9H9bQ+qJ0QQgK35J2nyVLf5VDJt3XnUSBUTg3ykdW9ni4mwwPIGFI+
         Rq7K9iz4FWM+U7U+yVFpAbqI0TTL/45s9pNeMQzTf+Sh/+AETSMONo4fIaqKeZrnFG9o
         1eyROoMdyITxNKCsKiUUITg4f87G71FVWvdyEbd6jh6voG5fEH84e+cYhR+n0c/j392Y
         W6p3BX4JO0Ww5ypJQ410hMIo2H3KlJ3o/UcFvh1rXxHGaShhXQUBwOwTf5V0vWW++8OB
         Ou+yJopYAhs7qeuTmikElaCaaWmbTnyksybxl9TEfAwpcl6QzyvEX9MPmZs5W++172pf
         26gQ==
X-Gm-Message-State: AOJu0YwOqmLkmOsbFtDGBB30OIYfES8tWyve5QuCkjsd+1SsgamvBKEQ
	gS4BmW+u0qfkam405VI20yowEZ0V69N0mN9UTHbRpcTUgiCfZBgXH/nX
X-Gm-Gg: Acq92OF8EduiXUJtooL2CJfOrmhYP2eXLBZUnla/yAjZZiZtieur7DrQtUkoeRkUYPI
	sSGJmOCx3xwe4bnr46lOvbN3BZ+Dw4UGbTpTF/MHQJimeuFYA/UxruTFZSuHXeCOMUrEZ5f2vkg
	3loW5+FfQRldodCypQzyGBWMKA2h15d3PWKULWvvp0mTPMP5FFtjJYSeohu0Qr6Tx9KYR1FFwcP
	yRHByxGTM5GTz/W5TtaCv1zHbIpqLyVPyMe4UkWnUM5AEYkr2C/BzrVY1opAGmbUFscW8zRI3Hp
	wV636CpJiLReGltCyDj4VXwT4F5cCSVDdRA6hnXJZXWLRrzyv1KCJHMWnEzl6a2WZiJrb1qQmvU
	f/GR/icyiqV0gQ4JsMVFLTJE6QfejyLU9u3Uk227OfXiKeALIqVGSJZ4PxfJgWiawZLd86gtmpE
	/lbkrIgUb4/H8zKReH
X-Received: by 2002:a05:6808:168c:b0:47b:bd7b:10d0 with SMTP id 5614622812f47-482e56090fcmr13413233b6e.13.1779228671563;
        Tue, 19 May 2026 15:11:11 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee4fa4a9sm6977201b6e.11.2026.05.19.15.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:11:10 -0700 (PDT)
Date: Tue, 19 May 2026 17:11:07 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2026, #04)
Message-ID: <agzGKQCfc7JYOyQx@denethor>
References: <xmqqv7clbizy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7clbizy.fsf@gitster.g>

On 26/05/18 10:32AM, Junio C Hamano wrote:
> * jt/odb-transaction-write (2026-05-14) 7 commits
>  - odb/transaction: make `write_object_stream()` pluggable
>  - object-file: generalize packfile writes to use odb_write_stream
>  - object-file: avoid fd seekback by checking object size upfront
>  - object-file: remove flags from transaction packfile writes
>  - odb: update `struct odb_write_stream` read() callback
>  - odb/transaction: use pluggable `begin_transaction()`
>  - odb: split `struct odb_transaction` into separate header
>  (this branch is used by ps/odb-in-memory.)
> 
>  ODB transaction interface is being reworked to explicitly handle
>  object writes.
> 
>  Will merge to 'next'?
>  source: <20260514183740.1505171-1-jltobler@gmail.com>

I think this series should be ready to go now. The last version
submitted fixed the leak reported by Peff.

Thanks,
-Justin
