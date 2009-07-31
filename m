From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] Add Gitweb support for XZ compressed snapshots
Date: Fri, 31 Jul 2009 11:27:50 -0700 (PDT)
Message-ID: <m38wi4so66.fsf@localhost.localdomain>
References: <828BD9FC-1238-4B2E-858D-248977F04D31@uwaterloo.ca>
	<4A7332F3.50908@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Jul 31 20:27:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWwph-0006sR-Nj
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 20:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbZGaS1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 14:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbZGaS1w
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 14:27:52 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:55215 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbZGaS1v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 14:27:51 -0400
Received: by ewy10 with SMTP id 10so1711861ewy.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=dlaYGeit8Kgc3zbUBjp+9q1BADar9wVf1YYmyz+bl18=;
        b=JTkvwruGpY9ay0uNIOBOOEhZ1+3JNTGbRAlzFx6MLgpLH4BNKb08vUJ6aIo6N9IzyN
         dUWLSyEMxvlF8uduZkcYbkZvrMvI1ztcgUQ7sz3lvw+Ker7Sna6BTff9m8EwoLTOPMFf
         wEL5OqTU3WSjFQc4TAe2j09WyNj5s0mXEho3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=QGqTIeRhZ5E18znIAEibmDusoOglpiE1WBOLgEptbkhRDhxKS46dmqE/lYJFZ8nS8z
         f9OwXT1mV90uVvv/ErNJIWOQOXCv9r9MRuE6Dmntltic2Kz9jaa4P9ptL57Rk8zpekTI
         HbOz4XasnQS68NIEsz9YFqKTsrUhFvQQ567tw=
Received: by 10.210.66.10 with SMTP id o10mr1249885eba.65.1249064871032;
        Fri, 31 Jul 2009 11:27:51 -0700 (PDT)
Received: from localhost.localdomain (abvt17.neoplus.adsl.tpnet.pl [83.8.217.17])
        by mx.google.com with ESMTPS id 5sm4559455eyh.56.2009.07.31.11.27.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Jul 2009 11:27:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6VIRmp9029368;
	Fri, 31 Jul 2009 20:27:48 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6VIRk0x029365;
	Fri, 31 Jul 2009 20:27:46 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A7332F3.50908@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124590>

"J.H." <warthog19@eaglescrag.net> writes:
> Mark A Rada wrote:

> > I have not enabled XZ compression by default because the current
> > default is GZip, and XZ is only really competitive with
> > BZip2. Also, the XZ format is still fairly new (the format was
> > declared stable about 6 months ago), and there have been no
> > "stable" releases of the utils yet.
> 
> One thing that would concern me greatly, is not so much the CPU time
> (though that's a *huge* change in comparison to gz) but the memory
> usage.  Where gzip and bzip2 are chewing 4M and 13M respectively, xz
> chews 102M.  From a 'beefy' server perspective chewing up that much
> memory per snapshot for that long could be bad.  This is likely
> something that needs to have some sort of enable/disable switch if
> it's going to be included.

First, by default project specific override for 'snapshot' feature is
disabled, and only 'tgz' ('.tar.gz') snapshot links are generated.

Second, if you want to enable project specific override for 'snapshot'
feature, you can still control what snapshot formats (among 'tgz',
'tbz2', 'zip' and now 'txz') from $GITWEB_CONFIG by simply deleting
formats you don't want to be used from %known_snapshot_formats.

For example

  delete $known_snapshot_formats{'txz'};

> 
> Good analysis btw, though I'll admit it makes me leary of something
> dynamically generating xz compressed files.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
