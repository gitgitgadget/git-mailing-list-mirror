Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F4B26E653
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895886; cv=none; b=KPUF6GaCj1+s5WJthquVWnvbuHDC9X9JB6gxScmOcox3mlS+pJ6ik0Dd7nyMDJvpQYByAHmxqwrbRvOJRkfncnvSwJi1d7Ud+sXbJM6vp/rc7TcExMh+zGmA5UMykpSIUnlcmM0omUFTcdI1ppdvEclFhEZxJsm0OQQCRhOlfUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895886; c=relaxed/simple;
	bh=HE+3hPHK0tO0PnFZu/AYYaNJ1gKQl15ECqdtlhOQNag=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YU4QvJDeyzoDbz6o90xKvRyb4jnGLlH/4efQRbI75WhWiRx2580f92MvHiAli/MicWXiABNd0FXM0To84QqWsN6An99mXhGnU0Oa++XcaXhdPkPBIKEDeIFn1G6HPTM9ew4sdCGUMpi5/QCqqLk8SZJ6HP/czotyy4p+eMS43lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbjrq2gV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbjrq2gV"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f3ac22948so1518141f8f.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 08:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739895882; x=1740500682; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG4iePMgc/SX/1ONSHK/c3e2He/X8AdCj+2j+mvbkgw=;
        b=bbjrq2gVfxjU95k+5wc+3Qkwyt/ThHlYJgMs2k7J0LiKfiYSNd2sI18Q0eUkEFQ81N
         FeItz74G2tmEg5AROd1MW0pETgnOP92yYG+sU4iOgyZUrZLQUBMeJ7pQBymkUdpTh18F
         +oKWpsNtgcE325cPY+0BqUiBezZaIrmkby5hXOxNyvY8A0929K1NPrQ3Pr/LXW53zwKN
         M0subFyjI6sTntY9fFdiUz2dSqjh3CiHdYHR9iAe4n/PC9LcqaNVgFzx1PGiW2JkrVZ4
         75PBnga/zGSJoPExj+PaKzmiE0IFgQf5KGFiBtRKTa6uj2Qw/Y+8MXAeY34CcXZYJreX
         6Wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739895882; x=1740500682;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jG4iePMgc/SX/1ONSHK/c3e2He/X8AdCj+2j+mvbkgw=;
        b=mlqZUhejVdeHAbq47tzGpPBDl4TQ3ZezEzHfEGvPZrDwWY0TdDZs0xWLSGXB9jFxYx
         p2hgVtfeJCa4XpndCJE/J3jgSEuAxt6t3/Z0z0rE0K93S+8aF+6PaUeaQO2wVij8Lw8k
         JTAytsxSTC3jcfQ1enPawZX+l/wOsz8OfY/3Ai1dgFPdzygDloo0zgbVbJqdlBNKFcaT
         e9UVTPjo2H7duZxRf0yvlp8uMQH0UwsnMmNWY1wSVavZ67Nu+ZNHVxZFRaM8DC5uZKJw
         zcc/EdycrHUaOTORiXwMXuZB6mlz3hQaJ7lzgOMbQz2WUoJkDwS9x9VuRLcDgTsd66n1
         yKzg==
X-Gm-Message-State: AOJu0Yx4/sGoWpdgX9CmcaTVUHQkWrjJ/Tn+riv0NdZJSlV3v9upJugy
	YwoMlulhcvD5GDjV9+Ql6FYDgx5BagHoLIi0EPTUbjgdDNvhDm/xwtv5mA==
X-Gm-Gg: ASbGncu2zuGrVjpVhAklOppP1puxzm+wP96H5PPRLle3QSNNAoALD1+nByevohoOL3G
	YFfX/yquMM88Ipeoy/JzS8s0pEGtJalySSYjjOQ5TH3KeMwIx961RsfRZ+hdgFUDWxv2HVvzamP
	5vYDPJfjgRJeNHwGntcagNSmp3DGmxpSULySCmc38flDOxLvEp0tL6k9DNzSSTKwQUD2VPHKJXx
	OyE1wMKGXUSd3CgZBL2GP+Wx9ntoFdBVmQ02jKCIxqyRzVP2Xpmq28nnSOC0EaG+/hoVXFr5WKs
	tfufkBEwXqhgcEMH
X-Google-Smtp-Source: AGHT+IFu+UTIIwT1diee+7//5XZRvTjEZVh2DNFQQOO0+dMNYzShF6oRxP6YWQ9jD+q15L/CkoEKTw==
X-Received: by 2002:a05:6000:1845:b0:38e:ae25:6d66 with SMTP id ffacd0b85a97d-38f33f28f97mr13918955f8f.19.1739895882460;
        Tue, 18 Feb 2025 08:24:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25a0fa38sm15695848f8f.98.2025.02.18.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:24:42 -0800 (PST)
Message-Id: <63b09dbe1b7bc7c671526288e302051e5f447552.1739895879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
	<pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Feb 2025 16:24:36 +0000
Subject: [PATCH v2 2/5] merge-tree: remove redundant code
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

real_merge() only ever returns "0" or "1" as it dies if the merge status
is less than zero. Therefore the check for "result < 0" is redundant and
the result variable is not needed. The return value of real_merge() is
ignored because exit status of "git merge-tree --stdin" is "0" for both
successful and conflicted merges (the status of each merge is written to
stdout). The return type of real_merge() is not changed as it is used
for the program's exit status when "--stdin" is not given.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/merge-tree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 57f4340faba..3c73482f2b0 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -601,7 +601,6 @@ int cmd_merge_tree(int argc,
 		line_termination = '\0';
 		while (strbuf_getline_lf(&buf, stdin) != EOF) {
 			struct strbuf **split;
-			int result;
 			const char *input_merge_base = NULL;
 
 			split = strbuf_split(&buf, ' ');
@@ -618,16 +617,14 @@ int cmd_merge_tree(int argc,
 			if (input_merge_base && split[2] && split[3] && !split[4]) {
 				strbuf_rtrim(split[2]);
 				strbuf_rtrim(split[3]);
-				result = real_merge(&o, input_merge_base, split[2]->buf, split[3]->buf, prefix);
+				real_merge(&o, input_merge_base, split[2]->buf, split[3]->buf, prefix);
 			} else if (!input_merge_base && !split[2]) {
-				result = real_merge(&o, NULL, split[0]->buf, split[1]->buf, prefix);
+				real_merge(&o, NULL, split[0]->buf, split[1]->buf, prefix);
 			} else {
 				die(_("malformed input line: '%s'."), buf.buf);
 			}
 			maybe_flush_or_die(stdout, "stdout");
 
-			if (result < 0)
-				die(_("merging cannot continue; got unclean result of %d"), result);
 			strbuf_list_free(split);
 		}
 		strbuf_release(&buf);
-- 
gitgitgadget

