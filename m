Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1948E3E95AA
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203634; cv=none; b=YBv4G/Te8iahkpZdxw9yDoHe87qOQSZfOXakFU45I0nXOhaGmS+oAeJ9VT7PenJgXv+5hh6nG99XcE+w59frEv7AJg3D0gF5GjNWuSHkeO57ZyRVBitxk4oGulx5pekXvbcSIKFNDMbudHu0nIiqaAeln0Q7SGTtOcOiNUKEAZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203634; c=relaxed/simple;
	bh=2o0nL8mZqjac2GKQK7mFKP2PJLnfEGTpKGcYF8CrzXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAhHZjp0tHjPbfiiPu9Vn3A6Si2sLqJ3L9ThgIRzKvq/RFHZyImS96i8LkNWRzn5TibQmOCrAPiP8jAK/qSUsPrrh9f607m4cFgf9QNji3gqtmMw449z/xWK7ygyouYUyAPYOpHbqjO3Lyi3DqL/GVtX0UKrmReHJNxI0dFxpkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsFxX/ea; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsFxX/ea"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81f4e136481so3401851b3a.3
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 03:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770203633; x=1770808433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tsv6bMh5ktnKPNDVdMN2FkusFh31uv+IxEGJYvQnV6c=;
        b=PsFxX/eaEk2wln1DQ/HsLBS0PlzjCuy7tw8hZiOSDb+H88ruI1ZLMHh08sDcTl8gCP
         B8dME6iLj9VRHo9YmhNTyo767tSZ58zM3kFp4g4LFfLtFt7anjtlqp6cQlQb2+fs55AJ
         v58b0VQs7OvkQYGJnZ4OpFPgzGGBBU8yLDqjwF/8dkXRjmKyf2/TmXkiJn/BhlMV/ARi
         G0Gedj/Z7DoVYy9xlGSKhcINIarCC9jaFJqgYAnk/Eo1xoZ5e6X9goPXTTb+jbZLMoVq
         IYs1xP/3SylVMXHJ9ZO24bd4wPGSGdLiTKJ9WpbAIBAv1NcUTre0SZdnljcX1CXHJ/6q
         b5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203633; x=1770808433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tsv6bMh5ktnKPNDVdMN2FkusFh31uv+IxEGJYvQnV6c=;
        b=TlT9geyqNlCMMZAwSllvKC8fjN2QKNfTPR8CWLbzIt8ThqaRFgrBlKbeQ2rH5D0/Wp
         TogHTkjoaPgqp1QGLBJb9yQJ+mwiF1AfmvpwP76rNubr2K9+VexBdoQOzAZUptCzu9Ll
         o2cf8aNYpeYp9xCNE0jlYoe73J2QUhLbzjdJeBUbhdmaeNlDtQBJiZaGrZ54MdCN88a9
         N1tYm6QxAYzklhNaYGaxnU3yvQghVMZSOTMLPgYGnpu2MR/16qfrWnHEP+uFR9A89Udl
         xCMCRh1lG7Dowfn7nprXIQmKqZlJIFPC8ldg5K9AovjUMUviIDJL5TlZ3A2v0hsLV5Af
         PzoA==
X-Gm-Message-State: AOJu0YxKRY/ZUMr3ElAXI36v+w5Z0yRRFERp2LALv3TLSovuGuQZ0mVb
	/hq82KeBbSLg+76kDA2i65Bjnv9odPdZixbs1s53UMNgRRcwW2KxnsUsbxoC2g==
X-Gm-Gg: AZuq6aKjXR7m7t/Em38Rp7gpPdWbjQ0vzOQ6QNCPunxhgtZQxHqWFEOBTdvia1Hvn1f
	LvuWY0fwhZFlImrtgPLN9KNzL1BWx9AwfeykLPmqVWACrnT/sjzw2srhurZ8zVaMOpU1Ab4EzP7
	J+/YfDrZ4wYJX+Jubb0kWpd6al7oVfHBLxQifb8kV+RhdeTuJgFKOCKGgt/NOTk6I0kTy34CRNw
	OQvMBtR7QrTndm3j1BHA25r58OX+9pe3cpK3AtIfpxWJFcNB85hWe72IlusR8tFqBBkPJaD6uad
	M/dnF3loid4Xvgtky0kZ0VAKHaI7/evWAUKMwBk/e2A3uFHkH+D85hLVqoX8kbgt4PD0SQ3ejj3
	eckdZnxigcuKaKB1p+fLe3alE6eQUwww83/+0+0BPYKn0713JCjNmI5kssW1E/DhszkHarEijXK
	xFALar6psDCk3iIfyb0x6wd97oUg2knfHCf9anhdYBzEWKER0tyOxnLXc=
X-Received: by 2002:a05:6a20:1593:b0:38d:ecd6:60c with SMTP id adf61e73a8af0-393725d6aa2mr2391290637.77.1770203633203;
        Wed, 04 Feb 2026 03:13:53 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:1b99:bc9:8a3a:dbe0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d438f1dsm1942631b3a.32.2026.02.04.03.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:13:52 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: valusoutrik@gmail.com
Subject: Re: [Newcomer] Question about inconsistencies in MyFirstContribution.adoc
Date: Wed,  4 Feb 2026 16:43:04 +0530
Message-ID: <20260204111343.71975-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAPHqhPmDSh8WRwYt0TJUQQajM5r84m6tc6RZsiM-YzeBbxzwaw@mail.gmail.com>
References: <CAPHqhPmDSh8WRwYt0TJUQQajM5r84m6tc6RZsiM-YzeBbxzwaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hi everyone,
> Newcomer here, while going through the MyFirstContribution.adoc I
> noticed some small inconsistencies , which might not be a problem to
> anyone really, but since I was doubtful I am writing here.
> 
> > Add a line to #include "config.h" and #include"repository.h". Then, add the following bits to the function body: function body
> 
> And then the tutorial uses `git_default_config` , which I am assuming
> used to be in `config.h` but now it's in `environment.h`.
> 

Yes this is a valid inconsistency, but this is fixed in a recent patch [1].
It is currently in the next branch.

> 
> Another small thing was
> > There are a number of single-key lookup functions like this one; you can see them all (and more info about how to use repo_config()) in Documentation/technical/api-config.adoc
> 
> But There is no api-config.adoc in ./Documentation/technical
> 
> I couldn't find any other place where the repo_config() was explained
> , Inside the Documentation folder it has been mentioned in 4 files
> - MyFirstContribution.adoc : excluding this
> - MyFirstObjectWalk.adoc : excluding this as well
> - user-manual.adoc : used to explain what `builtin/cat-file.c` was doing
> - 2.50.0.adoc : is about a release ?
> So I assume the thing that the tutorial refers to is currently not present ?
> 
> While writing this mail , I checked two previous Patch mails:
> One was about a patch by Arnav Kapoor (
> https://lore.kernel.org/git/pull.1972.git.git.1748005233977.gitgitgadget@gmail.com/
> ) another one was probably about rejecting this patch ? And then
> From this ( https://lore.kernel.org/git/xmqq8qmso59i.fsf@gitster.g/#t
> ) I am assuming repo-config used to be called git-config , but a
> search on git-config shows up too many matches , and I think i should
> stop here and ask for advice.
> 

Actually the documentation for repo_config was shifted to config.h,
to make it easier, see patch [2].

You can replace 'Documentation/technical/api-config.adoc' with 'config.h'.

> I believe this won't count as a microproject for gsoc , but
> nonetheless, it may or may not help newcomers.
> Is this a possible patch ?
> 

Every change, even if it is a small documentation change is an improvement,
but I would suggest apart from this doc change you can look into [3]
for some more microproject ideas.

Best,
Shreyansh

[1]- https://lore.kernel.org/git/20260112195625.391821-1-shreyanshpaliwalcmsmn@gmail.com/
[2]- https://github.com/git/git/commit/6c96630cb0900446f7069f64d3d58bac539c0a58
[3]- https://git.github.io/SoC-2025-Microprojects/
