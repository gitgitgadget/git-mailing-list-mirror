From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 0/2] Add an update=none option for 'loose' submodules
Date: Wed, 24 Aug 2011 21:30:08 +0200
Message-ID: <20110824193007.GC45292@book.hvoigt.net>
References: <cover.1312923673.git.hvoigt@hvoigt.net> <7v8vqzreeo.fsf@alter.siamese.dyndns.org> <20110811195955.GA21185@book.hvoigt.net> <7vy5yujtr2.fsf@alter.siamese.dyndns.org> <20110822200052.GC11745@sandbox-rc> <7v62lpuky8.fsf@alter.siamese.dyndns.org> <20110823194350.GA57187@book.hvoigt.net> <4E540B03.2030909@web.de> <7vpqjvrebk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 21:30:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwJ9U-0004cS-Lg
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 21:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580Ab1HXTaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 15:30:11 -0400
Received: from darksea.de ([83.133.111.250]:60681 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751172Ab1HXTaK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 15:30:10 -0400
Received: (qmail 5335 invoked from network); 24 Aug 2011 21:30:07 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 24 Aug 2011 21:30:07 +0200
Content-Disposition: inline
In-Reply-To: <7vpqjvrebk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180029>

Hi,

On Tue, Aug 23, 2011 at 02:46:39PM -0700, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
> > It might surprise people. E.g. when their old scripts don't work anymore as
> > they did before because a submodule won't be populated or updated in the work
> > tree even though it is present in .git/config. So I agree that this should be
> > documented in the release notes so people can check if their expectations are
> > still met.
> 
> Worse yet, their custom old scripts that they use to update submodules in
> their repository, if properly written, assume that anything registered in
> the .git/config file as [submodule "foo"] _must_ be populated, but they
> can no longer assume that and now has to look at submodule.foo.update and
> if it notices the variable is set to "none" leave the submodule repository
> alone. Having "submodule.foo" registered in the .git/config file alone
> used to mean the user is interested in "foo" submodule and wants to have a
> checkout for it, now it does not necessarily mean that.
> 
> That is definitely a huge semantics change.

Ok seeing it that way. You are right. How about this?

-8<---
From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] mention the new submodule.$name.update=none flag in the
 ReleaseNotes

---
 Documentation/RelNotes/1.7.7.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/RelNotes/1.7.7.txt b/Documentation/RelNotes/1.7.7.txt
index 8de880f..b8edcf1 100644
--- a/Documentation/RelNotes/1.7.7.txt
+++ b/Documentation/RelNotes/1.7.7.txt
@@ -71,6 +71,10 @@ Updates since v1.7.6
    submodule; it now goes on to update other submodules that can be
    updated, and reports the ones with errors at the end.
 
+ * "git submodule update" does not clone/update a submodule when
+   submodule.$name.update is set to 'none'. This option is copied from
+   .gitmodules when a submodule is initialized.
+
  * "git upload-pack" and "git receive-pack" learned to pretend only a
    subset of the refs exist in a repository. This may help a site to
    put many tiny repositories into one repository (this would not be
-- 
1.7.6.551.g4266ca
