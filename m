From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] Fix in-index merge.
Date: Sat, 23 Aug 2008 11:19:43 +0200
Message-ID: <48AFD62F.2090500@gnu.org>
References: <20080823060839.GB23800@genesis.frugalware.org> <1219479293-29111-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 11:20:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWpIm-0000ev-HQ
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 11:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbYHWJTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 05:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbYHWJTt
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 05:19:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:11213 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbYHWJTt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 05:19:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so471917fgg.17
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 02:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:sender;
        bh=XzHWrpJNypEimmLkdm4zQ2v40bgxrZn22qZbiX7+Y3k=;
        b=bokH95QgLKeEHKiumL3N26AFqRf5dyg8gx+lYr7tK2ycCUOiOLJ+UCcl/SxNVZO/O2
         UySDCyJWchEq/JW12/AHOpCBvbn6giBRrIfAizNl7TF9XOdmR0wi5IX1NhPf2K/oq7Ax
         XDcsMDM1CPz8STEiooZc+DdjKZUAJX1ZzivfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:sender;
        b=w+7KQLgkZo8PuNGGkSDm6BDzqoEHKDJNe2/dZpq59mAeH85B0yX2XIGCw2mA8r6CkJ
         airu7Rls+9rq4+tBU3RiyoXIvv3x5zAYPXCqZPgSiMeBW4yf2vZ9OodZqk0jYvU9o2hg
         VelthRq2Kp0bTRIzy3C6s3Czj6Aj5kuXVkGgw=
Received: by 10.86.52.6 with SMTP id z6mr1551936fgz.48.1219483187706;
        Sat, 23 Aug 2008 02:19:47 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id l19sm2252392fgb.7.2008.08.23.02.19.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 02:19:46 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1219479293-29111-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93449>

Miklos Vajna wrote:
> There were 3 issues:
> 
> 1) We need read_cache() before using unpack_trees().
> 
> 2) commit_tree() frees the parents, so we need to malloc them.
> 
> 3) The current HEAD was missing from the parent list.

Unfortunately it does not really work yet, since the files only present
on the second branch are not added.  I do get

Trying really trivial in-index merge...
Wonderful.
In-index merge

but then "git status" gives:

# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       b

(in my testcase for pre-merge, this results in a failure of the
"octopus" testcase).

Paolo
