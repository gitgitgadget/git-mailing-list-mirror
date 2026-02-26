Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD74A3E9F87
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119790; cv=none; b=E3Wxi85SD+LhE1IYhO+sy/ttXPDaj+tuOudwoSAqSsqXdLQyZkef1mWwDo4wHgbKORBwzihSmePDEeEcDp69NcDUyqw80pUs2Tuo5zS5g+UZu5mIJyhmU+sS38ISdJIoBg3sfQduBPa8aM9AmI9DzsdVxCgixhhJkqdnaYvFRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119790; c=relaxed/simple;
	bh=f9oYWkullBN5mBWzQgMWipanQyxPbzo+lGxlrXzwb1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1Sa4nkbvjADKLVhRXgRZDaygapARyf8b4NlBLh1mRZYAWXG8r7YvfhF9JXqJfPVKi3qVTH2KLdlE97lW0saGuYdBZW5AzEamprsORc+JiaTCdQyCtl+jIsl9UJxQGQhfAb8RSjYGQ5oWFUCECb7Fn1izV/23w6zkGtZqYi2w1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1cunwng; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1cunwng"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899a2f4cdddso12398886d6.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 07:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772119789; x=1772724589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xYPBXw4QvDo148gBfZ0qZqCgnihnpHOr5RkDzXBoPI=;
        b=b1cunwngmyznzeQhe2JNVlatrbYCq9KaNkNx+gAPT8a5N31Ydy5BzP/P2maAAcwKLx
         YMYwGnFJHB+8JBIzD1AssYyymNFUZJEOol8vBg/UkUYnK6qXR18QI311ejU9wFXjgKHP
         X/F9wnV+NYgBhjia2X1q/G3Y14TBp3dSN71Helyi81SQpdHKxzYPJtJ33y/E2tgHc7k/
         4imO1WGOBxHH6hlRfVKjNr+V/TrUI2KFMA7ug+mjrvzeYY37ghFniJ8imkwpI5cEM9Nw
         ZjmUOJXr1L7bt3HcqicLPEt+utO1gLFHjzTkD/BcwENUvfHO2RIZsx0jpRnUIKHfRo2O
         3BEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772119789; x=1772724589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xYPBXw4QvDo148gBfZ0qZqCgnihnpHOr5RkDzXBoPI=;
        b=P3hnOWiNN/BVE14GKx5gzXGqxDTp8o0xTQgNxYcpeEhatGtXyZYk2SsKKb+JrR66tX
         ioMC+j6DUnffKvdNwMuEj30icFz5BK6muehW2lvYv7CXm6McWtQv+UZ0WiDuj1+bTajH
         M8TdUdn+HaAbIxSgbNnkb3un8e+wYZiX4pDDOo+hFajGdQ2OGVeoR9hAG8aZ11r7INu0
         ifssYoehbjRRWRZS75QyarZd3jOOsDCJeLr81Hwu6GXeub+Kab2ySWU7YIbObBbIY5um
         Wq9tkyPZMQYUtchK5JU2Y0U4SaUIG4sWVQIEpy9duXdN5ObBh742/FdO5X0VCTWC8BKr
         ItKw==
X-Forwarded-Encrypted: i=1; AJvYcCWuXwL5GFBDwi1IAi4TAuSJS2X6EM9rsYaqXSt1U9xVJEPJIa6g0kE//pB/GoqGgbJj6kc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+7MO+U9YU7o8a1BkkXKB2ngmZ7zw+0pl9KLDv3f21XlzRbw9/
	qAbYRjIKfMbgKdLpUG+GNH9gMjpj7KJforRu9ZNc7IXjYeVCgp/K68BB
X-Gm-Gg: ATEYQzyRYcbsH7dGOSm98pTrkdOOHaJ+wnLsFjzdpHxc7aRk+JIik6wZucNsesauBKS
	bcQ42/Dp8oAmreeuJpfVXT/SPycRDZL+7hTyshtqhc9saoC9K+I70C5zIhbDmWiFbMlV/bSBBxx
	zYB1/X+aU4j2Vxz6TYUuZSAVBj6yR0Nbs61WX7InDU2dDBV0LNETBUP4KjOtfU394n3jNbDjGwM
	yzmny7KOFHPslnp7Rc5qxnHidSRkZY9WtGvrRCrAbHV8aBtOtcQq9NZm2oA2XyPf940Y4pWd51p
	IJfhXDA0d44nWAO66w8RZEeHsS2qiN44N8XOmaVeBq/5I6Z+ZOEjAlP9P3nK2Vwg47ZW4tAEyEN
	fuNPzB77Npj+diaw4SZ5GFlU+Lcue/blxp+JTtzJuwaTo8nMBE4CvH7sEH47SimDH31jI2SEzL+
	ox7Mxuv+WkCzDrK3fYezLJp4uuOleYaW9EYv5fX+jfBeVufOWy86gQQ4Gm5+OrpJBCbmQzgXQ1p
	CfJpw3m
X-Received: by 2002:a05:6214:29ca:b0:895:73f:db47 with SMTP id 6a1803df08f44-899c1f00ba5mr70084776d6.48.1772119788615;
        Thu, 26 Feb 2026 07:29:48 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7159b44sm19350316d6.9.2026.02.26.07.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 07:29:47 -0800 (PST)
Message-ID: <08c6e203-3444-45c7-9bc9-cc2590be30c3@gmail.com>
Date: Thu, 26 Feb 2026 10:29:47 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] for-each-repo: work correctly in a worktree
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, fastcat@gmail.com,
 Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
 <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
 <4e3f4aa6cd36f779c6c1d6b4f30bb68ed807b9da.1771968924.git.gitgitgadget@gmail.com>
 <xmqqv7flervq.fsf@gitster.g> <eeebc30a-40bf-40ac-a16b-ca5e128c3c01@gmail.com>
 <20260225131344.GA2139176@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260225131344.GA2139176@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/2026 8:13 AM, Jeff King wrote:
> On Wed, Feb 25, 2026 at 06:44:51AM -0500, Derrick Stolee wrote:
> 
>>> Looking at run-command.c:prep_childenv(), it seems that you can pass
>>> "VAR=VAL" to "export VAR=VAL" in the child, and pass "VAR" to "unset
>>> VAR" in the child.

> But I really think you should consider keeping config-related variables
> in place, as prepare_other_repo_env() does. Otherwise something like:
> 
>   git -c pack.threads=1 for-each-repo repack -ad
> 
> will ignore that config in the sub-processes (whereas it currently is
> respected).
> 
> And for that, you do need to loop yourself.

Great point. Here's another attempt:

static int run_command_on_repo(const char *path, int argc, const char ** argv)
{
	int i = 0;
	struct child_process child = CHILD_PROCESS_INIT;
	char *abspath = interpolate_path(path, 0);

	while (local_repo_env[i]) {
		/*
		 * Preserve pre-builtin options:
		 * - CONFIG_ENVIRONMENT, CONFIG_DATA_ENVIRONMENT, and
		 *   CONFIG_COUNT_ENVIRONMENT persist -c <name>=<value>
		 *   and --config-env=<name>=<envvar> options.
		 * - NO_REPLACE_OBJECTS_ENVIRONMENT persists the
		 *   --no-replace-objects option.
		 *
		 * Note that the following options are not in local_repo_env:
		 * - EXEC_PATH_ENVIRONMENT persists --exec-path option.
		 */
		if (strncmp(local_repo_env[i], "CONFIG_", 7) &&
		    strcmp(local_repo_env[i], NO_REPLACE_OBJECTS_ENVIRONMENT))
			strvec_push(&child.env, local_repo_env[i]);

		i++;
	}

	child.git_cmd = 1;
	strvec_pushl(&child.args, "-C", abspath, NULL);

	for (i = 0; i < argc; i++)
		strvec_push(&child.args, argv[i]);

	free(abspath);

	return run_command(&child);
}

This comment details my findings from comparing the list in
local_repo_env[] and the top-level options listed in
Documentation/git.adoc. That's how I was able to find that
--exec-path sets an environment variable that's NOT in the
list and we want to be sure we don't set it.

Should we add the comparison to EXEC_PATH_ENVIRONMENT as a
precaution to make sure it's not added to local_repo_env in
the future? Or is that too defensive?

Thanks,
-Stolee

