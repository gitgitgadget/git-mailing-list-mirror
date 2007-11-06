From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in  git, help users out.
Date: Tue, 6 Nov 2007 18:43:39 +0100
Message-ID: <7790B5EB-2EFC-47EF-8A5A-FA83CA26DDB9@wincent.com>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com> <7vlk9cmiyq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711052325090.4362@racer.site> <7vsl3kjdct.fsf@gitster.siamese.dyndns.org> <7vk5oviqbe.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711061216330.4362@racer.site> <20071106124833.GA25637@artemis.corp>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 18:44:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpSTU-0008G1-Dc
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 18:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbXKFRoL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Nov 2007 12:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753490AbXKFRoL
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 12:44:11 -0500
Received: from wincent.com ([72.3.236.74]:48164 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753459AbXKFRoK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Nov 2007 12:44:10 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lA6HheKV012358;
	Tue, 6 Nov 2007 11:43:41 -0600
In-Reply-To: <20071106124833.GA25637@artemis.corp>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63690>

El 6/11/2007, a las 13:48, Pierre Habouzit escribi=F3:

> On Tue, Nov 06, 2007 at 12:25:33PM +0000, Johannes Schindelin wrote:
>> Hi,
>>
>> On Tue, 6 Nov 2007, Junio C Hamano wrote:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>>
>>>>> In the same way, I would expect "git revert <commit> -- file" to =
=20
>>>>> undo the
>>>>> changes in that commit to _that_ file (something like "git merge-=
=20
>>>>> file
>>>>> file <commit>:file <commit>^:file"), but this time commit it, =20
>>>>> since it
>>>>> was committed at one stage.
>>>>
>>>> Allowing people to revert or cherry pick partially by using
>>>> paths limiter is a very good idea; ...
>>>
>>> As Pierre said earlier, a partial revert via "revert <commit> --
>>> <paths>" and a partial cherry-pick would make quite a lot of
>>> sense, and in addition, it should not be too hard to add.
>>
>> Yes, but Pierre also said earlier that people want to revert their =20
>> local
>> changes.  And the logical thing to try that really is
>>
>> 	git revert <path>
>>
>> Now, if you read that out in English, it does not make too much =20
>> sense:
>> "revert the path" (not "revert the _changes_ to that file").  But =20
>> it is
>> what people try to do.
>>
>> However, IIUC another thing Pierre mentioned is that
>>
>> 	$scm revert <commit> <path>
>>
>> commonly means "revert the file _to the version_ stored in <commit>"=
=2E
>> This is just different enough from "revert the _changes_ to that fil=
e
>> stored in <commit>" to bite people, no?
>
>  Yeah but that's what checkout is for. The main source of iritation =20
> for
> new users comes (IMHO) from svn, where `svn revert path/to/file` is =20
> part
> of the workflow: in case of a conflict when you `svn up`, you have
> either to:
>  (1) fix the conflict and `svn resolved path/to/file`
>  (2) drop your changes and take the trunk version `svn revert path/=20
> to/file`
>
> People really expect git revert -- path/to/file to do the same as git
> checkout HEAD -- path/to/file. Though I believe that like I said, =20
> maybe
> we don't wan't git revert -- path/to/file to become the first class
> command to do that, but rather to do what the user meant, hinting =20
> him in
> the direction of the proper command. I wasn't really advocating that
> git-revert should be a complete implementation of what git checkout
> <comitish> -- <paths> does. YMMV.


I agree; they're semantically different and it wouldn't be a good =20
thing to start blurring the lines between them too much. It's just =20
unfortunate that the term "revert" is used by most other SCMs to mean =20
something different than what it means in "git-revert". I think the =20
best path here is education, what Pierre says, rather than changing =20
git-revert's semantics.

The other changes discussed so far in this thread (path-limiting git-=20
revert with preserving its semantics) seem like a good thing.

Cheers,
Wincent
