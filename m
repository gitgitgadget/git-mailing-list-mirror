From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: Re: Git and GCC
Date: Sat, 8 Dec 2007 03:21:40 +0100
Message-ID: <998d0e4a0712071821o520a75c4lbcaae92256071f48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"David Miller" <davem@davemloft.net>, gcc@gcc.gnu.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 03:22:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0pKO-0002nq-9W
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 03:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbXLHCVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 21:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbXLHCVn
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 21:21:43 -0500
Received: from wr-out-0506.google.com ([64.233.184.233]:57219 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbXLHCVm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 21:21:42 -0500
Received: by wr-out-0506.google.com with SMTP id c49so750897wra
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 18:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=PZT/ph6TQAO1aaJ/mJsyL3syWihJc/oJZ1uC+mLD7Cw=;
        b=WhSQAqzrYf0eK22yGXMHXbVkUj4udSO1dva3DHOnucW9rkeNIInTtV9eX0zGGjggmyh0OJpHKQAp8yd6lIyCyYNQ83lgai6/wOzaHhHQIhbQYQeV9Trzq/ZtSiAxSZOQWVrHY8FtX/0KlYb/zgwtfU/hXR4bcFS9/6Su8F5rQzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=xrw1sJKFoB9RhEkaEdCZcoBYFc2UctRB5Fyi0UEOu6QEY7ZamXTk0ibuGsuewPGfwoefJJ/0eMlMf+rY501Md891rXGbVLofR3SpxC1Ud6uuapjbqMQdQdlOMzxJvVSbascNAmkotn0f1ZSn967U/xRWymWUr4rHFLrXL/Np7JA=
Received: by 10.70.49.4 with SMTP id w4mr874283wxw.1197080500623;
        Fri, 07 Dec 2007 18:21:40 -0800 (PST)
Received: by 10.70.54.17 with HTTP; Fri, 7 Dec 2007 18:21:40 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67497>

On 2007/12/07, "Linus Torvalds" <torvalds@linux-foundation.org> wrote:
> On Fri, 7 Dec 2007, David Miller wrote:
> >
> > Also I could end up being performance limited by SHA, it's not very
> > well tuned on Sparc.  It's been on my TODO list to code up the crypto
> > unit support for Niagara-2 in the kernel, then work with Herbert Xu on
> > the userland interfaces to take advantage of that in things like
> > libssl.  Even a better C/asm version would probably improve GIT
> > performance a bit.
>
> I doubt yu can use the hardware support. Kernel-only hw support is
> inherently broken for any sane user-space usage, the setup costs are just
> way way too high. To be useful, crypto engines need to support direct user
> space access (ie a regular instruction, with all state being held in
> normal registers that get saved/restored by the kernel).
>
> > Is SHA a significant portion of the compute during these repacks?
> > I should run oprofile...
>
> SHA1 is almost totally insignificant on x86. It hardly shows up. But we
> have a good optimized version there.

If SHA1 is slow then why dont he contribute adding Haval160 (3 rounds)
that it's faster than SHA1? And to optimize still more it with SIMD instructions
in kernelspace and userland.

>
> zlib tends to be a lot more noticeable (especially the uncompression: it
> may be faster than compression, but it's done _so_ much more that it
> totally dominates).
>
> 			Linus

It's better

1.   "Don't compress this repo but compact this uncompressed repo
      using minimal spanning forest and deltas"
2.   "After, compress this whole repo with LZMA (e.g. 48MiB) from 7zip before
      burning it to DVD for backup reasons or before replicating it to
internet".

   J.C.Pizarro "the noiser"
