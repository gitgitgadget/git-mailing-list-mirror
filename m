From: david@lang.hm
Subject: Re: When Will We See Collisions for SHA-1? (An interesting analysis
 by Bruce Schneier)
Date: Tue, 16 Oct 2012 11:32:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1210161131100.13407@asgard.lang.hm>
References: <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com> <CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com> <20121015183438.GB31658@sigill.intra.peff.net> <507D4651.6080207@lsrfire.ath.cx> <20121016173254.GD27243@sigill.intra.peff.net>
 <20121016175806.GB26650@thunk.org> <20121016182751.GA30010@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 20:33:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOBwo-0001pg-Pd
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 20:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492Ab2JPScs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 14:32:48 -0400
Received: from mail.lang.hm ([64.81.33.126]:48700 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755118Ab2JPScr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 14:32:47 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id q9GIWa2U020582;
	Tue, 16 Oct 2012 11:32:36 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20121016182751.GA30010@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207869>

On Tue, 16 Oct 2012, Jeff King wrote:

> On Tue, Oct 16, 2012 at 01:58:06PM -0400, Theodore Ts'o wrote:
>
>> I seem to recall that there was at least some discussion at one point
>> about adding some extra fields to the commit object in a backwards
>> compatible way by adding it after the trailing NUL.  We didn't end up
>> doing it, but I could see it being a useful thing nonetheless (for
>> example, we could potentially put the backup SHA-2/SHA-3 pointer there).
>
> I don't see much point in it. If we want to add new backup pointers to
> commit objects, it is very easy to do so by adding new header fields.
>
> A much bigger problem is the other places we reference sha1s. The
> obvious place is trees, which have no room for backup pointers (either
> in headers, or with a NUL trick). But it also means that any time you
> have a sha1 that you arrive at in some other way than traversal from a
> signature, you are vulnerable to attack. E.g., if I record a sha1 in an
> external system, today I can be sure that when I fetch the object for
> that sha1, it is valid (or I can check that it is valid by hashing it).
> With sha1 collisions, I am vulnerable to attack.

If you have two hashes of the same contents (SHA1 and SHA3) and they both 
agree that the file has not been tampered with, you should still be in 
good shape just using the SHA1 as a reference.

David Lang
