Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eidTgVue"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754981A3
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 22:17:48 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F8601ABAF3;
	Thu, 16 Nov 2023 01:17:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6MnXMydLnla4xCnvPY22XMk8eb35P2XbaZcCkI
	qD7dM=; b=eidTgVuedcwaaGbEzC0Kv6h76uceDLB8lHK8oaKHLbOD8FmR/v3Bii
	O2vgWHg2LQjPhif90haWrV2CC4XwjPDo815lNgnF82XuoZnPUvlXMhh8FzZ5qNB9
	p/SK5mOOs1vwEmhyKtUvIK9B0PHpw3rVnWFbxNXYROjNFdksc8b5I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 26F531ABAF1;
	Thu, 16 Nov 2023 01:17:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FA461ABAEE;
	Thu, 16 Nov 2023 01:17:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  tboegi@web.de
Subject: Re: [PATCH 1/1] attr: add builtin objectmode values support
In-Reply-To: <20231116054437.2343549-1-jojwang@google.com> (Joanna Wang's
	message of "Thu, 16 Nov 2023 05:44:37 +0000")
References: <xmqqttpmtnn5.fsf@gitster.g>
	<20231116054437.2343549-1-jojwang@google.com>
Date: Thu, 16 Nov 2023 15:17:43 +0900
Message-ID: <xmqqsf56ql14.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DAF43BAC-8447-11EE-AF2F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Joanna Wang <jojwang@google.com> writes:

>  t/#t1700-split-index.sh#        | 547 ++++++++++++++++++++++++++++++++

This was added by mistake and we can safely ignore it?  IOW, is
everything else in the patch, other than the addition of this path,
what you intended to send out?

Other than the removal of that file, I locally applied the following
fix-up while checking the difference relative to the previous
iteration.  Other than these, the updated version looked very clear
and nicely done.

Thanks.

 t/t0003-attributes.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 86f8681570..774b52c298 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -580,12 +580,13 @@ test_expect_success 'builtin object mode attributes work (dir and regular paths)
 '
 
 test_expect_success POSIXPERM 'builtin object mode attributes work (executable)' '
-	>exec && chmod +x exec &&
+	>exec &&
+	chmod +x exec &&
 	attr_check_object_mode exec 100755
 '
 
 test_expect_success SYMLINKS 'builtin object mode attributes work (symlinks)' '
-	>to_sym ln -s to_sym sym &&
+	ln -s to_sym sym &&
 	attr_check_object_mode sym 120000
 '
 
