From: John Keeping <john@keeping.me.uk>
Subject: Re: Git 1.8.4.2: 'git-rev-parse --is-inside-git-dir' wrong output!
Date: Sat, 2 Nov 2013 10:58:16 +0000
Message-ID: <20131102105816.GC24023@serenity.lan>
References: <CACbqpSvU4qxc0WtquP6Eq8bZGjLxTrVhtT2Nqw90wb23ESkfcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ville Walveranta <walveranta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 02 11:58:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcYuU-0005La-L4
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 11:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab3KBK6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Nov 2013 06:58:23 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:46830 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab3KBK6W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Nov 2013 06:58:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 227DB6064A5;
	Sat,  2 Nov 2013 10:58:22 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y4i5NVgc74+3; Sat,  2 Nov 2013 10:58:21 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id C1C1A198007;
	Sat,  2 Nov 2013 10:58:18 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CACbqpSvU4qxc0WtquP6Eq8bZGjLxTrVhtT2Nqw90wb23ESkfcw@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237239>

On Fri, Nov 01, 2013 at 06:19:51PM -0500, Ville Walveranta wrote:
> "git-rev-parse --is-inside-git-dir" outputs "fatal: Not a git
> repository (or any of the parent directories): .git", instead of
> "false" when outside of a git directory.  "--is-inside-work-tree"
> behaves the same way. Both commands work correctly (i.e. output
> "true") when inside a git directory, or inside a work tree,
> respectively.

I think that's intentional - and it looks like the behaviour has not
changed since these options were added.  With the current behaviour you
get three possible outcomes from "git rev-parse --is-inside-work-tree":

    if worktree=$(git rev-parse --is-inside-work-tree 2>/dev/null)
    then
        if test "$worktree" = true
        then
            echo 'inside work tree'
        else
            echo 'in repository, but not in work tree'
        fi
    else
        echo 'not in repository'
    fi
