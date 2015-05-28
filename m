From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Redirect "git" subcommand to itself?
Date: Thu, 28 May 2015 13:36:25 +0300
Message-ID: <20150528133625.bfececc222a4820e9fb27aaa@domain007.com>
References: <CAGZ79kZHa9wUrRsWfHgGdSdx+cN9VAirAAfu3YLVTuSmggcehg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 28 12:46:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxvKK-00027N-E8
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 12:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbbE1KqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 06:46:12 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:49712 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbbE1KqL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 06:46:11 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2015 06:46:10 EDT
Received: from tigra.domain007.com ([192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t4SAaPR9023001;
	Thu, 28 May 2015 13:36:26 +0300
In-Reply-To: <CAGZ79kZHa9wUrRsWfHgGdSdx+cN9VAirAAfu3YLVTuSmggcehg@mail.gmail.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270136>

On Wed, 27 May 2015 17:28:34 -0700
Stefan Beller <sbeller@google.com> wrote:

> so I just run into this problem again (which happens to me maybe
> twice a week): I want to do a git operations, so I type "git " into
> my shell,
[...]
> then I copy the whole operation "git revert --abort" in this case and
> paste it to the shell and let go.
> The result looks like
>     $ git git revert --abort
>     git: 'git' is not a git command. See 'git --help'.
[...]
> I wonder if we want to make a "git" subcommand, which behaves exactly
> the same as git itself?
> Then "git git git status" would just return the same as "git status".

In your ~/.whateverrc, put this:

git() {
  while [ $# -gt 0 ]; do
    test "$1" != "git" && break;
    shift;
  done;
  command git $@;
}

This assumes a POSIX-compatible shell but I think you've got the idea.
("command" is a builtin which forces interpreting the following word as
the name of an external program.)
