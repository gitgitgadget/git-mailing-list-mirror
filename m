From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Wed, 11 Jun 2008 17:35:29 -0500
Message-ID: <VvvF8m917iheDGmce6GDbHpylrcdO5FHv3p0WaTpMdrLPTsIwooVnQ@cipher.nrlssc.navy.mil>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 00:39:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6YwZ-0007s0-2A
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 00:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbYFKWgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 18:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbYFKWgG
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 18:36:06 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39415 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbYFKWgF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 18:36:05 -0400
Received: by mail.nrlssc.navy.mil id m5BMZUHk026673; Wed, 11 Jun 2008 17:35:30 -0500
In-Reply-To: <20080611213648.GA13362@glandium.org>
X-OriginalArrivalTime: 11 Jun 2008 22:35:29.0901 (UTC) FILETIME=[73C849D0:01C8CC13]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84675>

Mike Hommey wrote:
> On Wed, Jun 11, 2008 at 04:29:56PM -0500, Brandon Casey wrote:
>> The stash makes use of git's reflog mechanism, but it is not a reflog
>> in the traditional sense. Each entry is a state that the user explicitly
>> requested git to remember. The stash is generally short-lived, but the
>> user probably expects that a stash will continue to exist until it is
>> explicitly deleted. So we should not expire stash entries.
> 
> I wonder if it wouldn't make sense to have git reflog expire not expire
> stashes *at all*. I mean, you don't necessarily cleanup your repo with
> git gc, and you may end up killing your stashes with git reflog yourself
> if you don't use the "magic" --exclude...

How do you do it cleanly? I don't like the idea of a config option which
must be set by default when a repository is created and I don't really
like the idea of a hard-coded refs/stash in builtin-reflog.c.

git-reflog is currently a generic command. I didn't mind teaching git-gc
about stashes, but to a quasi-plumbing command like git-reflog it doesn't
seem right.

-brandon
