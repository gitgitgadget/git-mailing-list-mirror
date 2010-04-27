From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Metadata and checkin file date
Date: Tue, 27 Apr 2010 02:35:00 -0700 (PDT)
Message-ID: <m3sk6hck8b.fsf@localhost.localdomain>
References: <alpine.LFD.2.00.1004270719320.17234@bbs.intern>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerhard Wiesinger <lists@wiesinger.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 11:35:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6hCD-0005G7-CX
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 11:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248Ab0D0JfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 05:35:05 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:37475 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab0D0JfE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 05:35:04 -0400
Received: by bwz19 with SMTP id 19so17685bwz.21
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 02:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=zkAuBALNqqavtn0MI+wnBEgzmV2dzurBvtpoLMc+uoQ=;
        b=Noe8GUR+W+nacJPi1P0HBA5Wg8Dh2JMHbKxxGfYq908ivo6YDiHI94NmfrcEXdBGSp
         DSVjW1RPoXMSvkqdVd/Xcrjy4Z35ImeU6OkH7MGO6gLTK+yh8IP+NxnVIehxVAUf5v7K
         BoaL3pk9jxFDuaoMm1gApOfqqaYmLsKR2eD2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=dqnA41ij/ZxOgaxR1NkO7W6Xc3YnYHXxTq5OD2jAVPIeb80VI5BL0a59JLNEP/h7i/
         afPW69Gkb6TIrf6LailBbuDQk95uJF0oWWFtz9FUFcLTKrLt15iE9OXzNhhCOwe9LMD5
         3fxMC6AkMnrETgQ8yHOHwsRlULy5phq3leufk=
Received: by 10.204.11.18 with SMTP id r18mr3514021bkr.55.1272360901457;
        Tue, 27 Apr 2010 02:35:01 -0700 (PDT)
Received: from localhost.localdomain (abwh49.neoplus.adsl.tpnet.pl [83.8.231.49])
        by mx.google.com with ESMTPS id 16sm1792979bwz.9.2010.04.27.02.35.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Apr 2010 02:35:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3R9YUiR012259;
	Tue, 27 Apr 2010 11:34:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3R9YDd9012249;
	Tue, 27 Apr 2010 11:34:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.2.00.1004270719320.17234@bbs.intern>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145890>

Gerhard Wiesinger <lists@wiesinger.com> writes:

> Hello,
> 
> I'm new to git and I'm looking for the following features:
> 1.) Metadata for
>    a.) directory versioning (e.g. add/rm, mv)
>    b.) rights (basic: chmod, chow, chgrp, extended: extended
> attributes like ACLs and selinux), necessary for versioning e.g. /etc
> 2.) Original file dates (checkin date) on clone and pull (and not
> checkout date)
> 
> Is this possible? Any plans if missing?

Git is distributed version control system (DVCS), not a backup system.
It is used mainly for distributed development of programs.  Therefore
it supports natively only those parts of metadata that make sense for
VCS, namely symlinks (with workaround for filesystems that do not have
support for symbolic links) and the executable permission for files.

File ownership does not make sense for VCS, as other people that clone
your repository do not have the same set of users that you have, and
might not have the same set of groups that you have.  Neverthemind that
their filesystem might not support notion of file ownership, not only
do not have support for extended attributes and the like.

If you really, really need this, you can use additional tools to
preserve metadata, like Metastore or git-cache-meta, or even ready
tools that use Git as bckend like IsiSetup or bup (well, bup use
git package format, not git itself...), see this Git Wiki page:
https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

HTH (Hope That Helps)
-- 
Jakub Narebski
Poland
