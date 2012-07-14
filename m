From: David Aguilar <davvid@gmail.com>
Subject: Re: bzr->git: keep empty directories
Date: Sat, 14 Jul 2012 15:46:11 -0700
Message-ID: <CAJDDKr5V++TtS24D=SsaPnkx==Zo8=fpvg2RNod9+-JGxWfhGQ@mail.gmail.com>
References: <87sjcuz9q7.fsf@bitburger.home.felix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Felix Natter <fnatter@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jul 15 00:46:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqB70-0004ZM-1K
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 00:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab2GNWqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 18:46:13 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43052 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab2GNWqM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 18:46:12 -0400
Received: by vcbfk26 with SMTP id fk26so264890vcb.19
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 15:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ONvZrLG/7pO38wJ8LEu2YbcTMencrDNuyDr81GILjpY=;
        b=STGx1ZcVUSyP2CAksTrncJMs9nbLo4hB9QBYgwz8y5SeBuXXYibpiYprIF17WZ69Yy
         FMhpso0ZcVdPlV6J/T4Z0FrS2y35BH5ooUU1w0xFO6JLkZbpv9gELe010ku4wYysU7X6
         J7BjyORlGiMQICFLIXE/Z4SXfZVOt13nIPaC9iZ1QePyTSp6xD7TBcvMZv2SbexlkWoy
         DdMquFwvU/9lZSzotZkP1lLBrfnVzLCWgPE6EuHjxAAd/z9mfXAiZQpcXn2lRo/TU9bl
         +pfTAvdpwzdQLz3JSQcvRboI68V0acybr14TEIRMJd7eHVpVCGKITsuTwpqbyK2kWjwi
         Fp+g==
Received: by 10.220.240.141 with SMTP id la13mr2800121vcb.46.1342305971239;
 Sat, 14 Jul 2012 15:46:11 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Sat, 14 Jul 2012 15:46:11 -0700 (PDT)
In-Reply-To: <87sjcuz9q7.fsf@bitburger.home.felix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201463>

On Sat, Jul 14, 2012 at 7:41 AM, Felix Natter <fnatter@gmx.net> wrote:
> hello,
>
> when converting a repo from bzr to git:
>
> mkdir freeplane-git1
> cd freeplane-git1
> git init .
> bzr fast-export --plain --export-marks=../marks.bzr ../trunk/ | git fast-import --export-marks=../marks.git
> git checkout
>
> Empty directories are not contained in the git working index. This is
> because of the --plain option, which "Excludes metadata to maximise
> interoperability" and thus does not support empty directories
> (http://doc.bazaar.canonical.com/plugins/en/fastimport-plugin.html).
>
> However, when I use "--no-plain" (which according to above documentation
> exports empty directories), git cannot handle it:
>
> $ ./freeplane2git.sh
> Initialized empty Git repository in /home/felix/git/freeplane-git1/.git/
> 15:56:09 Calculating the revisions to include ...
> 15:56:09 Starting export of 4290 revisions ...
> fatal: This version of fast-import does not support feature commit-properties.
> fast-import: dumping crash report to .git/fast_import_crash_3915
> bzr: broken pipe
>
> I already tried to hack bzr-fastimport's exporter.py so that it does not
> emit commit properties but emits empty directories but i was not
> successful.
>
> So is there another way to preserve empty directories or shall I report
> a bug on bzr fast-export?
>
> Many thanks in advance!

I would suggest hacking it to optionally not emit commit properties as step one.

A later enhancement would be to optionally create directories with
empty .gitignore files, or something similar. git really doesn't care
about empty directories.
-- 
David
