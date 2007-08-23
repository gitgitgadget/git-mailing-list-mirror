From: David Kastrup <dak@gnu.org>
Subject: Re: confused about preserved permissions
Date: Thu, 23 Aug 2007 10:08:18 +0200
Message-ID: <86fy2abrm5.fsf@lola.quinscape.zz>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <6031FB22-648E-47DE-92EE-2E7255322C27@lrde.epita.fr> <7v8x83i5ma.fsf@gitster.siamese.dyndns.org> <20070823060052.GA25153@piper.oerlikon.madduck.net> <85mywiixtp.fsf@lola.goethe.zz> <B38B8F2F-92B0-48F4-9093-54724FA862C2@lrde.epita.fr> <7vfy2avg2b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 10:08:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO7kH-0003MC-GI
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 10:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552AbXHWIIq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 04:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbXHWIIp
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 04:08:45 -0400
Received: from main.gmane.org ([80.91.229.2]:45070 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755552AbXHWIIn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 04:08:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IO7jz-0004cu-4T
	for git@vger.kernel.org; Thu, 23 Aug 2007 10:08:31 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 10:08:31 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 10:08:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:DZFGXuXOFGGgVyNfquGdCFpC1xU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56470>

Junio C Hamano <gitster@pobox.com> writes:

> Benoit SIGOURE <tsuna@lrde.epita.fr> writes:
>
>> Let's look at the problem from another point of view then: I want my
>> *working tree* to be group readable even though my umask is 066.
>
> I have to wonder if there is any sane development tool that
> supports that kind of thing.  E.g. vi, emacs, gcc,...?  If you
> allowed a tool to do that, what's the point of having a umask?

Hm?  Are we talking about the same Emacs here?  The thing that has a
directory editor built into it with which one can do chmod and so on?

Here are a few functions:

    executable-make-buffer-file-executable-if-script-p is an autoloaded Lisp function in `executable'.
    (executable-make-buffer-file-executable-if-script-p)

    Make file executable according to umask if not already executable.
    If file already has any execute bits set at all, do not change existing
    file modes.


----------------
dired-do-chmod
  Command: Change the mode of the marked (or next ARG) files.
This calls chmod, thus symbolic modes like `g+w' are allowed.

(fn &optional ARG)

----------------
executable-set-magic
  Command: Set this buffer's interpreter to INTERPRETER with optional ARGUMENT.
The variables `executable-magicless-file-regexp', `executable-prefix',
`executable-insert', `executable-query' and `executable-chmod' control
when and how magic numbers are inserted or replaced and scripts made
executable.

(fn INTERPRETER &optional ARGUMENT NO-QUERY-FLAG INSERT-FLAG)



However, Emacs does not provide a hook into the system call as far as
I can see: it calls chmod explicitly.


-- 
David Kastrup
