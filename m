From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Tue, 25 Nov 2008 18:34:47 +0100
Message-ID: <20081125173447.GB13935@m62s10.vlinux.de>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Fabian Seoane <fabian@fseoane.net>
To: Ondrej Certik <ondrej@certik.cz>
X-From: git-owner@vger.kernel.org Tue Nov 25 18:36:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L51pX-0002he-VP
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 18:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbYKYRew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 12:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbYKYRew
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 12:34:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:33207 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752747AbYKYRev (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 12:34:51 -0500
Received: (qmail invoked by alias); 25 Nov 2008 17:34:49 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp042) with SMTP; 25 Nov 2008 18:34:49 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+qJtF7LA+qUiUerkybkI3Ap+dd+ZBq5I1ytG0R9n
	cEg/Ad+Jsfw3wg
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 8FFA91818B; Tue, 25 Nov 2008 18:34:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101672>

On Tue, Nov 25, 2008 at 05:44:28PM +0100, Ondrej Certik wrote:
> Hi,
> 
> I would like to export our whole git repository to patches, and then
> reconstruct it again from scratch. Following the man page of "git
> fast-export":
> 

Perhabs you are looking for git filter-branch, because it seems you want
to change the history in some way (e.g. remove a wrongly committed file)?

Nevertheless, I expect your shown commands below to procude the same
repo again, so you might be on something ...

-Peter


> $ git clone git://git.sympy.org/sympy-full-history-20081023.git
> $ cd sympy-full-history-20081023
> $ git fast-export --all --export-marks=marks > patches
> $ cd ..
> $ mkdir sympy-new
> $ cd sympy-new
> $ git init
> $ git fast-import --export-marks=marks < ../sympy-full-history-20081023/patches
> git-fast-import statistics:
> ---------------------------------------------------------------------
> Alloc'd objects:      25000
> Total objects:        21355 (       144 duplicates                  )
>       blobs  :         8009 (         0 duplicates       4529 deltas)
>       trees  :        10627 (       144 duplicates       9189 deltas)
>       commits:         2719 (         0 duplicates          0 deltas)
>       tags   :            0 (         0 duplicates          0 deltas)
> Total branches:          21 (        26 loads     )
>       marks:        1048576 (     10728 unique    )
>       atoms:            726
> Memory total:          2880 KiB
>        pools:          2098 KiB
>      objects:           781 KiB
> ---------------------------------------------------------------------
> pack_report: getpagesize()            =       4096
> pack_report: core.packedGitWindowSize =   33554432
> pack_report: core.packedGitLimit      =  268435456
> pack_report: pack_used_ctr            =      40706
> pack_report: pack_mmap_calls          =       2791
> pack_report: pack_open_windows        =          1 /          2
> pack_report: pack_mapped              =   26177739 /   35513414
> ---------------------------------------------------------------------
> 
> 
> 
> However, the repository is very different to the original one. It
> contains only 191 patches:
> 
> $ git log --pretty=oneline | wc -l
> 191
> 
> and it only contains couple files. Compare this with the original repository:
> 
> $ git log --pretty=oneline | wc -l
> 2719
> 
> What am I doing wrong? Is there some other way to do it? I also tried
> "git format-patch" and "git am" and that almost works, only it changes
> hashes. Is there some way to tell "git am" to preserve the hash?
> 
> Thanks,
> Ondrej
