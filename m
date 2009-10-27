From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: possible usability issue in rebase -i?
Date: Tue, 27 Oct 2009 16:50:44 +0100
Message-ID: <40aa078e0910270850u6ffec41cj372da11d9df533f@mail.gmail.com>
References: <40aa078e0910270313j5dc68576v86a3947f0dc7f9f@mail.gmail.com>
	 <2faad3050910270817l71394722nda55265ed96722df@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Baz <brian.ewins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 16:50:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2oJw-00009e-F1
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 16:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760AbZJ0Pum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Oct 2009 11:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755757AbZJ0Pul
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 11:50:41 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50499 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754AbZJ0Pul convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 11:50:41 -0400
Received: by bwz19 with SMTP id 19so351939bwz.28
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 08:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RaGYAI3JrZYv4uwSrRcAGPAlTc49o/+FwYwbmx1lzT8=;
        b=RP9yalTtdFS1yr9ZHAyf6NgDbJx6RLxO7Qk7wE+21yMogOIqWQd6tk0mbiwzLFdoLk
         2HjgjOgmWm39m2elW5B4P/+zkVrSY/fWTvXMpBa88Mv2wBVgDk2SGdqnOgajs/lQfGxR
         s5ODhIXgoVGnTX1FdfIEFBVE8Csv4jIXIQNfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=xcjqd16lvDJUYI8+knDcZ0F5IfxhxoubJ6SRpFMwiUwubW1nXN5WaCCZelRl82MTeu
         g9zDYTkY+aPxbjgvPIiIuN4y2M//8h3iKe2trVFdLX2qD6SHDhM0Fjc1knZngBKYqoNn
         6Fs60KNwHA/WKhyZJf9O8BPVc43CnSDiDUG2k=
Received: by 10.204.162.200 with SMTP id w8mr9648375bkx.142.1256658644148; 
	Tue, 27 Oct 2009 08:50:44 -0700 (PDT)
In-Reply-To: <2faad3050910270817l71394722nda55265ed96722df@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131351>

On Tue, Oct 27, 2009 at 4:17 PM, Baz <brian.ewins@gmail.com> wrote:
> I've got a somewhat related minor usability issue with rebase -i. I
> accidentally typed something like 'git rebase -i -z' and got this
> message:
>
> error: unknown switch `z'
> usage: git-rebase [-i] [options] [--] <upstream> [<branch>]
> =A0 or: git-rebase [-i] (--continue | --abort | --skip)
>
> Available options are
> =A0 =A0-v, --verbose =A0 =A0 =A0 =A0 display a diffstat of what chang=
ed upstream
> =A0 =A0--onto ... =A0 =A0 =A0 =A0 =A0 =A0rebase onto given branch ins=
tead of upstream
> =A0 =A0-p, --preserve-merges
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0try to recreate me=
rges instead of ignoring them
> =A0 =A0-s, --strategy ... =A0 =A0use the given merge strategy
> =A0 =A0-m, --merge =A0 =A0 =A0 =A0 =A0 always used (no-op)
> =A0 =A0-i, --interactive =A0 =A0 always used (no-op)
>
> The last two lines were the surprise. It suggested to me that '-i' an=
d
> '-m' were now the defaults for git-rebase - which of course they're
> not. A user would not know that this is actually reporting the flags
> that work for git-rebase--interactive, especially since that's not
> what the command calls itself. I wasn't sure about the best approach
> to fixing this - the only comparable commands that pass arbitrary
> flags down to an exec'd program make it clear what program is going t=
o
> be called (usually git merge) and so interpreting errors is easier.
>
> It seems the intent here was to signal that the flags are different
> once a rebase is in progress, but this usage message is shown when
> rebase -i -z is called in any state.

If that is the case, my instinct tells me that this information should
be reflected in the usage-string (instead of the parameter
description). Something like this?

--->8---

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 23ded48..3ed5f94 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -13,15 +13,15 @@
 OPTIONS_KEEPDASHDASH=3D
 OPTIONS_SPEC=3D"\
 git-rebase [-i] [options] [--] <upstream> [<branch>]
-git-rebase [-i] (--continue | --abort | --skip)
+git-rebase [-i] [-m] (--continue | --abort | --skip)
 --
  Available options are
 v,verbose          display a diffstat of what changed upstream
 onto=3D              rebase onto given branch instead of upstream
 p,preserve-merges  try to recreate merges instead of ignoring them
 s,strategy=3D        use the given merge strategy
-m,merge            always used (no-op)
-i,interactive      always used (no-op)
+m,merge            use merging strategies
+i,interactive      interactively edit commits
  Actions:
 continue           continue rebasing process
 abort              abort rebasing process and restore original branch

--=20
Erik "kusma" Faye-Lund
