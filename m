Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC36971469
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jv9WdQpf"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AF941D858A;
	Mon, 18 Dec 2023 13:47:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3J7C2CC+r85E2m+msGDnc4dU8LQ01/6DgQGk08
	h2ihQ=; b=jv9WdQpfpZRiQoupi05Wp1wyEb3H4f4ch7oBAzECyLL+NbZ5ehdFda
	6KMTgMdp6mRGgL9gC4kBDh7zFDvVYXdsBFfxPFwqISw0JvJveiAU4fzIJJx2WpBT
	Ib68xzcoP5iRYTJ6+DgQhpKviDnqVwwoJv/QErBpqGNbJCOZEBwRY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FD311D8589;
	Mon, 18 Dec 2023 13:47:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4EC4D1D8587;
	Mon, 18 Dec 2023 13:47:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
  git@vger.kernel.org,  five231003@gmail.com
Subject: Re: [PATCH v2] test-lib-functions.sh: fix test_grep fail message
 wording
In-Reply-To: <xmqqjzpbh3kq.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	18 Dec 2023 08:34:45 -0800")
References: <20231203171956.771-1-shreyanshpaliwalcmsmn@gmail.com>
	<20231217153140.1831-1-shreyanshpaliwalcmsmn@gmail.com>
	<CAPig+cSJ=RcJtYKzT0Kj1-0nJT0YxA=KPYV=5H80_inJYS_Vnw@mail.gmail.com>
	<xmqqjzpbh3kq.fsf@gitster.g>
Date: Mon, 18 Dec 2023 10:47:29 -0800
Message-ID: <xmqqh6kfe4am.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E5C29446-9DD5-11EE-AB70-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I'll see if that is the only glitch in the patch (in which case I'll
> manually adjust the authorship and apply) or respond on list
> (otherwise).
>
> Thanks for pinging and ponging.

Here is the version I queued.
Thanks, both.

--- >8 ---
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Date: Sun, 3 Dec 2023 22:47:59 +0530
Subject: [PATCH] test-lib-functions.sh: fix test_grep fail message wording

In the recent commit 2e87fca189 (test framework: further deprecate
test_i18ngrep, 2023-10-31), the test_i18ngrep function was
deprecated, and all the callers were updated to call the test_grep
function instead.  But test_grep inherited an error message that
still refers to test_i18ngrep by mistake.  Correct it so that a
broken call to the test_grep will identify itself as such.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index c50bc18861..502f892fad 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1222,7 +1222,7 @@ test_grep () {
 	if test $# -lt 2 ||
 	   { test "x!" = "x$1" && test $# -lt 3 ; }
 	then
-		BUG "too few parameters to test_i18ngrep"
+		BUG "too few parameters to test_grep"
 	fi
 
 	if test "x!" = "x$1"
-- 
2.43.0-76-g1a87c842ec

