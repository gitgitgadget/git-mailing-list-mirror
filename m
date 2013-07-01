From: Phil Hord <phil.hord@gmail.com>
Subject: Re: git clone -b
Date: Mon, 1 Jul 2013 13:49:37 -0400
Message-ID: <CABURp0oQ9MNGZecD4mkniXMEUJ5L7Xn+JFQMEgc97Mfe26JYvg@mail.gmail.com>
References: <51CD7AB7.3040409@atlas-elektronik.com> <51D12A0E.60709@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 19:50:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtiEm-0007ee-Rr
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 19:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab3GARt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 13:49:59 -0400
Received: from mail-vb0-f52.google.com ([209.85.212.52]:35701 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853Ab3GARt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 13:49:58 -0400
Received: by mail-vb0-f52.google.com with SMTP id f12so3870173vbg.11
        for <git@vger.kernel.org>; Mon, 01 Jul 2013 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=v5Pa0zIVbioz8gDnPhqd9KmuEfDtkOM9TWPZMG75kjA=;
        b=L+1gIJwCZYQRK5Iasn641LGJBcQwOc7oWT51Zz1akXnLOB2Ocov4A20fKkB/En9sMO
         eB5hL96RRAvBKM8fIrW9P3mro5VCMyPDcbzq9RKY/LD8mjsp7ZWQ9bFjEt8bbeY4pawN
         erHwxwLl97pCwQkSTXbMvRdKKYSj2zMETyVOHgkYdx5w2gFldITt8voPXWz5QhO+6RaX
         +BmCm2r62l7x/o9q2vhE0oqWKkcpVy2HW/5CEclsjoNVnL1zhyASn7DHSVKNdcLQKIMW
         aodqz01+GxBOq/RoZU0fRLu5MGGeXVz1r7w4r7rmO1VGsHcxOtxJibdAWTAmsua92zex
         +ueQ==
X-Received: by 10.58.255.229 with SMTP id at5mr9896805ved.44.1372700997937;
 Mon, 01 Jul 2013 10:49:57 -0700 (PDT)
Received: by 10.58.220.72 with HTTP; Mon, 1 Jul 2013 10:49:37 -0700 (PDT)
In-Reply-To: <51D12A0E.60709@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229316>

It would be nice to support more generic specs for the --branch
switch. But it is complicated because the refs have not been fetched
yet during the clone, and so normal refs operations -- which expect to
work on a local repository -- do not work.  So, the ref is looked up
locally from a list in expected locations after fetching the remote
refs but before the clone occurs.  The remote refs which are fetched
is not configurable during clone, and so only 'refs/heads/*' is
fetched for non-mirrors.

I was able to tweak git-clone to fetch the remote ref when I hacked
builtin/clone.c to check in 'refs' and also to extend the refspec to
something more broad ("+refs/*:refs/remotes/origin/*"), but this is
not a workable solution.  But there probably is a more correct way
than the hack I tried.

Phil
