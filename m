Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430CA14288
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="QfmKsOF9"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94E92685
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 07:22:09 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-113-74.bstnma.fios.verizon.net [173.48.113.74])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3ACFLhxf032334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Nov 2023 10:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1699802505; bh=KCD3K7NR+G0Jl10KL0usMrIUiA6yIKFTn7KHXYo1F/0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=QfmKsOF9+wG79t19otInGK/LBTdH0qYVtwMFy+aBBW+piMEp04+KrvMcEgTel8VmG
	 ZwMsPBXGlJ0/E3yRmOfnuPRcYMZxicAFGrPcdXcoejwQNmpLSG7By9QYXGL67cQI3r
	 FJPVFINXaRY+SkFcKa+Io2n3Xou2mzoOEgNjHsXKyfsg3zOZQnOvackhgMi8XRgYkR
	 4bdYf7yYsOKiwGYis7xReq8nVj9MYjTNp4W0inuaM1wAU+JKHIjxXpXeD3o7cNSufL
	 0MXcYGPvvrQpU44JRHPBTVlojmUvvOmfRYI906bgEvBZy6ffVesNbeJjbHee5DUuAw
	 aF5gjswDZ2AYA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 72E5715C02AA; Sun, 12 Nov 2023 10:21:43 -0500 (EST)
Date: Sun, 12 Nov 2023 10:21:43 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sandra Snan <sandra.snan@idiomdrottning.org>, git@vger.kernel.org,
        Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: Re: first-class conflicts?
Message-ID: <20231112152143.GD35991@mit.edu>
References: <87cywmintp.fsf@ellen.idiomdrottning.org>
 <002901da1101$7d39a420$77acec60$@nexbridge.com>
 <Gr..Y5kkszDx87g@idiomdrottning.org>
 <ZUmJyFs7z7wdmLVK@mit.edu>
 <xmqqh6ltrs6t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh6ltrs6t.fsf@gitster.g>

On Sat, Nov 11, 2023 at 10:31:54AM +0900, Junio C Hamano wrote:
> Correct but with a caveat: it is too easy for lazy folks to
> circumvent the safety by mistake with "commit -a".
> 
> I wonder if it would help users to add a new configuration option
> for those who want to live safer that tells "commit -a" to leave
> unmerged paths alone and require the unmerged paths to be added
> explicitly (which may have to extend to cover things like "add -u"
> and "add .").
> 
> Perhaps not.  I often find myself doing "git add -u" after resolving
> conflicts and re-reading the result, without an explicit pathspec.

Maybe the configuration option would also forbit "git add -u" from
adding diffs with conflict markers unless --force is added?

I dunno.  I personally wouldn't use it myself, because I've always
made a point of running "git diff", or "git status", and almost
always, a command like "make -j16 && make -j16 check" (or an aliased
equivalent) before commiting a merge.

But that's because I'm a paranoid s.o.b. and in my long career, I've
learned is that "you can't be paranoid enough", and "hope is not a
strategy".  :-)

					- Ted
