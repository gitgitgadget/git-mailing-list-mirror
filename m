From: Vicent Marti <tanoku@gmail.com>
Subject: [GSoC] libgit2 before the first evaluation
Date: Sat, 10 Jul 2010 19:31:22 +0200
Message-ID: <AANLkTil46G2eI2cmXL5mHWrxFbCuavrFlcScT-7nwdoh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Andreas Ericsson <ae@op5.se>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 10 19:31:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXdu1-0003ht-Hd
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 19:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576Ab0GJRbp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jul 2010 13:31:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48060 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab0GJRbo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jul 2010 13:31:44 -0400
Received: by fxm14 with SMTP id 14so1666695fxm.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=AkCa6bV0Glq3aSHHgDKs5pFhJKzQX1UNtL1S8j318Ac=;
        b=yEWYQGd1cg7toWhsIN9LnVoEtSxr/JjPGFxj9zyKMolPQ23uo68F9ujd5cWiGRDwSa
         Ju6CjkOArajTFIftpCORPgF95PphchbgmClKGAWly47Cku2iKyoVP8i7AykoYu2vauJP
         +3KnjhBB4qpnZtvGn1NZOEx4tn5al66C0wjQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=Apc/xSkMsTCwAWHzTRdRZF8Vs6zn27iNjH/sozMZRH2ORxpb0Sf5L3vqG1RLE1JUCa
         gcUyC1ZGtwCWOdEx6TYeLp2zxytj+wUJX6KjPag+kfL534I50LzCHEt9FCvyL9GGwORm
         MZLy+NNSWoa1EOKd8lFvugGTdykOvSG/+d77g=
Received: by 10.103.199.5 with SMTP id b5mr2190645muq.76.1278783102269; Sat, 
	10 Jul 2010 10:31:42 -0700 (PDT)
Received: by 10.204.97.142 with HTTP; Sat, 10 Jul 2010 10:31:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150726>

Hello everybody,

the first coding period of this year's Summer of Code is almost over,
and the libgit2 project is looking good. Here's a short status update:

All the functionality for revision walking is in place in the main
development branch [1]; together with it there's a set of extra
functionality: a work in progress interface to load tree objects in
memory, and a finished interface to load commits in memory and extract
detailed information from them. All this code has been reviewed for
style and fixed accordingly (thanks Ramsay), and is in the process of
being reviewed for design. The libgit2 core developers have been very
busy lately, so any input on this matter is very much welcome.

=46urthermore, while waiting for code reviews I've created a new
development branch [2] and began working on the features required for
the second period of the Summer of Code. So far, there's support for
loading and parsing index files from disk; there is also a WIP
implementation of git-like atomic file locking [3] which will be
required for writing the index files back to disk.

I've been having some issues with file locking, however, since the
reference git.git implementation differs quite a bit from the one on
JGit: it seems like JGit applies an additional filesystem-level lock
(i.e. POSIX flock()) to the temporary ".lock" file, something which is
complicated to do in a cross-platform manner in C. There's also
differences between implementations which I'm trying to work out (not
easy since I'm no Java expert): for instance, it seems like the JGit
implementation doesn't update its internal state to signal that the
file is unlocked after a commit (LockFile.java:393). Are there any
JGit developers who can throw some insight into this?


Either way, once the atomic file locking issues have been solved, I'll
get started on the remaining functionality for working with index
files (modifying & writing back to disk) . After that, the last goal
for the Summer is the API for reference manipulation which hasn't been
designed yet. I'll keep you all updated.

Thanks for your time,
Vicent Mart=ED
http://www.bellverde.org

[1]: http://github.com/tanoku/libgit2-gsoc2010/commits/gsoc
[2]: http://github.com/tanoku/libgit2-gsoc2010/commits/gsoc-index
[3]: http://github.com/tanoku/libgit2-gsoc2010/commit/8b92be06f64c04c2b=
2d874cf00769a7deb9a2835
