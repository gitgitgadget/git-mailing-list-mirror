From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] t/depend-add-using-export
Date: Sat, 9 Oct 2010 09:45:06 +0200
Message-ID: <AANLkTik6R89vPhwKyWOheHPkxQ9JPpmrQVmXon8Vn4+A@mail.gmail.com>
References: <1286588598-4005-1-git-send-email-odabrunz@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, Petr Baudis <pasky@suse.cz>,
	martin f krafft <madduck@madduck.net>,
	Per Cederqvist <ceder@lysator.liu.se>
To: Olaf Dabrunz <odabrunz@gmx.net>
X-From: git-owner@vger.kernel.org Sat Oct 09 09:45:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4U7w-0004sx-Qw
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 09:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab0JIHpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 03:45:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46852 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab0JIHpH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 03:45:07 -0400
Received: by iwn6 with SMTP id 6so1203962iwn.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=sJSqWhUK/RTiug2H9KkHhErQJV3+PFOxEgLpenVD4Us=;
        b=GZmzbELB2S83PxCdsgdgNzYfG7piZXmv+eZ7YDN+pCBmExLWaTLLFUd30ZXynZE3bD
         Ubb0Os6294uOooLMqUTnGKeFbVdJPPDfhY8rZew3rXZ1fnt94s6IIdpvK7B7vWjARhGR
         z9A+pL40fTdv25kEeV7X/m/UHDNPW2HMUkq1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nZdPxgIktZoGA0fcvYwQjCOL1Vt9pf9lRhEqkvo0jLJtwGbshh1d+pZ+hvOcoTZD6Q
         TThTsnaWjdkfskcahbwRyu7gVJbmbdMovk9BFzrUEw3U6R5rTzYR6xALS/B1aOUbmkfq
         2WiORabzeuz/+fGffB84ZnTE9Of4FchOfdYx8=
Received: by 10.231.30.134 with SMTP id u6mr3044401ibc.121.1286610306683; Sat,
 09 Oct 2010 00:45:06 -0700 (PDT)
Received: by 10.231.147.80 with HTTP; Sat, 9 Oct 2010 00:45:06 -0700 (PDT)
In-Reply-To: <1286588598-4005-1-git-send-email-odabrunz@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158573>

On Sat, Oct 9, 2010 at 03:43, Olaf Dabrunz <odabrunz@gmx.net> wrote:
> When dependencies can be removed as well as added, tg depend add
> needs to make sure that the new dependency can bring in changes
> from a branch that has previously been removed as a dependency
> from the current TopGit branch.
>
> This implementation uses an exported branch set up by tg export,
> and merges the new dependency into the commit that corresponds to
> the current base. Using the exported branch in the merge has the
> advantage that removed dependencies do not appear as parents, and
> the merge base selected by git merge does not include changes from
> a removed dependency. As a result, these changes can be merged in
> again if the new dependency brings in these changes.
>
> The tree of the merge commit is then used to create the next
> commit on the TopGit base branch.

I'm really not an expert, but history comes from the commits not from
the trees. Just using an hand made tree and commit this to the base
doesn't change anything, because somewhere in the parent commits is
still the information, that we merged in a branch that we just tried
to remove (i'm speaking for tg depend remove). But maybe I don't
understand what this patch changes. The only idea is, that we don't
use merge commits for the base any more! Is this what this patch does?

Bert
