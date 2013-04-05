From: =?ISO-8859-1?Q?Kenneth_=D6lwing?= <kenneth@olwing.se>
Subject: Re: Collective wisdom about repos on NFS accessed by concurrent clients
 (== corruption!?)
Date: Fri, 05 Apr 2013 14:35:40 +0200
Message-ID: <515EC51C.9070206@olwing.se>
References: <515419D0.7030107@olwing.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:21:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWH0-0002u6-Pr
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161382Ab3DEMg0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Apr 2013 08:36:26 -0400
Received: from hotelroom5.mainloop.net ([192.121.13.73]:42608 "EHLO
	hotelroom5.mainloop.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161279Ab3DEMgY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 08:36:24 -0400
X-No-Relay: not in my network
Received: from [IPv6:::1] (unknown [82.214.25.167])
	by hotelroom5.mainloop.net (Postfix) with ESMTPSA id 4AFE47100E
	for <git@vger.kernel.org>; Fri,  5 Apr 2013 14:36:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <515419D0.7030107@olwing.se>
X-Antivirus: AVG for E-mail 2013.0.2904 [2641/6225]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220203>

Hi

Basically, I'm at a place where I'm considering giving up getting this=20
to work reliably. In general, my setup work really fine, except for the=
=20
itty-bitty detail that when I put pressure on things I tend to get into=
=20
various kinds of trouble with the central repo being corrupted.

Can anyone authoritatively state anything either way?

TIA,

ken1

On 2013-03-28 11:22, Kenneth =D6lwing wrote:
> Hi,
>
> I'm hoping to hear some wisdom on the subject so I can decide if I'm=20
> chasing a pipe dream or if it should be expected to work and I just=20
> need to work out the kinks.
>
> Finding things like this makes it sound possible:
>   http://permalink.gmane.org/gmane.comp.version-control.git/122670
> but then again, in threads like this:
>   http://kerneltrap.org/mailarchive/git/2010/11/14/44799
> opinions are that it's just not reliable to trust.
>
> My experience so far is that I eventually get repo corruption when I=20
> stress it with concurrent read/write access from multiple hosts=20
> (beyond any sort of likely levels, but still). Maybe I'm doing=20
> something wrong, missing a configuration setting somewhere, put an=20
> unfair stress on the system, there's a bona fide bug - or, given the=20
> inherent difficulty in achieving perfect coherency between machines o=
n=20
> what's visible on the mount, it's just impossible (?) to truly get it=
=20
> working under all situations.
>
> My eventual usecase is to set up a bunch of (gitolite) hosts that all=
=20
> are effectively identical and all seeing the same storage and clients=
=20
> can then be directed to any of them to get served. For the purpose of=
=20
> this query I assume it can be boiled down to be the same as n users=20
> working on their own workstations and accessing a central repo on an=20
> NFS share they all have mounted, using regular file paths. Correct?
>
> I have a number of load-generating test scripts (that from humble=20
> beginnings have grown to beasts), but basically, they fork a number o=
f=20
> code pieces that proceed to hammer the repo with concurrent reading=20
> and writing. If necessary, the scripts can be started on different=20
> hosts, too. It's all about the central repo so clients will retry in=20
> various modes whenever they get an error, up to re-cloning and=20
> starting over. All in all, they can yield quite a load.
>
> On a local filesystem everything seems to be holding up fine which is=
=20
> expected. In the scenario with concurrency on top of shared NFS=20
> storage however, the scripts eventually fails with various problems=20
> (when the timing finally finds a hole, I guess) - possible to clone=20
> but checkouts fails, errors about refs pointing wrong and errors wher=
e=20
> the original repo is actually corrupted and can't be cloned from.=20
> Depending on test strategy, I've also had everything going fine (ops=20
> looks fine in my logs), but afterwards the repo has lost a branch or =
two.
>
> I've experimented with various NFS settings (e.g. turning off the=20
> attribute cache), but haven't reached a conclusion. I do suspect that=
=20
> it just is a fact of life with a remote filesystem to have coherency=20
> problems with high concurrency like this but I'd be happily proven=20
> wrong - I'm not an expert in either NFS or git.
>
> So, any opionions either way would be valuable, e.g. 'it should work'=
=20
> or 'it can never work 100%' is fine, as well as any suggestions.=20
> Obviously, the concurrency needed to make it probable to hit this=20
> seems so unlikely that maybe I just shouldn't worry...
>
> I'd be happy to share scripts and whatever if someone would like to=20
> try it out themselves.
>
> Thanks for your time,
>
> ken1
>
> --=20
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
