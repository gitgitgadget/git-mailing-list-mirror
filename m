From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list
	available repositories
Date: Wed, 28 Jul 2010 01:42:51 -0500
Message-ID: <20100728064251.GB743@dert.cs.uchicago.edu>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu> <20100726232855.GA3157@burratino> <AANLkTikqA3kNif+7Bi+=xkJ2FgCFAsfCj0N5dft5pnFR@mail.gmail.com> <201007270916.59210.j.sixt@viscovery.net> <20100727174105.GA5578@burratino> <AANLkTikr5jjZJa2irLb2rNew8ngJcv3rhcFV+pNRpRrw@mail.gmail.com> <20100728003336.GA2248@dert.cs.uchicago.edu> <AANLkTik1D45_cHPapbmMMys-V544ssCyoxrs5Fxck7oP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jul 28 08:43:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe0Ly-0002Cy-GE
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 08:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab0G1Gmx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 02:42:53 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:34006 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab0G1Gmw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 02:42:52 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id B70164C54;
	Wed, 28 Jul 2010 01:42:51 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 7F3BB9A176; Wed, 28 Jul 2010 01:42:51 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik1D45_cHPapbmMMys-V544ssCyoxrs5Fxck7oP@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152042>

Greg Brockman wrote:

> That aside, here's an analysis of my patch series:
> Patch 1 just adds
[...]

Agh, it=E2=80=99s getting late.  In my last message I completely
forgot about the make_cmd() step.  Sorry to waste your time
on that.

And sorry to waste your time in general --- from your description
it sounds like this could be summarized by:

 patch 1 adds
  memory allocation, split_cmdline call (innocuous things)
  execv which will fail if git-shell-commands is not a directory

> This will be an arbitrary directory if a user can 'su' to the
> git-shell user.

That would be an odd setup, but I guess with shared repositories
there's a reason to do it.

> (I am however starting to lean towards always
> chdir'ing into the git-shell user's $HOME, do people feel strongly
> about this in either direction?)

I don't feel strongly either way.  It would be a good way to
put the worry about that attack vector to rest (if you use
getpwent instead of getenv to fetch $HOME).

Patch 2 adds the new run_shell() feature, but it is guarded
with access(COMMAND_DIR), so existing installations should not be
affected.

Patch 3 does not even touch git.

> See anything I'm missing?

No, it looks good to me.

Thanks for the patient explanations.

Jonathan
