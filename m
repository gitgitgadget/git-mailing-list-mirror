From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] perl/Makefile: update NO_PERL_MAKEMAKER section
Date: Wed, 23 Jul 2008 01:09:40 +0200
Message-ID: <20080722230940.GK32184@machine.or.cz>
References: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil> <XKT02T_QW2tKLHpR7e3VuZjLXv3RP2E0GD54gXKrdIFm8xQsKvAyjg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jul 23 01:10:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLR0E-0002vh-7B
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 01:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbYGVXJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 19:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbYGVXJn
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 19:09:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33146 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645AbYGVXJm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 19:09:42 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 8E233393B282; Wed, 23 Jul 2008 01:09:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <XKT02T_QW2tKLHpR7e3VuZjLXv3RP2E0GD54gXKrdIFm8xQsKvAyjg@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89558>

On Tue, Jul 22, 2008 at 04:15:41PM -0500, Brandon Casey wrote:
> The perl modules must be copied to blib/lib so they are available for
> testing.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>

I don't understand why do you need to do this; perl.mak should do this
on its own during project-wide make all. What Perl version are you using?
How does the pm_to_blib target look like?

	pm_to_blib : $(TO_INST_PM)
        $(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', '\''$(PM_FILTER)'\'')' -- \
          Git.pm $(INST_LIBDIR)/Git.pm
        $(NOECHO) $(TOUCH) pm_to_blib

here. Is your INST_LIB = blib/lib and INST_LIBDIR = $(INST_LIB)?

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
