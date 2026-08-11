Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C203290AA
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 03:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786418474; cv=none; b=hJvlWXpdDpEpA5YYhERCVxIrhbVt5lO1VhkaGaiNtXklSvTcs6vFfbSlupVOufM5eaOrxq2ZZnnZ10icx/gm85LvF8mGPICJbHzI6Arhxxuz/AmeUXOrlc+9gqqn3Y9xaoOYjcXEXOEgr6m03O8L0FwLp+khqrk5v49OkutCUlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786418474; c=relaxed/simple;
	bh=R7vKuepRemiBOcBTon7lcG2FzGP0KXG59L2UCcUknc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qSC2FgmGxuWYjaKq1jr/YbCcttv/pP/MdXwM4fSHyjwEaGrg6EcQ+yjiFf3S7Za9/En7zawA12kPmXmy9JkaXzo68+/GUzWfsZ6fTRjdKw4Xt1U85XDCkHkBrTVgmHl2+Z4o/TDEeigRf5D5hMJVhuKtinlSHx1LPtmby3dGL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rZr9myB8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b4PDKbfX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rZr9myB8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b4PDKbfX"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F327EC0087;
	Mon, 10 Aug 2026 23:21:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 10 Aug 2026 23:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786418472; x=1786504872; bh=mpo+tDaqQ9
	xGfKie8Sxwx3DcdPH0D6h+WtnzsacopPs=; b=rZr9myB83pHnrfqod3S7gcvp24
	cnAO413eMl9Nw3e6khc4PITDmNKXyIXXjBOWm/5QjbgtgMGVakp2zeEBzCLUx3Nt
	zX6/hSTCklBuHtBRmg5A+6t7Py2iImkZ+bd1gk41JCeQVfckJL9pV4AifO2JaPnS
	jKZRveNxEON5+8m6uZy4jPdqQl2pLArHFmVTdaHitI/4RsxbQsuxHYk2kqoAMU6+
	67h+WnjHQHuT3GPgltzAWVOgK1cOA4jJ3o1126EqVODi1Iz0QCzAqAsjIUnSE5BY
	dJ+SQdtRoP9xoQdh7TyFmMYh05T6d241MaK8LZUHCNmeVGigNXI3JQuFQRqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786418472; x=1786504872; bh=mpo+tDaqQ9xGfKie8Sxwx3DcdPH0D6h+Wtn
	zsacopPs=; b=b4PDKbfXPrrw9xoqm3R6j66k/5Fh3ccCd+vnoaNAuZlx61BHnOS
	PBFBetRn2jM16Icc6AnuEz7aHm8mcHg5XIhRZBuzfrmdipTTOVCAMuVNm6aSdDx5
	Y++zcwwP5G5L23UufxQgUXbVYgY3IEEXE5VN5vr5ehPNXUcW72M1vTr9OTpASYDW
	nsOEfopnA2RbNMJR8I/8xRr7ZnYr06Ix5IZ/xdMcZBohbpUP4t0K6nTUr4Zxds+b
	4xVk5mM50kACO955yh68ON80VUG5qOBLfWSFspTbSK0e79DNlVRlDncrNTWwgHEZ
	8aSW7oMyuIhIA5yodbiPW5y7rvYol6uiItQ==
X-ME-Sender: <xms:J5V6anAnymUoY4c18ZFLroBK57pMRXsiXN5purodqbOLVEYdS0xvSw>
    <xme:J5V6agFLdaRpHh4eBAFxd-n7FWQHnFU0yixteAqyrP97Tnv8uhcapwezRBTzcISAW
    jzH2Pk8DviyuYlDpEA-q1DurMsJPfBPmsqZ4_uEb2ThAC9XLCflYw>
X-ME-Received: <xmr:J5V6amOqXfGF1GIDHAp9TbdQ1Y-ePN0TswPv66S-gtU26lhpi14RgPSb4Zg5V1cylzjMTPYdpsXekP2kk_78q5uQfONFDxSrAQ>
X-ME-Proxy-Cause: dmFkZTFt2v20ZcOsOi+Km1cvhhM03CpKmrWxDO4ov88+/EhRDxL/l69Y1RQy4u/dqr0RJd
    0fZM7tTSIGNzkab4SeDgRJqzldd8P9InobH6jC8aoKlzk2nTgHvRVaeOtS3M0U8HlbwkEy
    wfafUzo9zOJOK+XQhQ0Hy5rD14r3zFlH7x55h7fQpWlZxpe5/Sq+K4qCqUEbGCtJzKSmKe
    rQKtzRUOX1AexMBz0AMCfOtBVNvh5SkwRk8RmS6FIRzz7L2KVhkJejaRCulLgHKUT+P90A
    wgzkp2uVuE6zby74I91KyrWQfqeoz5xQyVyBddInzPi1mK219BrJQYv5u0LGm0C9TmroL7
    k967J64KmocKyAhBIQOIi5NKssGhEL0qnjLOJdhq87hubZGKp5TwSUE21Z3jXbBr/yHKq+
    mEKNHWk2zi12MpQsVFpU9Bg7e8R6sCPWHdaFVTTpA1giiTqMUo1zDMfthwX1MphRDwxg06
    4mIvm4fvPWhx4DNdoNdTfa3oANKce3Fx18S8NpysEFPcye0rxmdvkVlo6JfQXaOO4dOyyB
    Afu6l9JkKnWNcdJEI4uMnRJis7z9OAx1U6zjP6zYjseaW91oxCXYtv/fJt/Hj7IpngyaRO
    UjhcVsGic4942CKR7W/7P/tEEnQgmM5wJLGTH8++57bI5c+e6PXQWSqZamOw
X-ME-Proxy: <xmx:J5V6ap4zx-YqU5lzMDcCKZ_oGmEbvalQL3vg9GWUy5GicOz4ven2Tg>
    <xmx:KJV6ahgeWVY09TvnsHrG_uj9huLUtSHEczc2cj8jnJj9xYfmB6aU6w>
    <xmx:KJV6amcWvXTyJvaUGcJvsjx_baHj9H4vL3Uu6qqBcd2Qpw813A4Oqw>
    <xmx:KJV6ahwQnlgDavnBqLmRiS_qWaueJ0_6GR-8WIKLSd6Dz8U3S4OjWw>
    <xmx:KJV6asvf5lAn5wELY5n7QZqwymfqJ8dpO7kC-9VDJgvONKDrAR_CzLXV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 23:21:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,  Britton Leo Kerin
 <britton.kerin@gmail.com>,  Elijah Newren <newren@gmail.com>,
  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: [PATCH 2/2] completion: complete tracked paths for "git checkout"
In-Reply-To: <xmqq7blx5oor.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	10 Aug 2026 20:19:32 -0700")
References: <xmqq7blx5oor.fsf@gitster.g>
Date: Mon, 10 Aug 2026 20:21:10 -0700
Message-ID: <xmqqmrut4a1l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When completing arguments for "git checkout", _git_checkout()
delegates to __git_complete_refs(), which only completes revision
references.  This is good, as mixing revisions and paths in a single
list from which the user can choose is confusing.  However, if no
reference matches, or if "--" is given, _git_checkout() leaves
COMPREPLY empty.  Bash then falls back to the default filename
completion in $PWD.

This fails when "git -C <path>" is used, as $PWD is not the target
repository.

Update _git_checkout() to use __git_complete_index_file() when "--"
is present, or when revision reference completion yields no matching
candidates, so that tracked paths are offered as candidates.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash |  4 ++++
 t/t9902-completion.sh                  | 27 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 38dec1cabe..bd4b6e9247 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1780,6 +1780,10 @@ _git_checkout ()
 			;;
 		esac
 	fi
+
+	if [ ${#COMPREPLY[@]} -eq 0 ]; then
+		__git_complete_index_file
+	fi
 }
 
 __git_sequencer_inprogress_options="--continue --quit --abort --skip"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 53a2bfb2ac..46fe94d8d5 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2713,6 +2713,33 @@ test_expect_success 'git -C <path> checkout uses the right repo' '
 	EOF
 '
 
+test_expect_success 'git checkout completes tracked paths when no refs match' '
+	# file1 and file2 are tracked but ufile is not
+	# there is no ref that begins with f
+	test_completion "git checkout f" <<-\EOF &&
+	file1
+	file2
+	EOF
+	test_completion "git checkout -- f" <<-\EOF
+	file1
+	file2
+	EOF
+'
+
+test_expect_success 'git -C <path> checkout completes tracked paths in specified repo' '
+	test_when_finished "rm -rf repo-for-checkout" &&
+	git init repo-for-checkout &&
+	echo content >repo-for-checkout/otherfile &&
+	git -C repo-for-checkout add otherfile &&
+	git -C repo-for-checkout commit -m otherfile &&
+	test_completion "git -C repo-for-checkout checkout o" <<-\EOF &&
+	otherfile
+	EOF
+	test_completion "git -C repo-for-checkout checkout -- o" <<-\EOF
+	otherfile
+	EOF
+'
+
 test_expect_success 'git diff completes tracked paths when no refs match' '
 	# file1 and file2 are tracked but file3 is not
 	test_completion "git diff f" <<-\EOF
-- 
2.55.0-698-g3e60a4dc4e

