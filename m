From: Ron Garret <ron1@flownet.com>
Subject: Re: git-mv redux: there must be something else going on
Date: Wed, 03 Feb 2010 12:30:14 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-DFA9D6.12301403022010@news.gmane.org>
References: <ron1-32BD5F.10255403022010@news.gmane.org> <32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com> <ron1-5F71CB.11234903022010@news.gmane.org> <32541b131002031147r367ee08fxc64c4c54165953a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 21:35:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NclwT-0005An-3a
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 21:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353Ab0BCUfL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 15:35:11 -0500
Received: from lo.gmane.org ([80.91.229.12]:41419 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932622Ab0BCUfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 15:35:09 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NclwI-00053H-15
	for git@vger.kernel.org; Wed, 03 Feb 2010 21:35:06 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 21:35:06 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 21:35:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138887>

In article=20
<32541b131002031147r367ee08fxc64c4c54165953a3@mail.gmail.com>,
 Avery Pennarun <apenwarr@gmail.com> wrote:

> On Wed, Feb 3, 2010 at 2:23 PM, Ron Garret <ron1@flownet.com> wrote:
> > In article
> > Ah. =C2=A0That explains everything. =C2=A0Thanks. =C2=A0(I thought =
git mv was
> > equivalent to git rm followed by git add. =C2=A0But it's not.)
>=20
> I suppose in this case it's not.  The only difference is when your
> work tree differs from your index, though, and it's to be expected
> that 'git rm', in removing things from the index, would lose your
> ability to track those differences.
>=20
> > So... how *does* git decide when two blobs are different blobs and =
when
> > they are the same blob with mods? =C2=A0I asked this question befor=
e and was
> > pointed to the diffcore docs, but that didn't really clear things u=
p.
> > That just describes all the different ways git can do diffs, not th=
e
> > actual heuristics that git uses to track content.
>=20
> If you really want to know the details, looking at the code really is
> probably the best solution; it's not even that long.
>=20
> The short version is that git chooses a set of candidate blobs, then
> diffs them and figures out a percentage similarity between each pair.
> (A simple way to think of the similarity index is "how long is the
> diff compared to the file itself?"  If the diff is of length zero, th=
e
> similarity is 100%, and so on.) If the similarity is greater than a
> certain threshold, then it's considered to be the same file.
>=20
> Choosing the set of candidates is actually the more interesting
> problem, since detecting moves using the above algorithm is O(n^2)
> with the number of candidates.  That's why 'git diff' and 'git log'
> don't do it at all by default.
>=20
> If you provide -M, the set of candidates is the set of files that wer=
e
> removed/modified and the set of files that were added.  (Added files
> are compared against removed/modified files, iirc.)  Normally that's =
a
> very short list.  With -C, you need to compare all
> added/removed/modified files with all others, which is slightly more
> work.  With --find-copies-harder, it becomes potentially a *lot* of
> work.

Thanks!  That clarifies a lot.

rg
