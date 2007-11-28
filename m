From: Andreas Ericsson <ae@op5.se>
Subject: Re: StGit hooks
Date: Wed, 28 Nov 2007 14:14:15 +0100
Message-ID: <474D69A7.6020404@op5.se>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com> <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com> <20071128093403.GB12977@diana.vm.bytemark.co.uk> <20071128101718.GA13940@diana.vm.bytemark.co.uk> <474D5482.5020609@op5.se> <20071128121905.GA15953@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:14:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxMkW-0008O3-Eh
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 14:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757148AbXK1NOW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 08:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757121AbXK1NOW
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 08:14:22 -0500
Received: from mail.op5.se ([193.201.96.20]:40472 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478AbXK1NOV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 08:14:21 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A82111F08049;
	Wed, 28 Nov 2007 14:14:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zwzzyPOVQvRO; Wed, 28 Nov 2007 14:14:18 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 016131F08048;
	Wed, 28 Nov 2007 14:14:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <20071128121905.GA15953@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66320>

Karl Hasselstr=F6m wrote:
> On 2007-11-28 12:44:02 +0100, Andreas Ericsson wrote:
>=20
>> Karl Hasselstr=F6m wrote:
>>
>>> Also, if StGit is to set up hooks automatically (commit hooks,
>>> pre-rebase hooks, whatever), it'd be nice to not have to worry
>>> about overwriting any existing hooks the user might have. But git
>>> currently allows only one hook script per hook, right?
>> Yes, but you can obviously call any number of scripts and programs
>> from within the hook that git executes.
>=20
> That doesn't help here, however, since the user and not StGit "owns"
> the "top-level" hook. StGit would have to rely on the user having
> installed a specific kind of multiplexer as a hook script (e.g. one
> that executes everything under .git/hooks/$hook.d/). Or it would have
> to install it itself, and hope that moving any existing hook to the
> subdirectory where the multiplexer looks for hooks doesn't break
> anything. Both solutions are problematic.
>=20


The user-defined hook can be kept in the hooks directory too. It just
needs to be named in such a way that git will never have a hook named
like that. For that reason, I think it would be easiest to just agree
for the git core to never call any hooks prefixed with "stgit" or
some such. I think the odds for it happening by chance are remote, to
say the least.

---%<---%<---
#!/bin/sh

do_stgit_things

sh -c '"$GIT_DIR/hooks/pre-stgit-$action-hook" "$@"'
exit $?
---%<---%<---

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
