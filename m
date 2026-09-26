Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08C372B41
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790439653; cv=none; b=Yo2Fosand3ASNi6mBw2t61hnrfldWxqH5XNGaR6E5LYzvWtfN1wEaXszM2ws+r135BfBr7WK8LCahMv7apNzT6pgvIOdk/RuowmZMLGSEdHVpdIWL73HrhF4JNL+OSVvYyPMj8ZuBy1zQTSCQRYZ7vImMCNzzWlODclaOzZPm7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790439653; c=relaxed/simple;
	bh=EKlEjefOWLV1KeQuV0XIP4SHtCle5Y+2yP9IeMAWzKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffPYQJVZvzTtMKQjtRhOLg0zUDxyUiOuHQcp5ET9A55f0w9aD/fA+tGnOqPEyfb+JEUIgwEcNFCpaSsrD8kjedkLiM4HCEe8KXEq6Q9MkAQXVZzThsvwFm0PUgKFu3/69A47XLfB9NYXWFf/T/XHSOADRrYCSA4GRAVqoASpryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlSBv0Kw; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlSBv0Kw"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93c59695cc9so54137285a.3
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790439650; x=1791044450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JyokEbIGh9LQH13wkpSrMAmmhk08RM3101YcWRvkCSQ=;
        b=SlSBv0KwKeDJe/GmhcQoyTh6yWU+On/yI0TqngQZAOy2Z1delXtgIyTgDTJxr3TaWz
         vEN0tqMxnWEBrZ+KdqQ4Q0XEKiwIwD40kc/0o8gZ4G3E4kVOnUK/+4cSlE0nbuK/6B0n
         4JVHJVOEbHNegSiS+H2FaNMLBhPiiEGdRWSYMta3WAV5h9EdwMeFcbT2P1CmaACVN0G9
         Fb9hlgF1knkKuKkif7jeDkHpUG8wVBDPFW6t3+oD5z3J0M8kTmcffdcBRtuCGpWechVz
         7NN/JW44/POBE61G2NtDQWJk0ZBKWL5qopuHdGarUphvFfFhCZoogM6l7cluUk5qglQg
         FMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790439650; x=1791044450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JyokEbIGh9LQH13wkpSrMAmmhk08RM3101YcWRvkCSQ=;
        b=1qK5rt7GwXKFr7JPcRCODcoZ/b8iQ+6DnbbFmhT2O/lEJF4RufsAIDNWZecwwKOdQh
         bb/s2AuBXEixDyRSHJGgVZiHwdHpEq/ZATxNpZHcvYd6mGBE9D8CTYABN2eTqDX/Fosw
         jghWV695EOW+Wyo6dIQ/3pBD9CsnMV4POPD6wIU7m/iUtW6GCy0EcTJjqYPsupN3/oXl
         pX2Am+roepuFq7hIA3s7bYdr26ehgqWfLgucbhfb8YFNZ0GXFue3E5Wi2tKuwCBSOorz
         xY3LBIAhARvZ1OSMn58AQtFcZohIg/OiDIvSU4IVOsDJ+XxSFenOn8FHWUx6rG4SzXmJ
         nmNQ==
X-Gm-Message-State: AFuF++nKdx4ovExZJvCsS3Jv89ZfyvRuc+XaWWmYDCBN7XWf8ZdlOx+U
	AR8F09FPifHkOOaBtE+E6qKGjdLUqV+sfHBg51fN5gk/pQSOiZnJVOWhaohbezCA
X-Gm-Gg: AYBFou2Rw4+eu9j77cCvWKsZ0bWStgX9szrzMlqTTpYiy399o6WUZR0Zh/z6QkXqJVO
	hMeb4aFgI6wpit4R0dfejyVLVkPdCU5eKKTwXRV9TeqaevjiDWuMYFjoIq+iEjZEJ3dE1lc7biB
	BViM8OeCxqSnB6e0bgeg5eDUDb+9vzfex3IXYUXKepDW7dDZ67Pa/mOoODFs5I3B8zLj9hqP+9I
	ZSPY7U2gqWHDH826jyKwRaAt/1cykm7azgh8dkkorOY6Csu/fq2GgI4SVJ3T/d3rak/toOfcx9y
	k3TomfThpO9wLiyvsfw/AQ6/WWJNmSrNT4I/ksV9BJFq+2m/5rvCyJLoW9j2CmpveOwmq4kubGd
	k+Xi+aq0iNmHNizzV4XfsdoZqzd8J5lO6OZNOmS2AFhAgg8gFg/V4bIU0S1/c+bbS4f6lPqv1hS
	mc2EPaSC/xGce21eqz/JpXIUYr3D0dDGmP+forVnDZXc2smugxnMhjjhb9ZOCfSLD99DJGQCzfX
	PR0+Tb1p1Eqh/nXH9UGy7s3HNTLIDGoanq6MNVXnOpTADc5SJ1NYibWKFVImYsHwaS3vuYJ518W
	nWz351IOx7ArDTJr6DMKOV+uNKNzLBzSIEnYYjM/Ui5S3Oz9caz0
X-Received: by 2002:a05:620a:8810:b0:939:c303:c54a with SMTP id af79cd13be357-93c43c9db58mr1167618985a.31.1790439650170;
        Sat, 26 Sep 2026 09:20:50 -0700 (PDT)
Received: from localhost.localdomain ([2603:7002:a00:5733:58df:3319:3c13:321f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c448ae8ecsm440919985a.9.2026.09.26.09.20.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 09:20:49 -0700 (PDT)
From: Andrew Pleeter <andrewpleeter@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	ben.knoble@gmail.com,
	peff@peff.net,
	sandals@crustytoothpaste.net
Subject: [PATCH v9 0/4] var: -z output, multiple variables, and broken-out idents
Date: Sat, 26 Sep 2026 12:20:44 -0400
Message-ID: <20260926162048.30853-1-andrewpleeter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqq33va1lcg.fsf@gitster.g>
References: <xmqq33va1lcg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a reroll of the single patch in v8, split up as Junio asked
for, with the changes Phillip asked for on the list.

v8 was one commit doing four things at once. It is now four patches:

  1/4 converts the internal representation of a multi-valued variable
      from a newline-joined string to a string_list, with no change in
      output. Phillip suggested doing this as its own preparatory step.

  2/4 adds "-z", which is what forces the switch to parse_options(), so
      that conversion lives here rather than in 1/4.

  3/4 teaches "git var" to take more than one variable.

  4/4 adds GIT_AUTHOR_NAME and friends.

Changes since v8:

 * GIT_SIGNING_KEY is dropped. Phillip asked three times how it was
   meant to be used, and once I looked properly the answer was that the
   value cannot be interpreted without also reading gpg.format, and that
   in the default configuration it is a committer ident rather than a
   key at all. I would rather leave it out than define a variable I
   cannot describe. Details are in my reply to him on this thread.

 * Asking for several variables no longer exits non-zero just because
   one of them has no value; such a variable is left out of the output
   and the rest are still shown. A non-zero status is now reserved for
   real errors, such as naming a variable that does not exist, so
   callers can detect those from the exit code. A single variable still
   exits 1 when it has no value, as before. This is Phillip's
   GIT_CONFIG_NOSYSTEM point.

 * GIT_CONFIG_GLOBAL is documented as a variable that can have more than
   one value.

 * The commit messages are prose rather than a list of bullet points,
   and no longer narrate how the patch was developed.

The tests use nul_to_q rather than running test_cmp over files
containing NUL bytes, which Phillip pointed out in v6. Each patch builds
and passes t0007 on its own.

One thing I did not do, and would like an opinion on: for a multi-valued
variable in multi-variable mode, rather than emitting a trailing
delimiter, each value is shown as its own "VARIABLE=value" entry, which
matches "git var -l". Phillip suggested the trailing delimiter and I am
happy to switch.

Andrew Pleeter (4):
  var: represent multi-valued variables with a string_list
  var: add "-z" output mode
  var: accept more than one variable
  var: add broken-out identity variables

 Documentation/git-var.adoc |  68 +++++++++--
 builtin/var.c              | 242 +++++++++++++++++++++++++++++--------
 t/t0007-git-var.sh         | 153 +++++++++++++++++++++++
 3 files changed, 403 insertions(+), 60 deletions(-)

-- 
2.54.0 (Apple Git-157)

