Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6C2288AD
	for <git@vger.kernel.org>; Mon, 19 May 2025 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689201; cv=none; b=cxO7wsso/iJT8mh5pwXxNLhXbg/+l2efXWWnRvfrKgjQbOQw0+A4z7ZCy1VGk+0JWcO8ZwdlhQyACdDcQ0lUbuDe7v1GChljD2hlV8hIWQVnJhagBha9bHzvQgXj23PZWswnXHqPzvURuJ/n6osulQuB1x3NIa7mQgraxC9n9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689201; c=relaxed/simple;
	bh=MAgUUwYX1noDCbVFPWk8EBoax+gJ7aEWToOv7TUC+W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gc2KK3ZXXZhn0nGdcRkdqT6LBB0caVqQL2yci4I+jRGiNeiV1I82JyGAE+gt0KPmR1t8ztL7SEFt5SGz0YNOS5QGTUHv08CWMLEGO3XfyOJvBn8fMazY4D9yMGWw5lP5pSlqrPOt/VrX3VIHiMaYFbiHWMAL90xaJd9AgcIWQWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjaiU4kD; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjaiU4kD"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-601a8b6c133so3238198eaf.1
        for <git@vger.kernel.org>; Mon, 19 May 2025 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747689198; x=1748293998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aR09pR4m/CfqpRP9wfotOETgf1l99zzNlVfw6po0L4g=;
        b=WjaiU4kDwEzGzbi0356ojWwGzgn9dePNiR6fbZKYN3AtfGEgSMoxREg06awj3UpU9M
         is904y2fgY+1sPfoz5JxOIuDpAegWh/G41HQWcmlFxN/m3rBKXt5kONyEHrsTgr/u+3q
         btR/d5cUt3ocpIJXTPiHYxS66M/K3N9Ah3a8Chg9PYV1vYC/QKhvTn6ipsERkubaLa/0
         hqCIJZdQE211uLkdFGNZ3A/ssEYu8fnJ58i70W3dXGhYTR3lWRHhiVIqd2kh+6wCZGpl
         JIZ+AiFt6X9S3FABxry6dMyyha4fjkS4Md8EA5jfPyMwVG2hk3Iv/1gl1vM1Xn+1PBVf
         e/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747689198; x=1748293998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aR09pR4m/CfqpRP9wfotOETgf1l99zzNlVfw6po0L4g=;
        b=ovBmnVwTrIifmEj1LYUK3a6yJD6vgMnxHBmLX1RlTLyB+JvDmg13TFPJ4D14n8/w1n
         AMP7gELrc4kY3un0i0AITMylYzVIEoHJiv5FJapJiQ9OzG/NR0CV2IId8BnejKZYyD+o
         +QCTUt6gEi0G9qajMcIa3t+qNtLhknzkY+WQ/wx59jdbhCK45QTpHGq/kwFhBmdqh6aT
         9I8ND9S+d4KQdXvQsWGy4pLNLJ8zMvSLMfwz2sKxyGM4VyvjTQK+e1IQb/zX4zR3Dj7v
         gP9jUli+GIU9uMI+ZoWPO+AyBk6+h+Z9zdMGCsMQcHaMR14KvHRMR5cUZagxEccBRcd7
         8HWw==
X-Gm-Message-State: AOJu0YzRbrbwM3gjVRfTFlH10BVJvzuoAH8uSGAHZYmbk+sID6zkjamK
	9a0Sk9+nrjMvD0+ggzRy6lNSyYwCp82e+m7HSx04rbHisuzxzMJqmhBt
X-Gm-Gg: ASbGncv8DFGu+5YdTOwTFyMILPmBPMCh7qIZVAFbSRcUhYt1weNgvEgLVGjzF84SpJb
	wt+I7afi1//0DTOzu6E/U8OVNg128BKpQseGi3GxfXe7nVVgiaQHMIVgNrkIBBB5eMC+C82kf4O
	wvJzrVaO/9BhINiUKLyxoL70htHQJzlcItGMNkTfVydHzh1m4hnjabnNuB3TUXXPMw7mvkoGgnb
	4dsUhvxEXVCkqhpsgJpmlB+DVcuWC/dxe88jWe741ih2FQjmU5aMRO86bdVntnoRyCTFKc6ieMw
	l10o/aN8G26D3IsGPFwsHpW5q6/D3uQKQAJ9kDv+k4Ji
X-Google-Smtp-Source: AGHT+IH6HfrmM0/ZqunQvfRxyln83yFhrEcugfCGCQiP+ZGw7ddv5wcgH5x+LOYdLH5wvNOJ03EDQA==
X-Received: by 2002:a05:687c:339a:20b0:2d8:957a:5166 with SMTP id 586e51a60fabf-2e39bbdd3f9mr7227247fac.4.1747689197766;
        Mon, 19 May 2025 14:13:17 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2e3c0b21fe5sm1914223fac.45.2025.05.19.14.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 14:13:17 -0700 (PDT)
Date: Mon, 19 May 2025 16:08:40 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [RFC PATCH 1/2] t5412: test receive-pack connectivity check
Message-ID: <g2sthtaz5u4zj56bc7clqpxkgcn6leqbbim3kvsvqsaxe2io5o@kmzit5vi7trh>
References: <20250507030249.4802-1-jltobler@gmail.com>
 <20250507030249.4802-2-jltobler@gmail.com>
 <aBtgCYYKPuowEeNQ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBtgCYYKPuowEeNQ@pks.im>

On 25/05/07 03:28PM, Patrick Steinhardt wrote:
> On Tue, May 06, 2025 at 10:02:48PM -0500, Justin Tobler wrote:
> > @@ -630,6 +630,7 @@ integration_tests = [
> >    't5409-colorize-remote-messages.sh',
> >    't5410-receive-pack-alternates.sh',
> >    't5411-proc-receive-hook.sh',
> > +  't5412-receive-pack.sh',
> 
> Instead of creating a new test file, do we maybe want to generalize
> "t5410-receive-pack-alternates.sh"? Just a suggestion, this is not a
> strong requirement from my side.

That makes sense to me. I'll generalize "t5410" and add the test there.

> > +	# Capture git-send-pack(1) output sent to git-receive-pack(1).
> > +	git -C repo send-pack ../setup.git --all \
> 
> The `-C repo` shouldn't be necessary at all, should it? The repository
> in which it runs is specified via the first parameter.

The repository specified by the first parameter is the repository the
pack is being sent to. We still need to define the repository on the
sending side.

> > +	test_grep "fatal: Failed to traverse parents" actual &&
> > +	test_must_fail git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
> 
> I'm a bit surprised by the error message though. First, why is it on
> stdout? Second, shouldn't there be some hint that the connectivity check
> has failed in the error message?

From my understanding, git-receive-pack(1) also writes the errors it
encounters on stdout using sideband. On stderr, git-receive-pack(1) does
print the git-rev-list(1) errors it encounters also so we could just
capture that and use it in the assertions instead.

When the connectivity check fails, the command error string is set to
"missing necessary objects" and outputted on stdout. I will also add a
check for this too.

-Justin
