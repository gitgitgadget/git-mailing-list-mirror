From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Compression and dictionaries
Date: Sun, 13 Aug 2006 23:37:21 -0400
Message-ID: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 14 05:37:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCTGf-0006hm-Pl
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 05:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbWHNDhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 23:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWHNDhX
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 23:37:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:28703 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751828AbWHNDhW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 23:37:22 -0400
Received: by nf-out-0910.google.com with SMTP id a4so1586136nfc
        for <git@vger.kernel.org>; Sun, 13 Aug 2006 20:37:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JRpocdIH8bel3s+I4/n+1ACRHScc2m/XiKmttL1FZeN/M4U/iY59M62u+6JgJ3HbjZRjLbV+xEAeDQ05GHu3vWtiiyx5kFfKJBGiTkBAlhHiZ687EKZrI93EzJB2ujr4rAxZqgNDaoPA5vLnHt+vizQ1sutGUy3o0yTbRre7wRg=
Received: by 10.78.133.10 with SMTP id g10mr3089687hud;
        Sun, 13 Aug 2006 20:37:21 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Sun, 13 Aug 2006 20:37:21 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25313>

>From what I remember from long ago most compression schemes build
dictionaries as a way of achieving significant compression. If so,
since we zlib compress each entry in a pack individually, are there
many copies of very similar dictionaries in the pack?

Some compression schemes support being initialized with a fixed
dictionary and sharing it over all entries. A fixed dictionary could
be built by analysing a large pack file. Sharing a compression
dictionary would probably be a win for me since I have 1M+ entries in
a pack.

Poking around in the zlib it appears that zlib supports precomputed
dictionaries.
http://www.zlib.net/manual.html

  int deflateSetDictionary (z_streamp strm, const Bytef *dictionary,
uInt dictLength);

-- 
Jon Smirl
jonsmirl@gmail.com
