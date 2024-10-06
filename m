Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0055216D4E8
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728216754; cv=none; b=UKyptSxZ8G5DqShg959d5IhawZenJhsyIxb8nxR9HLL0e5CuCQDvCczOEE2OqCSxPuAzlMts+SIof+MA47AcJ7ryzL8WbhFNS5nyRDMPmtxIBjKkVPdUHId8VFRWmGwAXIs3iUWbMM0hop6LEdhnwBp0Jr7ctlrqzqmodrN3AkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728216754; c=relaxed/simple;
	bh=WzwCehdBnUKnauxZ/UxeXCLmZccoq+ydAwirsBKoI+E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sWOa0fU89RzGG2U2UxJPJo39tYvjLgW7mgklBsjQq8pbhjA/jxWXnb60KNEgE7gGpZ+O9KnHZRm5wGpVjp3O2vijNS3KpxSRzcA807vlecvY0TIELMN9kyeF17CMI6PYtKAzVxQkTYXoVu1Hd1Da3EV7f6y9CebaQ4Xe6QU/Z3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuYQndQS; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuYQndQS"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c89f3e8a74so4926310a12.0
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 05:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728216751; x=1728821551; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WzwCehdBnUKnauxZ/UxeXCLmZccoq+ydAwirsBKoI+E=;
        b=SuYQndQSDENBfIsjLOWQ7bQiDy6cSoweDbkBC1Bc3PfI5iCWnvBCH1W8uI5zb1t/n5
         GqHxFtzWKq//13aBF+XRY5McmPw2hd+c5WBK+KUfnKaZcA94OWzoxWhyQPyojHnHyTll
         Nq2tFF7I77ILJvuFfTkwsb5TEQLguzWjUcD/Z9GjyTchA/DG55UGH+VCTGErSxDhUAQI
         bVzaS5vfGWbNZGr+5lfK3E9IITH9sr0PmyP725vZenN66cQlgEI/bYTpkUD1o4FjaS6y
         Lsylcgutg0cBbHEOeetSluvkkVmdmm+2eAPMQ0I0Xub0Athfjmg1iFgbEHiVDWOdoljo
         KVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728216751; x=1728821551;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzwCehdBnUKnauxZ/UxeXCLmZccoq+ydAwirsBKoI+E=;
        b=XLxxaeVAEG6wAdClc1LHwMLpLzR7nRCETc+zce16Z74Ktu8VwlSa4FZ1cWU9t0dlG5
         Cub8yjsn//tRX1OHxwa9FXeE3FNTI8JFwxulDOqwa2BGnZhft6rHDzpOB0KaG7hhmKG0
         n0FofMkuIW0Za7govdjslcQeqgahUC5KrATXpHhtyGjIU9c4/42SxqChgHmXJFNtRsAb
         MkDHUkqfa4UCfuq8rHYGcu2+G7RjS2T1fgNyXPSv40z4TkFPF7JJOyVKNv+vMkxPbZ7N
         j0hSI9S7GtwEjZOxnAuJEz/LUtRYvTTEf2o+2VAFa/nHhih2bO62qhvIWwyKjlsC02zG
         9aQw==
X-Gm-Message-State: AOJu0YwVQHcVSLuH0Ji4fGiu5WCOSsp9mY2N86TlOWp63r3D/Bil+y60
	13Fau09VCgp/Np7FZPCJoMqNW+0szBWQc3BrsnGEq1dz23sLmACRY8TYr0z2rFDjr+j6a0uCvI/
	a9/RnFAVPf45YgIg1x2jR9o/NGSd+yDH7cR4=
X-Google-Smtp-Source: AGHT+IH7dv1fLRV+hoWGpKl4KeSLf9YPbkSZ3p1ZpXXNOCc5ytVyZJRCUS5UoArWqaq3cY85KjlvTAUyJF7u7nayTnQ=
X-Received: by 2002:a05:6402:27d2:b0:5c8:8455:b3f9 with SMTP id
 4fb4d7f45d1cf-5c8d2e1f3c8mr6525366a12.4.1728216750885; Sun, 06 Oct 2024
 05:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chizoba ODINAKA <chizobajames21@gmail.com>
Date: Sun, 6 Oct 2024 13:12:19 +0100
Message-ID: <CACwP9ara-N1PGYi8wt3MsDvs50thXf9iw2w4n-syZD0wwXXqfA@mail.gmail.com>
Subject: [Outreachy] Applicant Introduction
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, Chizoba here. I am interested in contributing to Git - Convert
unit tests to use the clar testing framework.
PS: I also have read:
[1]: https://git.github.io/Mentoring-Program-Guide/
[2]: https://git.github.io/General-Microproject-Information/
