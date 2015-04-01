From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Clone from shallow bundle bug
Date: Wed, 1 Apr 2015 16:55:57 +0700
Message-ID: <CACsJy8C0wMFiPw1thSWN-dPVW+9N=JXDsy_HFCj=Oyu2rf40eg@mail.gmail.com>
References: <551B0D37.5070407@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 11:56:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdFNx-0001TC-45
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 11:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbbDAJ43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 05:56:29 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37467 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbbDAJ42 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 05:56:28 -0400
Received: by igcxg11 with SMTP id xg11so41363405igc.0
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 02:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BYlLdgoX32CVIMCsWo895cgEIjmK86osiJCSziXLXGI=;
        b=AnGar6u2ZaqgWVUFZwXz/D2Sq4oR26l0s12yVWFP4DjEg/NiLGssOhhQE6oPo3fu21
         Te1J/PlFBnqMIfy1Erm/fCKaS60JSsGMfGtu8mt3tCkR49bpE95avPoO8XOJdchuR5Dz
         8xvfVyFvBtUoezVGAHuZk7W2R6M88VyylLQvYkpdrKtFYDvOxx6CGZYeEvlB6DfJemcr
         cih/U9LfUb1qwh9sTxJPIlGq7NFGkA6XGAP6ysVbAvTV7bgV4eLkPDPU4oVQYCgXnBFV
         DicgWuS+gxaYj73ATRXpWyljivPdL9DXnw+cJkCQIqMnVrUl1g3LlxoDTzOEn6vZ2D05
         vEwA==
X-Received: by 10.50.147.99 with SMTP id tj3mr10678486igb.41.1427882187377;
 Wed, 01 Apr 2015 02:56:27 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Wed, 1 Apr 2015 02:55:57 -0700 (PDT)
In-Reply-To: <551B0D37.5070407@ubuntu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266598>

On Wed, Apr 1, 2015 at 4:10 AM, Phillip Susi <psusi@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> I made a shallow clone of my repo, then used git bundle create to pack
> it all into a bundle file, then cloned from that bundle.  The initial
> shallow clone has a .git/shallow file that identifies it as a shallow
> clone ( and I guess keeps things from complaining about the missing
> history ), but the the repo cloned from the bundle does not,

You made me worry a bit. We have checks in clone and fetch to make
sure the result is "good" (i.e. gitk should not complain, clone/fetch
should report it instead). Unfortunately I tested and it seemed to
work as expected (i.e. clone fails)

$ LANG=C ./git clone ./shallow.bundle  shallow2
Cloning into 'shallow2'...
Receiving objects: 100% (2813/2813), 5.33 MiB | 0 bytes/s, done.
Resolving deltas: 100% (250/250), done.
Checking connectivity... error: Could not read
50a3ba22454e2989424d5de489de9c0f68fed5ec
fatal: Failed to traverse parents of commit
c73a8a63134734ddf7077d09355a10a0077ed2ca
fatal: remote did not send all necessary objects

> so gitk
> run in that clone complains about not being able to find the objects
> referenced by the oldest commit in the repo.
-- 
Duy
