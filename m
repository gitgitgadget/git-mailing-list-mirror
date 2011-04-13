From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: REMOTE_USER value propagation through http push
Date: Wed, 13 Apr 2011 09:32:11 -0700 (PDT)
Message-ID: <m3k4ey2jvn.fsf@localhost.localdomain>
References: <4DA57183.6040308@laposte.net>
	<m3oc4a2tzf.fsf@localhost.localdomain>
	<22124707.170284.1302701972329.JavaMail.www@wwinf8403>
	<201104131627.29138.jnareb@gmail.com>
	<12538384.27708.1302706703346.JavaMail.www@wwinf8204>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Axel <axel.ml@laposte.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 18:32:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA2zS-00039j-RZ
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 18:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156Ab1DMQcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 12:32:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48232 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933145Ab1DMQcO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 12:32:14 -0400
Received: by fxm17 with SMTP id 17so577809fxm.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 09:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=d7z9Pcez6t7yeyZdCBagbfaFkme9dI8b1urB6HUi1gQ=;
        b=NILTLr6pXxNSj5H1nHTqc85NF8iWr7YxGQeqiTT/0Ue67dPwczXtZW8T8v1oTOuzQ0
         JH4LNpV4EVwCAIJ+MwH7i+5z9tehHIqASA/HkL3gx1OY8FuP5EHWmAo4WkUXt1+xtI4K
         4Duq6Rbl/c9n8tYrYq6gBOiM6bRKKPzXfab5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=qgSK6V/ycqz51tA0FPrPE3/GVEFqrmgJX2/Uurj7FyCk9/ODwDtyrJm44cmJLkX5Lz
         UN0WovGgfnvhsm1nTZWEcraXlgLDenSJ7e5d8IGBs+jg8Jcz4sbn3yRzI/hrgR3ZWeDh
         KWFr04iAvK3sqOSv+3JvknjAGfSRRgPkDHias=
Received: by 10.223.15.141 with SMTP id k13mr671754faa.30.1302712333128;
        Wed, 13 Apr 2011 09:32:13 -0700 (PDT)
Received: from localhost.localdomain (abwp92.neoplus.adsl.tpnet.pl [83.8.239.92])
        by mx.google.com with ESMTPS id l4sm233055fan.14.2011.04.13.09.32.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 09:32:11 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3DGVelV029190;
	Wed, 13 Apr 2011 18:31:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3DGVPgr029186;
	Wed, 13 Apr 2011 18:31:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <12538384.27708.1302706703346.JavaMail.www@wwinf8204>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171465>

Axel <axel.ml@laposte.net> writes:

> Jakub Narebski wrote:
> > 
> > Nope, at the time of push commits are already created, and author and 
> > committer info are already set in stone, and not possible to change 
> > without rewriting commits.
> 
> I will dive further into the links you gave. I think I'll sacrify
> the credentials information then for the moment.

What you can do in _distributed_ version control system such as git is
to ensure that pushed *existing* commits (created on client) match
credentials.

That is opposed to situation in _centralized_ version control system
where credentials are used to *create* commits on server.

> Is there a chance that we ll see one day this third level of
> information (the authentication credentials) added to the push and
> displayed by gitweb ?

Well, git by itself doesn't log authentication credentials.  In the
reflog you have user which git is running as, and only if push was
done via smart protocol (and core.logAllRefUpdates is true on server).

So it is unlikely for gitweb to display e.g. gitolite logs... well,
unless gitolite would adds it to gitweb via some pluggable mechanism
like $feature{'actions'}.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
