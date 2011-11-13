From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git behaviour question regarding SHA-1 and commits
Date: Sun, 13 Nov 2011 12:27:57 -0600
Message-ID: <20111113182757.GA15194@elie.hsd1.il.comcast.net>
References: <CAJuRt+r9BjYcead6hgzdUT0Bisz1D48cegqkoJ0S537VMYBy_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: vinassa vinassa <vinassa.vinassa@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 19:29:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPeoP-0000qq-W4
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 19:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234Ab1KMS2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 13:28:08 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51794 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab1KMS2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 13:28:06 -0500
Received: by iage36 with SMTP id e36so6338990iag.19
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 10:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ly4usqMGubxKVJvLodp1CdtizwfbRKvx7fdV8w2X8L8=;
        b=oMDiJYNLt+dVcaPFEnEVDxUcbm8NyYLGHvbAHjyNT7Z/DNeB2DnI7vHx6nYIx9EFcI
         LFU+5ZU1p7azUWcIJaJ2MUMUutrh+hhAOIQkuMQFATzhZN2UgptOv0OEfv+FpK5clS58
         dGKxElpQfUlJ0kHpAjvQnuCpnoHm49G3KqLkU=
Received: by 10.50.41.196 with SMTP id h4mr20841246igl.42.1321208885527;
        Sun, 13 Nov 2011 10:28:05 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id wo4sm4575421igc.5.2011.11.13.10.28.04
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Nov 2011 10:28:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJuRt+r9BjYcead6hgzdUT0Bisz1D48cegqkoJ0S537VMYBy_g@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185345>

Hi Vinassa,

vinassa vinassa wrote:

> I am wondering about how git behaves currently, if I kinda win the
> lottery of the universe, and happen to create a commit with a SHA-1
> that is already the SHA-1 of another commit in the previous history.
> However improbable.

That would be great!  You could definitely get an academic paper out
of it.

> Would that be detected, so that I could just add a newline, and then
> commit with a different resulting SHA-1,
> would I just lose one of those commits (hopefully the new one), would
> I end up with a corrupted repository?

I suspect that one of the two commits would "win" the right to be
shown by commands like "git log".  A commit made after one of the
commits participating in the hash collision might be stored as a delta
against the wrong one in the pack, producing errors when you try to
access it (which is good, since it helps you find the hash collision
and you can get a paper and prizes).

Though I haven't tested.  It would be nice to have an md5git (or even
truncated-sha1-git) program to test this kind of thing with.

Thanks and hope that helps,
Jonathan
