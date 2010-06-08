From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH 1/4] gitweb: Move subroutines to Gitweb::Config
 module
Date: Tue, 8 Jun 2010 16:13:21 +0200
Message-ID: <20100608141321.GP20775@machine.or.cz>
References: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
 <201006081446.22587.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 16:13:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLzYa-0003m9-4u
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 16:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab0FHON0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 10:13:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60732 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755322Ab0FHONZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 10:13:25 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4813D862096; Tue,  8 Jun 2010 16:13:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201006081446.22587.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148676>

  Hi!

On Tue, Jun 08, 2010 at 02:46:20PM +0200, Jakub Narebski wrote:
> Third, and I think most important, is that the whole splitting gitweb into
> modules series seems to alck direction, some underlying architecture
> design.  For example Gitweb::HTML, Gitweb::HTML::Link, Gitweb::HTML::String
> seems to me too detailed, too fine-grained modules.

  I agree!

> It was not visible at first, because Gitweb::Config, Gitweb::Request and to
> a bit lesser extent Gitweb::Git fell out naturally.  But should there be
> for example Gitweb::Escape module, or should its functionality be a part of
> Gitweb::Util?  Those issues needs to be addressed.  Perhaps they were
> discussed with this GSoC project mentors (via IRC, private email, IM), but
> we don't know what is the intended architecture design of gitweb.

  I would expect Gitweb::Escape functionality to live in Gitweb::HTML
(HTML escaping) and/or Gitweb::Request (URL escaping).

> Should we try for Model-Viewer-Controller pattern without backing MVC
> (micro)framework?  (One of design decisions for gitweb was have it working
> out of the box if Perl and git are installed, without requiring to install
> extra modules; but now we can install extra Perl modules e.g. from CPAN
> under lib/...).  How should we organize gitweb code into packages
> (modules)?

  I thought we already discussed MVC and sort of agreed that it's an
overkill at this point. At least that is still my opinion on it; I'm not
opposed to MVC per se, but to me, this modularization is a good
intermediate step even if we go the MVC way later, and doing MVC properly
would mean much huger large-scale refactoring than just naming a module
Gitweb::View instead of Gitweb::HTML. Let's do it not at all, or
properly sometime later. I think it's well out-of-scope for GSoC.

> Perhaps having gitweb.perl, Gitweb::Git, Gitweb::Config, Gitweb::Request,
> Gitweb::Util and Gitweb would be enough?

  I'm not sure what would fall into Gitweb::Util. I think Gitweb::HTML
makes a lot of sense to have, but I don't see the advantage of finer
graining than that - I dislike the Gitweb::HTML::* submodules as well.

  Pavan, can you outline your next plan on the other modules you aim to
create, plus possibly a bit of rationale?

-- 
				Petr "Pasky" Baudis
The true meaning of life is to plant a tree under whose shade
you will never sit.
