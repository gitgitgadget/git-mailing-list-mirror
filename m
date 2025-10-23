Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7DC2DAFA8
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761262195; cv=none; b=nHdc3hn6E2N8ipdUKsDQlZ+cLhApgXPzNbC+47qKXLeM06CvhjetAzYi6Cp7jx7sCkBIr1ojBdpp770aEF7GfdNOQ8R8ejf3Ngv4yU0RiXkvZYIFwTd6JyO9/E3rLMMkBF9/+ivHCXoVkkxRf00Av9cFfaluxjREvJ+8ypfiR7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761262195; c=relaxed/simple;
	bh=WoEim+W9B27mTS2iQGXgYOLM7v2SYr1RLWMQnfLlkaY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t9xfs8MFV6hQvj+nrOONvEjoEi0rAh3INKU7nnsgMmewfuwEVy7LvRIbErRAJDMpr8hIUBqyOEJauqcONwsIhe50Miz9MQ95cEW9yV/QrSbfAu0cwfmlf78PpdNASHyVV0iu1tM2kNkOFqRss2Phb8klkSFAEq2MYVgAO88zsBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gesh.uni.cx; spf=pass smtp.mailfrom=gesh.uni.cx; dkim=pass (2048-bit key) header.d=gesh-uni-cx.20230601.gappssmtp.com header.i=@gesh-uni-cx.20230601.gappssmtp.com header.b=byOHX+eW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gesh.uni.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gesh.uni.cx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gesh-uni-cx.20230601.gappssmtp.com header.i=@gesh-uni-cx.20230601.gappssmtp.com header.b="byOHX+eW"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-426f1574a14so809880f8f.3
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 16:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gesh-uni-cx.20230601.gappssmtp.com; s=20230601; t=1761262191; x=1761866991; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lXhSts+MEguRFypzWDZqKvC16QVl58y2WpdW037V5Bg=;
        b=byOHX+eWr3GE+DWB9+9DQn99IQy369LP1+gcz0islKnjWhK7lVbRmhQY+Xqt0Bswwf
         HghFqK/WBjsSuyLJ8gouAry4SiRRdWQ3ccWM4nRVcChP4c13xJHt1o6/0Oj4dhL9O11d
         K116QU4/qujJd8nkM2DTnHe5ONRG1xbUtgtjW7dyWslrzPGynXmMkTADCeKR0P974Ihj
         VgR8mFHj0XIJqgvRxXf7Y/dOeJhIVF4gi6rKw0WowzWdZko7EiQz0+Swgwodt1nYQoz2
         7WPVtxXHuBCgeJtyntYQaxjhTOiDakh+brLBdXNkD5tU4wWqPe8FZJMpFrhSGULBFxo7
         bm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761262191; x=1761866991;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXhSts+MEguRFypzWDZqKvC16QVl58y2WpdW037V5Bg=;
        b=Luh+qe8z9IBmM2RHfz2WStZhkDcxjlhUpGYMAh2/Bf0LZX/U7pQw7i7od2JPhfSevY
         A4GDthbhYS0yoLyX0w8Dk9jgivCoLhnJGu1AxGgbAK+FBeefHG+GAsXNM8g/UCClYq8n
         Dtk3y58eEQeuE+8/CdcDOYgm45fpoboJ7XVplvj2i7hfQnmB7BtDVWX4b/REr1NYz6yK
         0AdBLTyTFGXcGnmjTGZZZeoeZ+ahf9U3u/aD22jinXqzWL+ndgogDAFWif4VC4vx4NTA
         HeXUXO/Ha5ucdiK48qMIysSHsH0sBj1XAfkSmpw3du51VsCLiE+3VLYqRjMgX5q3jq2b
         AFfg==
X-Gm-Message-State: AOJu0YxbvkOfzHf/yvFqUk2XrhL9CLoEbLwqe+9StQtwA/kaHHSpjrqh
	yRldr1Cz9G3jptif/s9w1tmKgJYf7adWiR+ySG772mTMeprxBD1rpDPThHblH/dQ95SYMvaNrVc
	pMG7KPk0=
X-Gm-Gg: ASbGncvL7ZAtiXoGajn3gKeA4Z/o6fUyAdmUlH6ZkQi50VpAyzmEQewXcZOZgX/TiWL
	LZ5FWXyFkUzt3zqDiuf1rkCcL8uvRkbq2CAT51WkKFI3RBEVH+BUWTUXvaDQmVqNLkGtdVxBcB4
	gyVtGsr5eDibhBWY6RchM/s9ygXO/x2LLSjrGhEBndLNjG67wE9+AIAbFqxbLGtAlo+oGLUBUZ3
	OEJ0cDccTnPSXfB+1z9cfuWBlVvnBFRiPk7hAp35/s73iEXbR2511NWW7SgAdK5JocezGJbX4wk
	tu1SIhU8pKSWsyQgtA7K25HhWdA3rvInrQkSs7TwH/Mm3IxpcV8CeDtoWuDCJRImH+YQyv3wf2/
	mdjQi1NKO123HAWR0zcRA1tWDIwGqRY4QiVPXzpLV9royRiTkEoLjJNdNYQUzGtKoIdMYyJjXHz
	8lSA==
X-Google-Smtp-Source: AGHT+IGSPKbKteIROTYVEdkopEnjX0Du0ZhggRDAynWH9gs7kyGdSUdIm7OHhvGqDAT6uOq48WMTTQ==
X-Received: by 2002:a05:6000:2f83:b0:427:880:9538 with SMTP id ffacd0b85a97d-4298a0bd253mr3044340f8f.45.1761262190872;
        Thu, 23 Oct 2025 16:29:50 -0700 (PDT)
Received: from telcontar ([46.120.21.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e7630sm6289244f8f.10.2025.10.23.16.29.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 16:29:50 -0700 (PDT)
Date: Fri, 24 Oct 2025 02:29:47 +0300
From: Gesh <gesh@gesh.uni.cx>
To: git@vger.kernel.org
Subject: Handling of improperly-configured custom diff drivers is confusing
Message-ID: <ok3e53h6kxxv4ukvwe4e6bac24ph5oykffrc26fqmwkrltm25e@byvhfqgfygsv>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
After investigating what I thought was a git bug, I ultimately found it was due
to my misconfiguring the diff.pdf driver. In particular, I had (years ago now)
misread either the git docs or the pdftotext manual, because I had naively
configured
diff.pdf.textconv = pdftotext
Unfortunately, pdftotext's default behaviour is to write the text to a new file,
not stdout -- the correct configuration is
diff.pdf.textconv = sh -c 'pdftotext "$0" -'
All this is well and good, and thankfully this episode has left me with a better
configuration. Although, it would perhaps be nice to have git warn on a textconv
configuration that was constantly emitting an empty file for existent files.

Moreover, my investigation yielded some surprising (and underdocumented?)
information:
- It appears that triggering a textconv driver with cachetextconv set generates
  a commit. I caught this because I configure the user information per-repo, so
  diff was complaining the user wasn't configured
- Custom diff drivers are run in a temp directory subsequently rmdir'd by git.
  In particular, they _can_ write to disk, but must cleanup after themselves.
  Caught this because my configuration *was* leaving files around -- but git
  only complained it couldn't rmdir.
- git diff and git log crash if in the course of printing a custom diff driver
  crashes. In particular, they cut off printing. This was useful, because it
  meant I actually bumped into this bug, instead of it slipping my notice as I
  jumped in the output to the tag I was interested in.
- git log --simplify-by-decoration seems to generate some sort of squash commit
  of all the commits between two nodes it prints, but display them under the
  existing SHA. I think this was the first time I used simplify-by-decoration
  this thoroughly, so I hadn't noticed this before.

Not sure how much of this is actionable -- it ultimately ended up being my
fault, but I'd've appreciated clearer diagnostic messages and clarifications in
the docs.

Either way, hope this is useful to someone.
Gesh
