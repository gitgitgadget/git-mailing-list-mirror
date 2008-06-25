From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to rewalk the commit list after rename detection
Date: Wed, 25 Jun 2008 13:50:01 -0700 (PDT)
Message-ID: <m3tzfhi6iz.fsf@localhost.localdomain>
References: <20080623153814.GD15773@redhat.com>
	<20080625190404.GE4039@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Don Zickus <dzickus@redhat.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:51:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBbxJ-00017v-3u
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 22:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbYFYUuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 16:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbYFYUuI
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 16:50:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:37380 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbYFYUuG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 16:50:06 -0400
Received: by ug-out-1314.google.com with SMTP id h2so157649ugf.16
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 13:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=NNElrxhgUQO4jJbEEvvEKhH0uP1k2FIvJ11xCgb5Rhk=;
        b=tuPRuYdxaNhIEm9xODjV4PxNT+myqu7X4glzDwCJlVU9Pr4xL2vzl+wC3R2TeGS7Lc
         Lgmawjt6cvBI59EdnJMEvA7NHQb6m0uesh6XBYP9DfbylkxzFqD8enHDIGcgGqar7L7B
         sRXGMyHJnI6HA97txya7zJbsECqAyUbbRR2Ug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=m2BrouuZROOZuknBfnf7cr6ryxGL44lnZogs4kGPX9phAWOjSW+9Ei0zJXioztc6CK
         f3kzEm9SMDNUc+0x+qqZ9UgkNL7RTkwI73SYlkGj2YrLJHrYHt6qZj3sBKfB5Y+50c7k
         pZ5GuU1myPXPoLI7tu93cyNIsF4XC0naSZeFA=
Received: by 10.67.103.10 with SMTP id f10mr855174ugm.3.1214427002710;
        Wed, 25 Jun 2008 13:50:02 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.220.164])
        by mx.google.com with ESMTPS id i40sm695046ugf.24.2008.06.25.13.50.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 13:50:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5PKnvp1017716;
	Wed, 25 Jun 2008 22:49:57 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5PKnuEJ017713;
	Wed, 25 Jun 2008 22:49:56 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080625190404.GE4039@steel.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86345>

Alex Riesen <raa.lkml@gmail.com> writes:
> Don Zickus, Mon, Jun 23, 2008 17:38:14 +0200:
> >
> > I am trying to find a way to handle a situation where I am looking for a
> > change in a particular file, but the filename is old and has since been
> > renamed.
> > 
> > Processing the commit list internally (using init_revisions,
> > setup_revisions, get_revision), I can easily find the rename of the file,
> > but that is usually the start of the walk for that file (as it was just
> > deleted for the rename).  I do not know how to re-walk the commits list
> > armed with the new file name.
> 
> Try looking at git log --follow <name>

Unfortunately it _almost_ works, see:
  "git log --follow <filename> doesn't follow across 'subtree strategy' merge"
  Message-ID: <200806221451.50624.jnareb@gmail.com>
  http://permalink.gmane.org/gmane.comp.version-control.git/85766

("git log --follow gitweb/gitweb.perl follows rename from gitweb/gitweb.cgi,
but not rename (moving) from gitweb.cgi in a merge commit).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
