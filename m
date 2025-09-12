Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279D724BCF5
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757699961; cv=none; b=JKiXmv/HAC6veVDOECmqNphtk+2bXkCTIo6+cCW0SpJIUV0YUv8XhQocmIv6ZrIxMt6xH+GeQedzI/5WPNP6734Gtuc8Kqu+nYJ+fJ3IPswUNOPTco8bECm7vu45A4xfLhMBgeK3JI+y7ywQPOIv26hGmzuFSLigVQtKnZIVGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757699961; c=relaxed/simple;
	bh=WZInW9X2QVaan1imrJm3wFpIydvkejQvjGEJ7xZyjO8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZFlPvcam2xhs4JTc9ccFAOpaNK4F6uRL98brRkdGjrleg22IxtI9VKvEkQKI+FjNs21dgQTOuJG5oIGWZOOu8lYdVwkyvMLQ/g0B3t+fNu5GpX6z44jbZsdP7PgUDBL0FoklOXBhejHXCNaP5jTJCWuk+dxJEo4DO6livKCNiPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lo/S6tyN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lo/S6tyN"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-25c90c3ba65so18475ad.0
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 10:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757699959; x=1758304759; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WZInW9X2QVaan1imrJm3wFpIydvkejQvjGEJ7xZyjO8=;
        b=lo/S6tyNJL3dytp1aHhwjFia95T44S5sdiyQwluLV8Kfhza2GA3+xZRZaKKlrdFpNx
         e44lFn9lwx5j3zipu5kvdQ8N2pHJPYTpcFcmqBI3kIYUBZ4PvdJAUBHwVPtub4phyltK
         Bhdg8jPhpQzjYQTZjEYJNT7qOnSutWNIk9O0rfG0gtrSSx/d/jI1KEX41/C3XpE1eht1
         wESQZeTzNGZVFPJrZWyGgQuSiO6sob6fpNX2WIKV4XUfog1k3o7QkYnvExk1eKCO3+BW
         7CwwEkht4icEBiOE0Y7o6uEyYO9pB1H6mjNQsORjwxExZQfnQYSVXZamKQntTiABK+Dv
         ijLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757699959; x=1758304759;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZInW9X2QVaan1imrJm3wFpIydvkejQvjGEJ7xZyjO8=;
        b=fq8HghOzBIONdxt4latUdJQrFw0uE0FCz7TkrBJXdb9AcweTSIplIl90n3A0Z8YGTR
         +6f1rAfKIA1OsaBexvhDiN+V4SIq+aCucebIASqv1OL/uahW5lgWFwB28d8UNCiUerxc
         eHMnV/g+iYTGQrUWRpoeFh7H6lTezCMP9NCfz6/15HXywZYA3dd937H9RtCZjJatkgZH
         magnPuAxzD2kp8GjM4mb7mO/wwZrvpceW3DYVDPUXpu7NJLW6I/RUPQsMdXLAid0LOKF
         4Ox/530TBc1ZxbvUWMQ7syZfcfZjazLxHTzvYLXSI1xjW7dVQKjG7ZzMgmka0PzvzcSN
         k0RA==
X-Forwarded-Encrypted: i=1; AJvYcCUeLt88KNC9HxJcaxaGirz3pHj8a2vy6BmmjjcKApwQhdktQ+5SRNLScfmzY5+khZeTC5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHQnKNCUhvM+GvOZtwY2eUgwJbIC1mUtFIyh9x0khepC+pHWC5
	nuBrozak51/da0fDbwpl01656wp6XvhJrahe0ZUKE2hZqH7hm/lurzwxFOL6smG/2diopRpnqky
	XBx5JZGHn0xjRz89JYG7lasp/yCfYjmubMVCZiT4ceCNnf7zEQ/maS113
X-Gm-Gg: ASbGncuM/rwbdQQ5VhbENHZnlQCw70zTXlL1L09jMwfc7z02yfaIPszHOe2eOuRtmQT
	Tz0BgilP3KYPanc1UX14yq4tckjUgDKRB1VLNeK4aEfHxYagvGXiptM1YDdX5sXUNhEYZppXAS8
	6g3k5ss3el1SyzwIUwLfBpMrNUaWtDqK4SeFg1gjsVy0ApNH3zD+NGZfZyItBncsI4QjqGWoSuA
	3v+C7JxXJ9sOwM58liB/RSNBw==
X-Google-Smtp-Source: AGHT+IG5jQ0m5zHbb6d0J0h8DEMM1aCmNbjtjdxmPv99dNN35l779alRcfRmjKy1Eb/IJXpLHsrzbWHbFnN0FZAxfHE=
X-Received: by 2002:a17:902:d2c5:b0:240:6076:20cd with SMTP id
 d9443c01a7336-25a7f1c8525mr14925975ad.15.1757699959144; Fri, 12 Sep 2025
 10:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 12 Sep 2025 10:59:06 -0700
X-Gm-Features: Ac12FXxLopl9F9a-AmCJAqVuzppnQ1MDAiHyTG0shsnbrU5GIrilTxlofWnpgo8
Message-ID: <CAJoAoZm+yeF7KUbVBqUh0zc58b1jXVPEtWimrUutX_5ifixxgw@mail.gmail.com>
Subject: What kind of help is needed for SHA-256 work in the next ~year?
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

brian has been working on the SHA-256 implementation and now on the
interop, pretty much solo, for quite some time. I realize that it's a
bit late in the party to ask, but as we're talking about switching the
default for new repositories in Git 3.0, I think it is past time for
the rest of the project to pitch in if we can.

What kind of help would be useful to you at this point, brian? How
much of the work is planned and ready for you to delegate to someone
else (and what's the timeline like, if you have one)? Do you need help
with testing any parts of the existing code in scaled scenarios? My
understanding is that you have a roadmap to guide your own work, but
if it's not shareable, is that something you could use some program
management help with? Anything like that?

I can't guarantee that Google will be able to jump on and help right
away, but at least understanding what needs doing is a good start for
me to be able to ask around - especially if we're looking ahead to
2026, that gives me more room to try and get help. I thought to ask on
the list instead of mailing brian directly because I assume that's the
case for the other corporate contributors to the project, too ;)

 - Emily
