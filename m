From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: cvsps, parsecvs, svn2git and the CVS exporter mess
Date: Sat, 5 Jan 2013 10:58:04 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130105155804.GB1938@thyrsus.com>
References: <20121222173649.04C5B44119@snark.thyrsus.com>
 <50E5A5CF.2070009@alum.mit.edu>
 <20130103205301.GD26201@thyrsus.com>
 <1E7F9F86-F040-42E4-98C4-152B8CCE47CE@quendi.de>
 <CAA6gtpky9JxFDdpLM6kY9su-9FWX8RoWHU4uptd_Zk+ZJuhrtA@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <postbox@quendi.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Yann Dirson <ydirson@free.fr>, Heiko Voigt <hvoigt@hvoigt.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Keith Packard <keithp@keithp.com>,
	David Mansfield <david@cobite.com>, git@vger.kernel.org
To: Bart Massey <bart@cs.pdx.edu>
X-From: git-owner@vger.kernel.org Sat Jan 05 16:58:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrW8q-0008KL-Bd
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 16:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798Ab3AEP6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 10:58:11 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:53984
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781Ab3AEP6K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 10:58:10 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 219594044B; Sat,  5 Jan 2013 10:58:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAA6gtpky9JxFDdpLM6kY9su-9FWX8RoWHU4uptd_Zk+ZJuhrtA@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212699>

Bart Massey <bart@cs.pdx.edu>:
> I don't know what Eric Raymond "officially end-of-life"-ing parsecvs means?

You and Keith handed me the maintainer's baton.  If I were to EOL it,
that would be the successor you two designated judging in public that
the code is unsalvageable or has become pointless.  If you wanted to
exclude the possibility that a successor would make that call, you
shouldn't have handed it off in a state so broken that I can't even
test it properly.

But I don't in fact think the parsecvs code is pointless. The fact that it
only needs the ,v files is nifty and means it could be used as an RCS
exporter too.  The parsing and topo-analysis stages look like really
good work, very crisp and elegant (which is no less than I'd expect
from Keith, actually).

Alas, after wrestling with it I'm beginning to wonder whether the
codebase is salvageable by anyone but Keith himself.  The tight coupling
to the git cache mechanism is the biggest problem.  So far, I can't
figure out what tree.c is actually doing in enough detail to fix it or pry
it loose - the code is opaque and internal documentation is lacking.

More generally, interfacing to the unstable API of libgit was clearly
a serious mistake, leading directly to the current brokenness.  The
tool should have emitted an import stream to begin with.  I'm trying
to fix that, but success is looking doubtful.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
