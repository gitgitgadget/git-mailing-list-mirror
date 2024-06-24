Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0092F24
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226605; cv=none; b=U0mKLQTxuPA6QxQ2+1bbPMzPvLHbkBZL84C797tT2kxsHleVhxY0R383cqGYmpZURAuxo/tf6bEOP0CsYGSwKE2ltLV2hXiWL8c9syizQ4R83R1z+IxI4YZtRdjAK7PEmswrkr8iD1Bp1GLKeyNWsU1toy/Ko70p95hVVg2fgN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226605; c=relaxed/simple;
	bh=+3tubUy7nXHuB6p2w61Eyx2GmriSzhVlX6YEeBFAAgs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxXinvdzBu/KibYxW1b55tyY/0ol11adInOPzntT78TTikOGGtpIgyqC0vPFAbsl3t0OJAHRAb207K77NxsRVoSEiLljNd5CSmIvZCFZqaYicX2kFz27IV3RakHd9wTA3S6iOgnMra9zLIPxZMzGiUZEQ7bKCKpZqQVibXwWzlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=df30ZWLk; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df30ZWLk"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d21b3da741so2270291b6e.2
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 03:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719226603; x=1719831403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zN/gx9TLHE0HEe6+gbLBqezr9l2KcVvjOJpyJiLeuts=;
        b=df30ZWLkqZDn2TYtrQ+m+MHHfaLZpxxHUuNkTuCXTk0nilLwNgpe2g6xkFR/AZ7qNm
         yJecDAeqXVu5UkrNziprQVYzu+jXefQqehFfpCK0uJWbR9hEkb74V3IeABaszFe+Dtsk
         K4/EadebMNssfNFq/P1umnnZ9bqM6wq5EY+iyPNSrwFr351KtG30J92MsSXevoDw6qHA
         x0bE73RJ34CPpp2HcSQpSpnrDMdlUyRQfrxhjI0g9lXeK4049S9LsiXDZvTfDggQWJ7X
         9DjCzm833rdU92qzt5uj91DvLdlZztIvGkRkd2aXcj+d7c28Ku3y5c89mckWE/DooOaG
         UQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719226603; x=1719831403;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zN/gx9TLHE0HEe6+gbLBqezr9l2KcVvjOJpyJiLeuts=;
        b=tAf64J3TW27ir13aBAekmeP2okkTBe04oCnMk0uMVALvZ9TSQpV/gq4WVhVhh0vBNS
         81B3RJcf885UqSJ5xuMh2mdHACWppD/dEdAfFnYOvLWfGPqj6noP4M8FYVA4Ug2Wufkv
         WKzbcs5pbVcO2Urr3dQ1IEISFio5g76Dq5Loi6OqhLmZqoS2x0L+jqptK9Y0ShSFdP7P
         t+JMghiY7u9XPgPvY+x1xSwSgYD2ykKOj/ApgU5muBjrTWDj1TiRJ/akOpPgx8VKom7R
         ChFlj6O7m+2ohnsmsviPATiv3QO//bWqysgEfN4HNRfPvJMV3a6wAb3KFEFtHMkdMjI7
         jyEw==
X-Forwarded-Encrypted: i=1; AJvYcCVzgxDDeMg77F3l4l9GPKX5565iuDKsSQD6mp7/ncXo5G08W7tAvYQrAUTYSgkFNZUqqAKJiX17hz/spY4zfgeVJ+w8
X-Gm-Message-State: AOJu0Yz9isG35jPaGImVdiPbs7auvEw0ZMLZpL93mFM6iOvK1cxN3ZFM
	ia2j6TbHiHUNNXbqZavEMOhzXJIxN2LBYkPmNzkL7ikbXHDAA9SdMkGxkaCPZnn+AN+NjdFIKRz
	vm8gWoPNuyNCc7ridJKlff87sXLHzLw==
X-Google-Smtp-Source: AGHT+IEH5ttUaDRhILs7RTtqd/xCjkYzJmnIsXywMCM55E+uPw+zM8x9y64f65k3+ruRNR6MEUNX/Ep5wX3vJq3tF+Y=
X-Received: by 2002:a05:6870:7014:b0:254:6eb5:ab2f with SMTP id
 586e51a60fabf-25d06b73f7dmr4635685fac.6.1719226602870; Mon, 24 Jun 2024
 03:56:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Jun 2024 10:56:41 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240623214301.143796-1-abhijeet.nkt@gmail.com>
References: <20240623214301.143796-1-abhijeet.nkt@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Jun 2024 10:56:41 +0000
Message-ID: <CAOLa=ZRGramQ3MdzzXzZ19yeUB_rQZPbZ3u=eA=T2SfV3nhYOA@mail.gmail.com>
Subject: Re: [PATCH] describe: refresh the index when 'broken' flag is used
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>, git@vger.kernel.org
Cc: Paul Millar <paul.millar@desy.de>, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000f3eeff061ba0a2b5"

--000000000000f3eeff061ba0a2b5
Content-Type: text/plain; charset="UTF-8"

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

> When describe is run with 'dirty' flag, we refresh the index
> to make sure it is in sync with the filesystem before
> determining if the working tree is dirty.  However, this is
> not done for the codepath where the 'broken' flag is used.
>
> This causes `git describe --broken --dirty` to false
> positively report the worktree being dirty.  Refreshing the
> index before running diff-index fixes the problem.
>
> Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
> Reported-by: Paul Millar <paul.millar@desy.de>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/describe.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index e5287eddf2..2b443c155e 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -645,6 +645,20 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  	if (argc == 0) {
>  		if (broken) {
>  			struct child_process cp = CHILD_PROCESS_INIT;
> +			struct lock_file index_lock = LOCK_INIT;
> +			int fd;
> +
> +			setup_work_tree();
> +			prepare_repo_settings(the_repository);
> +			repo_read_index(the_repository);
> +			refresh_index(the_repository->index, REFRESH_QUIET|REFRESH_UNMERGED,
> +				      NULL, NULL, NULL);
> +			fd = repo_hold_locked_index(the_repository,
> +						    &index_lock, 0);
> +			if (0 <= fd)
> +				repo_update_index_if_able(the_repository, &index_lock);
> +
> +
>

I'm wondering why this needs to be done, as I can see, when we use the
'--broken' flag, we create a child process to run `git diff-index
--quiet HEAD`. As such, we shouldn't have to refresh the index here.

Could you perhaps state how you can reproduce the issue mentioned?

Also apart from that, we should add a test to capture the changes.

>  			cp.git_cmd = 1;
>  			cp.no_stdin = 1;
> --
> 2.45.GIT

--000000000000f3eeff061ba0a2b5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 357254a4ff8f2826_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aNVVPY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUE1Qy85NUdPR0haRE9XbTliREhVc0MrV3JYUWtFYwpmUS95azdSNkNK
Ymd3aXFoUVluNkFKL0xLSTZndjVqOC9Gak9pcGs0N0hDM3I1NWVjUExMc3hWR1ZySHp1MmE1Ci9t
N1RVZER2eFNWeUVlMUdzOTEzMURqdlhXT0pYYTRoQnRPc2wrQ2xZSW5CUFhrK1JvR0ppWXNKcnNW
UVpzUFkKZGNBbjV0YTR2S1hEbVhsc3l0SjRnck5zNDNhSUkxTjU3SFJZeUVRMnVvcm91cmpSSkIz
SytOV3JaTlRoM3krYQpSYUFQa1NZS0wwZi9OUHFsTnFDaXZmYzZSRnkwNWJOamsvMlEwYi9ua01O
eXpvS2Y4dWV3c3RvWlUvaGE5eHFSCm1MQmFKVHZUaGs1WjdBZWNEZXQ5YUU5YytLa0cvWjl6OE5z
R0g5elZwMG5yMUo3WDdVOEFTcmJ5MVNFQmZ0VDYKTWs4TERIbzl6TS95ZmFWaFlOU0orSk1UaUxQ
MzlQWWdaazVDb0hGUjlWRVZyeWJPRU1ZdWtuRjhONzVMMHMwawpiS05memZZRnVPandmM3JKWjNx
L0dnRFYxb3hEYUpxRVoyTTlHektKc1hVRmNKYmlVQlgxSjI2SXJEeHZaY1NXClpBOXo0cWR6clFm
YStiK1RYUHdicVRSQmwxemRJUUNmR3pHREZoaz0KPXA2VkMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f3eeff061ba0a2b5--
