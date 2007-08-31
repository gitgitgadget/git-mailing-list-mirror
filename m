From: "Stephen Cuppett" <cuppett@gmail.com>
Subject: [RFC] Change handling of RelNotes
Date: Thu, 30 Aug 2007 21:35:36 -0400
Message-ID: <316a20a40708301835hc4236d4tdb289b6f705ab86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 03:36:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQvQR-0003Mc-NS
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 03:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756387AbXHaBfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 21:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754392AbXHaBfi
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 21:35:38 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:37292 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057AbXHaBfh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 21:35:37 -0400
Received: by nz-out-0506.google.com with SMTP id s18so535864nze
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 18:35:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=B4S5l3b9TDNi/cnTxnT+KG7KrcEZvn8AOZXOx75tWTzg92mTCCBBZf82IQ1zBcMDQY2wK3p/y10p2lReljBeIj/flOH1nM7kV7Tmeo7geAw+J8nJ7iRuZUOZ1xBhto/ztAvnBhQDycRU2pYgK+wdP3tsLsABN2FCt4z00GarENU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QTkIIEQkgoLMdGN4PQ3IDCA+IvgtysRSD0tBD+/gAQKR9g5zENJ4g2lZ3LpgdWZmazPb4FU+JLmbogSuVygbTw9WtBwv2w/7ZUMaTeXtp3l+1MAppc6utdCYgFE2gH5enTlaAxEQohTDqSClf4lMjHSeRT/V3qAk8Gk7f+8UhHw=
Received: by 10.143.165.13 with SMTP id s13mr52064wfo.1188524136328;
        Thu, 30 Aug 2007 18:35:36 -0700 (PDT)
Received: by 10.142.111.8 with HTTP; Thu, 30 Aug 2007 18:35:36 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57100>

I went to clone git onto a memory stick today.  The default fs on the
sticks doesn't support symlinks.  After looking a little bit, the only
symlink I can see in the source tree is RelNotes.  It appears when
going to a new release the file gets created in /Documentation and the
symlink updated.

I propose we eliminate this symlink.  There are multiple other things
we can do to eliminate it and make the repository more flexible across
filesystems:

 * Always have current release in /Documentation/RelNotes and keep the
prior versions named the way they are maintained now.  When starting a
new release, rename the file and create it again.
 * Keep the current in RelNotes and leave the archived ones in
/Documentation.  Doing same content move and clear operation when
starting a new release.
 * Keep two copies RelNotes and /Documentation/RelNotes-X.X.X that
essentially have same content and RelNotes has a lot of churn
 * others...?

With this one abnormality the git repo on a normal flash drive doesn't
work... at least in my case.
