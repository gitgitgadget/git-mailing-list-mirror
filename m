From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: RFC: reverse history tree, for faster & background clones
Date: Fri, 12 Jun 2015 13:33:35 +0200
Message-ID: <1434108815.5381.3.camel@kaarsemaker.net>
References: <mlefli$h6v$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andres G. Aragoneses" <knocte@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 13:33:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3NDU-0004fh-HI
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 13:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbbFLLdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 07:33:40 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33344 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbbFLLdj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 07:33:39 -0400
Received: by wiwd19 with SMTP id d19so15819673wiw.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 04:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=udGA6iniPRPAEXS/Zyc1k/+yKrEh84QkqyOw6ohMT0M=;
        b=Kn1tjYESwdAuAolmr0C4VyUBVf3pd+dBgYyXBmp1CvYmG8szza/lZ64CwV0Eywv9Bh
         hiiFwlYkENA9Byd7ZfT7FgsutJASYCxdo4htR+uo9nOP9o9JB7QBXHV9uauPWaKv8uXh
         EHG+bCO65r74mA5DsdmH9Pg72VO021V3A15h1N6WBcWJLz7Xl7sENxQx/lxjhqScIZQb
         McwUmgievHjKqKbIiKch4iaZW2GAWt+fTSe+Tzbj6cuDIZTcaoJv3mzSVvgYUqWF7FmX
         fr1oE17ufR++uuA0VphcYxQ9nVTa1aTrFKNsnCz6p10XQpv6tdO7xcByXogMQHNLukpQ
         M64Q==
X-Gm-Message-State: ALoCoQnlZ/rtFtcI0M2jWY9RxPWsHXwzrzBV53Cry5FutLI0hHpmnTYqTnYV3j1tatkG/y6vDYCG
X-Received: by 10.180.104.197 with SMTP id gg5mr6070964wib.27.1434108818561;
        Fri, 12 Jun 2015 04:33:38 -0700 (PDT)
Received: from seahawk.local (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id be3sm2309325wib.21.2015.06.12.04.33.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jun 2015 04:33:37 -0700 (PDT)
In-Reply-To: <mlefli$h6v$1@ger.gmane.org>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271481>

On vr, 2015-06-12 at 13:26 +0200, Andres G. Aragoneses wrote:

> AFAIU git stores the contents of a repo as a sequence of patches in the 
> .git metadata folder. 

It does not, it stores full snapshots of files.

[I've cut the example, as it's not how git works]

> 1. `git clone --depth 1` would be way faster, and without the need of 
> on-demand compressing of packfiles in the server side, correct me if I'm 
> wrong?

You're wrong due to the misunderstanding of how git works :)

> 2. `git clone` would be able to allow a "fast operation, complete in the 
> background" mode that would allow you to download the first snapshot of 
> the repo very quickly, so that the user would be able to start working 
> on his working directory very quickly, while a "background job" keeps 
> retreiving the history data in the background.

This could actually be a good thing, and can be emulated now with git
clone --depth=1 and subsequent fetches in the background to deepen the
history. I can see some value in clone doing this by itself, first doing
a depth=1 fetch, then launching itself into the background, giving you a
worktree to play with earlier.

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
