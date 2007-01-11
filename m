From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: add clean-obsolete-scripts target
Date: Thu, 11 Jan 2007 09:32:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701110929400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701101319480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vhcuyaaxq.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701110919040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 09:32:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4vM4-00088b-OA
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 09:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbXAKIcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 03:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbXAKIcJ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 03:32:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:58364 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030216AbXAKIcI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 03:32:08 -0500
Received: (qmail invoked by alias); 11 Jan 2007 08:32:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 11 Jan 2007 09:32:05 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0701110919040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36557>

Hi,

On Thu, 11 Jan 2007, Johannes Schindelin wrote:

> On Wed, 10 Jan 2007, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > On Cygwin, newly builtins are not recognized, because there exist both
> > > the executable binaries (with .exe extension) _and_ the now-obsolete
> > > scripts (without extension), but the script is executed.
> > >
> > > "make clean-obsolete-scripts" removes these ambiguities by removing the
> > > older of these file pairs.
> > 
> > I would prefer it to be rather automatic -- how about this instead?
> 
> I like your method better. However, does it execute an rm -f for _every_ 
> builtin, even if it does not exist? This is a huge performance eater on 
> cygwin. Every fork() is _expensive_.
> 
> Even worse: are you sure that it does not remove the _builtins_? Maybe you 
> noticed that I asked for "git-bla." instead of "git-bla", since the latter 
> will happily access "git-bla.exe" (at least when you do an "ls git-bla" 
> and "git-bla.exe" exists, but not "git-bla", it _will_ show 
> the metadata of "git-bla.exe", but with the name "git-bla").
> 
> Will test.

Okay, I tested. And it works, indeed. No idea why, though. And while it 
looks a bit strange [*1*], the performance is not as bad as I expected.

Ciao,
Dscho

[*1*]

$ make
[...]
rm -f git-pack-refs.exe && ln git.exe git-pack-refs.exe
rm -f 'git-convert-objects';  rm -f 'git-fetch-pack';  rm -f 
'git-fsck-objects';  rm -f 'git-hash-object';  rm -f 'git-index-pack';  rm 
-f 'git-local-fetch';  rm -f 'git-daemon';  rm -f 'git-merge-index';  rm 
-f 'git-mktag';  rm -f 'git-mktree';  rm -f 'git-patch-id';  rm -f 
'git-peek-remote';  rm -f 'git-receive-pack';  rm -f 'git-send-pack';  rm 
-f 'git-shell';  rm -f 'git-show-index';  rm -f 'git-ssh-fetch';  rm -f 
'git-ssh-upload';  rm -f 'git-unpack-file';  rm -f 
'git-update-server-info';  rm -f 'git-upload-pack';  rm -f 
'git-verify-pack';  rm -f 'git-pack-redundant';  rm -f 'git-var';  rm -f 
'git-merge-tree';  rm -f 'git-imap-send';  rm -f 'git-merge-recursive';  
rm -f 'git-ssh-pull';  rm -f 'git-ssh-push';  rm -f 'git-http-fetch';  rm 
-f 'git-http-push';  rm -f 'git-merge-recur';  rm -f 'git-format-patch';  
rm -f 'git-show';  rm -f 'git-whatchanged';  rm -f 'git-cherry';  rm -f 
'git-get-tar-commit-id';  rm -f 'git-init';  rm -f 'git-add';  rm -f 
'git-annotate';  rm -f 'git-apply';  rm -f 'git-archive';  rm -f 
'git-blame';  rm -f 'git-branch';  rm -f 'git-cat-file';  rm -f 
'git-checkout-index';  rm -f 'git-check-ref-format';  rm -f 
'git-commit-tree';  rm -f 'git-count-objects';  rm -f 'git-describe';  rm 
-f 'git-diff';  rm -f 'git-diff-files';  rm -f 'git-diff-index';  rm -f 
'git-diff-stages';  rm -f 'git-diff-tree';  rm -f 'git-fmt-merge-msg';  rm 
-f 'git-for-each-ref';  rm -f 'git-grep';  rm -f 'git-init-db';  rm -f 
'git-log';  rm -f 'git-ls-files';  rm -f 'git-ls-tree';  rm -f 
'git-mailinfo';  rm -f 'git-mailsplit';  rm -f 'git-merge-base';  rm -f 
'git-merge-file';  rm -f 'git-mv';  rm -f 'git-name-rev';  rm -f 
'git-pack-objects';  rm -f 'git-prune';  rm -f 'git-prune-packed';  rm -f 
'git-push';  rm -f 'git-read-tree';  rm -f 'git-reflog';  rm -f 
'git-repo-config';  rm -f 'git-rerere';  rm -f 'git-rev-list';  rm -f 
'git-rev-parse';  rm -f 'git-rm';  rm -f 'git-runstatus';  rm -f 
'git-shortlog';  rm -f 'git-show-branch';  rm -f 'git-stripspace';  rm -f 
'git-symbolic-ref';  rm -f 'git-tar-tree';  rm -f 'git-unpack-objects';  
rm -f 'git-update-index';  rm -f 'git-update-ref';  rm -f 
'git-upload-archive';  rm -f 'git-verify-pack';  rm -f 'git-write-tree';  
rm -f 'git-show-ref';  rm -f 'git-pack-refs';  rm -f 'git';
[...]
