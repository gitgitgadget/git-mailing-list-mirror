From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: master: t5800-remote-helpers.sh hangs on test "pulling from
 remote remote"
Date: Sun, 15 Apr 2012 14:51:41 +0200
Message-ID: <20120415125140.GA15933@ecki>
References: <4F893CD8.5020700@gmail.com>
 <20120414201446.GB29999@ecki>
 <4F8A0F96.5060408@gmail.com>
 <20120415011118.GA4123@ecki>
 <4F8A8211.2010908@gmail.com>
 <20120415105943.GD6263@ecki>
 <4F8AAE7C.1020507@gmail.com>
 <20120415114518.GB9338@ecki>
 <4F8AB7F1.1020705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 14:53:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJOwy-0002gl-0D
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 14:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab2DOMw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 08:52:59 -0400
Received: from smtpout12.highway.telekom.at ([195.3.96.74]:22857 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753157Ab2DOMw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 08:52:58 -0400
Received: (qmail 11215 invoked from network); 15 Apr 2012 12:52:55 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL505.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub78.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <srabbelier@gmail.com>; 15 Apr 2012 12:52:53 -0000
Content-Disposition: inline
In-Reply-To: <4F8AB7F1.1020705@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195566>

Hi Sverre,

The 'pushing to local repo' test of t5800 which pushes using
git-remote-testgit.py results in a deadlock for Stefano. Invoking
fast-export/fast-import manually seems to work, however. I don't know
what else to try at this point.

I am pasting some relevant results below.

> expecting success:
>         (cd localclone &&
>         echo content >>file &&
>         git commit -a -m three &&
>         GIT_TRACE=1 GIT_TRANSPORT_HELPER_DEBUG=1 GIT_DEBUG_TESTGIT=1 git push) &&
>         compare_refs localclone HEAD server HEAD
> 
> [...]
> Debug: Remote helper: -> export
> trace: run_command: 'fast-export' '--use-done-feature' '--export-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed
> 7c49f539a8c/testgit.marks' '--import-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' '^refs/testgit/origin/master' 'refs/heads/master'
> trace: exec: 'git' 'fast-export' '--use-done-feature' '--export-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' '--import-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' '^refs/testgit/origin/master' 'refs/heads/master'
> trace: built-in: git 'fast-export' '--use-done-feature' '--export-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' '--import-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' '^refs/testgit/origin/master' 'refs/heads/master'
> Got command 'export' with args ''
> trace: built-in: git 'for-each-ref' 'refs/heads'
> Debug: Remote helper: Waiting...
> trace: exec: 'git-fast-import' '--quiet' '--export-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks' '--import-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks'
> trace: run_command: 'git-fast-import' '--quiet' '--export-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks' '--import-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks'

This is Stefano's output, at which point git fast-import hangs. On my
box, fast-export runs a little later (after Got command 'export' with
args ''), but I don't see how that would matter.

Below is the result from running fast-import/fast-export manually:

On Sun, Apr 15, 2012 at 01:58:41PM +0200, Stefano Lattarini wrote:
> On 04/15/2012 01:45 PM, Clemens Buchacher wrote:
> > Hi Stefano,
> > 
> > Almost there. :-)
> > 
> > On Sun, Apr 15, 2012 at 01:18:20PM +0200, Stefano Lattarini wrote:
> >>
> >> $ git 'fast-export' '--use-done-feature' \
> >>       '--export-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
> >>       '--import-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
> >>       '^refs/testgit/origin/master' 'refs/heads/master' \
> >>    | git 'fast-import' \
> >>          '--export-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks' \
> >>          '--import-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks'
> > 
> > To simulate a git push, you have to run fast-export from localclone and
> > fast-import from the server directory. I.e. starting out in
> > t/trash directory.t5800-remote-helpers:
> > 
> > $ (cd localclone; git fast-export --use-done-feature \
> >       --export-marks='.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
> >       --import-marks='.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
> >       ^refs/testgit/origin/master refs/heads/master) |
> >   (cd server; git fast-import \
> >          --export-marks='/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks' \
> >          --import-marks='/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks')
> >
> OK, I cut & pasted your command; it ran successfully, with this output:
> 
> git-fast-import statistics:
> ---------------------------------------------------------------------
> Alloc'd objects:       5000
> Total objects:            3 (         0 duplicates                  )
>       blobs  :            1 (         0 duplicates          0 deltas of          1 attempts)
>       trees  :            1 (         0 duplicates          0 deltas of          1 attempts)
>       commits:            1 (         0 duplicates          0 deltas of          0 attempts)
>       tags   :            0 (         0 duplicates          0 deltas of          0 attempts)
> Total branches:           1 (         1 loads     )
>       marks:           1024 (         6 unique    )
>       atoms:              1
> Memory total:          2294 KiB
>        pools:          2098 KiB
>      objects:           195 KiB
> ---------------------------------------------------------------------
> pack_report: getpagesize()            =       4096
> pack_report: core.packedGitWindowSize =   33554432
> pack_report: core.packedGitLimit      =  268435456
> pack_report: pack_used_ctr            =          2
> pack_report: pack_mmap_calls          =          1
> pack_report: pack_open_windows        =          1 /          1
> pack_report: pack_mapped              =        253 /        253
> ---------------------------------------------------------------------
> 
> Thanks,
>   Stefano
> 
> Other possibly relevant information:
> 
>   $ hg --version | head -1
>   Mercurial Distributed SCM (version 1.8.3) $ python --version
> 
>   $ python --version
>   Python 2.7.2+
> 
>   $ /bin/sh --version | head -1
>   GNU bash, version 4.1.5(1)-release (i486-pc-linux-gnu)
> 
>   $ git describe
>   v1.7.10-167-gf245c01

Clemens
