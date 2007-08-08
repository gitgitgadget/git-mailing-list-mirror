From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: 'pu' branch for StGIT
Date: Wed, 8 Aug 2007 23:39:17 +0200
Message-ID: <20070808213917.GA22521@diana.vm.bytemark.co.uk>
References: <20070807022043.GA8482@diana.vm.bytemark.co.uk> <1186549433.2112.34.camel@dv> <20070808092027.GB7860@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 23:39:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IItFd-0008EY-0o
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 23:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935828AbXHHVj2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 8 Aug 2007 17:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763820AbXHHVj2
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 17:39:28 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2870 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765029AbXHHVj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 17:39:27 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IItFN-0005vA-00; Wed, 08 Aug 2007 22:39:17 +0100
Content-Disposition: inline
In-Reply-To: <20070808092027.GB7860@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55373>

On 2007-08-08 11:20:27 +0200, Karl Hasselstr=F6m wrote:

> On 2007-08-08 01:03:53 -0400, Pavel Roskin wrote:
>
> > Also, "stg import" commits the patch, which seems wrong to me.
>
> Hmm, I hadn't noticed. That would be an unintended side-effect of
> the DAG patches, presumably. I'll look into it tonight.

I can't reproduce. (Using master of git://repo.or.cz/stgit/kha.git.)
The last subtest of t1800 actually tests that a mailbox was imported
as a series of patches, and that works fine for me (the other subtests
don't make sure that a patch was created; they just verify that we got
the right tree). Furthermore, the following works for me:

kha@yoghurt:~/stgit/t> ./t1800-import.sh
*   ok 1: Initialize the StGIT repository
*   ok 2: Apply a patch created with "git diff"
*   ok 3: Apply a patch created with GNU diff
*   ok 4: Apply a patch created with "stg export"
*   ok 5: Apply a patch from an 8bit-encoded e-mail
*   ok 6: Apply a patch from a QP-encoded e-mail
*   ok 7: Apply several patches from an mbox file
* passed all 7 test(s)
kha@yoghurt:~/stgit/t> cd trash/
kha@yoghurt:~/stgit/t/trash> ls
foo.txt
kha@yoghurt:~/stgit/t/trash> PATH=3D/home/kha/stgit:$PATH stg series -d
kha@yoghurt:~/stgit/t/trash> PATH=3D/home/kha/stgit:$PATH stg import -m=
 ../t1800-import/email-qp
Checking for changes in the working directory ... done
=46inding uninteresting commits ... done
Importing patch "email-qp" ... done
Now at patch "email-qp"
kha@yoghurt:~/stgit/t/trash> PATH=3D/home/kha/stgit:$PATH stg series -d
> email-qp | test patch

So a patch is definitely created. Could you describe in more detail
exactly what you do to make it fail?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
