From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 19:33:38 -0400
Message-ID: <45395CD2.4020508@utoronto.ca>
References: <200610180057.25411.jnareb@gmail.com> <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org> <20061018053647.GA3507@coredump.intra.peff.net> <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org> <20061018185225.GU20017@pasky.or.cz> <eh76np$trg$1@sea.gmane.org> <BAYC1-PASMTP061F10D0B5AF9F6608134CAE0C0@CEZ.ICE> <4538D724.5040508@utoronto.ca> <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca> <20061020224030.GL20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090607000304000307000008"
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 01:40:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb3yE-00031q-H5
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 01:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992741AbWJTXkH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 19:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992743AbWJTXkH
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 19:40:07 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:39840 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S2992741AbWJTXkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 19:40:03 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Gb3sR-0007bs-00; Fri, 20 Oct 2006 19:34:11 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061020224030.GL20017@pasky.or.cz>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29559>

This is a multi-part message in MIME format.
--------------090607000304000307000008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Petr Baudis wrote:
> Dear diary, on Fri, Oct 20, 2006 at 05:34:39PM CEST, I got a letter
> where Aaron Bentley <aaron.bentley@utoronto.ca> said that...
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Jakub Narebski wrote:
>>> Aaron Bentley wrote:
>>>> In Bazaar bundles, the text of the diff is an integral part of the data.
>>>> It is used to generate the text of all the files in the revision.
>>>
>>> I thought that the diff was combined diff of changes.
>> It is.  It's a description of how to produce revision X given revision
>> Y, where Y is the last-merged mainline revision.
> 
> Aha, so by default a bundle can carry just a _single_ revision?

No, bundles contain 1 or more revisions.  They contain all the ancestors
of X that are not ancestors of Y.

Only the diff from X to Y is shown, but the diffs for all other
revisions are present in the MIME-encoded section.

Consider these four revisions in a straight-line ancestry: a, b, c, d.
'a' is a common ancestor.  b, c and d are the revisions that are missing
from the target repository.

A default bundle will contain

metadata for d
diff from a -> d in plaintext
metadata for c
diff from b -> c in MIME encoding
metadata for b
diff from a -> b in MIME encoding

To install b, the diff for a->b is applied to a.  To install c, the diff
for b->c is applied to b.  To install d, the diff for a -> d is applied
to a.

Doing a diff from a -> d instead of from c -> d introduces some
redundancy, of course.  But we do that because we want an overview diff.

> That doesn't sound right either, because then it wouldn't make sense to
> talk about "combined" or "simple" diffs. So I guess sending a bundle
> really is taking n revisions at your side, bundling them to a single
> diff and when the other side takes it, it will result in a single
> revision?

No, it copies the revisions verbatim, and we are careful to avoid data loss.

> Hmm, but that doesn't sound right either, that's certainly no revolting
> functionality and seems to be in contradiction with previous bundles
> description. But if it doesn't squash the changes, I don't see how the
> combined diff can be integral part of the data. Sorry, I don't get it.

It's because there's no other diff in the bundle that produces 'd'.

>> I've attached an example of what a combined patch-by-patch bundle looks
>> like.
> 
> But that's the one there's no UI to select? Or where is the combined
> diff?

That is the one that doesn't have UI to select it.  I've attached a
normal bundle for comparison.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFOVzR0F+nu1YWqI0RAkACAJ4z2SJZgelZLfhoFKhEZbmvRIXMjACfag+h
6j+5vvIeHt7xMZOvp6CUcPk=
=33G4
-----END PGP SIGNATURE-----

--------------090607000304000307000008
Content-Type: text/x-patch;
 name="hello-world-default.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hello-world-default.patch"

# Bazaar revision bundle v0.8
#
# message:
#   Added 'world'
# committer: Aaron Bentley <abentley@panoramicfeedback.com>
# date: Fri 2006-10-20 11:30:21.903000116 -0400

=== added directory  // file-id:TREE_ROOT
=== added file world // file-id:world-20061020152929-12bknd8mm9mx48as-1
--- /dev/null
+++ world
@@ -0,0 +1,1 @@
+Hello, world

# revision id: abentley@panoramicfeedback.com-20061020153021-b5fcea14e9cd2b34
# sha1: 6d553e72158aaa76c258d98c15cd24922d171cd9
# inventory sha1: 64af82c4d81d9d6ad4f33fc734d32c2a1eaa0df5
# parent ids:
#   abentley@panoramicfeedback.com-20061020152951-10cff5ff5a51e9a2
# base id: null:
# properties:
#   branch-nick: bar

# message:
#   Capitalized
# committer: Aaron Bentley <abentley@panoramicfeedback.com>
# date: Fri 2006-10-20 11:29:51.953999996 -0400

=== modified file world // encoding:base64
LS0tIHdvcmxkCisrKyB3b3JsZApAQCAtMSwxICsxLDEgQEAKLWhlbGxvCitIZWxsbwoK

=== modified directory  // last-changed:abentley@panoramicfeedback.com-20061020
... 152951-10cff5ff5a51e9a2
# revision id: abentley@panoramicfeedback.com-20061020152951-10cff5ff5a51e9a2
# sha1: f7b79934bc3b0a944e35168b5df6b106c5b29ebf
# inventory sha1: 1400d56451752300cc31c9c94ff7ee2188e8ef8c
# parent ids:
#   abentley@panoramicfeedback.com-20061020152935-64bde004f622131f
# properties:
#   branch-nick: bar

# message:
#   initial commit
# committer: Aaron Bentley <abentley@panoramicfeedback.com>
# date: Fri 2006-10-20 11:29:35.536999941 -0400

=== added directory  // file-id:TREE_ROOT
=== added file world // file-id:world-20061020152929-12bknd8mm9mx48as-1 // enco
... ding:base64
LS0tIC9kZXYvbnVsbAorKysgd29ybGQKQEAgLTAsMCArMSwxIEBACitoZWxsbwoK

# revision id: abentley@panoramicfeedback.com-20061020152935-64bde004f622131f
# sha1: 0728f761b891b257f0a71e2e360799eec080cd21
# inventory sha1: e52e030ea40f6bf5da78f4e8eb8efcd072b0930a
# properties:
#   branch-nick: bar


--------------090607000304000307000008--
