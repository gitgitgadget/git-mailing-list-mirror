From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: hg2git error
Date: Wed, 22 Jul 2009 18:05:24 +0000
Message-ID: <fabb9a1e0907221105n319391es3c928b1bcab4e86a@mail.gmail.com>
References: <alpine.DEB.1.00.0905241932301.26154@pacific.mpi-cbg.de> 
	<fabb9a1e0905241038x7ea22622k930f50b9c7598c6e@mail.gmail.com> 
	<alpine.DEB.1.00.0905242013080.26154@pacific.mpi-cbg.de> <fabb9a1e0905241120v65adf9f9u7b8d212e99d7f6cd@mail.gmail.com> 
	<alpine.DEB.1.00.0907221946590.7343@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Rocco Rutte <pdmef@gmx.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 22 20:05:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTgCS-0006OR-4M
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 20:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbZGVSFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 14:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbZGVSFq
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 14:05:46 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:60346 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbZGVSFp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 14:05:45 -0400
Received: by ewy26 with SMTP id 26so421178ewy.37
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bMwioq8mAo2XTqrjt5JlkzPHdLJNYZFYm7KlJuSJr1M=;
        b=ITNhXMKCDUOFD+djjsiGYvpq27JQ+jW0CkNHARn7e7kdbW2RkkkDcbJ+2/1c7KuwWI
         uGQtyTTHkoBQO5W1kZ919y/4tpXP9+dmZ+/lkJ7+zt3Z//F4UlaYdf1eneO0rkqe3qWD
         ovahDF3urAzrfy2SR4nj09mL2xuP/Nnmv65ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=j93FApJROMQZT1buDb7aKMBV+bfw94e3PUUzh70ytoCNvOHpT8IBe0Ya2w5pS3KSoa
         NvBNl7jB5bxIjyZ9o5oVqa/Kr4+y8fXjnCd/r/9W32MZcjRPZtG89gkV+fIVu4GxtfpX
         rGy4+sbuLO3EHGnbhykWrxRPVV1oiFXy0DFdQ=
Received: by 10.216.49.194 with SMTP id x44mr328654web.130.1248285944110; Wed, 
	22 Jul 2009 11:05:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907221946590.7343@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123763>

Heya,

On Wed, Jul 22, 2009 at 17:47, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Could you give me a quick run-through how to install it and use it to
> mirror, say, the netbeans repository?

Sure, feel free to ping me on IRC if you have any questions, I'll
explain my workflow for Melange, I reckon you can adapt it to suit
your needs.

1. clone hg-git
```
mkdir ~/code
git clone git://github.com/schacon/hg-git.git ~/code
```
2. edit your .hgrc to include the following to turn on the hg-git
plugin, and the bookmarks plugin which hg-git likes to use to store
branches from your git repository:
```
[extensions]
hgext.bookmarks =
git = ~/code/hg-git
```
3. hg clone the repository of your choice, I'll pretend it's ~/code/Melange
4. add the following to ~/code/Melange/.hg/hgrc:
```
[git]
intree=1
```
5. if possible, add '.git' to .hgignore, if not possible you'll just
have to live with it showing up in 'hg status'
6. run `hg gexport`, this will create a ~/code/Melange/.git which is a
regular git repository
7. add .hg to ~/code/Melange/.git/info/exclude
8. now each time you want to pull in new hg updates, run 'hg pull && hg gexport'
9. Depending on your preferences, you might want to add the following
to your ~/code/Melange/.hg/hgrc below intree=1:
```
exportbranch=refs/heads/from-hg
```

Doing so will cause `hg gexport` to override the 'from-hg' branch
instead of 'refs/heads/master', allowing you to work in the git
repository without worrying about losing any changes when you run `hg
gexport`.
10. Push from the git repository as usual:
```
git remote add origin ssh://srabbelier@repo.or.cz/srv/git/Melange.git
git push origin master
```

If you have any questions, feel free to ask :).

-- 
Cheers,

Sverre Rabbelier
