From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Handling large files with GIT
Date: Wed, 8 Feb 2006 22:14:18 +1300
Message-ID: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Feb 08 10:14:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6lPC-00050L-Mp
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 10:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWBHJOV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 04:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWBHJOV
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 04:14:21 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:61106 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964858AbWBHJOU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 04:14:20 -0500
Received: by wproxy.gmail.com with SMTP id i34so1428747wra
        for <git@vger.kernel.org>; Wed, 08 Feb 2006 01:14:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lAnk0uqMH2l4qgbTXVh5ZxEWXDSvTAoiWA0Xq5d341Lu19RPaxa0ErvvnUSnwMqXznsk8EncAwj554qoEby3m+fR5uu6xwgL4KgdP+QY91+Af8pn+mhFJMIdIAOeuvSIvI/4G+czcniLMvNijyMafAgF6qs6ka9V4pSr6oVXSU8=
Received: by 10.54.112.10 with SMTP id k10mr9014820wrc;
        Wed, 08 Feb 2006 01:14:18 -0800 (PST)
Received: by 10.54.71.7 with HTTP; Wed, 8 Feb 2006 01:14:18 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15734>

Roland Stigge recently pointed out a use case using very large files
where GIT has some serious limitations. He is one of several Debian
developers keeping their homedir under version control with SVN (blame
Joey Hess for this - http://www.kitenet.net/~joey/svnhome.html ).

SVN does reasonably well tracking his >1GB mbox file. Now, I don't
know if I like the idea of putting my own mbox file under version
control, but it looks like projects with large and slow-changing files
would be in trouble with GIT. Not literally trouble, but gross
inefficiencies.

The problems are two. At commit time, a full copy is stored in the
object database until git-repack && git-prune-packed are called. And
during the transfer over the git protocol we send the full object,
even if both ends have objects that are good candidates for a small
delta.

I'm not strong on either aspect of git (packfile format or git
protocol), and I don't personally deal with large files. So feel free
to ignore me for the time being. If it ever itches, you might get a
patch...

cheers,


martin
