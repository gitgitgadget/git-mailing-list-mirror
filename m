From: Mark Lodato <lodatom@gmail.com>
Subject: Re: Meta-variable naming convention in documentation
Date: Fri, 26 Feb 2010 17:51:03 -0500
Message-ID: <ca433831002261451k3164d413y77d4989239862f30@mail.gmail.com>
References: <ca433831002252055l37292cf6v868cc407f0be7250@mail.gmail.com> 
	<7vfx4oeeol.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 23:51:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl91u-000081-Oa
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 23:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966487Ab0BZWvZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2010 17:51:25 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62865 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966484Ab0BZWvY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2010 17:51:24 -0500
Received: by gyh20 with SMTP id 20so301913gyh.19
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 14:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HdoN3WuAuQ5JDtEyonfY0+goPwI09Rh0SLU6MU7z0HI=;
        b=bLMe7L1rh7CGBviqeb+IBd7VAKOex1pn8We4GW8wvHe6uYAQ1YLaLSVMYSh3zCcgm/
         w1KJ+hm+cJUAvgVkSepSekclwANIp+0OXziJW1H6fuGoIJDlf9yD1wHmQT0Es0ArR5Yi
         8xl5VLQTR5i4/TyFPDMmL9NsddPqYENrIbMQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=X+Y/FkPG6KpQ4urEtiRY18IQdVAdLzRkOaVTojtvtJv28VHa12t9RZKI4NQ/0nZ4BU
         Q+sSRlPBw/FoCfgrJbSokbSD5JfAVTDBLvZJ1HW7GZ6uB3Sk/kw00k2bX96gQ9B9eHTD
         o5jEXb2WS34nWNbukWkv/b8PqD5mCbFWe4ztg=
Received: by 10.90.40.17 with SMTP id n17mr1129445agn.3.1267224683368; Fri, 26 
	Feb 2010 14:51:23 -0800 (PST)
In-Reply-To: <7vfx4oeeol.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141159>

On Fri, Feb 26, 2010 at 12:42 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Mark Lodato <lodatom@gmail.com> writes:
>
>> The following accept exact filenames or directories. =C2=A0If a dire=
ctory,
>> this matches all files within that directory recursively.
>>
>> =C2=A0 =C2=A0 =C2=A0 git-archive =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 path =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fdir
>>
>> =C2=A0 =C2=A0 =C2=A0 git-bisect =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0<paths>/<pathspec> =C2=A0 =C2=A0 =C2=A0fdir =C2=A0 =C2=A0(f)
>
> What does the gap between these two mean? =C2=A0Do you mean "bisect a=
nd later
> are not in the 'exact filenames or directories' group"?

Each of the three types is divided in two, separated by a blank line.
The first group, all without (f) at the end, die if one of the paths
given on the command line does not exist.  The second group, all with
(f) at the end, do not complain if any of the paths do not match
anything.  I called the latter group "filtering" for lack of a better
term.

So, git-archive, git-add, git-checkout, git-commit, git-rm all take
pathspecs (the first using diff logic, the rest using ls-files logic),
but they complain if any of the pathspecs do not match.  It's probably
not worth documenting this, but it may be worth implementing
--ignore-unmatch for all but git-rm (which already has it.)

Similarly, it may be a nice option to have a --warn-unmatch option (or
a configuration variable) to warn (or possibly die) if any of the
pathspecs hit nothing.   Then again, maybe it's not worth the trouble.

It appears that git-diff-tree and git-ls-tree take some sort of
pathspec - it ignores unmatching patterns, but it does not allow
globbing or directory matches.

> In general, unless the command takes only one filesystem entity (e.g.=
 in
> "format-patch -o <dir>", <dir> cannot be anything but a single direct=
ory;
> in "blame <file>", <file> cannot be anything but a single file)

In this case, I suggest that we use the same meta-variable always:
<file> or <dir>, or a more specific thing like <source>.

> you never
> give a single "filename" to git command. =C2=A0Even when you say "git=
 add
> Makefile", you are _not_ giving a filename that is "M' "a" "k" "e" ..=
=2E;
> you are giving a _pattern_ to be matched with files git would find by
> traversing the filesystem. =C2=A0In the case of "Makefile", it may ha=
ppen to
> match only one single file.
>
> This pattern is called "pathspec", and commands that can take one pat=
hspec
> can always take more than one.

In these cases, I think we should always use the meta-variable
<pathspec> - never <path>, <file>, etc.

> I think it would make sense to document which ones are concrete paths
> (e.g. "blame takes a filename" vs "diff takes zero or more pathspecs"=
),
> but it would not make much sense to document the two different pathsp=
ecs.
> The effort is better spent at fixing the difference --- obviously we =
would
> eventually want to be able to say "git diff 'lib/*.h'".

You're right, it's not worth having two different meta-variables, but
I do think it is worth noting in the documentation.  In git(1), we
could have something like the following:

<pathspec>::
	Indicates a pattern for filtering paths.  Matches are either exact,
	a leading directory, or a glob(7) pattern on the entire path.
	For example, "doc/help.txt" matches "doc/help.txt", "doc",
	"*.txt", and "d*t", but not "do", "help.txt", or "help.*".

<dir>::
<file>::
	Indicates a physical file or directory relative to
	the current directory.

(Note: the current document says "almost always relative to the root
of the tree structure `GIT_INDEX_FILE` describes."  Is this true?)

Then, for the diff logic commands, we could document that they do not
accept globs.  For example, in git-diff(1):

<pathspec>...::
	If given, limit the diff to paths matching the given parameters.
	(Does not accept glob(7) patterns.)

Once the logic is unified, and these commands do accept globs, we can
just remove the note.

Mark
