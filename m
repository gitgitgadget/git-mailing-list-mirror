Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739A27EA
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="UhSMQM5f"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146F3C1
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 18:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698629881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWkWyWFOsWYr8L9/hArd3hc9MtvsBqOdajjm6RlosKY=;
	b=UhSMQM5fN8pKx2O7XAZp24URMqyH2nIiYqOCUoyPFuTJu5y4bwtjOH0LL8U8FZa4+BkL3b
	2c/l+uCPgdkaJAevW62D91H+lOKtfSW+JUBOpAgckLkfvtwuDYL9pV+kKXKAezHxnCTwig
	A0wq7zE+ExyEdtITIklTtH1bdv6pdLA8fYMvUxX/290fvlspilBhdk+poZU/k8UHFBxU8X
	b31YqhfLF359zYxbTXRKaHybXycDYafq4OWgo//wLQpWeyevsIw+7xhpX0UHXQsjBL0e3N
	s25C8qereu9405ULwKUQlT6+1FCJucqk0lXVCa/T6gH06jBTJWltFG4w8dkxuA==
Date: Mon, 30 Oct 2023 02:38:01 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/6] status: add noob format from status.noob
 config
In-Reply-To: <xmqqjzr4gaie.fsf@gitster.g>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <20231026224615.675172-1-jacob@initialcommit.io>
 <20231026224615.675172-2-jacob@initialcommit.io>
 <xmqqjzr4gaie.fsf@gitster.g>
Message-ID: <c31418c38996d1e67a4f3602458a5a91@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-30 02:32, Junio C Hamano wrote:
> Jacob Stopak <jacob@initialcommit.io> writes:
>> diff --git a/table.h b/table.h
>> new file mode 100644
>> index 0000000000..c9e8c386de
>> --- /dev/null
>> +++ b/table.h
>> @@ -0,0 +1,6 @@
>> +#ifndef TABLE_H
>> +#define TABLE_H
>> +
>> +void print_noob_status(struct wt_status *s);
>> +
>> +#endif /* TABLE_H */
> 
> I am guessing that your plan is to add other "distim_noob_add()" and
> other "noob" variant of operations for various Git subcommands here,
> but I really do not think you want to add table.[ch] that has logic
> for such random set of Git subcommands copied and tweaked from all
> over the place, as the only trait being shared among them will
> become "they are written by Jacob Stopak", that is not a very useful
> grouping of the functions.  It is not even "this file collects all
> the code that produce tabular output from Git"---"git status -s"
> already gives tabular output, for example, without using any of the
> "I only want to draw a table with three columns of equal width"
> logic.  Adding code that are necessary to add yet another output
> mode for "git status" directly to where various output modes of "git
> status" are implemented, i.e. wt-status.c, and do similar changes for
> each command would make more sense, I would think.

Furthermore, "extended" should perhaps be used instead of "noob" 
throughout, to reflect the planned naming of the configuration option 
values.
