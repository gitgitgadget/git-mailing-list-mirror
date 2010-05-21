From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH] edit: Allow setting git tree SHA1 of a patch
Date: Fri, 21 May 2010 17:29:52 +0200
Message-ID: <u5twrux6znz.fsf@beatles.e.vtech>
References: <20100516172738.5043.94039.stgit@localhost.localdomain>
	<AANLkTikcG3Chw1cpiKB00MrnZz-HZk9xAF_KtTTiVECi@mail.gmail.com>
	<u5tzkzt73us.fsf@beatles.e.vtech>
	<AANLkTilV3VQARdyZ-m9GCXz1Rwt0j6Q6noNyFrmmDzR5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kha@treskal.com,
	Gustav =?utf-8?Q?H=C3=A5llberg?= <gustav@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 17:30:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFUAt-0001d3-6v
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 17:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933001Ab0EUPaE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 11:30:04 -0400
Received: from [62.20.90.206] ([62.20.90.206]:60936 "EHLO beatles.e.vtech"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758080Ab0EUPaD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 11:30:03 -0400
Received: from beatles.e.vtech (localhost.localdomain [127.0.0.1])
	by beatles.e.vtech (8.13.1/8.13.1) with ESMTP id o4LFTw4c003564;
	Fri, 21 May 2010 17:29:58 +0200
Received: (from david@localhost)
	by beatles.e.vtech (8.13.1/8.13.1/Submit) id o4LFTqlX003561;
	Fri, 21 May 2010 17:29:52 +0200
X-Authentication-Warning: beatles.e.vtech: david set sender to davidk@lysator.liu.se using -f
In-Reply-To: <AANLkTilV3VQARdyZ-m9GCXz1Rwt0j6Q6noNyFrmmDzR5@mail.gmail.com>
	(Catalin Marinas's message of "Fri, 21 May 2010 16:16:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147468>

Catalin Marinas <catalin.marinas@gmail.com> writes:

> On 21 May 2010 14:59, David K=C3=A5gedal <davidk@lysator.liu.se> wrot=
e:
>> Catalin Marinas <catalin.marinas@gmail.com> writes:
>>> 2010/5/16 Gustav H=C3=A5llberg <gustav@gmail.com>:
>>>> I would like to have something similar to this patch, which allows=
 for
>>>> setting the (git) tree of a particular patch. I would like to use =
it
>>>> (from the Emacs mode) to make it easier to split an old patch into=
 two
>>>> (or more).
>>>>
>>>> It might be that this is too "powerful" (read: unsafe), and maybe =
a
>>>> better (safer) command would use whatever is currently in the inde=
x
>>>> rather than a SHA1.
>>>
>>> I'm not against such option (as long as it is somehow mentioned tha=
t's
>>> dangerous) though I don't fully understand how one would use it,
>>> especially when the patch is buried under other patches. With a ser=
ies
>>> of patches, any easily accessible tree (sha1) belongs to one of the
>>> patches.
>>
>> The idea is that Gustav wants to allow the editing of a file as it
>> appears in an earlier version. Lets say you have patches A, B, C and
>> D. You realize that one of the changes in to foo.c in C shuold reall=
y be
>> done in A. So you open the "A version of foo.c" in your editor, do t=
he
>> change, and then save it. The save operation needs to update A to be
>> the new tree that contains the updated foo.c, and the remaining patc=
hes
>> will keep their tree. The effect is that the moved change now appear=
s as
>> a diff in A, but not in C (nor B or D).
>
> This is currently achieved by "pop B C D", edit file, "refresh", "pus=
h
> --set-tree B C D".

Exactly. But I realize that my example was poor, since this will make B
revert the change and then C reintroduce it. But perhaps this is
actually a defect of the propsed usage model. Gustav, did you think
about this?

> Can "edit --set-tree <sha1>" make this simpler?

One think I can think of is that it doesn't have to worry about
modifications to the work tree or the index.

> Which <sha1> value would be used with "edit --set-tree" (unless that'=
s
> done by Emacs mode behind the scene and it generates the tree that
> gets passed to edit).

Yes, that would be up to the tool (emacs in this case) to figure out. I
could probably give a couple of examples when a user could do it
manually, but for those cases the normal push/pop/refresh operations
should be good enough.

--=20
David K=C3=A5gedal
