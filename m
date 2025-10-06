Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303E14386D
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761820; cv=none; b=EDEmkZss0n8yZZ01fvlAzPSdk83SzrpDO+H8SBDnc9ZqTur2lf8TjWkZpCdBNQmx6jgAnK40mxsyXZayTqSouKrP2Hyo7MC1A9tJVx4WbTvRZC2r3Du7ibfqP5tpKl2WclzB+B7I65AC45dqonHqA2JhXGW8ZqayfUqvpB5gSq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761820; c=relaxed/simple;
	bh=EyJ21Qt3OyemeolLpCfqLVW7LQbxis4PMxxtoZbBlUU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAH8BiLWLln6ghBipK29BlhEiLkh/1XfMQPrEcadSNANxGrmBlnUahAMtOWP2RtQoXAGVKp/HkHSnIeJC3iIAAQ99BHM3QeRxxMxqzVzw31az+/qjKSDAkRhmcyGtRzphdcFyqXPrqE1dXnx5DQnJHrwDjA/0MEfkTtsDhmUXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEdKgq65; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEdKgq65"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8fb58f2b820so3172850241.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 07:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759761817; x=1760366617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2qlmEamB8X96fwKDvkE6FTCNCJ6uiCi1AMIQ+Op7GLw=;
        b=WEdKgq65fRWBmacrduzRAqbPN6SafJFF2BVDhE2YhLwgTEV+NL1hHspd7omGY5LXpi
         aXLmHFShR2PaERAQKJ8JWA0SjBnZu3Cq/2HsG3bpJQhvZgHzapvcYvS/8YtpCJ0PaCZn
         Mxnt++0xJGNTYazjWeT8ixvq/VwXyrE1eN6e6jTB5aYA6cmWQcjj6UWhYfWne4wUvwVo
         TdWKpzygfdp0qebCkUzfBZIeuOcxiTa2svUMrn9e2lTKIMHXTJbjn5+yXHSpcs6iTXiU
         zaVL4SoWwD9EB+LpiZ1bpiZKLH+E5kiVFm9TMVBAoQqmbGQMZNFNo/Xvmv5C+c4nZuXE
         yXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759761817; x=1760366617;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qlmEamB8X96fwKDvkE6FTCNCJ6uiCi1AMIQ+Op7GLw=;
        b=ZrhOepsm58l9X1eXkyco1aZ1MqTLjrExmn/jIxV2NCbquZmy38yedis0HN4I1cxNCe
         U9112OE6TEI+HMmNm/yPXdhW7lIK+vBOhLGEIsvSyrMspy6bi4D9QyEUmZh4G4BC6I6h
         c2v50coAxnD/nqaJzK3mgdT+HyGIcO+sGT3Bkdoi2GdlvGo8RGuIQnK+FqSqZf4FYl9Z
         IUw4CICuqbuMAxGlPVM6daPIuF1USfecyfhmtiVHMxYIbvb7aR1Uf7MfnMGdkBJoilmM
         Es56iUoxw3XJawmIM836HGXTMuPp8S0i4qbqdFyrioCXC6uXeGrX/Rnoma4sBJDuNnSa
         kopg==
X-Forwarded-Encrypted: i=1; AJvYcCWKINW/JBIXoeFIHepItz6zviLsWvzHdRMK3upwydYpeL7ZhnhLTtUGtK/D/EwW85IlpRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBuUu6+VI9IvZTQSz8heVEvxvwtkyQ7YYQEaLfvk6D2KDibVU
	t8rp8S/aobOhPJMRVBqpQjkHNroEUNR56Gw0UzzT96pp+LGuPPAiVdlKvTkjDH9M86ls5im0PZJ
	JKKP7bwNf0X4iHadmxwMIg/GP+LWsrzI=
X-Gm-Gg: ASbGncuCKFZrsrd8SZcOm2fkGt2R6Mnn/eOosgQM6ISzu/8SxDuwEKZQKN+BJVqeUtE
	sv4smw5uanGV2QB1KICgG3ZW8qIet0ZsA1ZBjR7ay81w7y5QfyrFuo3hjxl5WsHJQnouiprP7CL
	BUnKjQyfU5ajRCkdJ2uMj2wskAGsrnUEO1yhL38PZ7SSVD1cu2Eo2xlM2DsLPXUXtAcdYLFGU7/
	dvEIyp6xlpFmV9uD55J1kkRMffUEg==
X-Google-Smtp-Source: AGHT+IG+AEo4cXGklln7QV8NMST6/C0Gd4L5bL8AoIVAgQjm/8Mj+BFigRjnphi0nbBtBIPEE4Kt5QjeDPma4XpUpAw=
X-Received: by 2002:a05:6102:6d0:b0:5a1:f09f:524e with SMTP id
 ada2fe7eead31-5d41d1131b0mr5096534137.16.1759761817252; Mon, 06 Oct 2025
 07:43:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Oct 2025 07:43:36 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Oct 2025 07:43:36 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pull.2067.git.git.1759750539721.gitgitgadget@gmail.com>
References: <pull.2067.git.git.1759750539721.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 Oct 2025 07:43:36 -0700
X-Gm-Features: AS18NWCNBElLFPodUh6k5ntAfhch8--z8F5pgOpKXEIcMkmyI7LnNEnmNl3CjHE
Message-ID: <CAOLa=ZQVZMNXjZzSDCc9SXxRuAhRbo7hc-F9RmhYap=ABWVxzw@mail.gmail.com>
Subject: Re: [PATCH] stash: don't show irrelevant entry count in status
To: Miroma via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Miroma <its.miroma@proton.me>
Content-Type: multipart/mixed; boundary="00000000000001f6d106407e7a1c"

--00000000000001f6d106407e7a1c
Content-Type: text/plain; charset="UTF-8"

"Miroma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Miroma <its.miroma@proton.me>
>
> Currently, when status.showStash is set, 'stash pop' shows the
> following, confusing, output:
>
>     ...
>     Your stash currently has 1 entry
>     Dropped refs/stash@{0} (abc123...)
>

Right, so your proposal is to not print stash related status information
when already running a stash command. It would be nice to note that
here, along why you think so.

Personally, I think it is important to keep this as is, because it tells
the user the entries left in the stash post the stash operation.

> Signed-off-by: Miroma <its.miroma@proton.me>
> ---
>     stash: don't show irrelevant entry count in status
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2067%2Fits-miroma%2Fstash-no-status-showStash-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2067/its-miroma/stash-no-status-showStash-v1
> Pull-Request: https://github.com/git/git/pull/2067
>
>  builtin/stash.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 1977e50df2..2bd4b7d753 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -705,6 +705,9 @@ restore_untracked:
>  			     absolute_path(repo_get_work_tree(the_repository)));
>  		strvec_pushf(&cp.env, GIT_DIR_ENVIRONMENT"=%s",
>  			     absolute_path(repo_get_git_dir(the_repository)));
> +		strvec_push(&cp.env, "GIT_CONFIG_COUNT=1");
> +		strvec_push(&cp.env, "GIT_CONFIG_KEY_0=status.showStash");
> +		strvec_push(&cp.env, "GIT_CONFIG_VALUE_0=false");
>  		strvec_push(&cp.args, "status");
>  		run_command(&cp);
>

So this block is run to print the status, unless the '--quiet' option is
used. So it makes sense to do this here.

Small nit: Shouldn't we add a test to validate this change in behavior?

--00000000000001f6d106407e7a1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f17fd1f100178b84_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qajFaWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0wzQy80dkdjcXRUMVh1My9SYjdqakh2bjAyb2R5Tgo1OU1jZTF6d3hv
dVpoMFlveXdZank5dHZHVEFEYkE0bndURTFEZjF1UksvMW93L1lxSEhKVXFmUkdET0F5enFUCk5V
dVZGQUVBVW9Dc2hwVmU2cG9QVjN6cEt3NFFUK09rRnpPV1F6OEhTTE93N0hZOGtQVUhTUzU2L0tT
L3czU1oKR3p1ZHlqTE1lV0dNczVNdkN6bmF1WWg2NTE1VGNpMGhMbFZ2SHV1anBSL0Nlbkthdk94
Mm1Qc1o2WFZCNnlWMAorbTlSSW5UVUpzbGF0S2F1cFk1dys1NjdPeFc4dFMzU3FQQ29KMFk2Ymxs
a1kwZDZCZWQ1M2ZLRlYvT3BZcnU1ClAxcWJmR1kyK29CSjN6emZuS05neTFhQ1hrczc4WFBFaXY5
UGxTR3FWYWZ5VitDYjlwb0VhMUJXS0F5VS9Wc3gKbmN5azZJc3BRQUpHY1p2QXBUMUdkeTU1R05N
a01BRTNLRlR2a1IvN2p6NzBBRm5HRkNpTXFucUpoaEdXSUFZcworS1MyamF0L2NlcmVUaHNYVnV3
UDFxbXFHdTl1c0RiM1ltd2h1Myt1TjlJcUxrK0Nxdms1Zzd6VmQ4TVhRQWhXCjhiUE9qazRhMHJm
c0dmckNyc1hDbVJ2eWVobzV6a3didUgxb1RuST0KPVVUd2oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000001f6d106407e7a1c--
