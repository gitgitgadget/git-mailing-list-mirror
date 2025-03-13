Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E7A1F417E
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900545; cv=none; b=kOKxHBHhfnKJRcyrltRLzq5Xshb6/xMK4cUflPVPaJuApPZdVJksFaK7gWxkttivlNmjaUewOnzc/yU9pZ1URWeSGMnH3ttNrT/qKY1rbxi+/HTYEzuEgeNCBH01GuTEYN7EmVO6pzeKGe3h5/ov0Wzmt+dea2MzhADYkzz4/zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900545; c=relaxed/simple;
	bh=8pHxuBjdgW1Sy3SpTEKNKYZNEch2+lXNbg4dYpd3YMg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rFl3dmA8eZ6L0MEe4XlTvHa8CJgTKuc96xPdRSK520vAebNEE8pArzuYvxDb8RS/9c6mhtO0+0CGdyY1syRB45zj9KI1U40mIjy2aF4dkEtGWPUZb6w+GJT7kCWSfdrAyS5VvlybXcbUzAHkfZ6wOO6ntGO5JPiUBX/vzCj5hfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqK72yqh; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqK72yqh"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e5dc299dee9so1383271276.3
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741900542; x=1742505342; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8pHxuBjdgW1Sy3SpTEKNKYZNEch2+lXNbg4dYpd3YMg=;
        b=MqK72yqhqKPb1nX8yppeYgTthGfVu+rm9RDm9vl22oJMevQOu7ATqLSktq1O6a6/lP
         /jS8XQOqHcGvFQ4WMVrQXF4NiUrjUkX8MaiKrMMwShixp+DSKP9rHrJNWxcsH5IwM/Om
         BVyXwzlsz6IwLJt8F9FNkMy2V4W6Y33bMMralsgahBKy6E1+W959uitXE7TXkWo0bpd4
         dA/jyJaMvMRV4eAh6uILd1A10qvvQ0OT5hAeB5PHru6nlO2OpHgnRkQ+MAFDMhh7Oew6
         +l1Ab+ouQsrDaR4c5JosFrePkyUKASirCzTluY4dK6RCadVtvZyI2oEXynjzPe+coApT
         CkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900542; x=1742505342;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8pHxuBjdgW1Sy3SpTEKNKYZNEch2+lXNbg4dYpd3YMg=;
        b=s725N1LbP3NJNM3xY8cSBsW0clwXXFhgx4kHmlmTvy72cMIIkXUKubwt+MWbmvHVwk
         ddB6bI7ZTtnS7tHkSbQB8PbB2WnANB9+QuuGQZW2hZRcJpDtokGkTKP1g/LbMpbQ7Tjq
         Vsz9csLgOpocArsQxn/j8OkxcAnd41els5/zKcZQFTIh8Av8cHIOBgXn7HW60cJwDEa0
         CMfWSTS05Mz4n2OsEnd3aOyMW/8LOGnvyb+EbC03Q4WnZ3jFPUvanC3CAIAgzUV905+l
         VJVzqN9kkg+InmOK6Rw8vv4fSlLrYIvvdWF7gx4PSli8WfvooUaoDBdXVKgp3VKJhaZS
         APQg==
X-Gm-Message-State: AOJu0Yx+N8Xfv6NxltfKAb9EzYrmvPRdkO0Ee7aAhHQH2PSrzgCSX2lc
	Y5wMVpXLPO6pHZqaaBFZZSel9g7b8hlzEofZ9rZoVWjdK+9WeaD7Qah2Pp8/sKC/fzvnS1YrNTl
	ukyIK8AuQNMJrAneYILrpJtk42qkWBNU3Fqo=
X-Gm-Gg: ASbGncuOmB3YX6fr6RZciItxtZNW1tlkwphYUH8rdebCMr55/jWBVGOJIK7lw3Z+nqx
	1nuqOG9k4En4D4ZvHEAgU/BaQqS7tR3fTvT84i30w5f3IOonKFD5TlqHumVH1sy3mSZUgSyZB4d
	OWCrh5hj908JK9u2Osj+qk9+jNktDiMa0LJWVglL8fY3D85o/IqfoEFR0Mf7Y=
X-Google-Smtp-Source: AGHT+IFWvIxC/u+IS+qZOplbWBDij2JEKPXVaZBXfzUWKvkNj0AT8R0W3YpRqcpRQzZv0tFy/luEELI+5joLB77Atb8=
X-Received: by 2002:a05:6902:2504:b0:e63:c2d2:94f2 with SMTP id
 3f1490d57ef6-e63f64d6613mr167857276.4.1741900542601; Thu, 13 Mar 2025
 14:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Fri, 14 Mar 2025 10:15:32 +1300
X-Gm-Features: AQ5f1JrRlGxmb30cZRtfYDbeylqwVfqFHvpqIaqH9PkIdG2C9YsCggrhQvJzRNw
Message-ID: <CANrWfmQp1-oqWS533wsbmg8AbOVCAyefabWKy0DDzjQJJWPGGw@mail.gmail.com>
Subject: `--word-diff` documentation formatting error
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Git - git-diff Documentation --word-diff=plain
https://git-scm.com/docs/git-diff#Documentation/git-diff.txt-codeplaincode-1

`{added}` should be `{+added+}`
(trying to open new issue at https://github.com/git/git-scm.com/issues
results in me getting redirected to https://git-scm.com/community .)
