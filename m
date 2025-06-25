Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E0125DF
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861141; cv=none; b=BGNzBt+WXnsO13XCrVsJQPJIUTpdVJUsutMHJabw2DP7DTzwkkN5vB5J4BeJKqNlARNjsL2riEBcj9Gh+M2d8WChe1U4/AAgKobKZheL8ZHqe9YVc7t39CULopbyUd2lRZEf1YNdZdHipclGr6i3kW6APEu6H1nhjQ6cR/V3Ly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861141; c=relaxed/simple;
	bh=igXCJ2T98dkN/AmSPbq7n+onHs4fW04oRiw9bhih99g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wf/07iYcIo4nxiGfvPdDl1Ul6eodyzUd0Nl87Oh0W67DR6T2ejRYSfNOE1ZDvsozlErm8DR9+JTtZSj6gzG7MQtTQlRaAnU6pQGeil/5eWGBytok6ZgXqwWs9VUiRqckPXxFdnmt7/O5t2Oi9w+tmdAIK8gr4FLNcNm/YOnHUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5X5Z4h6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5X5Z4h6"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7494999de5cso913692b3a.3
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750861139; x=1751465939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRzO8MYkSaByLcDiR3ggFaTp3+wZC6hl4ZzAIWFpucg=;
        b=L5X5Z4h6BELhzAKGsC7WiSGefsz7dpmCpnYRB+xu/nRVlmMpUuPqZFDbpUz92Apty2
         yV+j+oV123f/TZnCUXkiuXu+TLdrBI3QLGq45wuV0HyIbLEeKybKW9FPlWuTHjSboHHb
         Jqfj8PWME/jLYLElIy3TYzEwUYS4Eum9XOjU8iGZ2B2rWtMvIMh2fF3BYnLfV/AsAraA
         OUf/lVbot9BsMspUpLOwX0IMrnnP18fhZwlM+tAMsnwUzZcIexV3orq/l72cPXFVoYM7
         2/mg1hIQc6WV5in0jjw9EFMoGlrQEU283sz2xiQVn5rTApCiAhVWXAluZPlWzeBLITJf
         jgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750861139; x=1751465939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRzO8MYkSaByLcDiR3ggFaTp3+wZC6hl4ZzAIWFpucg=;
        b=bAGHxOgA0DPdco2aS1yxzSkpFp5Ha+379qKbOQy8C35VgslT8Z4Lw+SyzfNbFyj9P/
         4Gk7aR3xuPuEDgUcenSzAb2UJ/McBt/zG9qPe1pZhA4b0yHl41HkgHOrQYqYeYEq1Hx2
         jfZgDr8XjZvlIo/l/tF+cu3AVv2B13SkmK2yUes8bMwNDmf7WfADRFPiPOa8G8y74hj0
         T1m4ymv1BD01Roy1vHb/hnhDFDFgyRABzTTaOVdc2wpqUPQ8FczLXRfir+WzLLGBnwVU
         D0vd67kLulgba1SAtYAWM9ANSwWg8bEp7Z9AGMyNmPpVsNvQJSMYSNbsouZYlLoUiz+4
         AqKA==
X-Gm-Message-State: AOJu0Yywue6qb9G6EJgh/jRZ07zlEkGZmQ9B8JfIztUa3vIxJRhZkAFG
	mdDTtWqoyj6bne2paQNQ4igLJmHNGHLnE8tytpuMKThTQQSXus4qyWfBuqOd6Q==
X-Gm-Gg: ASbGnctx249DFqUuWKUnMEP3xsqUO/ZayxQ2jLeW1E5vxnFnqSGO3MRprG5bqYPhLS8
	jnGLmH6QVhvGyacUQb42q0IQB6g6jnJhgkw6ZVW211tXjMgCUrRcoBqysWhmiY8wYenD0XsU7BH
	8OfPohZgWTSzpyeNOf2tcsMbwefMN/aee5ZjiQck9qPWFs2/OJr/tJN+qm3Pa99XLTVoRnvzyzw
	VBo+OqnV8L/v5/QmEsBwXwYGrBy/Hc6B3snKi5xXjXftXhKTMFNv1dkUM2dL9ZcZ6sgtK5CaQF+
	JFmByRngCVm/szR6Tn+5kYS7hYoIFx2pIcQldeb/eS/5KU3fpYAfHi7vnfXo0ZEYfk0TiNMGT/o
	=
X-Google-Smtp-Source: AGHT+IH2mKfYv3seolZk98v7bt+ZD1CDwsZ1+rpIKbN04360eC1PoOpwBuAc4P0oGxHlDqr1Iq9RUw==
X-Received: by 2002:a05:6a21:6da9:b0:1f5:619a:7f4c with SMTP id adf61e73a8af0-2207f285d40mr6487863637.29.1750861139228;
        Wed, 25 Jun 2025 07:18:59 -0700 (PDT)
Received: from fedora ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e42ad8sm4596360b3a.70.2025.06.25.07.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 07:18:58 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: ryenus@gmail.com
Cc: git@vger.kernel.org
Subject: Re [bug] pull --prune could not delete references due to lock file already exists error
Date: Wed, 25 Jun 2025 19:48:49 +0530
Message-ID: <20250625141849.78834-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <CAKkAvaw0sZ0sW9o_0NZdnZknS8M34UST3PetaPBQj5wwvJyjBA@mail.gmail.com>
References: <CAKkAvaw0sZ0sW9o_0NZdnZknS8M34UST3PetaPBQj5wwvJyjBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First off thanks for reporting the bug :)
So I cannot test this bug as my files system is case sensitive
but to just read the code and give a thought in a direction (Assuming that the bug is recreatable)

int refs_delete_refs(struct ref_store *refs, const char *logmsg,
		     struct string_list *refnames, unsigned int flags)
{
...
	struct ref_transaction *transaction;
...
	for_each_string_list_item(item, refnames) {

		transaction = ref_store_transaction_begin(refs, 0, &err);
		if (!transaction) {
			warning(_("could not begin transaction to delete %s: %s"),
				item->string, err.buf);
			strbuf_reset(&err);
			failures = 1;
			continue;
		}

		ret = ref_transaction_delete(transaction, item->string,
					     NULL, NULL, flags, msg, &err);
		if (ret) {
			warning(_("could not delete reference %s: %s"),
				item->string, err.buf);
			strbuf_reset(&err);
			ref_transaction_free(transaction);
			failures = 1;
			continue;
		}

		ret = ref_transaction_commit(transaction, &err);
		if (ret) {
			warning(_("could not commit deletion of %s: %s"),
				item->string, err.buf);
			strbuf_reset(&err);
			failures = 1;
		}

		ref_transaction_free(transaction);
	}

	if (failures)
		ret = -1;

	strbuf_release(&err);
	free(msg);
	return ret;
}

The original implementation:
Starts a single transaction using ref_store_transaction_begin().
Adds all deletions to that transaction.
Commits the transaction.
If any deletion fails, the entire transaction is aborted.
On case-insensitive file systems, two refs like:
may conflict at the file system level (e.g. both mapped to the same file or directory). 
If Git tries to delete both in one go, the transaction fails due to a lock file or unlink error.
(Above are my assumptions till now).

What has changed is:
Deletes each reference in its own transaction
struct ref_transaction *transaction = ref_store_transaction_begin(...);
ref_transaction_delete(transaction, ...);
ref_transaction_commit(transaction, ...);
ref_transaction_free(transaction);
If one deletion fails due to a case conflict, the others still proceed.
It avoids rolling back the entire prune operation just because of a single failure.
Keeps failure count and returns appropriately
Signals that something went wrong, but Git can now give partial success feedback.


The question I have is
If this approach seems viable or perhaps any solution, 
would it be possible to write a test case for this scenario?

Thank you 

- Jayatheerth
