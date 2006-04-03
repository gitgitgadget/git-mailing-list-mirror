From: "Kees-Jan Dijkzeul" <k.j.dijkzeul@gmail.com>
Subject: Cygwin can't handle huge packfiles?
Date: Mon, 3 Apr 2006 11:46:13 +0200
Message-ID: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Apr 03 11:46:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQLdZ-0005WI-AQ
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 11:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWDCJqO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 05:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbWDCJqO
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 05:46:14 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:29824 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751397AbWDCJqO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 05:46:14 -0400
Received: by zproxy.gmail.com with SMTP id o37so1756851nzf
        for <git@vger.kernel.org>; Mon, 03 Apr 2006 02:46:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=H0KY9ZwvVRAAPUzfdaQqzv+f90BiIkR/87Q2cowd5VT07E0vcUp2u8j5X4N/iOn88j/r4W1UI7O3pm05SgxyCAJXt2Q8Rx8qmGLWo5mn1NkusGOWg6W9lNOy/kexEw77tWVyAr/Wks+xm6sFW++Kfx+U0sCFO69n1uXIAilnSK4=
Received: by 10.35.43.10 with SMTP id v10mr823667pyj;
        Mon, 03 Apr 2006 02:46:13 -0700 (PDT)
Received: by 10.35.124.20 with HTTP; Mon, 3 Apr 2006 02:46:13 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18323>

Hi,

I'm trying to get Git to manage a 5Gb source tree. Under linux, this
works like a charm. Under cygwin, however, I run in to difficulties.
For example:

$ git-clone sgp-wa/ sgp-wa.clone
fatal: packfile
./objects/pack/pack-56aa013a0234e198467ed37ae5db925764a6ee98.pack
cannot be mapped.
fatal: unexpected EOF
fetch-pack from '/cygdrive/e/Projects/sgp-wa/.git' failed.

To figure out what is happening, I printed the value of errno, which
turns out to be 12 (Cannot allocate memory). I'm not sure how mmap is
implemented in cygwin, but if they allocate memory and load the file
into it, then this error is not surprising, as the pack file in
question is 1.5Gb in size.

I'm not sure how to approach this problem. Any tips would be greatly
appreciated.

Thanks a lot!

Kees-Jan
