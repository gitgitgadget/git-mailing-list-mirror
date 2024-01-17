Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5442561B
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705529768; cv=none; b=itdho0ZzixE0HzR3n2adqXojDEi8xUFJ3VeIpOSmO0rtKdqLUndsTBO6Uxd28OwcVdkGo/049enViQPmMqvMfCAGCActjPs9oS3/KKJenYnkHirE0irMDselczj2q3jdwxs56vVRn4QpOk0+7BBev3b/seDnsEbAi5JvYWLfnEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705529768; c=relaxed/simple;
	bh=ukaP3pTCswo7FBcTc0bch7aZp/ZOG7k9EPD6+iE86bk=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=o0PblweK70TZl4r6hDaenS01de9bhYEbI66cXtURk/+pqJn/ihFmGlHAKPZJs9V0YIkTG6X3qyhkhfcORo/o8cGGITpTo0hwloe3pQydKBmvvIzP2ivl+duXgYoJ9iYYCN6TGySMpDpoEQnXVp0slRggU1PTcRHeVmEDZGdrTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GcA/j5ev; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GcA/j5ev"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 992CA30078;
	Wed, 17 Jan 2024 17:16:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ukaP3pTCswo7FBcTc0bch7aZp/ZOG7k9EPD6+i
	E86bk=; b=GcA/j5ev7Q1VtyzQ1/9Nzm4Lfp8FYSxZNG5Zzw7lLSSZZ1c+HiCkRq
	0ynbd7c7/ksX7fTmjuo60bb14mZ/V6uOBjLgBdkh16IfxhhVuq4lklH8gMBxwXk/
	M4D3Z/rHiphXlbl8xNnnUJAFoyKvocInXRQpYqYyYXWRNGti5yzFo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9143530077;
	Wed, 17 Jan 2024 17:16:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F3A1D30074;
	Wed, 17 Jan 2024 17:16:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Pratap <chandrapratap3519@gmail.com>,
  Chandra Pratap <chandrapratap376@gmail.com>
Subject: Re: [PATCH v3] tests: move t0009-prio-queue.sh to the new unit
 testing framework
In-Reply-To: <xmqqa5p3vczi.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	17 Jan 2024 13:58:25 -0800")
References: <pull.1642.v2.git.1705220304781.gitgitgadget@gmail.com>
	<pull.1642.v3.git.1705502304219.gitgitgadget@gmail.com>
	<xmqqa5p3vczi.fsf@gitster.g>
Date: Wed, 17 Jan 2024 14:15:57 -0800
Message-ID: <xmqq34uvvc6a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FF1A1BEA-B585-11EE-A782-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I forgot to examine the contents of the tests themselves.
> ...

FYI: taking them all together, here is what I tentatively queued on
top of what was posted as v3 before I start doing today's
integration cycle.

Thanks.

----- >8 -----
Subject: [PATCH] SQUASH???

---
 t/unit-tests/t-prio-queue.c | 57 ++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
index 0b826b463e..3014a67ac2 100644
--- a/t/unit-tests/t-prio-queue.c
+++ b/t/unit-tests/t-prio-queue.c
@@ -22,44 +22,43 @@ static int show(int *v)
 static int test_prio_queue(int *input, int *result)
 {
 	struct prio_queue pq = { intcmp };
-	int i = 0;
+	int i, val;
 
-	while (*input) {
-		int *val = input++;
+	for (i = 0; (val = *input); input++) {
 		void *peek, *get;
-		switch(*val) {
-			case GET:
-				peek = prio_queue_peek(&pq);
+		switch (val) {
+		case GET:
+			peek = prio_queue_peek(&pq);
+			get = prio_queue_get(&pq);
+			if (peek != get)
+				BUG("peek and get results don't match");
+			result[i++] = show(get);
+			break;
+		case DUMP:
+			while ((peek = prio_queue_peek(&pq))) {
 				get = prio_queue_get(&pq);
 				if (peek != get)
 					BUG("peek and get results don't match");
 				result[i++] = show(get);
-				break;
-			case DUMP:
-				while ((peek = prio_queue_peek(&pq))) {
-					get = prio_queue_get(&pq);
-					if (peek != get)
-						BUG("peek and get results don't match");
-					result[i++] = show(get);
-				}
-				break;
-			case STACK:
-				pq.compare = NULL;
-				break;
-			case REVERSE:
-				prio_queue_reverse(&pq);
-				break;
-			default:
-				prio_queue_put(&pq, val);
-				break;
+			}
+			break;
+		case STACK:
+			pq.compare = NULL;
+			break;
+		case REVERSE:
+			prio_queue_reverse(&pq);
+			break;
+		default:
+			prio_queue_put(&pq, input);
+			break;
 		}
 	}
 	clear_prio_queue(&pq);
 	return 0;
 }
 
-#define BASIC_INPUT 1, 2, 3, 4, 5, 5, DUMP
-#define BASIC_EXPECTED 1, 2, 3, 4, 5, 5
+#define BASIC_INPUT 2, 6, 3, 10, 9, 5, 7, 4, 5, 8, 1, DUMP
+#define BASIC_EXPECTED 1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10
 
 #define MIXED_PUT_GET_INPUT 6, 2, 4, GET, 5, 3, GET, GET, 1, DUMP
 #define MIXED_PUT_GET_EXPECTED 2, 3, 4, 1, 5, 6
@@ -67,8 +66,8 @@ static int test_prio_queue(int *input, int *result)
 #define EMPTY_QUEUE_INPUT 1, 2, GET, GET, GET, 1, 2, GET, GET, GET
 #define EMPTY_QUEUE_EXPECTED 1, 2, MISSING, 1, 2, MISSING
 
-#define STACK_INPUT STACK, 1, 5, 4, 6, 2, 3, DUMP
-#define STACK_EXPECTED 3, 2, 6, 4, 5, 1
+#define STACK_INPUT STACK, 8, 1, 5, 4, 6, 2, 3, DUMP
+#define STACK_EXPECTED 3, 2, 6, 4, 5, 1, 8
 
 #define REVERSE_STACK_INPUT STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP
 #define REVERSE_STACK_EXPECTED 1, 2, 3, 4, 5, 6
@@ -76,7 +75,7 @@ static int test_prio_queue(int *input, int *result)
 #define TEST_INPUT(INPUT, EXPECTED, name)			\
   static void test_##name(void)				\
 {								\
-	int input[] = {INPUT};					\
+	int input[] = {INPUT, 0};				\
 	int expected[] = {EXPECTED};				\
 	int result[ARRAY_SIZE(expected)];			\
 	test_prio_queue(input, result);				\
-- 
2.43.0-367-g186b115d30



