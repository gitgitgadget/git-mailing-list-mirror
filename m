From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit: Annotate hundreds of files at terrific speed ;-)
Date: Mon, 25 Jun 2007 07:59:07 +0200
Message-ID: <e5bfff550706242259s143fe874mf82736426e94ecba@mail.gmail.com>
References: <e5bfff550706230935m5363a6dava9dbd62a56a1b685@mail.gmail.com>
	 <20070624230851.GN17393@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 07:59:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2hbV-0006CF-Q5
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 07:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbXFYF7L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 01:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbXFYF7K
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 01:59:10 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:63711 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbXFYF7I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 01:59:08 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1688682wah
        for <git@vger.kernel.org>; Sun, 24 Jun 2007 22:59:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EdGWlXt5zaIDTjMVnaZhASYk5nsv8LCYLTWiwFznQnPZgVPKQdiaZOHBqtXs4N5TDaoBDBbCjqfcTlJj1GCriW7QV2Bhw3QNZ0HNhqtIQqy4ohTGKlBqHlpL6F+RHgaLKD5oZKNghBjWWVCY6xeKVv+hq9CR49oOcKtjYll4HIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m37mKnzNShzW5iMXUbhgrNXx92mKUS0+ljLOHLyosNHTWA2TR3VqVyHAc22uylHCzuNPedoCtUU3FMZG7C9OX5K3FP+GViNe0Q0tDzjxlQsz8THuceD1y7/sYE6OdvzvqUbi3p2uxZs1OdHAX5s+CUmpiK94mkEZ/CEyrGsl/YA=
Received: by 10.115.107.1 with SMTP id j1mr5137711wam.1182751147980;
        Sun, 24 Jun 2007 22:59:07 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 24 Jun 2007 22:59:07 -0700 (PDT)
In-Reply-To: <20070624230851.GN17393@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50860>

On 6/25/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Marco Costalba <mcostalba@gmail.com> wrote:
> > You get _all_ the hundreds (more then 800) of revisions of this
> > monster history annotated in the time it takes *other* ;-) tools to
>
> By "other tools" do you mean git-blame?  ;-)
>

git-blame has some powerful features, like the possibility to follow
renames, and is fast enough for what it has to do, ie annotate _one_
file.

But missing to annotate all the file's history has its drawbacks for
using in a GUI tool, some clear, other not so clear:

- browsing among file revisions it's slow because after each user
'click' another annotation cycle should start from scratch (clear
issue).

- jumping from one file revision to another keeping the same mouse
selection or view (current line at the top of the view) is not
possible in general case without parsing all the annotations between
the two revisions.

- filtering, ie selecting with the mouse some lines and getting a
subset of the file history that modified at least one of that lines is
not possible.


So when 'git log --follow' patch will be mainstream I think current
qgit 'git log'  based annotation will be superior to a git-blame based
interface under any point.

Regarding speed IMHO it is already faster, ie it takes already the
same or _less_ time to qgit to annotate all the 800 and more file's
revisions of git Makefile then to git-blame/git-gui to annotate _one_
of them.

Note that this is not a problem of implementation, but of algorithm.
Simply, the best algorithm to annotate one file is different from the
best one to annotate all of them. Another thing I've experienced is
that on old files in big repos (kernel/sched.c) the time to get the
file history its much bigger then time to annotate them.


Sure, in git-blame annotation it's incremental, you don't have to wait
the end of history loading to start to show stuff. I've used it, but,
probably a my limit, I really don't start to analyze what I have until
git-blame has finished.

So *for me*, the incremental blaming it's more or less a kind of fancy
progress bar, when you really care to search some blaming info.


Regarding the CVS oriented annotation of qgit it's simply a problem
that I have no space to show the commit when the user selects a line.
In git-gui the half bottom screen space is dedicated to that, in qgit
the half top space is instead reserved for file history. Anyhow in
qgit you can double click on any annotation line and the history will
jump to the corresponding revision, from there (right click->popup
menu) you can sync the other tabs so to see full commit and patch.

I'm thinking on a way to add a quick view of commit log message when
the user clicks/selects/something-else on a line (in qgit memory there
is already all the needed info, remember, annotation it's git-log
based), but the screen space it's an issue.


Marco
