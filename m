Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5D72134E
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kde.org
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 7BDEF241DB;
	Thu,  4 Jan 2024 06:51:05 -0500 (EST)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1rLMFd-iPC-00; Thu, 04 Jan 2024 12:51:05 +0100
Date: Thu, 4 Jan 2024 12:51:05 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2] git-prompt: stop manually parsing HEAD with unknown
 ref formats
Message-ID: <ZZabqfPDcA1jtmZS@ugly>
References: <cc902954f30c2faa92d1c5a4469f0dcc23e4acfe.1700825779.git.ps@pks.im>
 <ef4e36a5a40c369da138242a8fdc9e12a846613b.1704356313.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ef4e36a5a40c369da138242a8fdc9e12a846613b.1704356313.git.ps@pks.im>

On Thu, Jan 04, 2024 at 09:21:53AM +0100, Patrick Steinhardt wrote:
>--- a/contrib/completion/git-prompt.sh
>+++ b/contrib/completion/git-prompt.sh
>@@ -408,7 +408,7 @@ __git_ps1 ()
> 
> 	local repo_info rev_parse_exit_code
> 	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
>-		--is-bare-repository --is-inside-work-tree \
>+		--is-bare-repository --is-inside-work-tree --show-ref-format \
> 		--short HEAD 2>/dev/null)"
>
that makes me wonder whether adding support for `--symbolic-ref HEAD` 
here would not be the cleaner solution? and why stop there, and not add 
a few more ps1 would need, like --upstream and --sequencer-state?  
(though arguably, this overloading of `rev-parse` should be deprecated 
in favor of a new generalized `query` command, maybe even unified with 
`var`.)

