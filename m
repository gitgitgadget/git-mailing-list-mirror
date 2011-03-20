From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Allow git mv FileA fILEa on case ignore file systems
Date: Sat, 19 Mar 2011 22:50:58 -0700
Message-ID: <7vsjuitk59.fsf@alter.siamese.dyndns.org>
References: <201103191528.34646.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 20 06:51:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1BY0-0003Th-5s
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 06:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074Ab1CTFvN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 01:51:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61393 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab1CTFvL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2011 01:51:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B11F3757;
	Sun, 20 Mar 2011 01:52:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qeNvXumoD3bs
	vxN5KKj6qD5lqv8=; b=b1khEmqhlEd0PVmmsYiS60KC1m0UeDdzOGiTnKaGxb46
	neWqFWIlrLnimErt3E2iNF+C3x0Kpvq49kmka/04eS92fhywwbD/6E7hi31S/u1M
	9y2tslEGWMrozEBy0AL23nTwlCSZvYAt+4OkwHU/MmIm/uxitpwbPldDOtaIFsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xSNCZh
	2QLbJvPCcJJ26EEpnIS/7kAhe5FOmSf50ATBFNBh/+pQMA3z1hTSjg/UxtcpAzmu
	YUNRFM+XKMM8wyv6+OX76/FxX9hzJWAUdXS0o03p7/yZgdspFdGxExuxdEeKvRIl
	YA/DX7XH29HShgjEMCW8u3QJpf0JmQELH+jiM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 45A143756;
	Sun, 20 Mar 2011 01:52:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DDBED3754; Sun, 20 Mar 2011
 01:52:37 -0400 (EDT)
In-Reply-To: <201103191528.34646.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Sat, 19 Mar 2011 15:28:33
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4555D18A-52B6-11E0-9D72-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169487>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The typical use case is when a file "FileA" should be renamed into fI=
LEa
> and we are on a case insenstive file system (system core.ignorecase =3D=
 true).
> Source and destination are the same file, it can be accessed under bo=
th names.
> This makes git think that the destination file exists.
> Unless used with --forced, git will refuse the "git mv FileA fILEa".
> This change will allow "git mv FileA fILEa" under the following condi=
tion:
> On Linux/Unix/Mac OS X the move is allowed when the inode of the sour=
ce and
> destination are equal (and they are on the same device).
> This allows renames of M=C3=84RCHEN into M=C3=A4rchen on Mac OS X.
> (As a side effect, a file can be renamed to a name which is already
> hard-linked to the same inode).
> On Windows, the function win_is_same_file() from compat/win32/same-fi=
le.c
> is used.
> It calls GetFileInformationByHandle() to check if both files are
> "the same".

Yeek; is it just me or the above single block of text too dense to be
readable? Can you use paragraph breaks?

> The typical use case is when a file "FileA" should be renamed into fI=
LEa
> and we are on a case insenstive file system (system core.ignorecase =3D=
 true).

Huh? I don't think renaming "FileA" to "fILEa" is typical at all. It is
very rarely done.

> (As a side effect, a file can be renamed to a name which is already
> hard-linked to the same inode).

It is unclear "a side effect" means "an added bonus" or "a regression" =
in
this sentence. I think this is latter.

Allowing filesystem specific logic to detect that two different "names"
actually refer to a single "file" and help renaming succeed is a sane
approach, but I think this particular implementation is flawed.

The important thing to notice is that "names" and "file" above refer to
the entities from the end user's point of view. Two files hardlinked
together on a filesystem with sane pathname handling are never the same
"file". I would probably have called it equivalent_filenames() to stres=
s
the fact that two _different_ names alias to the same file. is_same_fil=
e()
sounds more like you got two different filenames from the filesystem
(i.e. readdir() gave you both at the same time) and you are trying to s=
ee
if they are the same file, but that is not the case here.

I also find it a bad taste to make this feature depend on win32; doesn'=
t a
Linux box mounting a vfat filesystem have the same issue that we should=
 be
able to solve with the same code?  Can't we instead have a configuratio=
n
variable that tells git that the working tree is on a filesystem with
broken pathname semantics, and what kind of workaround is needed?  Isn'=
t
core.ignorecase already that configuration variable for case insensitve
filesystems [*1*]?

I would imagine that the implementation of equivalent_filenames(a,b) ma=
y
be !strcmp(a,b) for a sane filesystem [*2*] and !strcasecmp(a,b) for a
case insensitive filesystem.  For a totally wacky filesystem, your
lstat(2) based one might end up to be the best we could do [*3*].

When two different _names_ "A" and "a" refer to a single file, the only
thing that should happen for "git mv A a" is for the cache entry for "A=
"
to be moved to cache entry for "a", and no rename("A", "a") should be r=
un,
but I don't see any such change in the code. It may happen to work (or =
be
a no-op) on Windows, but because builtin/mv.c is supposed to be generic
(and that is the reason you introduced the is_same_file() abstraction i=
n
the first place), I'd still see this as a breakage.


[Footnote]

*1* Off the top of my head, perhaps core.ignorecase may have to grow in=
to
boolean plus extra to cover "this is not just case insensitive, but isn=
't
even case preserving" kind of broken filesystems like HFS+, but I didn'=
t
think things through.

*2* Incidentally, wouldn't "!strcmp(a,b)" solution suddenly start allow=
ing
"git mv Makefile Makefile" that we currently disallow? Is it a regressi=
on
(less safety against an unexpected input) or a good change?

*3* If we can find a solution that does not involve any calls to the
filesystem, it would be ideal, as we can reuse it later in codepaths wh=
ere
neither file "a" or file "b" exists on the filesystem yet (think: "we a=
re
about to create 'a' and 'b'---is that sensible, or will they overwrite
with each other on this filesystem?").
