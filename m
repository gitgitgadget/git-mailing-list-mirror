From: John Keeping <john@keeping.me.uk>
Subject: Re: Using clean/smudge filters with difftool
Date: Thu, 18 Jun 2015 15:11:16 +0100
Message-ID: <20150618141116.GK18226@serenity.lan>
References: <CAGA3++LiX9NyK94RPiuiG83X8FSRN4EkaxMchir51hGSQY90Tw@mail.gmail.com>
 <5582BA1F.1030409@drmicha.warpmail.net>
 <CAGA3++LrVSs3rMkg=S2Og48pz1yEBxwpcRsPt7sNLENRh1ooAg@mail.gmail.com>
 <20150618132622.GJ18226@serenity.lan>
 <CAGA3+++_mx=O=Un0pip8Q41X5PZBLmES=Hd=U=aSowryx5r=8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Florian Aspart <florian.aspart@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 16:11:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5aXV-0005H5-Dh
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 16:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127AbbFROL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 10:11:29 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:51792 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbbFROL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 10:11:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 01352CDA5FD;
	Thu, 18 Jun 2015 15:11:28 +0100 (BST)
X-Quarantine-ID: <pf7SHBB867s3>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pf7SHBB867s3; Thu, 18 Jun 2015 15:11:26 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 613A4CDA5ED;
	Thu, 18 Jun 2015 15:11:18 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAGA3+++_mx=O=Un0pip8Q41X5PZBLmES=Hd=U=aSowryx5r=8w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272009>

On Thu, Jun 18, 2015 at 03:51:25PM +0200, Florian Aspart wrote:
> 2015-06-18 15:26 GMT+02:00 John Keeping <john@keeping.me.uk>:
> > [Please don't top-post on this list.]
> >
> > On Thu, Jun 18, 2015 at 03:15:38PM +0200, Florian Aspart wrote:
> >> 2015-06-18 14:31 GMT+02:00 Michael J Gruber <git@drmicha.warpmail.net>:
> >> > Florian Aspart venit, vidit, dixit 16.06.2015 16:11:
> >> >> Hi everyone,
> >> >>
> >> >> I created a clean filter to apply on some files before commiting them.
> >> >> The filter works correctly when I commit the file and is also applied
> >> >> when I usethe iff command line tool.
> >> >> However, when using difftool with meld, the filter is not applied and
> >> >> the different versions of the files are compared without any
> >> >> filtering.
> >> >>
> >> >> Is there a way to apply the clean/smudge filters when comparing the
> >> >> working copy of a file to the HEAD version in a gui diff tool?
> >> >>
> >> >> I'm using git version 2.4.3 under Ubuntu.
> >> >>
> >> >> Best,
> >> >> Florian
> >> >
> >> > Are you saying that "difftool" compares an uncleaned working tree file
> >> > with a cleaned blob? That would be a bug in either difftool or the way
> >> > we feed difftool.
> >> >
> >> yes in this case "difftool" compares an uncleaned working tree file
> >> with a cleaned blob. I did not try the smudge filter to see if it
> >> applied in difftool.
> >>
> >> I think the problem comes from the way difftool is feeded, since I
> >> also had this problem when setting an external tool for the diff in
> >> the gitconfig file.
> >>
> >> However, I'm not sure if this is a bug or it is designed to be so.
> >> If the external tool changes a cleaned working tree file during the
> >> diff, then by saving this file the result of the cleaning filter would
> >> also be saved in the working tree.
> >
> > How is your filter configured?  Is it using a simple pattern (e.g.
> > "*.c") or is it using a file path?
> >
> > git-difftool uses `git checkout-index --all --prefix=$dir/` and I wonder
> > if the prefix means that the attribute specification does not match the
> > temporary file that difftool produces, so no filter is applied.
> 
> It is using a simple pattern:
> *.ipynb filter=clean_ipynb

I also realised that the code for file diff is very different from
directory diff do you see any difference between git-difftool acting on
files and with the `--dir-diff` option?
