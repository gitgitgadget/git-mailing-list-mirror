From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: [PATCH] topgit tg push feature
Date: Tue, 12 May 2009 09:54:13 +0200
Message-ID: <20090512075413.GA7764@gmx.de>
References: <20090507045904.GA2068@gmx.de> <36ca99e90905062245w1ec78828ice5ed18161b6ec43@mail.gmail.com> <20090507084355.GA11680@pengutronix.de> <36ca99e90905070250l656f8879g87eb27c09db2cd42@mail.gmail.com> <20090509103625.GC13344@lapse.rw.madduck.net> <20090509190910.GA9655@gmx.de> <20090511032813.GA15540@gmx.de> <20090511195532.GA28340@pengutronix.de> <20090511210614.GA6118@gmx.de> <20090512051334.GA22757@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 09:54:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3moz-0005ij-4K
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 09:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbZELHyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 03:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754479AbZELHyb
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 03:54:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:57524 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754163AbZELHyb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 03:54:31 -0400
Received: (qmail invoked by alias); 12 May 2009 07:54:29 -0000
Received: from mawercer.at.xencon.net (EHLO mail.gmx.net) [83.246.111.127]
  by mail.gmx.net (mp013) with SMTP; 12 May 2009 09:54:29 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX18bmPwQWKAbVL3g8dWmmrmh/hOf+rWxKPoziqzKOc
	E6Hhl0hjHimeKr
Received: by mail.gmx.net (sSMTP sendmail emulation); Tue, 12 May 2009 09:54:13 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090512051334.GA22757@pengutronix.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118878>

> hhhm, this hunk is new and unused.  Intended?
> 
> If it's OK for you I fix these up when commiting.  I will break out the
> change to tg.sh as shown yesterday in irc.

thank you x-times :-)
Sure that's fine with me. I already told you.

>That was my intention my asking for the -r option. The -r option is to
>'tg' not a tg-command. And it's still not addressed.
Bert: You're wrong:

tg.sh contains:

  base_remote="$(git config topgit.remote 2>/dev/null)" || :

  [...]

  if [ "$1" = "-r" ]; then
          shift
          if [ -z "$1" ]; then
                  echo "Option -r requires an argument." >&2
                  do_help
                  exit 1
          fi
          base_remote="$1"; shift
          tg="$tg -r $base_remote"
  fi

So base_remote is set by config first and then overwritten by the first
-r flag. my remotes is initialised with that -r flag.

Boy However its wrong again now:

If you use tg push -r foo it will push to poth: the config value and
foo. So probably its best to remove the second -r altogether and replace
my remotes by base_remote. You still can use the undocumented -r "remote
remote2" feature.

Marc Weber
