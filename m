Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B81EE02F
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748858261; cv=none; b=JDkpA6hCiUD+kP8dCFeOmugUovKsgOTFnNV2ClYGhXXAb0BS0HDwgjs3cgInYFyE3odiBvMtrl1YGkRmAqQ5hRDuroX7Q9129+h5clsFmFJ/LGh+aQi0hwegWZnI7VcfmngU3c0C5mGzF2cmpphobgf1XTQYyBbLcB2R/QOXZf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748858261; c=relaxed/simple;
	bh=rMwY3ejp2T0gTDEyFt6Lb6u1LYpLKvZoPaagqSJkqB8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cLaNT+q+maYqfCKLDod1v3grUNBpWBlXBOn7V4e8L9nCBca9dqD2AzRDSansROPwQIttMbRbppz5Po11NVwr5Da68bi/W5ScS3NzKg1hgFxYMEeD5We3lM2SwXanXqTFjuPe12rr7+i0SSKViHMrvPQTLi/XDkJB+JsPxOfB34w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG2/MWGZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG2/MWGZ"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-605c5502143so2930564a12.0
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 02:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748858258; x=1749463058; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1H/8gQxC7yfLGw+oGwG3wJJeY5xdTgOcdivQq51zpw0=;
        b=EG2/MWGZAODpTXXzcJoe07CD68LiY2ZYwsAEETkDHFSfXUL/s200vnuaT7CUkIm8Gb
         9R3ddQr/0Ty5ah+UJJP7Il5NLwNTVmkeAIF0lzFys/TFwvmNWida5wUo8DbnisdveD+4
         bwvaUEbjIax4ANuZUTTYe046xZsjee6SuNrHxi7GaA8wDfQd6Pw8giJJ60POTT77s4kL
         0DWQFOuwqb12a6DV+/fu0khKvi2BZQ6kpVqUCR2IOW3wcUXfr8zT+2KhuiMLD65uyeq/
         uW/GOJqehAJKKfHcxp4pqzPXRqcRy8u3zznKCPynEXdWC67ZU4SRk39dV/MQOuJZ6+NP
         /gTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748858258; x=1749463058;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1H/8gQxC7yfLGw+oGwG3wJJeY5xdTgOcdivQq51zpw0=;
        b=uexOvdKT8tC8AZfCBstiC04DC2AzdOBW0kLLfj/yNga58q1ym/tn/XI/lePc0ABFDw
         Z61j19yoJtGxzZlXzaMsxmWRE+s2MbKN3Ag/ivFGoOXKgRDBbMcGTTAUSKF2lUq2HZ02
         yVznkpwmPH9jTm695oPGmi96/1M98l8IBglD5LmOZkyatXcW3KT95C6baAmTGWDNZdiG
         HOfBk1GY/GRnqj5k2KE/oJmoyz27HAqF1QebnjGUqDjCSiWWLjUf79QiuoqyxpJYfrl5
         /sGFp9h81DNwr+Zc2/wKuugXx8w5MSs+43+GKc753G6gkh8ndauJ9N8QxAmZiH3RPXhT
         6Cjw==
X-Gm-Message-State: AOJu0YzUEYM1xF01m4dPV/VQYue09erAkL+GEBszx/AeTjXzxaRsI+9q
	eIs/tQewIHnRylr7Di+72iArKRgixs3f+U0M3Zx4+EEk08NHgftk0ppI
X-Gm-Gg: ASbGncvKU7Oklc7E0H15ArrcZ0+scixI4WJ2+P2yw57/WqTiZn8fdGYC/iggf9uPczX
	Xsn666rlUiFltIuq5dKrZn4rEceOdOZAh4drZHYbuysMe9PmlLwszlqNDSoOv1SWoKmQBsuBjqB
	hndQ9cSYv8tckHXiTE6S1k9rq7WObBOCkQoJoYOSZILDQ3lQqgf26gyEWPg5qyGl61sxYZTj3Be
	fIwR8A8KV/blTVptaIaV6MqDWZsZfAz41mNTJY8T6nzgjtkb18zQNSrY697UrIKx6aAU7yIO4RW
	1rm9r5QWNoWo8JF/0Qbnl8b3rAytcv8n9RM=
X-Google-Smtp-Source: AGHT+IFYLmYmhA+YlqkTOmFTcCvlkpA28wF4kWKqmycY5zhtLH1y6oExPX0Oq0dMvc3gz2+9pkb2mw==
X-Received: by 2002:a17:907:9624:b0:ad8:826b:fba6 with SMTP id a640c23a62f3a-ad8b0d7293cmr1656310566b.18.1748858257718;
        Mon, 02 Jun 2025 02:57:37 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:760e:bd06:5a20:3b6a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6ab2csm759665966b.184.2025.06.02.02.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 02:57:37 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/3] refs: fix some bugs with batched-updates
Date: Mon, 02 Jun 2025 11:57:23 +0200
Message-Id: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIN1PWgC/x2OwQrCMBBEf6Xk7EAb21r9FfGwTTZmQWLJplIp/
 XeDt3kwvJndKGdhNbdmN5k/ovJOFbpTY1yk9GSIr2xsa4d2sBPGy3gFeZ9ZFYW1IJC81oqQhBI
 ZibeCOVNyEY5WZY/5i5mKizVmDpw5Oca6eKoC2D6E4TxObdf3pu4utSLb/9P9cRw/Gei+vKMAA
 AA=
X-Change-ID: 20250528-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-24ff53680144
To: git@vger.kernel.org
Cc: jltobler@gmail.com, Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2595; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=rMwY3ejp2T0gTDEyFt6Lb6u1LYpLKvZoPaagqSJkqB8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGg9dY/bJ7QGO+0BL/vI1vFsIJmR3MTq9O7BD
 CUKVnQTamYLDokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoPXWPAAoJED7VnySO
 Rox/EogL/jtachcKkwRoo50pk8aikqyEbrmHEf+oSp7WkKahFvM6BBBNt/Ouqd/uhm5t2d0M+Hg
 IforMiIm6NfLAqybBTJDKxdRE+ovUnEEqUZ7TjZx6mBvKvaOTuS45ePYg0tx2Zw6BGvh0a2+RsX
 BJTd0KLEYkDLlpPBNs39v1KPyp9nc8KN9c3kRKFs4IPPHT5ZtqCQ0q0yUWaA2gERO6pYPF3dz9x
 ZhAKD8h4YvDN8CnlMWPvN2zkdxLNmb9ANTzqfeZgNJHMTIRGRMBPkQP0Dc7SqaTtpAVbtjAMARM
 cGrSpPEE1V1oS6J4LUSOh05kSigRRepJ2osk6ZcHAffm1DVQWpMMVRNKQPXz0NKzPjN7nZMEbEt
 oa6VRpmLlCsD+r7MBoE0jG3wsDEphMpU3R+FfZR38pIoPtlvvAJ4ubehvH6XVDqKtEcUtYWT0pc
 E6UzfqtEV4gEWZiAZd4C0G6CyMY/DVv07qvuQNPRCnsvmKwskRhv5maM9joHfzpLiRtg70xAIR5
 e4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 23fc8e4f61 (refs: implement batch reference update support,
2025-04-08) we introduced a mechanism to batch reference updates. The
idea being that we wanted to batch updates similar to a transaction, but
allow certain updates to fail. This would help reference backends
optimize such operations and also remove the overhead of processing
updates individually. Especially for the reftable backend, where
batching updates would ensure that the autocompaction would only occur
at the end of the batch instead of after every reference update.

As of 9d2962a7c4 (receive-pack: use batched reference updates,
2025-05-19) we also updated the 'git-fetch(1)' and 'git-receive-pack(1)'
command to use batched reference updates. This series fixes some bugs
that we found at GitLab by running our Gitaly service with the `next`
build of Git.

The first being in the files backend, which missed skipping over failed
updates in certain flows. When certain individual updates fail, we mark
them as such. However, we missed skipping over such failed updates,
which can cause a SEGFAULT.

The other is in the git-receive-pack(1) implementation when a user
pushes multiple branches such as:

  delete refs/heads/branch/conflict
  create refs/heads/branch

Before using batched updates, the references would be applied
sequentially and hence no conflicts would arise. With batched updates,
while the first update applies, the second fails due to F/D conflict. A
similar issue was present in 'git-fetch(1)' and was fixed by using
separating out reference pruning into a separate transaction. Apply a
similar mechanism for 'git-receive-pack(1)' and separate out reference
deletions into its own batch.

This is based off master 7014b55638 (A bit more topics for -rc1,
2025-05-30), with the changes from kn/fetch-push-bulk-ref-update merged
in.

---
 builtin/receive-pack.c           | 23 +++++++++++++++++++----
 refs/files-backend.c             |  7 +++++++
 t/t1400-update-ref.sh            | 14 ++++++++++++++
 t/t1416-ref-transaction-hooks.sh |  2 ++
 t/t5516-fetch-push.sh            | 23 ++++++++++++++++-------
 5 files changed, 58 insertions(+), 11 deletions(-)

Karthik Nayak (3):
      refs/files: skip updates with errors in batched updates
      t5516: use double quotes for tests with variables
      receive-pack: handle reference deletions separately



base-commit: 931c39f05e078e0df968a439379cb04b5c4666ef
change-id: 20250528-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-24ff53680144

Thanks
- Karthik

