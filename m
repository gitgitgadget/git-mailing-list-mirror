Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC21AE877
	for <git@vger.kernel.org>; Mon, 29 Dec 2025 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767031751; cv=none; b=dDM0FZTn9Qor8g24xtgSz9r5FCfv3AIIxoLkDhRg2NTuEB0IxGIBHZENuZr271bq8rfGXq1KhswzUg71+GJB2NQnGQGp2Omx8XX1OLzVTqMC+g3fgDKcH7YAkElbmE7pUDo4uS6aOGjFYZPsk9b0tSMSxXwAIhGj2MZSBzixe+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767031751; c=relaxed/simple;
	bh=4t1mC5VuGHXAakbZYEJevnGkWz7r5Dts0767AbRrOB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kBli2qsbgF7+JPPdeDSBAE+A8c9I11XRp2Zd8fNru4vUlfeXg/8s3x4X+NsjrJELc+S4JgRiNii1e1+D3Ly4yDWOA6x5hqdmVtCmWd2V5U57OndyhCZSvd4Ms0chzqOYebaNxy0Xnoou8adQOOj6eic6taQgZi033C+0/QWYIuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSGwCf2N; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSGwCf2N"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b1bfd4b3deso832804085a.2
        for <git@vger.kernel.org>; Mon, 29 Dec 2025 10:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767031749; x=1767636549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gUAL1XODmgZ+l/lrVD8ySxgug9mrWzkyA89sL5ZYRsI=;
        b=dSGwCf2NmeCHH3vTJQwQMVfcevz7P2RxDUkSzTJiwngvu8pQOI64dY335as/sashGK
         g8NSosw56axMk0RnsIjwAg0ZVu6QCG2w+Sa1C7s/BE5Ez24Ik1Jx4XkKOU3v0hkz++21
         Inw94KDfexqx1uKLC1fKhSM0pyHwPMHoxiftrwVY/Ij5S6VzUvoRRBeNhpggEqWrOrTO
         g4R5RAJFdHa6jvzNwjdaOvTh230JwImQWXkPcWd6+TnirTuMT09SfLbwGqOeNDjRrnz1
         CqTtfU+PpCBRC5JwF+T7tj3999tCcE9Ip6AmyT46t9obbyKGzysLkG96nxH37X+Snlv9
         9Jxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767031749; x=1767636549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUAL1XODmgZ+l/lrVD8ySxgug9mrWzkyA89sL5ZYRsI=;
        b=CzBYo6QhBPgiT5dGU7h3m6MZpQGEh9Mqqn9anKj+HaQ15i49xjLZRqv109Gw0qP1Dk
         Yqzvr7ld1mZTz3MjY9xMrIWqkpO3FzOjpXgR0naPApU9bbPQvyD2TYJAym+wH+ej8AFT
         4SMNRp7EdzSnoC4FkBaFmuHG10/0BB+xWruNXKrQbJ3Pa3Nq0afFfK6A0AfLDgvxA6g/
         VPHSDuA5RpXhRTFPbPfeHg5XaG8bvD3xvUfZYTabBGJJeKTkFF+EINpd+fgF32EPegwi
         uWXdksFh3VQmGOdFcOnIt0XEOiWvirFOA1fgNBiM5d2BZ+kJYY7UOVCkjFkf88ql3t3I
         WhVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfFn5uoVWV9NCx/LQuDCbS9+OXEsw9zB0iend5vrdu6pEwq+EkLfZvautwojjtXcCPftY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxLAT3ZNExN8Lk2ZiyvB1ijnrKcdfsxriWuwVjOzTyh29rqBKi
	ERqq04EzVI4GXG9WTmAwN2/7AisBnB+gqcxyg77/kUq429+rpEtccshiqNjOQQvN
X-Gm-Gg: AY/fxX4r8e/hNgY/CY46Op5vdM66k5UvY1oJEWttxgB56VPP4SaL4R9GSWQfp/NiiXr
	la5PcHXzbBb0GAUeNwB/lbyFXilw+8pMJe2eAnfEjzEtaEx9xURYkA67IOKCh2xgsILBbdoUofm
	9XHPzkgaFeVQYYSTgzABdXXeIYAp1iISlqEFM4+mo15mEauODPcH6ezH5l/be0CpjTmC5VZdJ55
	Pza8+dxQb1DaSFzLdvqh9TkK1NQHDaNEEl7V/LboTYoYOOEjLtjbT8ewcajTAwEon2ETV8r5nNT
	PdSNq3Zsxhlu1PA9W8Y3MpasdivUjAn+NilGfkLnsLYCk3GmfRDvXU9d+J4DnNSeDE1iOC+N1ch
	Ij20CYSA5uL7oBqSEjJHcsQlD6vDwaFhTIBRJvoJh0tH/F1TVbvF8IaRuBUjrmJkqrREumdxg+Q
	SIPKknZ8tojGm+8P4Y2eSCUy7PnCUdFSquKuTjZcdSll6VGDt/enXRyG1X80R8fiR4Nmc1
X-Google-Smtp-Source: AGHT+IFGGQhdFqqEw66GD17W9BhJPFgwvjZFIAkNSNr0qi+fOF3HGslk3VyW8kfjSH1PvmjrdBy7Xg==
X-Received: by 2002:a05:620a:2914:b0:8b2:62f9:9fd8 with SMTP id af79cd13be357-8c090501d58mr4227534485a.61.1767031748655;
        Mon, 29 Dec 2025 10:09:08 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096787536sm2437172885a.4.2025.12.29.10.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 10:09:08 -0800 (PST)
Message-ID: <01d09293-4b60-4a47-9350-73b1ff796c9a@gmail.com>
Date: Mon, 29 Dec 2025 13:09:07 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] show-branch: use prio_queue
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Git List <git@vger.kernel.org>
References: <70ed751e-fc3c-4cb4-a4fd-26094a9f622e@web.de>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <70ed751e-fc3c-4cb4-a4fd-26094a9f622e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/26/2025 2:44 AM, René Scharfe wrote:
> Building a list using commit_list_insert_by_date() has quadratic worst
> case complexity.  Avoid it by using prio_queue.

Excellent idea.

> That number is not limited, though, and in pathological cases like the
> one in p6010 we see a sizable improvement:
> 
> Test                      v2.52.0           HEAD
> ------------------------------------------------------------------
> 6010.4: git show-branch   2.19(2.19+0.00)   0.03(0.02+0.00) -98.6%

I love to see improvements like this, even if the construction is
unlikely to exist in reality. I do think it's likely to be valuable
for some large repos with many parallel branches.

Indeed, I tested this patch against a monorepo with lots of merges
with hyperfine, getting this output:

Benchmark 1: old
  Time (mean ± σ):      3.303 s ±  0.146 s    [User: 0.058 s, System: 0.069 s]
  Range (min … max):    3.162 s …  3.631 s    10 runs

Benchmark 2: new
  Time (mean ± σ):     141.7 ms ±   3.2 ms    [User: 30.5 ms, System: 93.1 ms]
  Range (min … max):   137.5 ms … 149.4 ms    19 runs

Summary
  new ran
   23.31 ± 1.15 times faster than old

> -static struct commit *interesting(struct commit_list *list)
> +static struct commit *interesting(struct prio_queue *queue)
>  {
> -	while (list) {
> -		struct commit *commit = list->item;
> -		list = list->next;
> +	for (size_t i = 0; i < queue->nr; i++) {
> +		struct commit *commit = queue->array[i].data;
...
> -static void join_revs(struct commit_list **list_p,
> +static void join_revs(struct prio_queue *queue,
>  		      struct commit_list **seen_p,
>  		      int num_rev, int extra)
>  {
>  	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
>  	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
>  
> -	while (*list_p) {
> +	while (queue->nr) {
>  		struct commit_list *parents;
> -		int still_interesting = !!interesting(*list_p);
> -		struct commit *commit = pop_commit(list_p);
> +		int still_interesting = !!interesting(queue);
> +		struct commit *commit = prio_queue_peek(queue);

Most of the changes are obvious replacements.

> +		bool get_pending = true;

But this is a new variable. Let's see how it's used.
)
> @@ -253,8 +254,14 @@ static void join_revs(struct commit_list **list_p,
>  			if (mark_seen(p, seen_p) && !still_interesting)
>  				extra--;
>  			p->object.flags |= flags;
> -			commit_list_insert_by_date(p, list_p);
> +			if (get_pending)
> +				prio_queue_replace(queue, p);
> +			else
> +				prio_queue_put(queue, p);
> +			get_pending = false;
>  		}
> +		if (get_pending)
> +			prio_queue_get(queue);

What's missing from this context is the loop iterating over
the commit's parents. Here's the full context here:

	while (queue->nr) {
		struct commit_list *parents;
		int still_interesting = !!interesting(queue);
		struct commit *commit = prio_queue_peek(queue);
		bool get_pending = true;
		int flags = commit->object.flags & all_mask;

		if (!still_interesting && extra <= 0)
			break;

		mark_seen(commit, seen_p);
		if ((flags & all_revs) == all_revs)
			flags |= UNINTERESTING;
		parents = commit->parents;

		while (parents) {
			struct commit *p = parents->item;
			int this_flag = p->object.flags;
			parents = parents->next;
			if ((this_flag & flags) == flags)
				continue;
			repo_parse_commit(the_repository, p);
			if (mark_seen(p, seen_p) && !still_interesting)
				extra--;
			p->object.flags |= flags;
			if (get_pending)
				prio_queue_replace(queue, p);
			else
				prio_queue_put(queue, p);
			get_pending = false;
		}
		if (get_pending)
			prio_queue_get(queue);
	}

The important thing here is that we are _peeking_ at the
current commit and then doing the following:

 1. Replace the current top of the queue with the first parent.
 2. Insert any later parents into the queue as new elements.
 3. If no parents exist, then remove the current top.

This replacement of the first parent is like a removal and a put,
but avoids a double-sift. That's a small optimization, but likely
worth the complexity you're using here.

> @@ -639,7 +646,8 @@ int cmd_show_branch(int ac,
>  {
>  	struct commit *rev[MAX_REVS], *commit;
>  	char *reflog_msg[MAX_REVS] = {0};
> -	struct commit_list *list = NULL, *seen = NULL;
> +	struct commit_list *seen = NULL;
> +	struct prio_queue queue = { compare_commits_by_commit_date };

This confirms that the queue sorts by date instead of acting like
a stack (if there was no sort specified).

> -			commit_list_insert_by_date(commit, &list);
> +			prio_queue_put(&queue, commit);
...
> -		join_revs(&list, &seen, num_rev, extra);
> +		join_revs(&queue, &seen, num_rev, extra);
...
> -	free_commit_list(list);
> +	clear_prio_queue(&queue);

More standard replacements. Good.

> diff --git a/t/perf/p6010-merge-base.sh b/t/perf/p6010-merge-base.sh
> index 54f52fa23e..08212dd037 100755
> --- a/t/perf/p6010-merge-base.sh
> +++ b/t/perf/p6010-merge-base.sh
> @@ -83,9 +83,9 @@ build_history2 () {
>  test_expect_success 'setup' '
>  	max_level=15 &&
>  	build_history $max_level | git fast-import --export-marks=marks &&
> -	git tag one &&
> +	git branch one &&
>  	build_history2 $max_level | git fast-import --import-marks=marks --force &&
> -	git tag two &&
> +	git branch two &&

These replacements of tags with branches does not impede any
other tests that use 'one' or 'two', but is necessary for the
functionality of 'git show-branch'. OK.

> +test_perf 'git show-branch' '
> +	git show-branch one two
> +'

Thanks for expanding the performance tests.

This patch LGTM.

-Stolee

