From: John Keeping <john@keeping.me.uk>
Subject: Re: git gui replaces amend message when prepare-commit-msg hook is
 used
Date: Thu, 4 Jul 2013 11:34:40 +0100
Message-ID: <20130704103440.GH9161@serenity.lan>
References: <CAGHpTBKOX8G1PZqE2njQ1UbFJeC_L6WxjnTC5NyT8LSbiBNGXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 12:34:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UugsK-000335-9C
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 12:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055Ab3GDKew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 06:34:52 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:49501 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab3GDKew (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 06:34:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 89B19CDA60A;
	Thu,  4 Jul 2013 11:34:51 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bOOtNVliQBYn; Thu,  4 Jul 2013 11:34:48 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 07017CDA5E5;
	Thu,  4 Jul 2013 11:34:47 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id EB997161E245;
	Thu,  4 Jul 2013 11:34:47 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5y4XwVpD+u4i; Thu,  4 Jul 2013 11:34:45 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 8DB0D161E554;
	Thu,  4 Jul 2013 11:34:42 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAGHpTBKOX8G1PZqE2njQ1UbFJeC_L6WxjnTC5NyT8LSbiBNGXw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229569>

On Thu, Jul 04, 2013 at 12:47:28PM +0300, Orgad Shaneh wrote:
> Hi,
> 
> If a prepare-commit-msg hook is used, git gui executes it for "New Commit".
> 
> If the "New Commit" is selected, and then immediately "Amend" (before
> the hook returns), when the hook returns the message is replaced with
> the one produced by the hook.

I think this is a problem with the hook you are running.  The hook is
given arguments specifying the message file and optionally the source of
whatever is already in the file (see githooks(5) for details).

It sounds like your hook is blindly overwriting the file, rather than
preserving its contents in the cases where you wish to do so.
