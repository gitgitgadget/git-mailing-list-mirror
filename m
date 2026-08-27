Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8206D4A2E15
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787860292; cv=none; b=u5YQ0U+g+dj16qS/fXDZvrvS93gUiOLssWbYycnOCd/urURP0MQkhHp/cinwiCVMdiXby364YVB6Ra7um05AHGQZzMSLaBOVbB1qIQ6xNZaOxGzI2PD/yACLOl++8EFMsAXGeBaVlSGMT1H0Dq+grX6SdJmSMZaNwAHXLb9GSlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787860292; c=relaxed/simple;
	bh=kUxWlgsEKQ68anxv42m2OfxZdB2lJWyclXEeL7apTuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dXKHuHRKiW+UTu+8RaDNX4+D/HPuEcwIZvoXKg/39S8PGasWHcJp7LrTaYKGD/Z3BAL3wk92BtlVedy5p2NxfJNjDhLZnNJsYJJVb7GTCGg7tx4XHn5cwtiu3SZI6Q1s2AqMXN3+JW83A4bermfYgnCPYFkCPlWkTooLCWfw9rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l9fWfBJ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WRscJjKG; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l9fWfBJ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WRscJjKG"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 66ED0EC0182;
	Thu, 27 Aug 2026 15:51:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 27 Aug 2026 15:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787860286; x=1787946686; bh=qEi/ZkztXy
	iUWsfrg4uZPGEx76oi75CEmzjnf+HBoSw=; b=l9fWfBJ15gUoeM18A3t5HFgReT
	poFN4UAvV9ZYl0Dw5gZGkct75oPCK1jBPILM9VlZL0j0AOEV4dIvUNA48XQ1LRxl
	QFYR4SjteQalUWX57smKPn6pv68ntgBu7pNE0zDNwuxttrY3cDAAWm80RUXFvxbx
	oqUwzkcmR957b3m2v2HkCBPhENCj4MYMfxVC8ZRA+A6+ddU/dH6OjOA2l5u9JxMd
	LTJ0T9G+0MlOJMYP3LMVzgU9zdxYzMtr6/XwvDQLjBtp8nqr11wzk9DGmeL8u0fT
	Qt9QifZ4PhsA5dVPLZqqKI3pyUxMFbLwW2gbCRu53ECEG9JKISc7RpXumvCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787860286; x=1787946686; bh=qEi/ZkztXyiUWsfrg4uZPGEx76oi75CEmzj
	nf+HBoSw=; b=WRscJjKGIxP6XoTONyE2EVXgaFpST8DrGl4uN2zEZMR+jASgo8E
	e/jdn6VOPt629QAEC908S+ctMBcS0e++gj9XDMUzINPR1xi3HtbNuENmy8AXYnUF
	WICOsiLN0CaO2+2D1ir7GBUKzYtuqTXiqFMix9pY4Wx1MBmuGb65MNk4yMyL7r3t
	OEosxYaU+bFY/aUScK2dVr8Teh4DDusezUC5PgWC35kvYo0iTA8iX1KXuf4IsFqJ
	+Vv2OBagUdzqus9EwQla4EQzP63WXVWD/hU7NVEHtNKMOi+AZ7SUD7jwdUEup8yp
	kvKCOQLdZsR09j/+bnBW3/RVNuE9r90Cc6Q==
X-ME-Sender: <xms:PpWQaqbTeSANXvWnhW2uIvhD-AgCcGXnksOGLoThVY0-5VPzZP8sxg>
    <xme:PpWQak054Ar9hGRD9XxTqd5BVGN9n8nJUnErr8nvSYoOLNHxcSJqNdWH0Pew1Zgv7
    Ztf0A_6tzLLfYKFPX2TnMy8xFOxWhdymFa6YbibmhSQKQDQI-kEgg>
X-ME-Received: <xmr:PpWQaiWcbeJs7xy5zRHSAMNUI7tAHNafBENBoLcpun5OSWB4DsQhf-1Hn29xUxIAM0Al0dxgYqOahcsj_gl10_0QsB1moO7QNw>
X-ME-Proxy-Cause: dmFkZTFunzUcT03Vi/S0xFv0xpBr9IgFfskCufh1aKULRqLOIQecDrt5hgQKfdrl+j8yeQ
    zSqb9OMvewRvwPin7+No4EWhXeNM1umieJZulDJ50RpZiZr1jXovlTrW0+Fr6WYcpQ2KC7
    N97juRs13eiicfMNM5jphrQhidtSiksz0Z1z5wK196R968hpWHULz4hKrTas1gYFutx2qY
    OAyw6yBSq3rdkdiDiULr1LlBP8SLxdcRVZzXLsGiZDAw5wGM0cIEUVy2T50AMbYQtSKWQZ
    l+mhznBm/xJgpUgDmovXcrNmIVKE7iXkmg9Qvm5yh3WcqWCqSWNHUJ4bY3acQay90MSHIk
    zQHBBbHhBPUM73vbfTBydjtMi3TGOjsyYuq49MTwHv8t8etGekCC9rhKKaRO/2JK++PBkT
    KNZ+ZR6NzwGwV+pvZFO4CD7gqBk9rvGXhiXaSXLKF0FLh5BSkVfjipO5q40jT8aXn/O4qd
    /igp1qKcnBHy/hPDxDI/Vti0CfNf/1lZeP+OkXUd4YAxARbSreBPESTeuGc9AB2W7aJrOQ
    5OMSAYyIuSYL4gP5r4zvkj0EbsKH189mFcy/2trGpKuiK6jE5i7dhzAsOjy0pWWWLSLvfu
    7FK8auUfzZfkrSJHbaMbms3HC8HcGL8/O8NyRO8VYsUvqo9z6t+8idai5qMQ
X-ME-Proxy: <xmx:PpWQamU929O0xyE9DHX2yB-JaQg4RuO_fSuNfwuAJoljsYwyBODNhw>
    <xmx:PpWQapdd_8b8bSXbVY_eoUXFbZQFSzkQCUmTZnPu8WyF9ieSgkA6VQ>
    <xmx:PpWQanUElmwYlz83D3lZwK2V3gLKUy3PDuis9i-U3KPaeURKBz9EKw>
    <xmx:PpWQaqcNkAPXXlRLQM6xvfHrPiGJvt-N_KxL0cY0NmCNXI0RoKcIrw>
    <xmx:PpWQas2lqJ5Ug48o0FlEwNMz0EKvZseXZHOyXYWH-0peNeoGk_DmwtaD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 15:51:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Hardik Kumar <hardikxk@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin: replace the_repository parameter in
 is_bare_repository()
In-Reply-To: <xmqqo6en8jof.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	27 Aug 2026 12:09:20 -0700")
References: <20260827-env-is_bare_repo-v1-1-aa99600dc213@gmail.com>
	<xmqqo6en8jof.fsf@gitster.g>
Date: Thu, 27 Aug 2026 12:51:23 -0700
Message-ID: <xmqqh5kf8hqc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> - Only update sites that do not introduce any functional changes.
>
> How did you make sure that the places touched by this patch do not?
>
> How do you deal with repo==NULL case in these code paths?

I guess this was a bit too short, so let me explain in a bit more
detail.

>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index 48d5251c6d..dbf4b4ffc7 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -957,7 +957,7 @@ static void build_ignorelist(struct blame_scoreboard *sb,
>>  int cmd_blame(int argc,
>>  	      const char **argv,
>>  	      const char *prefix,
>> -	      struct repository *repo UNUSED)
>> +	      struct repository *repo)
>>  {
>>  	struct rev_info revs;
>>  	char *path = NULL;
>> @@ -1187,7 +1187,7 @@ int cmd_blame(int argc,
>>  
>>  	revs.disable_stdin = 1;
>>  	setup_revisions(argc, argv, &revs, NULL);
>> -	if (!revs.pending.nr && is_bare_repository(the_repository)) {
>> +	if (!revs.pending.nr && is_bare_repository(repo)) {
>>  		struct commit *head_commit;
>>  		struct object_id head_oid;

There are a handful of uses of the_repository before the execution
reaches here.  But you left them unmodified.

The original code used to consistently used the_repository.  Here
you changed it to use "repo".  In practice, they are most likely the
same when "repo" is not NULL, so in that sense, this may not be
breaking anything, but you must ask yourself what the point is,
unless you convert all uses of the_repository with "repo".  It does
not help libification effort at all.

In general, builtin/foo.c::cmd_foo() are concrete programs that work
on specific repository (i.e., the_repository), and there is not much
reason to rewrite the use of the_repository to use "repo" given by
the caller which is git potty.  You'd also need to deal with the
case where "repo" is NULL (hint: "cd / && git foo -h").

They are quite different from other parts of the system, things
outside builtin/, many of which are general utility/helper routines,
many of which should be designed to work with given repository.
