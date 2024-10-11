Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C31C36
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604955; cv=none; b=h1CiMeafl6cJv1X5m0mgl1GLhHen1AGm5foIdXhlR/b2j/hVQxomTdSX1yIYT9kkkpHBfx7/JUfnz/wardhhL+Qf8v49UKonwAm+QH+1cDrNfrT+7uq/r78NhBxfZuN9vgjzgKafDMyem4H3qCGPs/y8kuDS8NnCbdkDhpodWlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604955; c=relaxed/simple;
	bh=FuWcNdHpNdVUfHRkW6JtBJz0jvfnbuVNEYyo/lhRs/c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=j10Li+y9BwwFEmeD+GUxtRxH8Rz7EKxG9+13U3D3fUu9Vda/w3/0tbo5hrCWTVjVCBwDZNoIqE3YJA8CrvduA79M6WKu5CCOTRiU+6AZiui3clQdu/UAnPjVjzFHu39g9RL35+3/zWgi/YR7Z391IOpjB0TpPAUM811B9oYQstI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqzRuYI5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqzRuYI5"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2d1858cdfso874110a91.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 17:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728604952; x=1729209752; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wBhctxHUTa0l4Ap3ifUliNWnO3GOmBBfG6xfem8ElBA=;
        b=hqzRuYI5Ai+BWdojvsYaE3VSjIgvSXtjj5Z7VSR11SU9QRVOpYDcyDpjxXmfZ5rVpa
         0IGdKM0YWo35Y/0BYT0LIl0WY33B8J4Kxe3eN5OO0a6cbDT0pU5KFb4PwFqoe9bnLEkL
         KwpxsC3qvXB24U5i2p3Xve084B1mpjm8f8id1EepUo6LoPe6IAsCq3bFW8oWJZ/84O/r
         EC+tJURbUEn35YC3XXKTTHXEvPcUcYFh6tFN2AXqPbVnX4i7FMWLXAvZENdLzmcLu6GP
         8unlLkfRqNwAY85CMRKvEGIeyn9eESdfwoVPKuG2jBo0fCOIj2i8fI/ApmluW8jq9Gd8
         b98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728604952; x=1729209752;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBhctxHUTa0l4Ap3ifUliNWnO3GOmBBfG6xfem8ElBA=;
        b=YKKtaTiyUpBFuhZgcLxx2zVkRJe/7FdxLfZuYNELV4+X7lj4U60cWuWztw8uG1auGW
         s6PJ/7PlecV+PxRi+e9UQe9o8+hdxyfyGDMc1iaCkzw1hd+GDxN1VumBYk0uW80lCvRL
         9F5pcMUUKPTLaiU/BQlz01MEwzvq97QLj1fumxkHQM0gHh2nkxbSs4xvmQorfddlFOfv
         xdk1OM10SjaYVJw35/V8Uj7atB0rJUtjjBdql+fIBj9KOfe03dWZ0hrQOoqGGR5pdr1r
         Y6AiDu+njbqZCy26gIfAX5bZXjnsR8EA8xkKFpzdwqhyhTM0DssOIVhUCc+wLukZMkT4
         Iz+w==
X-Gm-Message-State: AOJu0YygB0imhTKSd7TqChlQfHHtcodfgscFmxMn4MpQ92W4Tx45Bj1g
	2QltDqH5Pff6s5h8g+FhZpS1pOH52CR/xaH3MFRuahffHRykTbZpfoaZCKzMsYydz2YH9Qv/FcS
	gXRHC0G3+9T2FUH7xGkRurBRfDolTY5Bg
X-Google-Smtp-Source: AGHT+IFLlX1N1DdMopcKWhEiHgwwrgJzkbKMbl3U9kqragXpGWHSLK+iMceqrXgNamt30sg7HvkHGuvsm2VB6WgS3dc=
X-Received: by 2002:a17:90a:cb84:b0:2e2:af88:2b9f with SMTP id
 98e67ed59e1d1-2e2f0a52515mr1180551a91.16.1728604952581; Thu, 10 Oct 2024
 17:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ed Reel <edreel@gmail.com>
Date: Thu, 10 Oct 2024 19:02:21 -0500
Message-ID: <CAGjHeYdxczCNtT=2rk+r8i6xtMTQxt4PLf5wAv-=bmS5xx12jg@mail.gmail.com>
Subject: Unsubscribe
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-- 
"God gave us two ears and one mouth to remind us we should listen
twice as much as we talk."
