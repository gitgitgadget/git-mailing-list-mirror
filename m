Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B6D2236F2
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139909; cv=none; b=JskdyXh4ghB71Vxs2FGYI+PQV8f7tOz3cdbnnw8RjDg644bsAE1snGXZXeh2BjLUZD6g5yEz9IYRbNdOsKGidyQX5IWTQpfoi4bQZTQcVXbhnC3lhBhYcZp3wMeaqbe3Tl4iBtmI0XDoeKPyYCnDGBMHI1ZaYuHlEH69Ej1/pM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139909; c=relaxed/simple;
	bh=XqfZ+/uLlT82L5ACe3BC7pt5KrF5MyxHTwX8uKeJj3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0TzPTCLL+YvQxMnLE+LG2jHpw1FSem92vK0fT6BgYIHCG6A9YegQxO2bFQWAgM3nu2dQ9wjQtmDyTv7IyskJzgCMZ9mYbyZ5fMgFgU5/HVHwgoGI0DDmiu6kGbZu/qzQ7Gqp3bYrkHVYn3eWdzJ6O/0hoaiu+AlO4fBR8CBN/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Go3CjDYC; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go3CjDYC"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a525aedb24so8134153e87.2
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777139906; x=1777744706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N781USE2XbJ/DGS8VIEEHJsIhQ3HGr3ElDVgOtxwlak=;
        b=Go3CjDYCeP+0OjFSwrRtTbSHHTInaaOtCs5j0asdxP5kz80f+69rydFvyzpU3vfHxm
         VfcVHG9ilCw7+kOqzxdea7BxcW6/zMvXUDiPdMWMTwIWIaiFmJ8SPanPJ0p1PbRbDxls
         0XGnpFsmLt4C6e5Tleax/RtVIIvDo1+r9jlYYTq9W92SdyWYNJHFw97UjeGBs7/aWVto
         b0BLwSoe/BPbheRXZNtFEy+42R1fDuOU83kFOobePAjfLv1N2QH2MsD9UdT2NC0dX0xW
         PuQ8vP3KUksGym/0ncxXL+/yO8lNrrMvneuzYuN8IWbWoRbW9Z0gABa2JN+H+Ggnz9ha
         C0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139906; x=1777744706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N781USE2XbJ/DGS8VIEEHJsIhQ3HGr3ElDVgOtxwlak=;
        b=N/1J6yYmXOW9fpcaOYiIcPxtzl/5yKyjUeDcY4V6zfsQd5VDL4Pkm++9qkfF3yeT+i
         KGfKtEwUCpWR4Abu7Q5qcS0iOK0Qhp+xEzawCXqcUlgnX9OQKpANA7ggZialWEREJ4kq
         rSVyz1GD1qz9NJVNa5AQnrfn9RJBpfXbWCLl/MrVIbpHehy9thL/ku4SKOSBqedJui0o
         y2zhEfWvAfg7zpolCSNVYXwcK5jauE5OA1Ct8LpAqvR/qJKC39EtZFXbqvQSkisnkFI6
         jBvlKMzCPcwzq7b98bIxtPDlr7CGa5PKj24lHVHWS/ommYwM4QJHySKB1T7XzYuV32eG
         eY+g==
X-Gm-Message-State: AOJu0YwenlPd2wWmhGS+4pxRJozgmC3S3L/LE+t3DaZSDscBguBV8Sn6
	fpHWDdHBCh8NZf8S9jDat98BME0jTSi2s+6qZ59eF6y9jEMZR3Q0MjxB
X-Gm-Gg: AeBDieu4CE+xgZ30ag0FWfTI3rfm5+B9QhOZQyVWrnbHzCAoKEQxGGv49YdeCKXiE1O
	I5f77o+9XN7dnEWpKWWL3acVqpUARmzHIo0kZP1+9gb2UYXS58CieScw1zDTtKE4NwN9EHrsh/b
	Z1ihqzF0ifNt7FG7vcORBFzkGn7SjRE8sgPj56ROVks/C+4H8KIgKz2+sVc+ex4Gf3zkmLyiQGy
	7cMd0Vg0aYx2QrbqkL2Gp/Hl3a9j2CkTBO0JMBeK/lEWBhyQiVBHoHCwIlCk8sA4+sC3F3hWxmd
	shdmoA7dw0sevVdk2v4YJNSr8sBG3aTPL7L0qgIT14MRmVs0HC2VXkOGnpLr+NJ2LYFBen5ha7K
	pCOl355bbVyAO5VE98V/xN6c0n2mCVwopje4kb88XqW//5Gb203dktucSUe68lop1OzWUcgYGwG
	v5tSSS4BP6J7CZnvN/lLexu3tCN63c8CEzvcj1N9KJ1rSYsDTW6pPo+/8l77Qzhi2uqesVAAoWL
	ALhdR/xyFBruY4fBa2a2fdcGCI=
X-Received: by 2002:a05:6512:114c:b0:5a1:3bfd:b87b with SMTP id 2adb3069b0e04-5a4172dd85emr11733692e87.30.1777139905628;
        Sat, 25 Apr 2026 10:58:25 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb4f5119sm52234751fa.2.2026.04.25.10.58.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Apr 2026 10:58:25 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Multiple remotes
Date: Sat, 25 Apr 2026 19:58:24 +0200
Message-ID: <20260425175824.48380-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <xmqqfr4jwxzi.fsf@gitster.g>
References: <xmqqfr4jwxzi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> The last one was a rhetorical question.  I do not want to see such a
> configuration variable to implicitly trigger fetching at all.

🤣

Good to clarify that when working with me so that I don't go ahead and
implement that!

> If you are merely starting at a single arbitrary
> commit, instead of anticipating to having to repeatedly sync with
> the remote-tracking branch that will subsequently move, there is no
> point jumping to a "freshest" commit that you haven't even seen let
> alone inspected (i.e., you do not even know if it is a good base to
> build on).

Not sure I understand this sentiment. For better or worse, the latest
commit will decide what you have to work with -- unless we expect it to be
reverted or forced pushed over.

What better starting point is there?

> For a starter, if you interact
> with a repository with two or more branches, should
> 
>    $ git checkout --track=fetch -b topic origin/main
> 
> update an unrelated remote-tracking branch origin/maint from the
> same remote?  As I already said, most Git tools _depend_ on the
> stability of remote-tracking branches

This is an interesting question, and it's very likely that I am missing
some nuance here. However, with that said what option does the developer
have, you have to accept that the upstream changes constantly when others
are working on it. What good does it do to keep the "head in the sand" any
longer than necessary?

I'm not sure there is a way to fetch only 'origin/main' and avoid
'origin/maint'? Maybe, maybe, if that exists it could be useful here.

> still on a leave

Enjoy your vacation! I don't expect any response from you until you're back!


Harald
