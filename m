From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/2] send-email: expand paths in sendemail.{to,cc}cmd
 config
Date: Tue, 24 Nov 2015 22:58:24 +0000
Message-ID: <20151124225824.GB18913@serenity.lan>
References: <cover.1447797487.git.john@keeping.me.uk>
 <db0b817c4be57635248a48a529a32719ad232f02.1447797487.git.john@keeping.me.uk>
 <CAPig+cRY3W4VMgqnRuQFeMk7oueKsA=ZhMAk15LLyZg0KfVvCA@mail.gmail.com>
 <20151124084353.GH21488@serenity.lan>
 <20151124222330.GF29185@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 24 23:58:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1MXn-00081w-Df
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 23:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbbKXW6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 17:58:37 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:45730 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbbKXW6g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 17:58:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 4D634CDA563;
	Tue, 24 Nov 2015 22:58:35 +0000 (GMT)
X-Quarantine-ID: <rwlL0zQ1q3sA>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rwlL0zQ1q3sA; Tue, 24 Nov 2015 22:58:34 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 4257ACDA29D;
	Tue, 24 Nov 2015 22:58:26 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20151124222330.GF29185@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281647>

On Tue, Nov 24, 2015 at 05:23:30PM -0500, Jeff King wrote:
> On Tue, Nov 24, 2015 at 08:43:53AM +0000, John Keeping wrote:
> 
> > On Mon, Nov 23, 2015 at 07:04:46PM -0500, Eric Sunshine wrote:
> > > On Tue, Nov 17, 2015 at 5:01 PM, John Keeping <john@keeping.me.uk> wrote:
> > > > These configuration variables specify the paths to commands so we should
> > > > support tilde-expansion for files inside a user's home directory.
> > > 
> > > Hmm, I don't see anything in the documentation which says that these
> > > are paths to commands, and the code itself treats them purely as
> > > commands to be invoked, not as paths to commands. What is the
> > > behavior, for instance, with --tocmd='foobar -x zopp' or even
> > > --tocmd='foobar -x ~/zopp'?
> > 
> > The path behaviour only expands leading '~' and '~user' (as documented
> > in git-config(1)):
> > 
> > 	$ git -c sendemail.tocmd='foobar -x ~/zopp' config --path sendemail.tocmd
> > 	foobar -x ~/zopp
> 
> We usually run user-supplied commands with a shell (and AFAICT, that is
> the case here). So wouldn't that turn into (when used by send-email):
> 
>   sh -c 'foobar -x ~/zopp'
> 
> and the shell would expand it for us? Running:
> 
>   git -c sendemail.tocmd='echo ~/foo' send-email -1
> 
> seems to work for me (it puts "/home/peff/foo" into the "to" header).

Ah, I hadn't tested it.  We can drop this patch then.
