From: Sandro Santilli <strk@keybit.net>
Subject: preventing evil merges
Date: Thu, 30 May 2013 18:34:59 +0200
Message-ID: <20130530163459.GI31679@gnash>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 18:35:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui5oy-00027N-PN
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 18:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935559Ab3E3QfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 12:35:11 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:39586 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935536Ab3E3QfF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 12:35:05 -0400
Received: by mail-ea0-f174.google.com with SMTP id z7so580289eaf.5
        for <git@vger.kernel.org>; Thu, 30 May 2013 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=zVhIw6fUA7n7EO20o8emRYFdaQt/RWzd+ytq2BAvaYk=;
        b=dBlHHiiJvyt+7lfQHldE37yXwNrY+u0I5biMlVhck+8opZrEE+UgCtLWkwUEc9Svhg
         rGCyRr+CqotsIjuwMee7M05ZZ/Cl2U9My06VTQ1m7G+YITLXQ94t7ACToGnHJCgjeRbV
         kY+GHuEK17gx/9mV+JIJlgbXssgDFZ/MMyYYKwgP06yvIGAkMK51nj5MRghSN8HQe9Ii
         h5FvFKEMtdzolv+iUO4F+BWAwNm/EbsCL46GtnC3o5u0RN85PS9MuYZKctBoKRd3kXfc
         pzrucOsMtGj5/ndSN2FDNFG9wxToNBhlpZGb7Ac6kPo4KB2GHBKnc1IN0E+ADfXpe4YS
         janQ==
X-Received: by 10.15.109.142 with SMTP id cf14mr10515446eeb.77.1369931704455;
        Thu, 30 May 2013 09:35:04 -0700 (PDT)
Received: from gnash (ip-46-232-148-34.static.adsl.cheapnet.it. [46.232.148.34])
        by mx.google.com with ESMTPSA id y2sm61376149eeu.2.2013.05.30.09.35.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 09:35:03 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226020>

Hey all,
I've be burnt by what someone on IRC referred to as "evil merges",
that is loss of history after amending a merge commit:

 git merge anotherbranch
 git add something
 git commit --amend

After the steps above the addition of "something" can't be found in
the history anymore, but the file is there. Moreover (I think but
didn't try to reproruce) a further rebase to a common ancestore of
my working branch and "anotherbranch" resulted in further loss of
the changes. The only way for me to get them back has been by 
checking out from reflog.

I've no idea about what was going on but this experience reminded me
of another one I had in the past in which we could not figure out when
some changes were added into a repository (!).

If amending a merge is so dangerous, would it make sense to require
and hard-to-type switch in order for it to really do anything ?

--strk; 
