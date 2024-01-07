Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF5E12B68
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4T7B0y2kJHz5vfg
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 09:57:54 +0100 (CET)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4T7B0p1mPSz5tlC;
	Sun,  7 Jan 2024 09:57:46 +0100 (CET)
Message-ID: <ed9f9fc5-c398-4424-9b5b-dbe618cca2ed@kdbg.org>
Date: Sun, 7 Jan 2024 09:57:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Leveraging --rebase-merges --update-refs mechanism to rebase
 several branches in one run
To: Yann Dirson <ydirson@free.fr>
References: <763603689.1820092086.1704566524953.JavaMail.root@zimbra39-e7>
 <133456672.1820149400.1704567932308.JavaMail.root@zimbra39-e7>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git <git@vger.kernel.org>
In-Reply-To: <133456672.1820149400.1704567932308.JavaMail.root@zimbra39-e7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 06.01.24 um 20:05 schrieb Yann Dirson:
> The "core + 1 variant" case pretty much works out of the box, with --rebase-merges
> and --update-refs generating a perfect instructions sheet.
> 
> But if I was to rebase just one variant while rewriting the core branch, obviously
> all other variants would still fork off the pre-rewrite core branch, and we'd loose
> all chances of automating the same work on the other variants.
> 
> OTOH, if I get `git-rebase` to generate the instruction sheets for those other
> variants first, strip them (manually) from the common part, and insert them in the
> instruction sheet of my "core + 1 variant" case ... I do get the whole of my branches
> rebased together, and sharing the updated core.

Not a complete automation, but... You can merge all variant branches
into a temporary branch (or detached HEAD), even if that are merely -s
ours merges, and then rebase the temporary branch with --rebase-merges
--update-refs. This will generate the instruction sheet that you want.
You can remove the final merge instructions (the temporary ones) from
the instruction sheet if you do not want them to be executed.

-- Hannes

