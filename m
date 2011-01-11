From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git notes and core.editor config
Date: Tue, 11 Jan 2011 13:26:02 +0100
Message-ID: <201101111326.02277.trast@student.ethz.ch>
References: <AANLkTi=0BrBV+DLF_QfDi0mMVdz5tCLFsDMBKvw52nzz@mail.gmail.com> <201101111131.17429.johan@herland.net> <AANLkTik-=s-F8dmBRLU8o9LcSztb1P0WnkN5HK_n_No4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, <git@vger.kernel.org>
To: Jeenu V <jeenuv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 13:26:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcdIh-00026M-1f
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 13:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab1AKM0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 07:26:05 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:24295 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753330Ab1AKM0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 07:26:04 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 11 Jan
 2011 13:26:00 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 11 Jan
 2011 13:26:02 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <AANLkTik-=s-F8dmBRLU8o9LcSztb1P0WnkN5HK_n_No4@mail.gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164931>

Jeenu V wrote:
> On Tue, Jan 11, 2011 at 4:01 PM, Johan Herland <johan@herland.net> wrote:
> >> In other words, I
> >> don't think [git-notes] honors shell quoting for editor config variable.
> >
> > Indeed, it could, but I cannot immediately see what causes it. In
> > current 'master', builtin/notes.c launches the editor like this:
> >
> >  if (launch_editor(path, &(msg->buf), NULL)) ...
> >
> > while builtin/commit.c lauches the editor like this:
> >
> >  if (launch_editor(git_path(commit_editmsg), NULL, env)) ...
[...]
> $ git --version
> git version 1.7.0.4

git-notes was a script before 1.7.1, and that was indeed buggy in that
it used the editor as

  ${GIT_EDITOR:-${core_editor:-${VISUAL:-${EDITOR:-vi}}}} "$MSG_FILE"

instead of using git_editor() from git-sh-setup, which would have gone
through eval.

The builtin version of git-notes does not have this problem.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
