From: John Goerzen <jgoerzen@complete.org>
Subject: Re: git-email automatic --to detection?
Date: Tue, 26 Feb 2008 08:07:16 -0600
Message-ID: <slrnfs878k.prc.jgoerzen@katherina.lan.complete.org>
References: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org> <20080225183413.GA15131@sigill.intra.peff.net> <vpqoda43lva.fsf@bauges.imag.fr> <slrnfs67lp.lsg.jgoerzen@katherina.lan.complete.org> <vpqve4c136b.fsf@bauges.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 15:16:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU0aw-0000Cs-2r
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 15:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbYBZOPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 09:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbYBZOPJ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 09:15:09 -0500
Received: from main.gmane.org ([80.91.229.2]:33615 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612AbYBZOPI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 09:15:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JU0aE-0001iN-Ox
	for git@vger.kernel.org; Tue, 26 Feb 2008 14:15:02 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 14:15:02 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 14:15:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75140>

On 2008-02-26, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>> Right.  That's why this would be a per-repo setting.  It wouldn't be
>> pulled or cloned, just looked up when needed.
>
> I think it should. Not versionned, but initialized by "clone" based on
> the cloned repo.

That would work.

> The advantage of a clone-time initialization compared to a submit-time
> look up is that the local user can very easily change the value
> manually after a clone.

You could always make it work like this:

* If an address is given on the command line, use that.

* Otherwise, if an address is given in config, use that.

* Otherwise, look up the address at the remote repo; if successful,
  use that.

* Otherwise, prompt the user.

The advantage of this is that if the submission address changes (but
the remote repo URL hasn't), then patches can automatically go to the
right place.  Of course the disadvantage is that the config is not
initialized for offline mail queuing at clone time.

I have generally found that not being able to queue patches offline
isn't a big deal to me.  Of course, someone could effectively do that
also be using format-patch as it is normally used now.

-- John
