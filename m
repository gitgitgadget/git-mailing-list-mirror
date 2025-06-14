Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226552571A5
	for <git@vger.kernel.org>; Sat, 14 Jun 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749905033; cv=none; b=rTp50lKawNthN8PV6ZMxz+vzm65eFsW8GAizSZdysX7bBZsXG2lDgKPZmEBIP+33tdtyg7nxI1YLjpjjtqgkPi2qD3YD0PMnkbEPmmAYZKKNPaEETDDOwNisTa95G1BS3MEr+NyuYeJ1A4rNg9kEbaX/K8uuUQ0MYNLtL0s5w5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749905033; c=relaxed/simple;
	bh=f773iGrUV4Tycl6dQQnKTjcWVuaBBlVhExC837IeH8o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tV9nLyx6vGCiu8I6YnJbTAr8d0s45RKLnX5wCa3glFLz6botjfxK4PV18dTHN/8P30an/m78xS634cw5IJy6YwNz9fpxspzQsLAFW9LYQzT4PAkC3PCAf6GPTdvLhmyZrIANczE86sPx8JLKyyty9rtfHRxbn6BhMNeWLTaZucA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guXJw9yP; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guXJw9yP"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a43972dcd7so40369011cf.3
        for <git@vger.kernel.org>; Sat, 14 Jun 2025 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749905031; x=1750509831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f773iGrUV4Tycl6dQQnKTjcWVuaBBlVhExC837IeH8o=;
        b=guXJw9yPTOc3tWpbD0zpQaSHfNkB3MyXRdbgmQyiF4rsty95qP87zH+KlKJ7LigGA/
         g5h5jXQuv+LVgI2ygPeqWH05u1ahnq3vsx+BwmdXDpjsWkMgaojAg4CTEKTgipvvsvX5
         +1GJosvZlZU+09lrTRLu45wl2Ezflrjnvmk9YOGhyaQTNZrXwbh6pcB6KKZ+b7vtkHB7
         tzA8JOrATx8aru9gsBgXBRsT6PEtuoj4QUY4waSMLnGZBwlksL1lzeZW5F7oM9lLm/tc
         gGyP+Nn60BvW94kNF3HFmSDglP6nBdhiqo+i/iel71RdBY4KPlH7YOXrN6sFhYE6z71R
         bj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749905031; x=1750509831;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f773iGrUV4Tycl6dQQnKTjcWVuaBBlVhExC837IeH8o=;
        b=GvFHlT9EHuFOBAheYdmm+eiTxg7iCOlcyD+EwqSLXvglgO8OEos1rZUV3Pv+R0JARB
         F99O7Jr5TsPOBKT6aXgLtRrQcXHLjkC5h+cE0jXUHyeeWCctvI7kk8U9tEg8azDVfvEq
         /iB2AMXvnKOtFWmh58itXtk1jZnd98YY00qGLEz9uBr6Q4aj9iFnAj39ATXKEwc5IAxf
         FT2nZiPO2t8FgUs1Us41GvS3fk84TyGf2amXTkdIlNMw3QHd3q4/HiNkmpU72YXvSO4U
         4bu8tcCcgd/tbhcwqa9KcU+lVynNdHlQZLm31TTgHvFOnFQkPI9DkzuGWjjhVbIDKHWG
         oJYA==
X-Gm-Message-State: AOJu0YyFLA8ZKZBkUHXrYBR78QsCAUl1EFLHB5tvep/7NomxWLPExpQS
	fLUONbisnnAzQasa5AIplqkSlq7ylfhaMV0M1clWRcWYVPgdPLPBIVFR9IQKP0xxnof0a82PvHT
	K0oBYRAtyMKUp3hZUDbEOgRO8u+V6kWLaE5zb
X-Gm-Gg: ASbGnctEukSLxXoCbsu4tiHnSSNNpuJti/JX+HhgromxByz14lAJPLq9pd/ZTrCSdW7
	fPeDOnSqvTd/zK+4xiU+RjU46TlgLe6SL+G/x942J/T2gV6Oq4ETH7EBuf537g3xIIvFlr4KrNW
	Ux+wBJiP6Vq9ryEkjzzn8IQTrhkgAsYuq7DOOFUXu7wLedMJqB1q2dE/ab9wLRU/6u0z6FubLMI
	48=
X-Google-Smtp-Source: AGHT+IFQmgG0TLGggwBbTqhqhUcIxc/T/nfwzBJrVVSNW0KPzFWWy/7I9jzrp3b3mixOpMh+8KygQ/HlBkXcT0oT/UE=
X-Received: by 2002:a05:622a:118f:b0:4a4:3449:2b82 with SMTP id
 d75a77b69052e-4a73c55b6a5mr51141901cf.13.1749905030677; Sat, 14 Jun 2025
 05:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sat, 14 Jun 2025 18:13:39 +0530
X-Gm-Features: AX0GCFuOTUzKd8pKkXf82Cf6JyE7fDJC8xo-IedgiLU5srDhQMkvm6CCQ_04Ebo
Message-ID: <CA+rGoLf8Lf0gbPEUjTU9Zc9KQrzui4pjyvfxhA-LT4YuafqeOQ@mail.gmail.com>
Subject: Question: regarding understanding code base
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Ok so a couple of weeks ago, in this thread[1]
Junio advised that one of the best ways to understand git is to go back to the
_inital commit_ and travel back to the latest ones.

And I happened to quite like this idea, cause I still have to dig up a
lot of things in git.
The main question is
What are the best and smallest set of git commands to do this as
I can set this up as an alias and use this trick for many other projects too.

1 - https://lore.kernel.org/git/xmqqfrh3qe2w.fsf@gitster.g/


Thank you,

- Jayatheerth
