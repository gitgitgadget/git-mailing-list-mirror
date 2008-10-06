From: David Bryson <david@statichacks.org>
Subject: Re: [PATCH] Use "git_config_string" to simplify "remote.c" code in
	"handle_config"
Date: Mon, 6 Oct 2008 12:53:52 -0700
Message-ID: <20081006195352.GS5774@eratosthenes.cryptobackpack.org>
References: <20081003033937.GA11594@eratosthenes.cryptobackpack.org> <alpine.DEB.1.00.0810061610400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Reply-To: David Bryson <david@statichacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 06 21:55:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmwAb-0008Jg-PI
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 21:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbYJFTxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 15:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752738AbYJFTxy
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 15:53:54 -0400
Received: from cryptobackpack.org ([64.105.32.74]:38527 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbYJFTxy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 15:53:54 -0400
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id C90C410D0271; Mon,  6 Oct 2008 12:53:53 -0700 (PDT)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	DNS_FROM_SECURITYSAGE autolearn=no version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id 1AC1610D00B6;
	Mon,  6 Oct 2008 12:53:53 -0700 (PDT)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id CF6BF14464; Mon,  6 Oct 2008 12:53:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810061610400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97620>

Johannes,

On Mon, Oct 06, 2008 at 04:13:17PM +0200 or thereabouts, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 2 Oct 2008, David Bryson wrote:
> 
> > 
> > Signed-off-by: David Bryson <david@statichacks.org>
> > 
> > I tried to keep with the naming/coding conventions that I found in
> > remote.c.  Feedback welcome.
> > 
> > ---
> 
> Usually this comment goes after the --- but other than that, the form is 
> as perfect as you can wish for.

I see, still trying to remember all the little tricks for proper
submission, thanks.

> > @@ -314,15 +315,15 @@ static int handle_config(const char *key, const char *value, void *cb)
> >  			return 0;
> >  		branch = make_branch(name, subkey - name);
> >  		if (!strcmp(subkey, ".remote")) {
> > -			if (!value)
> > -				return config_error_nonbool(key);
> > -			branch->remote_name = xstrdup(value);
> > +			if (git_config_string(&v, key, value) ) 
> > +				return -1;
> > +			branch->remote_name = v;
> 
> What is the reason not to write
> 
> 			if (git_config_string(&branch->remote_name, key, value))
> 				return -1;

The only reason is it did not come to mind ;-)  But it does make the
statement somewhat clearer.

> ?  (Also note that we do not like the space between the two closing 
> parentheses.)

An oversight to be sure and not intentional, I read the CodingGuidelines
very carefully ;-)

Dave
