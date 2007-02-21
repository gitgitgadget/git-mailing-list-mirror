From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-blame.el won't run
Date: Wed, 21 Feb 2007 14:55:31 +0100
Message-ID: <87vehvsjho.fsf@morpheus.local>
References: <13283.1171492535@localhost> <87mz393mlo.fsf@morpheus.local> <24475.1171920735@localhost> <87abz92rp9.fsf@morpheus.local> <4157.1171992534@localhost> <87fy9020ne.fsf@morpheus.local> <13478.1172059706@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 21 14:55:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJrwn-0000lo-GF
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 14:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161239AbXBUNzu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 21 Feb 2007 08:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161241AbXBUNzu
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 08:55:50 -0500
Received: from main.gmane.org ([80.91.229.2]:54000 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161239AbXBUNzt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 08:55:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HJrwb-0002pI-1k
	for git@vger.kernel.org; Wed, 21 Feb 2007 14:55:41 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Feb 2007 14:55:41 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Feb 2007 14:55:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:R8+eV4EUR6Mb2WV1iwCqHTWQ5C8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40298>

Xavier Maillard <zedek@gnu.org> writes:

> Hi,
>
> This is the backtrace after C-g (after a few minutes):
>
>
> Debugger entered--Lisp error: (quit)
>   process-send-region(#<process git-blame> 1 28910)
>   (let ((display-buf ...) (blame-buf ...) (args ...)) (if startline (=
setq args ...)) (setq args (append args ...)) (setq git-blame-proc (app=
ly ... "git-blame" blame-buf "git" "blame" args)) (with-current-buffer =
blame-buf (erase-buffer) (make-local-variable ...) (make-local-variable=
 ...) (setq git-blame-file display-buf) (setq git-blame-current nil)) (=
set-process-filter git-blame-proc (quote git-blame-filter)) (set-proces=
s-sentinel git-blame-proc (quote git-blame-sentinel)) (process-send-reg=
ion git-blame-proc (point-min) (point-max)) (process-send-eof git-blame=
-proc))
>   (if git-blame-proc (message "Already running git blame") (let (... =
=2E.. ...) (if startline ...) (setq args ...) (setq git-blame-proc ...)=
 (with-current-buffer blame-buf ... ... ... ... ...) (set-process-filte=
r git-blame-proc ...) (set-process-sentinel git-blame-proc ...) (proces=
s-send-region git-blame-proc ... ...) (process-send-eof git-blame-proc)=
))
>   git-blame-run()
>   (progn (let (...) (if ... ... ...)) (setq git-blame-cache (make-has=
h-table :test ...)) (git-blame-run))
>   (if git-blame-mode (progn (let ... ...) (setq git-blame-cache ...) =
(git-blame-run)) (cancel-timer git-blame-idle-timer))
>   git-blame-mode(nil)
>   call-interactively(git-blame-mode)
>   execute-extended-command(nil)
>   call-interactively(execute-extended-command)

If you switch to the buffer called " git blame for <filename>" (notice
the leading space, you will probably see a usage/error message from
git.

Maybe your git blame doesn't like the --incremental flag or the
--contents flag.  But the problem is that I'm not sure how to make
emacs not hang.

process-send-region blocks when sending the file contents, since git
isn't reading it.  But git finishes, so emacs should be able to detect
that there is no process that can read anything anymore.

--=20
David K=C3=A5gedal
