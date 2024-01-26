Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5825C19452
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706273185; cv=none; b=U3z9+O9PCBWo3gTI6HTmnuhQFJQ5gZPnpA3utHmVjjjmZxP61r2AkXErIqBZ7S0jMACMiz7TN5opdHoe7tEEc/soOWRg5+ChCCSayfEiU8Q47O6FSnBOsD85yBXuaz7TRwFs7cnL8eX51urOX0RF/Z4bwKZ2hr1m9ommH3xI1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706273185; c=relaxed/simple;
	bh=cOjl2w2ucT/jAy27Ti8HBNONZ93u1BDWQN8RkyX7Ki0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=aiZXexCTZl/XEbRyADoFmdOIGlBaywiUGFVxES9WM0L2cYeiRa4UYSqlmoXhah44bWM+ByUnHNprcPnizSvYqr9tHEGR1ibD7zrDBENu62J8bVilfkYRl88Tj0nr5cNgDd9arpmZP45ZR0kpbrmvj/AyZNDlDrF4AyFeJRu7n0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gq/gIcNy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gq/gIcNy"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3387ef9fc62so407097f8f.2
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 04:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706273182; x=1706877982; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVLINEfeKB3tuVrfiCgUCZTno7jFT/lbRNm4fBR9d4g=;
        b=Gq/gIcNy636T2QgaXRhjLNVF/KEkw81Knpe8tkpmisuMO4MIxUABLIe8b3F+jwtS92
         ut6dR23usGAGWJDLIk6msLVNYADvQm4nzNkcvGG+NaRnx57S0mVaJbz783mefgaSo85t
         wgfK4z4XJP6WrcWp0PStooTKMP+Fp3LC5F8zPpuGTXdQrAUUz2dKGRJTvg0P5d3lpBb/
         cKHeUsMNvEVECy4ixh75/ogMzyrhQ8B2vfc+ZqnMS4jm0Klfr8712Kl8Y5gFVpoRJdGg
         Psl3LUddecVz8bQBdPK9+Kk9Jnyo3pPQ4QeFdfGI1kl6+1kvqKm31FCNY5MjnHOTFKvj
         ymsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706273182; x=1706877982;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dVLINEfeKB3tuVrfiCgUCZTno7jFT/lbRNm4fBR9d4g=;
        b=mxhqKWET0U47e7WG1g2BV3p3Yas459RSVu+faaFpo2ujCRPbXWv1QCKiQrrxVXdTJD
         kXn0rJMc3IzGe+OW61Eekn4dNZkloyRtp6xLd+uFAZoArA9VXUzHWBiBAYSe45a8DFMy
         KebPxsHpNQwOUSFdFg4HWfg4gVlgxRVaHmluBjfQgZsuaGIX3FGzc9334+QTpnGS0Mbb
         5I/NquzOVxN4CBFsL6q7GGNmdJssKelch1X9iyZOVTjwYyqjV4N92vbwYd7Y5Juc4HT1
         veqqHKpQmeT7O13S0LpXMWqxnlKdL37kvLcB5tHJj5B56ItfnhEw2Ze8Nxim0m8Mk4Yu
         vabA==
X-Gm-Message-State: AOJu0Yw/KTs5RBuHlxyC8zfpQ+BGa8wIYqcYPDlLEaLkJHOLzo4ys0Zk
	MBu7EDxURCRH6UOXMzXnDw6JvYWB6yAVbyhdCMFCUTlrW8yVMp1NFBaPkWSt
X-Google-Smtp-Source: AGHT+IEA99ZsEB33MrDYcw0v2uvTXr4jyjRQrWROtsrK8mDho3N3hSSQ/bxw5ezmWQ+jbfRFVYci0Q==
X-Received: by 2002:adf:f550:0:b0:33a:de67:fbaf with SMTP id j16-20020adff550000000b0033ade67fbafmr132619wrp.19.1706273181589;
        Fri, 26 Jan 2024 04:46:21 -0800 (PST)
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id ay13-20020a5d6f0d000000b00337d6aa3912sm1216566wrb.10.2024.01.26.04.46.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 04:46:21 -0800 (PST)
Message-ID: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
Date: Fri, 26 Jan 2024 13:46:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH 0/4] completion for git-reflog show
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When no subcommand is specified to "reflog" we assume "show" [1]:

    $ git reflog -h
    usage: git reflog [show] [<log-options>] [<ref>]
    ...

We are not completing correctly this implicit uses of "show":

With ...

    $ git checkout -b default

... we are not completing "default":

    $ git reflog def<TAB><TAB>

And we are incorrectly returning the "subcommands" when:

    $ git reflog default <TAB><TAB>
    delete expire show

This series fixes this and also adds completion for <log-options> in
"reflog show", so that the user can easily discover uses like:

   $ git reflog --since=1.day.ago

  1. cf39f54efc (git reflog show, 2007-02-08)

Rubén Justo (4):
  completion: introduce __gitcomp_subcommand
  completion: introduce __git_find_subcommand
  completion: reflog with implicit "show"
  completion: reflog show <log-options>

 contrib/completion/git-completion.bash | 63 +++++++++++++++++++++++---
 t/t9902-completion.sh                  | 11 +++++
 2 files changed, 68 insertions(+), 6 deletions(-)

-- 
2.43.0
