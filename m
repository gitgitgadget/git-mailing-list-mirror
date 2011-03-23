From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Relative ls-files
Date: Wed, 23 Mar 2011 16:57:55 +0100
Message-ID: <4D8A1883.1030606@drmicha.warpmail.net>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com> <4D89D052.5030801@drmicha.warpmail.net> <AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com> <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com> <4D89DCBE.3060400@drmicha.warpmail.net> <7voc51g7xo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: demerphq <demerphq@gmail.com>, John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 17:01:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2QV7-0007sl-3b
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 17:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933232Ab1CWQBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 12:01:32 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:35832 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933157Ab1CWQBb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 12:01:31 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 82E5E20404;
	Wed, 23 Mar 2011 12:01:30 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 23 Mar 2011 12:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=VDpBKQ21hlQLmT2P6w7Ks/k7I3U=; b=Sp4guwDjbjuiAvBEpGm0bioqTW8cJm33rF4iIbmZfgPedkDSVTnG/UVbg/AISf19aspSjC2ztqQqUC8B/+Jtv1oIkUTvmevdJdhlZGOc+NTwZgg/bj4SYU8Gtev8NGVVbvLHrvnSeoBRsDnTy/38PsC/3uBcVef9gq6A2YZG/CQ=
X-Sasl-enc: uOt4cFDclLVcpRpYgMiZ7xEpaqRiVuM0NSOcox+pwqa3 1300896090
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8A502440448;
	Wed, 23 Mar 2011 12:01:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7voc51g7xo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169848>

Junio C Hamano venit, vidit, dixit 23.03.2011 16:42:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>>> What's wrong with --relative  or something?
>>
>> ??
>>
>> ls-files already lists files relative to cwd. What you need is a way to
>> specify that you want all files, not just those beneath cwd.
> 
> Exactly.
> 
>>>> I've never liked magical strange notations.  ":" already has a meaning.
>>>
>>> +1
>>
>> I think you've both been missing out on the discussions about
>> --full-tree and refspec notation for that...
> 
> I like this answer.  Don't pay any much attention +1/-1 from people who
> are clueless to the topic, but do pay attention to them as persons by
> showing that there are things for them to read and learn if they want to
> discuss the topic.  A URL or two to the recent thread may have been nicer.
> 
>> Of course ":" has a meaning. "git show HEAD:" lists all files at the
>> top-level of the tree at HEAD. That is exactly why ":" has been
>> suggested to denote the top-level for pathspecs also. Note that this is
>> much more general than just an option for ls-files.
> 
> Talking about the "pathspec magic", I think in addition to "this is
> relative to root", we at least would need "this is literal, don't apply
> globbing" magic.  I am afraid that using ':' as the sole "magic for
> from-root" as you advocate may turn out to be too short-sighted and would
> hurt us in the future.

I admit I haven't thought much about globbing. Does my current POC patch
affect globbing in the way you want to avoid?

> 
> It may be more extensible if we used a common "magic introducer" at the
> beginning, an character unlikely to collide with any pathspec existing
> scripts and people use, and then have additional "what magic I want"
> signature immediately following that introducer letter in these magic
> filespecs.
> 
> Off the to of my head, "/" may be a perfect choice for "here is a magic"
> introducer, as we never give absolute paths on the fiesystem from the root
> to git [*1*].
> 
> Then, even when you are in a subdirectory somewhere, this:
> 
>     $ git ls-tree pu -- '/:*.h' "/!$path"
> 
> would list paths in the pu branch, limiting its output to any "*.h" header
> file, and a path that matches exactly with whatever is in $path variable
> without globbing within the current level.  The above uses ':' as "this is
> relative to root" (your favorite, whose rationale being that HEAD:Makefile
> names Makefile at the top) and '!' (randombly chosen without any rationale
> other than being "NOT" and without any association with "glob", which make
> it a bad choice of the letter) as "this is NOT a glob".
> 
> If we use ':' as the magic introducer, '::*.h" may be more logical if you
> follow your "HEAD:Makefile names Makefile at the top" analogy; ':/' breaks
> the analogy (the first colon is a general introducer and does not talk
> anything about what kind of magic; the second letter should be what magic
> it is about, and should use ':' from HEAD:Makefile analogy).

Mainly I want "few characters" (up to 2) and "good analogy". "/" and
"//" have obvious good analogies to file system usage.

> 
> I personally think "//*.h" looks a lot more natural than either ':*.h' or

With current git:

(cd Documentation && git show :Makefile)

Which Makefile do you get? That is why I call the ":" proposal natural.
I know, "git show Makefile" does not give the local one, but

git show :./Makefile

does. Given this, I would find ":/Makefile" very natural as well.

> ':/*.h' that have been suggested on the command line, so I am tempted to
> suggest using '/' (the first slash in the example) as the magic introducer
> and using '/' (the second) as the 'from-root' magic signature.

I'm afraid (but not sure) that leading "/" would create problems for Git
on Win! ":/" is fine according to the experts.

Michael
