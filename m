From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] use generic pci_iomap on all architectures
Date: Tue, 10 Jan 2012 18:38:58 -0800
Message-ID: <7vipkj7ykd.fsf@alter.siamese.dyndns.org>
References: <20120105145836.GA2751@redhat.com>
 <20120106083141.9c14a8d2d09539c6a6c0db75@canb.auug.org.au>
 <20120106083916.9588034bde22a6803e327aa9@canb.auug.org.au>
 <20120106084701.8f704542754db826deda318a@canb.auug.org.au>
 <CA+55aFwXj2ELrTDSgFfSC2Usz99-24uFSznAP34feJiCttwayQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Git Mailing List <git@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-arch-owner@vger.kernel.org Wed Jan 11 03:39:06 2012
Return-path: <linux-arch-owner@vger.kernel.org>
Envelope-to: glka-linux-arch@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-arch-owner@vger.kernel.org>)
	id 1Rko5h-0002Vm-9H
	for glka-linux-arch@lo.gmane.org; Wed, 11 Jan 2012 03:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932901Ab2AKCjC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glka-linux-arch@m.gmane.org>);
	Tue, 10 Jan 2012 21:39:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51118 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933596Ab2AKCjB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2012 21:39:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38D9157C0;
	Tue, 10 Jan 2012 21:39:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WWV1xR0JTiId
	iXPn+Wo8olZWlTE=; b=Fbl7VcOI+3GYTVHShCjxB5LG3Pfg7yqXc1BhG/JkbsIP
	X4W+9WEl9uPgwCJvv0sxEEw3wiNOjhh6Oz8Ywv0wXy0QMQWx9kgM6W+omC/ZqcGE
	YDG2tVDQSmIptJfukXHBFiTOUHy6GO6E/aWz7pffZlnNlbsrqnO81q84lkZ2C/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Y0AmOM
	m7uYm4HW8FY3IG+2q6XD6MFPQU7kTzsyCXiNTCLSVm3wi5rMAV80x4kghf2xBDxF
	pvyGSxFKkVfWGnMpHbxspGCCgFGXoURJnCoo+qfrWxHTze2v+FH4IeSjzhK1rg/g
	UfEZm00GY1qzjfFQEMZFSk+YtwiyINYPrk51E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2998957BF;
	Tue, 10 Jan 2012 21:39:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6C1857BC; Tue, 10 Jan 2012
 21:38:59 -0500 (EST)
In-Reply-To: <CA+55aFwXj2ELrTDSgFfSC2Usz99-24uFSznAP34feJiCttwayQ@mail.gmail.com> (Linus
 Torvalds's message of "Tue, 10 Jan 2012 17:51:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A7D5DE4-3BFD-11E1-8274-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188312>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Jan 5, 2012 at 1:47 PM, Stephen Rothwell <sfr@canb.auug.org.a=
u> wrote:
>> On Fri, 6 Jan 2012 08:39:16 +1100 Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>>>
>>> So why does you pull request refer to "commit
>>> 805a6af8dba5dfdd35ec35dc52ec0122400b2610", I wonder? =C2=A0Is that =
just what
>>> "git request-pull" produced?
>>
>> I see, "git request-pull" just puts in whatever you specify on the
>> command line rather than the merge-base ...
>
> .. and that is a fairly silly misfeature, since it makes the "since
> commit xyz" largely meaningless.
>
> I suspect we really should make "git request-pull" show the merge
> base(s) as the "since commit", because that way the output of git
> request-pull is "stable", and doesn't depend on what particular rando=
m
> state you've synced up to since.
>
> Junio, I think the patch would be as simple as the attached - totally
> untested - one-liner? Comments?

I think it makes sense.

We use whatever garbage the user gave us (e.g. "origin/linus" which may
have been updated since the topic forked and be made irrelevant) only t=
o
figure out where the history forked, and once we find that out we
consistently use the fork-point which has some meaning.

The parameter to "git shortlog" that appears later should also be updat=
ed
to match this, by the way, even though that should not affect the outco=
me
in any way.

I am however not sure what would happen when there are more than one me=
rge
bases. I guess those who throw pull requests are not supposed to be doi=
ng
merges in reverse direction, so it should not matter ;-)

 git-request-pull.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index d7ba117..38b68bb 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -96,7 +96,7 @@ git show -s --format=3D'The following changes since c=
ommit %H:
   %s (%ci)
=20
 are available in the git repository at:
-' $baserev &&
+' $merge_base &&
 echo "  $url${ref+ $ref}" &&
 git show -s --format=3D'
 for you to fetch changes up to %H:
@@ -124,7 +124,7 @@ then
 	echo "---------------------------------------------------------------=
-"
 fi &&
=20
-git shortlog ^$baserev $headrev &&
+git shortlog $merge_base..$headrev &&
 git diff -M --stat --summary $patch $merge_base..$headrev || status=3D=
1
=20
 if test -z "$ref"
