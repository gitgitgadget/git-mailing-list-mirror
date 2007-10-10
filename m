From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: git branch performance problem?
Date: Wed, 10 Oct 2007 18:30:02 -0300
Message-ID: <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com>
	 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com>
	 <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com>
	 <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:30:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifj8B-0000aX-D5
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692AbXJJVaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756686AbXJJVaF
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:30:05 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:27141 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666AbXJJVaE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:30:04 -0400
Received: by py-out-1112.google.com with SMTP id u77so634087pyb
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 14:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=mPSp2o0kJta7zfWHhJX+H8q6+YuHQN5JXz9lVu6Gr+4=;
        b=j56TNcP2OIKHRrn+OLBvq2qt4NOVtW7mtdYlOUiCcwZRK80sCS3DskZkCO5pzrrXh3z0UJJ19ilV6Nx2+Lj7HngDJYn1RnDU5TMDIxPE/LAU5dp8rWZjWg9uojQpmwrDjrzzmLEZqp15moFmQ9DLaAj6W8FJSlVK3Zo/6oNt/IY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CrMPXrHdHiOBs/13AqSu07VDIZLvJS9Q2RqR2UVJal68KWHsxRn9uy4vdOWUynci1fsqw5yZXEM8wFt7bJ1aAiGoi0dSO8bazrBDT7TBaILCBAMrrmeBkkOQzhTJsZEr/GEOfBjYZ6ZLEMVSvBQyC8S4tamOveEVLt5hb9U54po=
Received: by 10.65.151.6 with SMTP id d6mr1747312qbo.1192051802829;
        Wed, 10 Oct 2007 14:30:02 -0700 (PDT)
Received: by 10.65.157.11 with HTTP; Wed, 10 Oct 2007 14:30:02 -0700 (PDT)
In-Reply-To: <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60548>

2007/10/10, Han-Wen Nienhuys <hanwenn@gmail.com>:
> More to the point, I seemed to have lost my entire repository. This is
> the type of surprise  I don't enjoy.
>
> Now, can someone explain why 'git branch' takes forever if there are
> only two non-remote branches ?

So,

Here is a question:  I would like to share commitishes between two checkouts
of a repository. The reason for this is that I want to easily cherry
pick back and forth between the two. The files of in one of them
should be continually available, since I am running out of that
directory.

The way I solved that, was to have both repositories pointing to each
other, using alternates.

Now, after a couple of gc and pack-refs iterations, I am greeted by

hanwen@lilypond:~/vc/git6$ git fsck
missing tree 12b00ec3190f7b46a5fe0a3235445bead4c9645b
broken link from    tree 1718d09e0394d113c162e4a3471e7a1f20914a94
              to    blob 635e2802568b85017007698c0e6dd4d28dca496f
broken link from    tree 926899798fce75038e24f8fa1838f6da8bcf105f
              to    tree f1b852d270ebbaaf95d8ddc06c52763bad11ff25
missing blob 99f0c0d63276fce444e3a200167b636236784c52
missing tree f1b852d270ebbaaf95d8ddc06c52763bad11ff25
missing blob 236962a87fafae8ca2dce2dc550d344aa7a8884a
missing blob 7d69ca297f392a954c4cdcb62bb4c8a90ddb862b
missing blob 9e39be8f5cb4eeff97fcfd6eb77fefeda02f0e71
dangling blob f3a93f023080ce9fc6becb397e366cc4ceb192f5


could it be that GC does not handle cyclic alternates correctly?

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
