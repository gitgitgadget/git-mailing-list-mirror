Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144636E48C
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527405; cv=none; b=TC5jG9qI/Pb5m9j9BWu7kY3Uzegdlthp/hZvShUmXOPYHSiebqj1F1ylThaW3Q6iLO1U/cLVVYFprRLLoAQUSYTzjmEcEPRDt+yKHRaJfQ8uaHVPtCBoWUp39e4h6dcsOECyKE7ShA5IcUuFBXW3zpZXqWTiihgKnGS9g06XFx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527405; c=relaxed/simple;
	bh=yxWvKSBZKRws1j/xjvTRjCIeria3mlMGf+eDm8mQaeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tC9I28WuwXBKsTkPQWMvWF5wxYIPtwy5ANGZcGQg9r6ObEb5Jj+MJyJQ4T38qpXexktYqGEyt21ZQIwo0Rr+UkHOv+PxN95b+XsyUQrRvZ2xAmoqtg1JEUJmiRBKLy8lTuSe6LN+5kJpJ7jtT7OzA423+sbzSV+H2BRKwfMWz+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMiO/Gtm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMiO/Gtm"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f752b3423so1270262f8f.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 12:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785527401; x=1786132201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4N5n/jBw2Gun2luolu6k2RopRnqCYuzuBwdT1+JOWvA=;
        b=aMiO/GtmyX7EIwTdf6yDwlWOLqedSPXeMrg6l4zwWa+h7dzHW0wZXXz0mtDW2OWAk+
         yW2Ema07AR9tilXB0uUt87IXouCl8GsJVE1kzkbeudIxqI59HArrdjkeNfZgCehXK5dS
         tSs3NbXo/ig7J3P6sjaduBoknjqf3RbVTH3Mm+JCspHxKQgujv0/OpA2v40jQ5ldy1Hb
         8GSPIdWAz9oz5wjuBv3IqgywXFL267aRLg2ZgFhkSi3K6SKwq4KsRzzI885UFgI+NgoT
         WSVwe5KlhYEjA2+//XF00Xy+Zp30NqpkYegbwU11UCBm+QaoYDo4hFZ3y9dL1xfaTy2H
         TQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527401; x=1786132201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4N5n/jBw2Gun2luolu6k2RopRnqCYuzuBwdT1+JOWvA=;
        b=s9xxJklXLkM5K8PaNFAi7fNI/8bFkS7zJn1sZFJlU88slfbHG+MIB1ENstYtsxBnPD
         MjcaEphYRETPBopIRUlb9KvgnN1XNaS7FtqS/GZzqBnl9x0R31plvp1wP75vDQ0b29w1
         IMAnjivmsGGDYHdWT6kwTCEjloRlFh6ABY6xMlTAimkyQHfVNthiiv8rlZDQwWYjreOC
         nNfXchnUwXaXzorb0rL2jP6eRjlKgypAU4UCkm0KtPC1ASmrbcXtZenW4sZMVSBjBDd/
         LAIj926NffX7qI/VKHWgIyJKE3sXgDfemaTeaQL3dLHyESW/nCMILRDtUZiVmdyrHqY/
         di2A==
X-Gm-Message-State: AOJu0Yxgq5ZVzR8UozcsCfIeo/gCWWgrgyybQNyyrX0/Hd9iOhUGLxLF
	/WC+BXoPdr+SSqM3MlP0QdnA3gaNdTVOjxy4ktBV9/a9xnGC9MWoahbCfjh453eF
X-Gm-Gg: AR+sD10J4rOMAOfoMlKiomaL2SYkobuoXXz17x3cnjOt76EKwN2n6fXyTsPbraiQufa
	0JHxIcSMFpaLpY3YZ+njuYay6sIS//c2YKgmF4/W7/FQ8WDqLWLEz0OfZNTjNc0ffki7nwiCzOO
	Grc3pPWjw2jKeoLvf+T11KU5kWOliBSf23OGACnwbOWQLYpwj1tO/+kzZ6z1XLg5QZ6IisWGWk7
	OFnWJZ+3Bk8Vj5N2+cFO/cG+yqdEMLuuRwUryMMTzdxxe8hREob3LXUJAoPd0k4ZCXcnfjGsdbL
	YaIuqKrmWToYX0b5/vgWpaoZJCCjjMhW6zgIX70M0aDULjZPdqGTmRhYkIdJplg/+eojB7H+ZPf
	t75ldmDRhnOYsqVgSB+LcGdU+buSiTkMEZUq9o7nRbQNvNQNKYD7i9nkoMpA6qI6YmYFa4hzAhc
	sthuOfF6qMSoX8LOxnaz0FOfk/VFn+L39vdxXyslmnKcbaF8rk5zq3+4ZOJ4i5K3SC6WE5WKMS5
	agiT2tdCy5qoxRGStrwBXtG6EyGP0xZYgKoFmJ8UnaAbTd0ZgFPkTJ+orleDPGRgCK6noXxv7Z7
	AdfO6ertc6PcYQEATE4oS8842LoKyMgqHVpfXWXdSVfLFKlCVftYq4eAF/gacxGuwHBFtoiHgMB
	YlFHd9fyNAHvLeqZbBN5eS/Tqex7Nl5b6FhMrjxcEISKQceTcE2pQBKuyOozQWmsj4t3u1eRPHH
	khLJ6XL937YR+aTKjduCANpScdRT/DpQ==
X-Received: by 2002:a05:6000:71e:b0:478:1a24:912d with SMTP id ffacd0b85a97d-47fd7327659mr2119639f8f.57.1785527401462;
        Fri, 31 Jul 2026 12:50:01 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2cf1sm8248568f8f.10.2026.07.31.12.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:50:00 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Fri, 31 Jul 2026 21:49:38 +0200
Subject: [PATCH GSoC v2 5/6] serve: advertise type capability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-objecttype-support-v2-5-af577461ed57@gmail.com>
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
In-Reply-To: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The server and the client can handle type requests but the client won't
ask for it until the server advertises it.

Add type to the advertised capabilities so the client knows that it can
request it.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 serve.c                                |  4 ++--
 t/t1017-cat-file-remote-object-info.sh | 26 ++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/serve.c b/serve.c
index 2b07d922b3..2ce513cf2d 100644
--- a/serve.c
+++ b/serve.c
@@ -97,9 +97,9 @@ static int object_info_advertise(struct repository *r, struct strbuf *value)
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
-	/* Currently only size is supported */
+	/* Currently only size and type are supported */
 	if (value && advertise_object_info)
-		strbuf_addstr(value, "size");
+		strbuf_addstr(value, "size type");
 	return advertise_object_info;
 }
 
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
index 116862f9d0..93a70f65b7 100755
--- a/t/t1017-cat-file-remote-object-info.sh
+++ b/t/t1017-cat-file-remote-object-info.sh
@@ -7,6 +7,7 @@ test_description='git cat-file --batch-command with remote-object-info command'
 
 hello_content="Hello World"
 hello_size=$(strlen "$hello_content")
+hello_type="blob"
 hello_oid=$(echo_without_newline "$hello_content" | git hash-object --stdin)
 hello_short_oid=$(git rev-parse --short "$hello_oid")
 
@@ -19,6 +20,7 @@ unstored_oid=$(echo_without_newline "$unstored_content" | git hash-object --stdi
 # file name is hello, which is 5 characters
 # a space is 1 character and a null is 1 character
 tree_size=$(($(test_oid rawsz) + 13))
+tree_type="tree"
 
 commit_message="Initial commit"
 
@@ -31,6 +33,7 @@ commit_message="Initial commit"
 # An easier way to calculate is: 1. use `git cat-file commit <commit hash> | wc -c`,
 # to get 177, 2. then deduct 40 hex characters to get 137
 commit_size=$(($(test_oid hexsz) + 137))
+commit_type="commit"
 
 tag_header_without_oid="type blob
 tag hellotag
@@ -44,6 +47,7 @@ $tag_description"
 
 tag_oid=$(echo_without_newline "$tag_content" | git hash-object -t tag --stdin -w)
 tag_size=$(strlen "$tag_content")
+tag_type="tag"
 
 set_transport_variables () {
 	hello_oid=$(echo_without_newline "$hello_content" | git hash-object --stdin)
@@ -256,14 +260,12 @@ test_expect_success 'remote-object-info does not die on missing oid like info' '
 	)
 '
 
-# This tests depends on %(objecttype) not being supported yet, once supported
-# it needs to be updated.
-test_expect_success 'unsupported placeholder on remote returns empty string' '
+test_expect_success 'objecttype is supported by remote-object-info' '
 	(
 		set_transport_variables "$daemon_parent" &&
 		cd "$daemon_parent/daemon_client_empty" &&
 
-		echo "" >expect &&
+		echo $hello_type >expect &&
 		git cat-file --batch-command="%(objecttype)" >actual <<-EOF &&
 		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
 		EOF
@@ -271,6 +273,22 @@ test_expect_success 'unsupported placeholder on remote returns empty string' '
 	)
 '
 
+test_expect_success 'unsupported placeholders on remote return empty string' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		fmt="%(objectmode) %(objectsize:disk) %(rest) %(deltabase)" &&
+
+		# The hardcoded SPs between the atoms are respected.
+		echo "   " >expect &&
+		git cat-file --batch-command="$fmt" >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'requesting only objectname echoes back' '
 	(
 		set_transport_variables "$daemon_parent" &&

-- 
2.54.0

