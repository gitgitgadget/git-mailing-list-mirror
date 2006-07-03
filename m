From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-cvsimport gets parents wrong for branches
Date: Tue, 4 Jul 2006 11:15:47 +1200
Message-ID: <46a038f90607031615m2cafbf05q5922fb04eae72362@mail.gmail.com>
References: <20060703215303.GA24572@memak.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 04 01:15:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxXdx-0008Kw-S0
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 01:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWGCXPt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 19:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWGCXPt
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 19:15:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:44089 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932066AbWGCXPs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 19:15:48 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1631287ugf
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 16:15:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MBcOitubM/AK3bqElzpYUYtpRgjLVj4s7gHAvkN6mZWzQrXNOckXLrdK/eFJ5r8gUlX9oCaRVFnFnbHfm6htBVL7f+IAT4Bxm7cnN2wv3M/POSoBqN6eOxom7i427LxyeMr2+kGXpMnyopsjegmCkhRPtHhWIm40cQzv6T4B0h8=
Received: by 10.78.140.17 with SMTP id n17mr1074403hud;
        Mon, 03 Jul 2006 16:15:47 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Mon, 3 Jul 2006 16:15:47 -0700 (PDT)
To: Elrond <elrond+kernel.org@samba-tng.org>, git@vger.kernel.org
In-Reply-To: <20060703215303.GA24572@memak.tu-darmstadt.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23225>

Elrond,

you are right, the current git-cvsimport takes a very naive approach
to determine where branches open from. It uses cvsps internally, which
only reports on the ancestor branch, so we take the latest commit from
the ancestor.

Parsecvs probably has a more sophisticated approach, have you tried it?

It is pretty hard to get that one right in any case, as there are
cases where the new branch starts from something that is not a commit
in the parent (from GIT's perspective). So representing the branching
point would mean pointing to non-existing commits as parents.

If the cvs2svn documentation is not lying, it probably has the
smartest/correctest implementation. For small-medium repos, you may be
able to run cvs2svn and then import with git-svnimport.

cheers,


martin
