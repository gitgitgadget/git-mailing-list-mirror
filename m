Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA562D7DC6
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781117409; cv=none; b=EMiF11LX9kvdnA67IkGKEdXvAFiGxFL6IRRm73Pd1eYNS9Uv5GCwTt+k1pDMkksitAp7mPAbcKqaHJrJngelzpUlFbyvnFZqBMkqPyofkOU1z8yx/UkdRyKVLZzTu0htOthc8d81I1hj8qNhlFY8I+XGxuWG+KXXhu02KABepM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781117409; c=relaxed/simple;
	bh=Un2XdVG3XK/eU2hQm+EZcIkKBiLaI3yBCHM46QqOjDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=A1C2VQEnhcmW5ypoi7LBQokuLo5P44de0MpkQvh9S+kIsnvLm6fVgrPEzRY4jHDbr0hZr2DAibFhaa2Oi8J+fo9q7ZKoD4DKiLd9cUkjaVV3H5HhD7tfz6AmvRKqqbbw0AH4s5dPYNpNlTJmhnMMSDhx+4WILX4EBS/WSRrFdM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+NrgIvk; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+NrgIvk"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8cceb2ecc03so59949296d6.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781117407; x=1781722207; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7b2wxjG4mebC/iUNMJvohIHuacsDgIDp1ztvd6NU2g=;
        b=k+NrgIvk0LzUNKfkEsaJRYiBcIKC86szKfbmvNFaYS5YM4Np8GcmohElO8+Oe5y+/1
         Uo7boKQnjYGE4swdbd7HwO48cETCLIyOkW/08rXEeY8c7PjM9OII1BrZbfNHhHjNUL+Q
         weuCpddn6ew4qhM1fzR/WlR89GA4RRd40/pzM7uIL2j7fAUUeKEeRE1enE2Ad6Dg+Umx
         gtwiXY/WXlCsGMeQzQ4W0ElrdPqXX5pg1wbiGh2hwYi5z2KdbixniLu70sq6K37+vfUB
         EFqntX4fx0u0BUF7Dl4ggQGL7QAAVoJYNmEfqcu6LjKmaumfrM4QIMKBeGl1SRhac9QA
         YUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781117407; x=1781722207;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I7b2wxjG4mebC/iUNMJvohIHuacsDgIDp1ztvd6NU2g=;
        b=s1S5Ne5IFvXsTBWKxd/94UACUIic2qByDfXt855x9f6XwIv3EDwW7Mhdnm7D/sq6XJ
         JTd+VlzGSgrm6pPgMX94hTYNdSrBUBXf29x8UjSGT+X6joNjS3HMKj6Ro234pgvHtb4H
         0qJvQEfiDrXWxbRryupF/bWUHg5kbJt3etZCdjlCYd8ZUsCQfqFcl4vqqYLIz9FnaHmE
         42vfDsTluc6IS+gjTI9fjh0AhxNVGazjHbOT7wlhrV6C+zomw7orC2etER6z1BctXgQc
         9RXPO0fi8zaj1xXr7tLSCQWSnyPZBvvpidaf9zWKx1iT17ve7d7W3WSM1r2Sqim4WPSm
         uiag==
X-Gm-Message-State: AOJu0YyYBXHhaY874pdmnRbNxWhUruW5tQpDMFJGF8m1GK7ZcuydGE6A
	mdpLOCfBO3C521s1Tt9sJbQjv/USh/oCyJwV3VtvOs/1M/yFIh1fOTqNhze71tTT
X-Gm-Gg: Acq92OGWe0MO76nUZbeUmaHESWcvyMW/lPB5Dza7/aEzyqxsbhxgLUJz+LNtuvdcfMu
	Eu8PptW/X9JtUzUVanwmkbyFYXPP9kmwea2XHQ0wftlcvq9xez9AJZvZSeG2mA4JdcEgBDJuG4z
	UeRNlkFDZePSGvyoGGmlWFXVvBXt2U3rFLewqdpnNON2SKbUsP3TG1DdRvGuP+2bRXz2o+hQNUM
	GuvpgFXy4GmQLmO5C4BNteWtEuuJtO+vnwSZql87g+C2VkoI54Moft78u2BXRL3cNG1iMs37Kpw
	WOFJzRNMpb4Tf2vn8AulkQqNMSFmZRwtb9wW4ToaO18EIDhr4giBrYjLmXl0tFzWZyOxM7yiv0i
	F3kf4QPJafWjPLaLukpDjr3avDOcMsS9YB+kUaO5/ETLNXLSdWJeWXiyrk5ju5kW1T+8EBypuQh
	NNSLx8kaGPjSE6NXBq6jTGPdXmnI6xcMPWv2VvRZUwMP4DNUgTQY7A8CDzP/717EljIDTwISeKa
	KLudO0bkMiaDDPpv+whZJLn7ZxSQrkaYWvPw2xdHTfJ0bdYWCeyDVaJ7sZuGEQVQ4/0CU0AHDYi
	+4QUj+VIqFoCetSUQpzltgRZE1BhpoPrmUjeulbsWL4Kb31olhpzj+RyERyQi4jouA==
X-Received: by 2002:a05:6214:5f10:b0:8ce:e651:5d63 with SMTP id 6a1803df08f44-8cee6515fbcmr468943236d6.31.1781117406193;
        Wed, 10 Jun 2026 11:50:06 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([209.249.37.133])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecc8222bcsm245972286d6.0.2026.06.10.11.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 11:50:05 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 10 Jun 2026 11:50:01 -0700
Subject: [PATCH v3] describe: limit default ref iteration to tags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-describe-tag-ref-scope-v3-1-5aa63ab279f7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNyw6CMBBFf4V0bU0fthBX/odx0ccANUJJi42G8
 O+2uGFjXJ7MnXMWFCE4iOhcLShActH5MQM/VMj0auwAO5sZMcIkkaTGFqIJTgOeVYcDtDgaPwG
 uLSEK6Iko0aD8POWTe23i6+3L8anvYOZiK4vexdmH91ZOtOz+RhLFFEvBLeNMN1KLSzco9zgaP
 6ASSWyvaX5qWNYwIVvLpTWKs71mXdcP51laABUBAAA=
X-Change-ID: 20260607-describe-tag-ref-scope-7d00ae140a58
In-Reply-To: <20260608-describe-tag-ref-scope-v2-1-256fd36dca32@gmail.com>
References: <20260608-describe-tag-ref-scope-v2-1-256fd36dca32@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Patrick Steinhardt <ps@pks.im>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1781117404; l=2707;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=Un2XdVG3XK/eU2hQm+EZcIkKBiLaI3yBCHM46QqOjDU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKS9hpQ1uWeaCKjhlQyoFWHjFeficMtoTs/vNvciCM+rSI93B8N1sT1NAWXCt/aaIRLq4Vl8VR2
 ihYok5xXMMA8=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Without --all, git describe ignores refs outside refs/tags/. Commit
8a5a1884e9 (Avoid accessing non-tag refs in git-describe unless --all is
requested, 2008-02-24) moved this check ahead of object lookup. That
avoided loading objects for irrelevant refs, but the backend still has
to yield every ref before get_name() can reject it.

Pass refs/tags/ to the iterator so the backend can avoid visiting those
refs in the first place.

The new perf test creates 10,000 unrelated packed refs. It measures:

    git describe --exact-match HEAD

The runtime drops from 0.03(0.01+0.01) to 0.02(0.00+0.00). In a
repository with 120,532 refs but only 330 tags, the same command went
from 171.7 ms to 9.9 ms.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v3:
- Pack the synthetic refs to better match repositories with many refs.
- Generate update-ref input with test_seq -f.
- Shorten the commit message and report the p6100.6 result.
- Link to v2: https://patch.msgid.link/20260608-describe-tag-ref-scope-v2-1-256fd36dca32@gmail.com

Changes in v2:
- Exercise the performance test with both ref backends.
- Keep the ref count local to its setup test.
- Report native hyperfine output for an exact-tag lookup.
- Link to v1: https://patch.msgid.link/20260607-describe-tag-ref-scope-v1-1-653d232b86b5@gmail.com
---
 builtin/describe.c       |  3 +++
 t/perf/p6100-describe.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index 1c47d7c0b7..3532c8ff22 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -740,6 +740,9 @@ int cmd_describe(int argc,
 		return ret;
 	}
 
+	if (!all)
+		for_each_ref_opts.prefix = "refs/tags/";
+
 	hashmap_init(&names, commit_name_neq, NULL, 0);
 	refs_for_each_ref_ext(get_main_ref_store(the_repository),
 			      get_name, NULL, &for_each_ref_opts);
diff --git a/t/perf/p6100-describe.sh b/t/perf/p6100-describe.sh
index 069f91ce49..b1c61529bb 100755
--- a/t/perf/p6100-describe.sh
+++ b/t/perf/p6100-describe.sh
@@ -27,4 +27,16 @@ test_perf 'describe HEAD with one tag' '
 	git describe --match=new HEAD
 '
 
+test_expect_success 'set up many unrelated refs' '
+	ref_count=10000 &&
+	git tag -m tip tip HEAD &&
+	test_seq -f "create refs/heads/describe-perf/%05d HEAD" $ref_count |
+	git update-ref --stdin &&
+	git pack-refs --all
+'
+
+test_perf 'describe exact tag with many unrelated refs' '
+	git describe --exact-match HEAD
+'
+
 test_done

---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260607-describe-tag-ref-scope-7d00ae140a58

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

