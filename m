Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pimpmybyte.de header.i=@pimpmybyte.de header.b="Ngndyl/T"
Received: from pimpmybyte.de (kalmar.hosting.pimpmybyte.de [212.227.234.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F93319D
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 17:51:06 -0800 (PST)
Received: from [127.0.0.1] (ip-176-199-210-019.um44.pools.vodafone-ip.de [176.199.210.19])
	by kalmar.hosting.pimpmybyte.de (Postfix) with ESMTPSA id 182FF7E90A;
	Tue, 28 Nov 2023 01:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pimpmybyte.de;
	s=default; t=1701136264;
	bh=rwdqkXzOahC7CvzRyDCCy8N6SpD/zy0FyfBDSehg5zE=; h=From:Subject:To;
	b=Ngndyl/T13RRRdxbK2NAS5viufXCkvWiElSKfGCSF8j/kC/dH/WSHWogQDtkEispj
	 YpBNiKcI6eHNv/aOEFPY50lZ3uAta96lsCDhPVTzHn0RHeDb+uhDgsialLguP3hVXK
	 zRW+6lRmsRa8wpddITxnINaCi17CsNgGS7c/852M=
Authentication-Results: kalmar.hosting.pimpmybyte.de;
        spf=pass (sender IP is 176.199.210.19) smtp.mailfrom=mk+copyleft@pimpmybyte.de smtp.helo=[127.0.0.1]
Received-SPF: pass (kalmar.hosting.pimpmybyte.de: connection is authenticated)
From: Marcel Krause <mk+copyleft@pimpmybyte.de>
Subject: Re: [PATCH] doc: make the gitfile syntax easier to discover
To: git mailing list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Marcel Krause <mk+copyleft@pimpmybyte.de>
References: <20231124194711.563720-1-mk+copyleft@pimpmybyte.de>
 <xmqqr0kd5i66.fsf@gitster.g>
Message-ID: <70125a8e-57ed-2ac6-1260-2aaa10cbc851@pimpmybyte.de>
Date: Tue, 28 Nov 2023 02:51:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqr0kd5i66.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Thanks for your advice! I'll prepare a new patch.


> The title itself is sufficient, i.e. it had poor visibility, and you
> fix it by giving it better visibility.

Yeah I see now, I should have sent the explanation as cover letter,
not as commit message.


> more relevant is why you needed to find out what the former should
> be in the first place.

My gitfile links worktrees on limited-capability filesystems to a
git repo on a nicer filesystem.

^-- Should I write this in the commit message?

(For the more curious: That way I sync GRUB configs accross lots of
FAT FS thumb drives while having the main repo and main worktree on
an ext3 FS with symlinks and proper owner/group/mode for non-config
files of the project.)


> Do not unnecessary rewrap existing text, only to insert a few
> words, to force reviewers read a lot more than needed.

The shortest diff I can come up with would be:

--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -25,3 +25,4 @@ A Git repository comes in two different flavours:
  your working tree, containing `gitdir: <path>` to point at the real
-directory that has the repository.  This mechanism is often used for
+directory that has the repository.
+This mechanism is called a 'gitfile' and is often used for
  a working tree of a submodule checkout, to allow you in the

It loses the double space and thus the sentence boundary information,
but a similar case exists in line 156 (old) so I guess it'll be ok.


> Running "git grep linkgit:gitrepository-layout" would help you find
> the right way to spell this one, I think.

Found and fixed the missing "[5]".
Maybe I'll try and teach our tests to catch that.
