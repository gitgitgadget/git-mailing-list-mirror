From: Sam Vilain <sam@vilain.net>
Subject: Re: From P4 to Git
Date: Mon, 03 Aug 2009 23:30:10 +1200
Message-ID: <1249299010.7164.8.camel@maia.lan>
References: <85ljm84lat.fsf@oqube.com>
	 <m3fxcg3473.fsf@localhost.localdomain> <85r5vxbd8e.fsf@oqube.com>
	 <200907311122.43918.jnareb@gmail.com>
	 <81b0412b0907310414x7157fecey947da960ff8be1cc@mail.gmail.com>
	 <4A76967B.7080502@vilain.net>
	 <81b0412b0908030147i34a7440dg982c7a6e7dc51bca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Arnaud Bailly <abailly@oqube.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 13:28:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXvir-0006SV-ED
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 13:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbZHCL2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 07:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754778AbZHCL2s
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 07:28:48 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:36206 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753794AbZHCL2r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 07:28:47 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 6054921CC3D; Mon,  3 Aug 2009 23:28:31 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 0B35F21C2D7;
	Mon,  3 Aug 2009 23:28:22 +1200 (NZST)
In-Reply-To: <81b0412b0908030147i34a7440dg982c7a6e7dc51bca@mail.gmail.com>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124692>

On Mon, 2009-08-03 at 10:47 +0200, Alex Riesen wrote:
> Is it an import-once tool, or can the process be restarted? (because it looks
> like the script needs a complicated setup).

It's fully restartable.  Not only that but it uses transaction
protection to make sure that its internal state doesn't get corrupted
when performing the various options.

> Can it be used from a client machine?
>  And more importantly:
> can the branches be found from incomplete history,
> restricted by path and changelist range? (because, in a corporate
> setup, clients seldom have full access to all data).

No, it's server only.  I think I did get around to implementing not having
to go through all the stages for branches you didn't care to import.  It's
difficult though, the stage which correlates those thousands of 'integrate'
records is never going to be fast.  Be prepared to tune your postgres - add
lots of shared_buffers and sort memory if your project is as large as Perl.

Sam.
