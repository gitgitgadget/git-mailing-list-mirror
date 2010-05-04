From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/4] Documentation/notes: describe effect of environment and configuration
Date: Tue, 4 May 2010 11:24:26 +0200
Message-ID: <201005041124.26533.trast@student.ethz.ch>
References: <20100503233604.GA27451@progeny.tock> <20100503234140.GA27483@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 11:24:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9EMl-0004P2-LN
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 11:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312Ab0EDJYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 05:24:30 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:30684 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884Ab0EDJY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 05:24:29 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 4 May
 2010 11:24:26 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 4 May
 2010 11:24:26 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100503234140.GA27483@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146304>

Jonathan Nieder wrote:
> +core.notesRef::
> +	By default, 'git notes' and other commands read and manipulate
> +	the notes referred to by `refs/notes/commits`.  This
> +	configuration item allows one to specify an alternative
> +	default ref (to be overridden by environment variables or
> +	command-line options).
> +
> +notes.displayRef::
> +	Which refs, in addition to the default set by `core.notesRef`
> +	or 'GIT_NOTES_REF', for 'git log' to read notes from when
> +	showing commit messages.  Can be a (fully qualified) ref name
> +	or glob.  You may also specify this configuration variable
> +	several times.
> ++
> +This setting can be overridden with the 'GIT_NOTES_DISPLAY_REF'
> +environment variable.

I noticed you copied the rest of the description, but not these,
verbatim.  If the intention was to separate the specification of the
notes format exposed in git-config(1),

      [...] This ref is expected to contain files named after the full
      SHA-1 of the commit they annotate. The ref must be fully
      qualified.

      If such a file exists in the given ref, the referenced blob is
      read, and appended to the commit message, separated by a "Notes
      (<refname>):" line (shortened to "Notes:" in the case of
      "refs/notes/commits"). If the given ref itself does not exist, it
      is not an error, but means that no notes should be printed.

from the description of the option.  I agree to the idea, but maybe we
should also do the same in git-config(1).  For example, it could be
added to the NOTES section of git-notes(1) that already describes some
implementation details.

You also describe the warning semantics only for
GIT_NOTES_DISPLAY_REF, not for notes.displayRef.  I see the config
options as the main feature, and the variable as a mere convenience
(but others may disagree) so I would put the full semantics into the
config descriptions.

Otherwise, ack.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
