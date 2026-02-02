Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E0B1D130E
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770058462; cv=none; b=T31prEtkfccFvbKaXOQGsl92YregFEwAn09MYxqiOWQ8GgUV2x5LEwnL7Bxqdc7grVpIZNOZbmUdafbowxqcXdGIVVpYOxDcBmWZ5NQap9wYsQGsfPU5mrdhA1TwzZowOlwsKSCxORXsxQ8OM7J7jOn5zFhCOjqq1PwSMSGfKrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770058462; c=relaxed/simple;
	bh=4q0FuRXk9ESTkCUc7aCic4sjBhtKgcwxVrv+oCMKgBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVRGIpPuXrRBR+H/9PtGzTE17UOezd0qsI4JQITd9P8DwTHJkoxd+1R+E1bhgE9gXz8Vs3SP/JfC+6X4M5V23ipRNZVc0rCLLcULe+PMtbw3IrpP9wZ9sWx3n6lFbzMKuBowUHy4fpailj7CmWgLx+mAa8TABtWLMMqYQhnO1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rm89mWm0; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rm89mWm0"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-126ea4e9697so984c88.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 10:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770058460; x=1770663260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjgwJ1Nud8LfMLO8uSsdO5KWbrSIa0nSXmb9dXPRUbw=;
        b=Rm89mWm0Wnzs2YsGrTP1rtRS0Fey8i/T0BEBGbeYlLf/WYpZFZOXK5yRric7lo1rpv
         9X+BGEK6uE/Y1QIGfhK+EmW+DmSH3mWlRb1xyOed7FGfkV5jL+Fxl37kdHaMNRTyy0lh
         RABbX5+Gn2Tu/yDm5Z1acPMa49mr6H93rBXhq/37ohHDaAv1razBQx/9Esi0Ql8G1iyU
         DtuEhMG7n3Mu7GEBYmQNQSkFKB0gBrnTfxwJ7ZPj0fYIFKaWhWT3N4G6lwKe7VU4veAd
         RRaqkr0c6nYb8fwsUoVZwe8D7z6bJFCWzIv/ENKTx0y8tQKBIXz7/kGMb5pZVtDONOdx
         BWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770058460; x=1770663260;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjgwJ1Nud8LfMLO8uSsdO5KWbrSIa0nSXmb9dXPRUbw=;
        b=Nnng1lGvSMHAfNoOE0LyBTBwdRhlf4gDywEIqeUK+4+sj/nYRlezMnVUF8erTneh8f
         bg/aHoRrAJu2k2QFJH5b3Lj36KYn1e7c8fUYWdBsGB2Y6cucAYruAhfP7LtxN76kRWlx
         6ZqdWjfeLiCCEA2ARQ2Bvos7oRh+u7c6OdyYVWrNc8NRLP3qcN6O7X12BqFbnqoQF4Bw
         /vOiNe8Cu4YJ0LWqcXenN0lzLbV29wmv8hWjKgutwjgWSXeFGtP1d6OKH1dhKMWcLtGE
         onqVeUCDz/pfKe3YK2DiIWDhFAxvCo4MO1i0be/608ExbZFr+MHBAv0kOq40LyvCv9fO
         WBRg==
X-Gm-Message-State: AOJu0YxRcAm+DPxjjPLfKRTkdXoOTw19Xhg86qGeTz9XLKAyoHzpHfKj
	H6x98WTtGmfggpE6RcfzBS7y82T1TDv1VlWSlFzoPmu7E2Ik59LsUONu4EjpqNnI4g==
X-Gm-Gg: AZuq6aIDvxWrBjq7sDyPLvt2AWOLC/FzDRNAxyOkm9sqUT8AEROzk9SIENMU4pdyNCj
	I6PYmBeUeRcCL6BiL1wk4jqV93lgBelU1Cmo2mYe/T8WtdQAIP1J5XVg5XZuwmbZjr1atKmm6js
	TTtOhwBbXI+Ilcba0mXywuruW0lnqLgWByFoN+Jo7nCNHGoYq/03PkV2WjEOjiSseip94UdB9Vs
	e+BORjjdPTDoiI3i9qNDAtlJ8wZjsAXySnRXnfb0NI+79NGVWdQMxZ3/lUfKHpkNuAdTYO5+9bj
	ooMTb5zmvAPlW/rF37aeIp/IbVtyO7keV1xMyRYck1hLqy+MwHsjIYDNUxQ6JPk6Gzjl9UH+twB
	LyzZ3DR2PqUT4XuwMiY4S/kYIkS5EroJEPcxeV0SvlWJYgZwaj1xSOosu4cVlYcLVu66xvY0lWB
	lP8vx9Mpe+720KKaEtIOdlse6mGpocrwBTMqnJ7j/Nal7s
X-Received: by 2002:a05:7022:f401:b0:119:e55a:808a with SMTP id a92af1059eb24-126eb108f93mr11502c88.7.1770058459272;
        Mon, 02 Feb 2026 10:54:19 -0800 (PST)
Received: from google.com ([2a00:79e0:2f0b:6:cf17:5230:3390:192d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1adef97sm20275189eec.29.2026.02.02.10.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:54:18 -0800 (PST)
Date: Mon, 2 Feb 2026 10:54:13 -0800
From: Josh Steadmon <steadmon@google.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] subtree: validate --prefix against commit in split
Message-ID: <7k7ewvrb5hj3jyesiigy6dvo5w5pl67rk7ihztsuxbtqpymafv@ey64nvhzhacg>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>, git@vger.kernel.org
References: <xmqqh5smdejc.fsf@gitster.g>
 <20260115175403.3971-3-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115175403.3971-3-pushkarkumarsingh1970@gmail.com>

On 2026.01.15 17:52, Pushkar Singh wrote:
> git subtree split currently validates --prefix against the working tree.
> This breaks when splitting an older commit or when the working tree does
> not contain the subtree, even though the commit does.
> 
> For example:
> 
>   git subtree split --prefix=pkg <commit>
> 
> fails if pkg was removed later, even though it exists in <commit>.
> 
> Fix this by validating the prefix against the specified commit using
> git ls-tree instead of the working tree.
> 
> Add a test to ensure this behavior does not regress.
> 
> Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>

Unfortunately, it seems this patch breaks the subtree tests. We noticed
a failure in our build system at $WORK, and I was able to bisect the
failure to this commit:

$ git bisect start 54b18a3513eed9ed5ced5c238ade55a434fd619a 66b2238f5c17644ddf15f75a53c76faeca6d9f1e
$ git bisect run sh -c 'make && make -C contrib/subtree && make -C contrib/subtree test'

The tests fail on case 17 - split requires path given by option --prefix
must exist.
