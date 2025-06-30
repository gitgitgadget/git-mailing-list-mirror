Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DED6235346
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317840; cv=none; b=QQgapJVlcRvhaPylS4fEIb1K8BZpxGLmpnpTyfRMwtoJ5HbkYl5x7bGvdCFNX+NGRyzBQ57qKho1+aOACVNcVCiTG+MY9cCPAZlVyLuycVU0OlFjiz0m3kGJ/MD47ToqJjmG1/jYbohhheDZ51Gq0Unx8IHRn0mnXKD9HXxdGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317840; c=relaxed/simple;
	bh=lVmHYIpLfVtetDdr+pOnYFGvY+Qfo18hDZ1+Dw5aTxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T4zxhlbkfgH/wXHdfQb9yyhhcVLl/PIh8Mj5Llh8RZX5LpTq8zk0/nEQ9bMI3mUx/OHPzgsMwGw+en3HjsRut1NrXY2I7uw6DizYd/pceOQwPEfP25ag30oJaZ2+mjyiSN3uQXAIB86TnbDHDdV9H5QPLP0od1Fb1nyqhsgcwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh5x3Amv; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh5x3Amv"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso2500827b3a.0
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751317837; x=1751922637; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVmHYIpLfVtetDdr+pOnYFGvY+Qfo18hDZ1+Dw5aTxI=;
        b=Fh5x3AmvTMGNePVrFxLA8aaPWXdQHZyAkRdSscbEBjdRZ7ZLbEitwKZRyFFYHq5Sji
         Po38v1lesukY7/1krwr5haz/V0D3PyJWAPo6lL11NgM9npM41KufzaLfUWCV7FWdIuGf
         b8/20LQUqdw3axiIJGDWmhf2dcksgQqLikzK6sPCPGaHZlmZvc0KinCKj05LSf7s5pBi
         jjz4Tvn8LcrgpX4EoYcfc/Sfhy/5rFDPwG3fhDjpXpBAMcIDuhQ3WCBjd0YGRWxBkLki
         95dxQRI9rUZHlWKr+rrnQPuUaqq8fjlWwG/Q48ilrUGtT8xuDb7uv1iUNQEVZ0Nui+KP
         Ulmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751317837; x=1751922637;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lVmHYIpLfVtetDdr+pOnYFGvY+Qfo18hDZ1+Dw5aTxI=;
        b=l0tJ8MQ+enz+YqZFgF9pFdlX/Gf9fkLc6HfJ0vZdJn6VUxPMDG2ZYZsglFdEp4QAnl
         RTA7F0x5XE4y0lAOe5fLlkC8MuhJP/PsAHWdfOhoVvIhoume8Ja4dvOSSRIC/aLrGsaP
         BX9N5q4lyE0VGx3OrLxtoqhwGNXJPBAMGD7suHdcrE4Tt1svpwTy4kikWfz/ZooBDRgV
         blTiU4Ia/oVNGkmgVDzyVrKCvIi8guXTICmOFFB9N06X5BSTrICS5gfz6qFZEE5njgG6
         vssOyy6dbzYZQRy9kGVY9HT5oz7u7Gv/fT8fUaUAklbH6d7472JGgoa4Nnr53Lp2+fIm
         az5A==
X-Forwarded-Encrypted: i=1; AJvYcCWjZJ2FbthHK2jMMaogqsd4Nhz4bvzsyKmoZTzf+IY5mw0QoLHhOU9qbEiklr0IWy39au0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfeLiQ7n6YiL7BLMtvOkJo9epJYfKa+uErLE0VcPoVJY7uTxlD
	uiYn4b6Jx4QbJV7m6UIggiZJsHV/J/IdVu5ZMij2ALh3DchaY+zg8PeN
X-Gm-Gg: ASbGncuS8P5DLkP1OH9gEuVXUBRt60CLzPHLqBmiQUe4qCE+8stwkQHhcV+tVT2Lxn2
	fo1XqjvTiWhpjmK5yLXFMn5H9YWf0WD4l/ULyuluLhUyVRd5KmgLzkhcxuCEQ16dRCsjNmNhQxz
	+NvYDp7oYsE2Pdof2p8bOMITU997t86sg3bSfzmSyGoaq93xLHbK99GBvICDwTA303MNYb0Jo6f
	DMZ0nqF1fth1CeZsJUG5rLj+IkrIU/h9wu8RoIX+ftv/McmECF8PbWyvu4nND3dfiFLBVwZ8GWt
	CUuxrkoGIGJEU2B/RVoDmRpEJ2TPWhyxVVMmmd5Mo80Qht4I/4WD0UhO3lb8sG2wue+1cu5cl6d
	7QX5XAWC0qfqMqbJWEm5ATs3vYmg=
X-Google-Smtp-Source: AGHT+IE8p1QmvTDIggnVLCBCVxoet2y4weVn19ZVZjxFqE1tFZLf+z9UY2qi6qERs2BIWeNCbMgbVw==
X-Received: by 2002:a05:6a20:6a0d:b0:220:2da8:325c with SMTP id adf61e73a8af0-220a09125a6mr22190570637.0.1751317837450;
        Mon, 30 Jun 2025 14:10:37 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b34e31beab2sm8969451a12.47.2025.06.30.14.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:10:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Karthik Nayak <karthik.188@gmail.com>,  K Jayatheerth
 <jayatheerthkulkarni2005@gmail.com>,  ryenus@gmail.com,
  git@vger.kernel.org
Subject: Re: Re [bug] pull --prune could not delete references due to lock
 file already exists error
In-Reply-To: <aGKdICvmKlumU0ru@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Mon, 30 Jun 2025 14:20:16 +0000")
References: <CAKkAvaw0sZ0sW9o_0NZdnZknS8M34UST3PetaPBQj5wwvJyjBA@mail.gmail.com>
	<20250625141849.78834-1-jayatheerthkulkarni2005@gmail.com>
	<CAOLa=ZSA273KGPnwZ2aRBU_ybcCTYogBHvUwpa+5CfDOc2bEWg@mail.gmail.com>
	<aGKdICvmKlumU0ru@fruit.crustytoothpaste.net>
Date: Mon, 30 Jun 2025 14:10:36 -0700
Message-ID: <xmqq1pr1lyur.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Another option is for users on case-insensitive systems to use reftable,
> which won't have the same problems as the file-based backend and will
> preserve case properly.

The more guinea-pigs^Wadopters we have, the merrier we are ;-).


