Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD2A1BDD5
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932331; cv=none; b=lnFxwQaA9mwiB0dufWYsarmgAkTDUp8sk9pUrDyAjDf54lF44iQNKVIG74hNozMFoMXyp9ayW9zkW9A7++fzSe6PjFL8n98NHgDCvpCVlxE5VFceLs+BRUN2cp+tHln1aQcousBGWqy8Xw0RPYAErc3MunS9HZS3yfVoaPifmgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932331; c=relaxed/simple;
	bh=t7lpW1YgTci/yUf3H3h7d0Z5V0kxWZlxPTSiokX1g48=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k8Y13X+9xGWbdK/8E1ssrcS+ArHHhV0ilxpkeZrDDtf9H1LH1oCLoWNvivt7TtGRwcG3LqCTzM/chQYoOX5anqN4ic1sCeoZjSqYjAZ44Yx4t6uAwswn87Sy1moPpnvdCmB4uiboqvDgrOhYB1Rskucel2cbaQd1WoJt2bPKyb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0FmHrOT; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0FmHrOT"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so4118663a12.1
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 23:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708932328; x=1709537128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t7lpW1YgTci/yUf3H3h7d0Z5V0kxWZlxPTSiokX1g48=;
        b=Q0FmHrOT2nPlwyOhr4t8n+zXteoEE49wJElCCG62Zec2+dmFcPaxjX495PwZyKijzx
         6+lP8Rv2c01xStln8CcOS9III2UGub3VNP3l/SK/dVgZN3aRS8Un5c2p9sGOjAKkpDWz
         bVEahWagNwb9mh1NFNOzmUf90bAmjXxA01Wwbqra+q8HjqLpjjJmO7MyKIHB4uBIMXhq
         5IB9Ev27dTJupAkwBEo5iK+Wouny/X6S56q3KFEy2qNowezxnHSEe+fIoXWdtyEY4TaM
         oggTWvLG+oj0tzEarrAogkU2/yTRYGvsKfgVPK7yy5DvmGl8kMYmjGYyRBnT9gO8HBzG
         qqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708932328; x=1709537128;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7lpW1YgTci/yUf3H3h7d0Z5V0kxWZlxPTSiokX1g48=;
        b=m9c7LfyPEUX9wVIe0GBL+twzpi8XD0mp7BdAnOIQVSEuqvwUnzyP/BsDTo74KkDVzm
         HhBrk5QgdqIUibWAqiRbgTN7oLdFyC7ulxccKLAppyYR7J9gQbSgZlULE0D10ibllR4P
         bGMRCFTMFm1qPmLSr1Wjk1hr+j4ItivrySESGPhAfnzqyiJTyLCz6usJxZiD+g5w2830
         NCLcNRD59pDAeGgQtPqrNL2k9rpANTs1KcCWjG88nicY+TmDyO6u0+gufamwlRNualgW
         0VDP/HEPnLh4djR+MIia4GWd8fbNyuHSvROJn2RoHLNnn+07wOIC7LTPTISLUDCXAobg
         d06A==
X-Gm-Message-State: AOJu0Yz34231qldzyzGmK3f3S56qFOlc9dcWl3hTnLcbZOI3frtv0zBX
	xDJjlh2fjY4FP9AU8IF9tpUKdnzX9cM0GyqpS624XTtcTeAl3t+gwQ33jDmdqEN01bAY8XimJDw
	1xOXgFEK0xg7b9ewISggk/YMmwA0nYUvhUmtj6w==
X-Google-Smtp-Source: AGHT+IHNHStn9mWRyaMhHIq4M7OZOfgt7kunLHaLgrlBJ1jVlVoTroi4AZXix/Ya4B3FQ9VdJtxyNVPsHGvtb76wwIY=
X-Received: by 2002:a05:6402:713:b0:566:7a9:70bb with SMTP id
 w19-20020a056402071300b0056607a970bbmr508900edx.24.1708932327874; Sun, 25 Feb
 2024 23:25:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ZheNing Hu <adlternative@gmail.com>
Date: Mon, 26 Feb 2024 15:25:16 +0800
Message-ID: <CAOLTT8SQyBSWC=aqB2SRYmp3kR6RZ+L_-9yckWQf-X9rbzeNBw@mail.gmail.com>
Subject: [Question] How to parse range-diff output
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Christian Couder <christian.couder@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am currently looking to implement a service that provides a version
range comparison based on git range-diff. I can easily parse out
commit pair headers like "3: 0bf6289 ! 3: a076e88 dev5," but I am
unsure how to parse the details in the subsequent diff patch body.

It is not a standard diff output where one can parse out the filename
from the diff header, It should be called a diff of diffs. We can see
various headers with file names such as "@@ File1 (new)", "## File2
(new) ##", or "@@ File3: function3" in different formats. This is
confusing. How should we correctly parse a range-diff patch, and do
you have any good suggestions?

Thanks for any help.
--
ZheNing Hu
