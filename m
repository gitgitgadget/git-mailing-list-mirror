From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH 2/3] Different views on a repository
Date: Thu, 25 Feb 2010 10:25:22 +0100
Organization: SUSE Labs
Message-ID: <201002251025.22881.agruen@suse.de>
References: <cover.1267029680.git.agruen@suse.de> <92fea2335b73265b04d64fcc217055e1170f5e16.1267029680.git.agruen@suse.de> <4B863C77.8040304@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 10:25:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkZyR-0005tP-GA
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 10:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780Ab0BYJZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 04:25:28 -0500
Received: from cantor2.suse.de ([195.135.220.15]:49374 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788Ab0BYJZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 04:25:26 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id F30E68726A;
	Thu, 25 Feb 2010 10:25:24 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.12-0.1-desktop; KDE/4.3.1; x86_64; ; )
In-Reply-To: <4B863C77.8040304@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141038>

On Thursday 25 February 2010 10:01:43 Michael J Gruber wrote:
> Andreas Gruenbacher venit, vidit, dixit 24.02.2010 16:57:
> > Add --view options in upload-pack and receive-pack so that a repository
> > on the server side can be made to look like several independent
> > repositories on the client side.
> >
> > This is implemented by transforming ref names: for example, with
> > --view=one/, refs/heads/one/master on the server will look like
> > refs/heads/master to the client, refs/tags/one/v1 will look like
> > refs/tags/v1, etc.
> >
> > This allows to transparently share repositories on the server which
> > have a lot of objects in common without complicating things for the
> > client, and without breaking garbage collection.
> 
> Just from this description, I can't see why the same can't be done with
> appropriate refspecs. (A helper for doing that would be more welcome, of
> course.)

You mean on the client side? The problem then is that a simple "git clone" 
would not do the right thing anymore; you would still expose server-side 
implementation details to clients. Clients shouldn't have to bother with this 
added complexity. (They might not even have access to some of the views.) When 
you do the mapping server-side, you can split or merge repositories as needed 
without the clients even noticing.

> Maybe a few tests and documentation (i.e. examples, not just the option
> description) would clear this up?

Indeed, I should add some more background info.

Thanks,
Andreas
