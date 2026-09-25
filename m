Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3B03806CA
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369609; cv=none; b=ClBoIh3I2mwQh+Br/z1Qyb5Qrv9MA6f3W8ZaDvU9RwkCO+nUkMuqndjFUZhzGRYF7hZlk/MiR2lieiNYZ6PLHHg7GDKb8Fyt6S5Hu0qjTxeNUswcZNigMZryxSousJuUAnhVCgfe0zzsQL31LY+I9yCWyrXc1YKalg37fzlMmx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369609; c=relaxed/simple;
	bh=GoSvvhDMKzhH8NBSKbT+ZDuBwh5Zr7hicE72H6Fy++8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcdmqAa2QOG9uFsd8HaaIk+K9fXgTo+9dXkiK0kMRe+7zghXqxWRH3hNPPb4nWkqogaiERLOBdHJPDOL5eFuEqelMhtTogQhgOgpONwvYOoWEEAnFjXV28fcdQWwTWyJrjHoceFSrruNSn9/PuwL5LD5K/0BvfOcjjA24BWQfdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=a3FiQKSn; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="a3FiQKSn"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-7f4f0d37f93so990472a34.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1790369607; x=1790974407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5vbIUxRkS7kkG0uyI5uADf+qST1/bgM5ybNPnq/pb4I=;
        b=a3FiQKSn8L10sHc8EnjviQ5yWRHKfjBnMb3tBdEp6X0cx3wxLg1bqi0yMzw9EMSFTO
         a9XeQIEUI6FWCN+0DUatc4WcuHteBP3CYxjw4qZ5g8aHaupyerenUXoFEI0AbeOMgkir
         o/yoH6Yg9mf7l2OLUri+Ey5XXnSqryIQaK8eDBVR/S6JXpSQCmKqI82NgF72gGe+ertN
         SnPrWL6Ilnvjh46a7naBxpgeQLm5pwInFRjCkive8+tENp+t1+y71sKhyNCuGke1RazG
         WFvjbVQP8Zx1DrLQWbmJygpoR3c+dc3R5Y0iJtCeWd2Fg/FKQqTpb6iv2HkWxTinngSW
         1bgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790369607; x=1790974407;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5vbIUxRkS7kkG0uyI5uADf+qST1/bgM5ybNPnq/pb4I=;
        b=zsO6jT1sAA8cRisT+JUqj6qCN3wBOVtygg17V4CgUf55JGxPHNDx51md1+KG674kyV
         psyhGSJJ5ce2PSZ3DhB+/N8z7v0tLfXliqgVkcoc5Yi1WZOWs4VWpETBX27aHaGogy3e
         D/pgMXBmYTy130GGUIxs3rjaqEcZVVjcAjVKnUuDXjjPLpqw2PDm6mItHL0xUDbbMrB1
         Xy0LiefvS3iTdAW+1xYc+E4zRTFPyCikLi4fFJ5mkMC4o4X0T9piexvEc//043Cp19Q+
         saOD/h7MU96O0D0KCW/0WHMbTUcUQAFeX5/Is6DisB8dTvgR3SMy6mWLpicDvL2gFhZq
         2H0w==
X-Forwarded-Encrypted: i=1; AKwUvBxxOTSlkO6Gxo5AUtPqS2gjpe6kjcFmT9TEAWYdEeV4W0yjgDqwNz0M1eMi7go7zzgmHCo=@vger.kernel.org
X-Gm-Message-State: AFuF++ls41Hd/pVGIdE4aCBYn56ak3rQjzctK6k2i9yBv9NTdrG9s7QW
	YgnLbRJJOGjps4nEHAojnc6sEUfKSFh86BDkIU4psEAi0YsaGMPe7nq0kHysihY/4ndi5afpkc/
	4uJLRi1c=
X-Gm-Gg: AYBFou0Vx8XXYP8AhIGnBvQU9aN9VT0b7MYF4fldwoivnxEyQkn5AoP+1sjmcgrUXWf
	ND8BeLdLnqqjT9TMsk5s4SQYS6e4UYTt7NBP4KNxQQAV+N5KjCBKZEqqdyB4u6CdTkRDW7nc3Pu
	a6vGC5cT8hOD8okH4upmcgsXp2ZzeUNhis5NRFS4/F+TqqdLX8/+D/6ZLfnHIB/FprSZOROt6jP
	cVa/d6ICY67iHD/z7fpzbeE3L57IAUNrX4bdumCsrV9wWznewt7xZhD1i3738Xbm9pqFFMCXiby
	QI17Xh8hRONuzX8d6k/hj9/o3tPHHDebfln7E3OItfEuan8OMBib34PGm3U+RPxmVlv+ZS0MUPD
	ZDKVJQZiU8blOMpqxG5RZEmJPPY1iA4hy6Z6uonDthyKvN/yl6G9mFWEH8lLnHhXftVnGEmN0V1
	wOeWvS33g/SAiZcHhujLR5oFGebTXK9Tngf/mlbx7bUT2t6iw6hIe8oIRFEe8rVGfJWVVWh9I=
X-Received: by 2002:a05:6808:ec6:b0:4c3:9388:db43 with SMTP id 5614622812f47-4d72c042991mr7418080b6e.9.1790369606721;
        Fri, 25 Sep 2026 13:53:26 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-4dbf849c0b0sm2764891b6e.11.2026.09.25.13.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:53:25 -0700 (PDT)
Date: Fri, 25 Sep 2026 14:53:23 -0600
From: Tyler Cipriani <tyler@tylercipriani.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Aleksei Sviridkin <f@lex.la>, git@vger.kernel.org
Subject: Re: [PATCH v2] push: fix --force-if-includes when remote-tracking
 ref has no reflog
Message-ID: <arbfQ7xF1NgDeilU@localhost.localdomain>
References: <20260903010547.85469-1-f@lex.la>
 <xmqq5x0mfgyh.fsf@gitster.g>
 <20260904124433.12840-1-f@lex.la>
 <xmqqzexx58hc.fsf@gitster.g>
 <xmqq33vn5hsq.fsf@gitster.g>
 <20260906165052.21780-1-f@lex.la>
 <xmqqjyowz9oq.fsf@gitster.g>
 <20260909065639.47316-1-f@lex.la>
 <xmqqv78dordu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqv78dordu.fsf@gitster.g>
X-PGP-Key: https://tylercipriani.com/018FAC02.asc

On 26-09-09 17:57:01, Junio C Hamano wrote:

<snip>

>Doesn't that mean it is more logical to use the default gc
>expiration timeout than year 1970 and in any cases using the usual
>gc expiration would not waste more time than using 1970, right?

I like date=0 (i.e., 1970).

Tested locally, in _most_ cases both give the right answer. But
date=<cutoff> can give the wrong answer in a subset of cases, and date=0
can give a slower answer in a subset of cases.

I think the wrong answer is worse, and I think the case where
date=<cutoff> provides a wrong answer is common for me (with default gc
settings and lots of old git clones).

The important bits of is_reachable_in_reflog:

- date: initial: either gc.reflogExpire (default: 90 days) or 0. Later:
   maybe set by a walk of remote reflog.
- remote: e.g., remotes/origin/<x>
- local: e.g., refs/heads/<x>
- remote->old_oid: advertised oid for remote ref

We need to find remote->old_oid in the local reflog. We can't build on a
commit we've never fetched, so we set date to the last time remote's
reflog moved to bound our walk of local.

But remote's reflog can expire or be empty, so it needs an initial
value.

With date=0 (and remote gone: older than 90 days + gc, removed, or fresh
clone), we walk local until we find the remote->old_oid or we run out of
reflog to walk. But local is also subject to gc, so by default that's 90
days without having to bound anything. Since both reflogs are gc'd, the
time difference should be minimal.

With date=<cutoff> is only faster where we have no remote reflog, we
don't have remote->old_oid in our local, and our local reflog has
entries older than the typical gc cutoff; viz. I'm rebuilding history
without the remote tip and: (a) expired my remote reflog manually (b)
have my remote reflog gc configured differently than my local or (c) I
have gc turned off.

But in one case, date=0 gives the right answer and the cutoff date gives
the wrong answer:

     git clone ...            # 1. files backend, no remote reflog
     git reset --hard HEAD^   # 2. start a rewrite
     ...                      # 3. do nothing for gc.reflogExpire amount
     ...                      #    of time.
     ...                      #    Remote never moves/we never fetch.
     git commit ...           # 4. Finish rewrite and push
     git push --force-if-includes --force-with-lease origin main

Push fails with date=gc.reflogExpire (wrong). Push succeeds with date=0
(right).

And nothing about gc config need be tweaked from the defaults for this
to happen---git gc can even happen (provided it runs between the initial
clone and the reset, since the reflogUnreachable prune is 30 days by
default). But in small repos, gc may not have been triggered at all.

So date=0 is always correct and should have equivalent in runtime in
most cases. And it neatly side-steps what cut off should we use?
gc.reflogExpire vs.  gc.<remote>.reflogExpire vs.
gc.<local>.reflogExpire vs. flat 90 days vs. do we respect
gc.reflogExpire=never.

Thanks.
