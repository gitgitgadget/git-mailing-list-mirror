Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB745158219
	for <git@vger.kernel.org>; Fri,  3 May 2024 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759248; cv=none; b=UijW5xLlbgi9TgESW1qP+mbcJPxDzsVkN5AMytOFYB2KNl+YSFH4xFK+jb8dz/f6S3G77qMXyIYQ/dswg1RH+rv5eC3CgphTcL0eNo0bRhy1o5MNd56g/66K94U3baWkNAbg9z7JLC785lZXLDOOk/il4RxMquubeecYrJ4ggTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759248; c=relaxed/simple;
	bh=l0LgNwTqtdhO900hWY8nh4vxw4fEE6zvkyan9mKBKjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lon3sUbn4p4EzobWLA/ny1mdd6xyU9pOU5SIUwIWryxQ/goFNAL8QlB6VZQxJeRRiyenvOjyLOiyuzlWLT6lqxoZCLIdt48Zfw0oKksXfjYcy3guXX9hphSjl63ezdk9bvQ7wt8KTsKuOXBmLAU18xuQKuAKRfOSQ9OmY74gn94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KuOQtnlW; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KuOQtnlW"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BA2172ABE2;
	Fri,  3 May 2024 14:00:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=l0LgNwTqtdhO900hWY8nh4vxw4fEE6zvkyan9m
	KBKjk=; b=KuOQtnlWcEJyXxxSO40ywp+7JGzgwd0ZyLxAGLB0+IQBWdk7o5oWQb
	I277elSFcXVKui/3/9qZKord2Z5UQ37Y1lngdEDgLy7TvuGE3pmAYJfEV/xxtUsj
	GyW3v5PeC7iN1CxAk1J3cbxHcr0Zk+5QAC4lmXm+Wo8PYbAWehqNQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B15212ABE1;
	Fri,  3 May 2024 14:00:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C236A2ABDF;
	Fri,  3 May 2024 14:00:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: James Liu <james@jamesliu.io>,  git@vger.kernel.org
Subject: Re* [PATCH v4 0/3] advice: add "all" option to disable all hints
In-Reply-To: <ab604f4b73eab1d9aae4e2a20ba0630e@manjaro.org> (Dragan Simic's
	message of "Fri, 03 May 2024 09:31:04 +0200")
References: <20240430014724.83813-1-james@jamesliu.io>
	<20240503071706.78109-1-james@jamesliu.io>
	<ab604f4b73eab1d9aae4e2a20ba0630e@manjaro.org>
Date: Fri, 03 May 2024 11:00:42 -0700
Message-ID: <xmqqjzka7p2t.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0F8827A2-0977-11EF-BDD3-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Hello James,
> ...
>> Range-diff against v3:
>> 1:  55d5559586 < -:  ---------- advice: add --no-advice global option
>> -:  ---------- > 1:  ae3f45dadc doc: clean up usage documentation for
>> --no-* opts
>> -:  ---------- > 2:  1b0019026a doc: add spacing around paginate
>> options
>> -:  ---------- > 3:  31e73e6c0e advice: add --no-advice global option
>
> Just a small suggestion...  Perhaps the creation factor needs adjusting
> for the range diff to actually be produced.  To be clear, I don't mind
> that it's missing here.

I see this happen to too many series I see on the list.  There are
cases when the user knows that they are comparing an old and a new
iterations of the same series, e.g. running it from format-patch.
We probably should use a much higher creation factor than default to
run range-diff in such a context.

IOW, this shouldn't have to be done by individual users, but by the
tool.

When I do a post-am check myself, I often use --creation-factor=999
to force matching.

Perhaps something along this line may not be a bad idea.

----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] format-patch: run range-diff with larger creation-factor

We see too often that a range-diff added to format-patch output
shows too many "unmatched" patches.  This is because the default
value for creation-factor is set to a relatively low value.

It may be justified for other uses (like you have a yet-to-be-sent
new iteration of your series, and compare it against the 'seen'
branch that has an older iteration, probably with the '--left-only'
option, to pick out only your patches while ignoring the others) of
"range-diff" command, but when the command is run as part of the
format-patch, the user _knows_ and expects that the patches in the
old and the new iterations roughly correspond to each other, so we
can and should use a much higher default.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c | 2 +-
 range-diff.h  | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git c/builtin/log.c w/builtin/log.c
index 4da7399905..7a019476c3 100644
--- c/builtin/log.c
+++ w/builtin/log.c
@@ -2294,7 +2294,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (creation_factor < 0)
-		creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
+		creation_factor = CREATION_FACTOR_FOR_THE_SAME_SERIES;
 	else if (!rdiff_prev)
 		die(_("the option '%s' requires '%s'"), "--creation-factor", "--range-diff");
 
diff --git c/range-diff.h w/range-diff.h
index 04ffe217be..2f69f6a434 100644
--- c/range-diff.h
+++ w/range-diff.h
@@ -6,6 +6,12 @@
 
 #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
 
+/*
+ * A much higher value than the default, when we KNOW we are comparing
+ * the same series (e.g., used when format-patch calls range-diff).
+ */
+#define CREATION_FACTOR_FOR_THE_SAME_SERIES 999
+
 struct range_diff_options {
 	int creation_factor;
 	unsigned dual_color:1;

