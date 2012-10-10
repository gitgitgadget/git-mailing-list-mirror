From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Fwd: potential path traversal issue in v3 with wild repos
Date: Wed, 10 Oct 2012 06:41:41 +0530
Message-ID: <CAMK1S_hptJKtNJMKOr4ADgMqUoG1S9mQOTPrYV7egRhxW7ic6w@mail.gmail.com>
References: <CAMK1S_jotna+d_X2C-+es-M28i1aUBcsNeiXxwJ63EshQ8ht6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 03:11:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLkq1-000396-GA
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 03:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253Ab2JJBLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 21:11:44 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:59481 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757233Ab2JJBLm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 21:11:42 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so3509134lag.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 18:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=18RE3GQch5xjO4210L8AdyP030onIett3zkk+tesb4I=;
        b=vBUKnEEciYdcktD//glsPc0fxY4DaITbhKSwCfM3dRwase6AbZurZiEvgo4AO6UAQx
         cifek6CQ50ainVqYPNwL9NHoI2t3KE/gQ6yptNNkvMrcGQjMM/Kd3++W5j3GZwnd6bFx
         Owvx7CLdHQtB1CTkfqh6rAXcEiHnP21GkA5HhXNu/VljbCrGem9vRF96V75pzUQ7ymq4
         3v2HGQC5Czimv2up+rd3AzEPuyP2A+DWwQGcqt8W+M20/MY4KkVsPlQwkqrMQt21s1+q
         73l115GGlT7XUHdbRSQz0i4IXyyLx+nU8Fn9+biasEXLhjmyfIuPWpKSWvM69i/huOwC
         yxwg==
Received: by 10.152.48.102 with SMTP id k6mr18122716lan.12.1349831501098; Tue,
 09 Oct 2012 18:11:41 -0700 (PDT)
Received: by 10.112.84.97 with HTTP; Tue, 9 Oct 2012 18:11:41 -0700 (PDT)
In-Reply-To: <CAMK1S_jotna+d_X2C-+es-M28i1aUBcsNeiXxwJ63EshQ8ht6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207357>

oops; forgot to add the git list earlier.

---------- Forwarded message ----------
From: Sitaram Chamarty <sitaramc@gmail.com>
Date: Wed, Oct 10, 2012 at 5:15 AM
Subject: potential path traversal issue in v3 with wild repos
To: gitolite <gitolite@googlegroups.com>, gitolite-announce@googlegroups.com
Cc: Stephane Chazelas <stephane.chazelas@gmail.com>


Hello all,

I'm sorry to say there is a potential path traversal vulnerability in
v3.  Thanks to Stephane (copied) for finding it and alerting me.

Can it affect you?  This can only affect you if you are using wild
card repos, *and* at least one of your patterns allows the string
"../" to match multiple times.  (As far as I can tell, this does not
affect v2).

How badly can it affect you?  A malicious user who *also* has the
ability to create arbitrary files in, say, /tmp (e.g., he has his own
userid on the same box), can compromise the entire "git" user.
Otherwise the worst he can do is create arbitrary repos in /tmp.

What's the fix?  The fix has been pushed, and tagged v3.1.  This patch
[1] is also backportable to all v3.x tags, in case you are not ready
for an actual upgrade (it will have a slight conflict with v3.0 and
v3.01 but you should be able to resolve it easily enough; with the
others there is no conflict.)

My sincere apologies for the fsck-up :(

[1]: it's not the top-most commit; be careful if you want to 'git
cherry-pick' this to an older tree.

--
Sitaram


-- 
Sitaram
