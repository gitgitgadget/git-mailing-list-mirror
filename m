From: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: cvs revision number -> git commit name?
Date: Wed, 27 Jan 2010 18:47:18 +0100
Message-ID: <hbf.20100127jjbx@bombur.uio.no>
References: <hbf.20100126bda0@bombur.uio.no>
	<bc341e101001261453u16124186i298a53ead0b4eee2@mail.gmail.com>
	<201001270043.44614.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Aaron Crane <git@aaroncrane.co.uk>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 18:47:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaBzE-0005Uq-ME
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 18:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924Ab0A0RrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 12:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754100Ab0A0RrV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 12:47:21 -0500
Received: from mail-out2.uio.no ([129.240.10.58]:44459 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753477Ab0A0RrU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 12:47:20 -0500
Received: from mail-mx4.uio.no ([129.240.10.45])
	by mail-out2.uio.no with esmtp (Exim 4.69)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1NaBz5-0000HE-2k; Wed, 27 Jan 2010 18:47:19 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx4.uio.no with esmtp  (Exim 4.69)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1NaBz4-0003HD-Ob; Wed, 27 Jan 2010 18:47:19 +0100
Received: from hbf by bombur.uio.no with local (Exim 4.44)
	id 1NaBz4-0002yA-G1; Wed, 27 Jan 2010 18:47:18 +0100
In-Reply-To: <201001270043.44614.johan@herland.net>
X-Mailer: VM 7.18 under Emacs 22.2.1
X-UiO-Ratelimit-Test: rcpts/h 3 msgs/h 1 sum rcpts/h 5 sum msgs/h 2 total rcpts 718 max rcpts/h 11 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 55FDCBD6AA16154D5857FCF8B79A17343F6FEA73
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 1 total 1811 max/h 8 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138176>

Johan Herland writes:
>On Tuesday 26 January 2010, Aaron Crane wrote:
>> One thing to be aware of (beyond the need to run grep to convert old
>> CVS revision numbers to Git commit IDs)

which sounds like a job for a small tool, maybe aliased in .git/config.
'git cvsinfo file.c 1.23' or 'git cvsinfo [file.c] <git-commitname>' -->
output cvs and git commit info (cvs rev, commit, log message, etc).
Or maybe it shouldn't be cvs-specific.

>> is that there's a good chance
>> the mapping file will pollute the results of `git grep` for some
>> tasks.  (We've put the mapping file into our repo, where it's easy to
>> find.)  I'm considering gzipping the mapping file as a workaround;
>> that would mean our users will need to use zgrep (or equivalent) to
>> look up CVS revision numbers, which may or may not be a problem in
>> your situation.

Thanks for the tip.  Zipping sounds good.  In particular combined with
the grepping tool above.  If the unzipping gets slow, cvsinfo --unpack
could always put a bunzipped file in .git/cvsinfo.txt or something.

> You could consider adding the CVS revision numbers as notes (see "git help 
> notes" in >= v1.6.6) to the corresponding commits. Then they don't pollute 
> the commit messages, but instead live in a separate, but parallel hierarchy 
> that can be easily pulled in when you need to reference them (e.g. 
> GIT_NOTES_REF="refs/" git log).

Thanks, looks better than munging the log.  Though with one common
weakness - should likely omit noting mass commits, since they'd clutter
what 'git log' displays too much.  Of course, either could used combined
with a mapping table.

-- 
Hallvard
