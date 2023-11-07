Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1981B137B
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="WfINzYld"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59D144BF
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 16:55:25 -0800 (PST)
Received: from letrec.thunk.org ([172.59.192.143])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3AB0t1sP028412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 19:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1699664104; bh=JgNg/KTh/7uyo5XJeVG6IDcT63wjo9dR37R+WxJBXog=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=WfINzYldEyMx7zR1NvywnWb7IZzJxL+FyuIDNZjBxfZS9kXJOfK70wmkuHIQvm61O
	 IwUERtUHTahcEeUll+bKk0tTOMSWLpxkFcSquu4dC6rnuNzkRskxApVholtmMXiYJN
	 Yj5oqfEWnVvmiZCmMA3mk6X0h/qpBqbNaSqQEh+2q4N+eG35rFFdalAtFnrvUwNMzT
	 huKZaDma/X/LslLzmLbyRfGpzp4+OC0xGp6ZnkU4nrJAiHZEK4tGYbkYJORqsjc45m
	 /WflSN5gSPG5mn2+mea0ZMYaldS8N4Ocz/2qOLPayo9msTFtcoVb2lX+uGzYClot8Q
	 tTYGCAzMnC+zA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
	id B032A8C01E3; Mon,  6 Nov 2023 19:50:16 -0500 (EST)
Date: Mon, 6 Nov 2023 19:50:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Sandra Snan <sandra.snan@idiomdrottning.org>
Cc: git@vger.kernel.org, Dragan Simic <dsimic@manjaro.org>,
        rsbecker@nexbridge.com
Subject: Re: first-class conflicts?
Message-ID: <ZUmJyFs7z7wdmLVK@mit.edu>
References: <87cywmintp.fsf@ellen.idiomdrottning.org>
 <002901da1101$7d39a420$77acec60$@nexbridge.com>
 <Gr..Y5kkszDx87g@idiomdrottning.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Gr..Y5kkszDx87g@idiomdrottning.org>
X-Spam-Level: *

On Mon, Nov 06, 2023 at 10:45:03PM +0000, Sandra Snan wrote:
> Randall, thank you for that.
> 
> I just have sometimes wish git could be a little more aware of them beyond
> just storing them with ASCII art in the files themselves (and alerting /
> warning when they happen but I often can't properly see those warnings flash
> by so I end up having to search for the conflict markers manually). So if
> conflicts are a thing that *can* happen, it'd be better if vc could know
> about them which would make some of the rebases simpler as in jj. That
> doesn't mean we wanna adopt the jj workflow of deliberately checking in
> conflicts (not even locally), just be able to deal with them better if it
> does happen.

Well, if you miss them, "git status" does show that there are conflicts:

   Unmerged paths:
     (use "git add <file>..." to mark resolution)
           both modified:   version.h

And if you attempt to commit the merge without resolving the
conflicts, git won't let you:

   error: Committing is not possible because you have unmerged files.
   hint: Fix them up in the work tree, and then use 'git add/rm <file>'
   hint: as appropriate to mark resolution and make a commit.

So it's hard to miss the indications of the content conflict, because
if you try to commit without resolving them, it's not a warning, it's
an outright error.

Cheers,

					- Ted
