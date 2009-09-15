From: Owen Taylor <otaylor@redhat.com>
Subject: Re: Patches for git-push --confirm and --show-subjects
Date: Tue, 15 Sep 2009 07:50:32 -0400
Message-ID: <1253015432.11581.135.camel@localhost.localdomain>
References: <1252884685-9169-1-git-send-email-otaylor@redhat.com>
	 <7vpr9ugxn5.fsf@alter.siamese.dyndns.org>
	 <1252895719.11581.53.camel@localhost.localdomain>
	 <alpine.LNX.2.00.0909141745410.14907@iabervon.org>
	 <1252970294.11581.71.camel@localhost.localdomain>
	 <7v7hw19gr5.fsf@alter.siamese.dyndns.org>
	 <1252982329.11581.111.camel@localhost.localdomain>
	 <7v1vm892ow.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 13:51:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnWYy-0005LY-7q
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 13:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbZIOLuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 07:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbZIOLuf
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 07:50:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37042 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546AbZIOLue (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 07:50:34 -0400
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8FBoYLZ002322;
	Tue, 15 Sep 2009 07:50:34 -0400
Received: from [127.0.0.1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8FBoXxg016485;
	Tue, 15 Sep 2009 07:50:34 -0400
In-Reply-To: <7v1vm892ow.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128531>

On Mon, 2009-09-14 at 22:50 -0700, Junio C Hamano wrote:

> You might not see a "policy" in your approach, but it makes some troubling
> hardcoded policy decisions.  Here are a few examples of what your patch
> decides, and makes it harder for other people to build on (rather, "around):
> 
>  - We support only interactive validation (confirmation).  If you want to
>    have an unattended validation scheme, there is no way to enhance the
>    mechanism this patch adds to do so.  You instead need to add yet
>    another command line option and hook into the same place as this patch
>    touches.

It seems like the bulk of any patch is going to be creating a clean
position in the code to do confirmation.

>  - We assume "git push" is run from terminal, and the only kind of
>    interactive validation we support is via typed confirmation from a line
>    terminal "[Y/n]?"  If you want to run "git push" from a GUI frontend
>    and have the user interact with a dialog window popped up separately,
>    you are also out of luck.

That's an interesting situation to consider. How do you see a pre-push
hook being used for that?

>  - We assume it is good enough to have various built-in presentations of
>    supporting information while asking for confirmations; there is no way
>    for casual end users to customize and enhance it.

A shell script that duplicates the display logic from transport.c while
interleaving nicely abbreviated bits of log will be on the complex side.
Is forking and modifying such a script going to be approachable for
casual end users?

- Owen
