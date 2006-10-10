From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why gitweb commitdiff NO diff output ?
Date: Mon, 09 Oct 2006 19:28:07 -0700
Message-ID: <7viris9a6g.fsf@assigned-by-dhcp.cox.net>
References: <4b3406f0609280032y77cb5961i220b3cfd741ebfd4@mail.gmail.com>
	<eft8u4$un0$2@sea.gmane.org> <20061003095250.GJ2871@admingilde.org>
	<7vwt7hnvsk.fsf@assigned-by-dhcp.cox.net>
	<4b3406f0610080122r17a10ea4h2c71a399fb8398a@mail.gmail.com>
	<7v64et9fjq.fsf@assigned-by-dhcp.cox.net>
	<4b3406f0610091851i593f3e53v5d5fef891edb6d48@mail.gmail.com>
	<7v1wpgapew.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 04:28:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX7Lp-0000Ka-Fn
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 04:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbWJJC2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 22:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbWJJC2K
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 22:28:10 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:10715 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751939AbWJJC2I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 22:28:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010022808.MNNC16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Oct 2006 22:28:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YSUB1V0071kojtg0000000
	Mon, 09 Oct 2006 22:28:11 -0400
To: "Dongsheng Song" <dongsheng.song@gmail.com>
In-Reply-To: <7v1wpgapew.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 09 Oct 2006 19:13:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28596>

Junio C Hamano <junkio@cox.net> writes:

> "Dongsheng Song" <dongsheng.song@gmail.com> writes:
>
>> NO.
>>
>> When I change the repository's owner to gitweb process,  no diff output yet.
>>
>> $ chown -R www-data:www-data  cauchy/ gcc/ mph/
>>
>> 2006/10/10, Junio C Hamano <junkio@cox.net>:
>>> The site does not return any of these four blobs that are part
>>> of the commitdiff when a=blob is requested on them.
>>>
>>>         file:a34d77e47bf1561db1ade4f6b247598b880f80d5 ->
>>>         file:7625c494df01d4745e67bd4423e2fdbe9fc43799
>>>
>>>         file:b207fe30a5430f97d27d398d89c974b068694c7a ->
>>>         file:57b07ace4bb6352416bbf9436b9f2642b3273257
>>>
>>> I would first suspect if the repository actually have them _and_
>>> with an appropriate mode protection to be readable by your
>>> gitweb process.
>
> And does the repository have these four blob objects?

Sorry, the follow-up question was not very helpful to guide
another person over e-mail.  Let's try again with more specific
questions.

What do these say in that repository when run as the webserver
user?

	$ for blob in \
          a34d77e47bf1561db1ade4f6b247598b880f80d5 \
	  7625c494df01d4745e67bd4423e2fdbe9fc43799 \
          b207fe30a5430f97d27d398d89c974b068694c7a \
          57b07ace4bb6352416bbf9436b9f2642b3273257
	  do
          	git cat-file -t $blob || echo $blob does not exist
	  done
	$ git cat-file commit c977ee1b2e54d67bb379ce476f784431c32136d7 |
	  grep 'parent '
	$ git diff-tree -p c977ee1b2e54d67bb379ce476f784431c32136d7 | wc

The first one tries to make sure you have those four blob
objects in the repository, the second tries to make sure the
commit is a single parent commit as your gitweb output suggests,
and the last one is to obtain the diff text.

Also do you have the same problem with other commits, or is this
the only commit your gitweb is having trouble with showing
commitdiff?
