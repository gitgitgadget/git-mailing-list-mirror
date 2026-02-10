Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8DB2B9B7
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770701627; cv=pass; b=LepWEFhqqafV/pwVt61HmM8xDiSwmJ3yWEswfXm7PVNEcFS3kogtzl+qiXDwB36eM+ca61lcapfNNUSD5pdGdfUA42IcziRQiZumon8OG1Ecygkj+JFcq3Pya7epsd6XnK/tXjE8gSLc07mh9bZRmQUlg08XcyJ51/4VhTG/Yss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770701627; c=relaxed/simple;
	bh=AhHOcWUMMRvLA/w04cuA2W2Cu1fNBzPUlH/YWONVww8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nov+O8zP/y3d60xwYRs3kDuSwg9mez6fyasfkAXjai/pYuRVOHTIjAbHwsomF8CSnMjQwSPnc8DsmjYvO6QkObNaOHvGmFj0En92vxsQtETKhWNELiY0GEHTm1+kioc/FkYpWPNw7hwPfhE6rOY9hADYTkcWHVbtyO/999768qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQhzP53d; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQhzP53d"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso1979834b3a.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 21:33:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770701625; cv=none;
        d=google.com; s=arc-20240605;
        b=bDJlYe28gBHjAxtbjGrk9PRFo6XViZMWM932miZchDIGow2pWlt6haK4zMFWb66LL/
         TJXy+ibGHbC29WWUwhgGpdA+fCGiUwMth5jBxW0Bv7wHTG8yVjkD8uO53OIrOcVoY7ya
         0PJv+nLrVyxD82Fqi05mt0CD6sHvmp/gj2561UdYhQW1p4xUI6XX3likcYd4r8ddVdcr
         EtQJOMqF/9omWbo9ZY1o//H5/GjbTGLXJYdiRKxlQLdGew9tvk2y25UGYKpd68DrI0sP
         O31ASlXL86gu+qKarwG0yByXO0a3wAVesVseLyBllEq5sNtT0ZifYSIfLIYg68AYA+4k
         ky0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=AhHOcWUMMRvLA/w04cuA2W2Cu1fNBzPUlH/YWONVww8=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=ctQVGb9GI3NUsA3HzumZqVNCDu2rIdgBC63GnDRqF9FqUMrYOy4Rvo1RbJ/hO/NBLn
         DgK9xCe5Yvqn9qANw23IltM8xdAdtv9hrfqemGBbdxs8ulW3OON3ku9jH0eBo5+gYxXn
         704ZC7HFjO01i1WLK0qa2r1LVoqGKIYYwCctw1S/hJZSiWCeX8fizTGa8TbpfDnc8mrE
         gar9LFovjAVZrE/8NqU8JkTKf6O16tlTvV0uAyGE2dNYwjvbRx2t2jCUeMHdkcsSGSwn
         nQM4hreSZphI+vdtlaKIeJZQUhDZXZG7/BFCjaEokWFg+CrGjz6T5m1W0DTlpKgJkfP+
         pSTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770701625; x=1771306425; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AhHOcWUMMRvLA/w04cuA2W2Cu1fNBzPUlH/YWONVww8=;
        b=jQhzP53d1agX7xkKS0kLSDmqmIdSGZH+ofwTROB5beR0cJSzigSF+lXLk1RHk3zGTT
         tQ1k/Lx1dSx5sFg6uPkCNsGA/Ty4TKXFwbk0aV+UMPQM0jiwBBZvy3o07JFh8RRwwUaj
         mnOeGT1y8T6SgWz80XgIOJUmesYQibT52DjQ2NUq9l+g5BRjuMxm6mD1fY9ilCwW8qhv
         mMwEqK5cBu2LFBvv6Aw52dr8yE3IOddLpeJlmoBK+J+nGyqU8/bZ5HK55VstQRoYQUcO
         2Xr1cpORY+jJHS2+DTYlRddFVwBeSAV3PSeJEDmes0qdXnZd7Oc4/qhmq3UfNGjaYq0/
         y2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770701625; x=1771306425;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhHOcWUMMRvLA/w04cuA2W2Cu1fNBzPUlH/YWONVww8=;
        b=m3AUPgm/Y12jyMZRqrApgDsDa+My96MnDfpuhcFxKWPlW7Hz8/+MMhzrSlOCsb4vmb
         b0sQUdXeprWiRshVdjkEtOEkKwWtT+2lAyDcgdP1bsbsDq/wSEWyy20Wp747UsrQun3p
         bsgns4yvJfXcM4gAbO6nI8GfyhTdopAAfv3ndO71Feqd/3ZRZQOAgtQnUgA2kQNUqO5T
         C7pRaxv1nqxkxegGHR4aoJV8oA/wWoroUQkn67Y9/RoSvVFj6NZa7WmM3kvqoh4XdmFs
         31oDAGF9nByyIdFJ1n37PYFB7o9ifQIl5Jo9IUrilCbf/QR+yJ5sP8gxmGoZGCIhLKM5
         T+NA==
X-Gm-Message-State: AOJu0YxUTOJxK6anMb4UspzS88vi3cz2HRFXWLdhnktyYYzv9oB+sQdk
	CDrUCVmKrsyjRhCKYBm7fLQ6SBATrrmvTypGVSKtwj00FS1fWZqil5DXj0u+lWSAFASER+tPC18
	TrxVzO1AjciyiH65yypZI0qd6NkFyZn3l5Orl
X-Gm-Gg: AZuq6aJLJzfuImqF0zirpNToOlAf1+8fSJqg2ggzp6pYO6kHPzUZFcvKBS5ifCbCluG
	GvMNAGzfLqErRi09sH/GLclmpjB6HLNOU2HOntKX6RsGoiyECmJH/ALj/2RnFHzSV/wR+1xcjPW
	tjt5crds7SvfuEeND/7Lz/GKhbmoMv3RiAUUof0a9dtZUM6cQdyTYen3f2KJiiqmyTB1wrD+cnC
	VFtnYgWQM5SGcdKmAu9FbkRKRsRjuNnFK8lYGH4qlIRUwWVHfKzjgC5Et/TXahZXbzsJl59Bqoj
	yS5LxQxNmTqoNYUxUVnRHePQ7LAFOFwenZ581Q==
X-Received: by 2002:a05:6300:2211:b0:38d:e87c:48ca with SMTP id
 adf61e73a8af0-393acf53eb9mr13104648637.1.1770701625534; Mon, 09 Feb 2026
 21:33:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tyler Breisacher <matrixfrog@gmail.com>
Date: Mon, 9 Feb 2026 21:33:33 -0800
X-Gm-Features: AZwV_QhPd7xXjRTIRkW8hTU1uvwn_7hOeQWwn4LnhFcR73jliKj6SdyyQJfQM8k
Message-ID: <CAGf4dO6QQ+ZG0iWqOY4StM-_UfmH2rZsBjFUcv0ziK5qvbkTHg@mail.gmail.com>
Subject: git fetch --dry-run can modify the repo
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Interesting bug we came across -- or at least I think it's a bug. In
any git repo that is not a shallow clone:

$ cat .git/shallow # "No such file or directory"
$ git fetch --depth=1 --dry-run
$ cat .git/shallow # Prints a git sha

I would think no command should make any changes to the local repo if
--dry-run is passed.

Thanks!

Tyler
