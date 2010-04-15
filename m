From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 8/9] builtin: check pager.<cmd> configuration if 
	RUN_SETUP_GENTLY is used
Date: Thu, 15 Apr 2010 19:43:49 +0200
Message-ID: <q2rfcaeb9bf1004151043v5a8e5634z159b6fa01f859f7e@mail.gmail.com>
References: <20100413021153.GA3978@progeny.tock>
	 <20100413023003.GH4118@progeny.tock>
	 <y2yfcaeb9bf1004130312l197983cnf92371acc88464db@mail.gmail.com>
	 <20100414050643.GB28864@progeny.tock>
	 <m2yfcaeb9bf1004150133te8af6155n63d620fef2be98a2@mail.gmail.com>
	 <20100415084925.GA14660@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 19:43:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2T6a-0007dT-RY
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 19:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523Ab0DORnv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 13:43:51 -0400
Received: from mail-qy0-f189.google.com ([209.85.221.189]:34774 "EHLO
	mail-qy0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab0DORnu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 13:43:50 -0400
Received: by qyk27 with SMTP id 27so1962036qyk.23
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 10:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ovv8tRxyeg+GVkNb7BFiPhQ+1ocJypEbqAEqg1DLCnE=;
        b=bn3ayYVZj4ZJIbVj0sq+d0AaiiE+n8CbA2o0DOtEm2an/UGdNnzQlKw/J1BJmjmy+g
         PdRXqoW1TY/GXID1t6NvUGCef81VSjW1SL09pSIFbGus6gbRPMxBDIcPcwDETEKcUA9L
         +ONmSCBUwH8Fklqrr92S19PPFxxuuZp3dfqAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=leJWG2ss1wjmQwRw3s0v1cqL2sL/CLLI9e/d3ZrJ192P5nZGiQmOsJ8zqK5aInwqfl
         6XlqshO4CVymfj2/khryHCHfBQsv20CmHQFUHGv4TLdlxTMOmm0YapL3ZsYgd9aHaP/u
         t2Of1SakxUM3+qxo6k4p3hRc33xxRLirbVm+o=
Received: by 10.224.2.76 with HTTP; Thu, 15 Apr 2010 10:43:49 -0700 (PDT)
In-Reply-To: <20100415084925.GA14660@progeny.tock>
Received: by 10.224.113.151 with SMTP id a23mr91014qaq.386.1271353429381; Thu, 
	15 Apr 2010 10:43:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145001>

On Thu, Apr 15, 2010 at 10:49 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> FWIW, my latest is at
>
> =C2=A0git://repo.or.cz/git/jrn nd/setup/chapter-one
>
> Changes since the last series I sent to the list:
>
> =C2=A0- test cleanups, after Junio=E2=80=99s feedback
> =C2=A0- clarified commit messages, I hope
>
> If you=E2=80=99ve already started cleaning up or if something in the =
diff looks
> iffy, feel free to carry on with what you have. =C2=A0I don=E2=80=99t=
 want the test
> changes to interfere with more productive work.
>
> Looking forward to watching this evolve,

OK. Here is the topic breakdown into 11 sub-topics, after rebasing on
setup/chapter-one. Patches 1, 2-3, 4-5, 8-9, 10-12, 13-18 can go as
separate independent sub-topics, given that chapter-one is accepted.
The rest must go in sequence because they will need some of previous
groups. Commit messages aren't cleaned up yet, just the idea of
grouping.

Patches available at git://repo.or.cz/git/pclouds.git tp/setup

     1	rev-parse --git-dir: print relative gitdir correctly

This will become a problem when patches 37-43 (let's name it
"unset_git_directory") is merged. Other than that, it's can go alone.

     2	worktree setup: calculate prefix even if no worktree is found
     3	index-pack: trust the prefix returned by setup_git_directory_gen=
tly()

This is debatable, as you pointed out, because it changes "git
rev-parse --show-prefix" behavior. This is a prerequisite for 19-36
(run-setup-gently)

     4	Move enter_repo() to setup.c
     5	enter_repo(): initialize other variables as
setup_git_directory_gently() does

Good thing. Quite simple. Prerequisite for 6-7 (have_run_setup)

     6	builtin: remember whether repository has been searched for
     7	builtins: setup repository before print unknown command error

Introduce startup_info->have_run_setup_gitdir, and a guard in command
error printing.

     8	setup: save prefix (original cwd relative to toplevel) in startu=
p_info
     9	builtin: remove prefix variable from run_builtin()

Introduce startup_info->prefix. Will be needed for 47-48 (alias fix)
because setup_git_dir may be called in one place, and unset_git_dir is
called in another place.

    10	run_builtin(): save "-h" detection result for later use
    11	builtins: utilize startup_info->help where possible
    12	builtins: check for startup_info->help, print and exit early

=46ix "git cmd -h" shortcut. There will be warnings from git_config()
once the old "guard unallowed access" patch is in. It will be fixed in
patch 45.

    13	init/clone: turn on startup->have_repository properly
    14	t7002: test git grep --no-index from a bare repository
    15	Do not read .git/info/exclude if there is no repository
    16	Do not read .git/info/attributes if there is no repository
    17	apply: do not check sha1 if there is no repository
    18	config: do not read .git/config if there is no repository

Assorted fixes wrt unconditional access to .git/. All these patches
simple add "if (have_repository)" or so.

    19	t0001: test git init when run via an alias
    20	t5512: test that ls-remote does not require a git repository
    21	t7006: expose test_terminal() for use by other tests
    22	help: note why it is appropriate for this command not to use
RUN_SETUP_GENTLY
    23	hash-object: use RUN_SETUP_GENTLY
    24	shortlog: use RUN_SETUP_GENTLY
    25	grep: use RUN_SETUP_GENTLY
    26	archive: use RUN_SETUP_GENTLY
    27	mailinfo: use RUN_SETUP_GENTLY
    28	check-ref-format: use RUN_SETUP_GENTLY
    29	verify-pack: use RUN_SETUP_GENTLY
    30	apply: use RUN_SETUP_GENTLY
    31	bundle: use RUN_SETUP_GENTLY
    32	diff: use RUN_SETUP_GENTLY
    33	ls-remote: use RUN_SETUP_GENTLY
    34	var: use RUN_SETUP_GENTLY
    35	merge-file: use RUN_SETUP_GENTLY
    36	index-pack: use RUN_SETUP_GENTLY

The RUN_SETUP_GENTLY series. Of course these will need to be reviewed,
some commands might need finer-grain setup.

    37	Add git_config_early()
    38	t1300: test that scripted commands do not respect stray .git/con=
fig
    39	git_config(): do not read .git/config if there is no repository
    40	Use git_config_early() instead of git_config() during repo setup
    41	worktree setup: call set_git_dir explicitly
    42	worktree setup: restore original state when things go wrong
    43	Allow to undo setup_git_directory_gently() gracefully (and fix
alias code)

The unset_git_directory series. Make setup_git_directory() work right.

    44	Guard unallowed access to repository when it's not set up
    45	run_builtin: do now raise alarms
    46	setup_work_tree: do not raise alarm

Put unallowed access warnings in place. Also fixes false alarms.

    47	alias: keep repository found while collecting aliases as long as=
 possible
    48	run_builtin: respect have_run_setup_gitdir

=46ix alias related setup problem.

Insane?
--=20
Duy
