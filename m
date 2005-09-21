From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: StGIT cannot import properly from stdin
Date: Wed, 21 Sep 2005 09:03:34 +0100
Message-ID: <b0943d9e05092101033dd5d366@mail.gmail.com>
References: <433107C7.60901@drzeus.cx>
Reply-To: catalin.marinas@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 10:05:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHzZq-0007Gv-Mz
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 10:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVIUIDf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 04:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVIUIDf
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 04:03:35 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:63911 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750749AbVIUIDe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 04:03:34 -0400
Received: by xproxy.gmail.com with SMTP id t15so88836wxc
        for <git@vger.kernel.org>; Wed, 21 Sep 2005 01:03:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l/63czD2xvblL6FvOWM45I71xKo05RIJLk3Xc/mACyjspPYeRycAR++vIp4EK/v2fg+p+pHjsScT1+uGev20mkXcQyvrbm/85ArOwmLjwXjGeRYfH0YNvVmtszoJmqlqUfiDAW1N66MpFTmhq2KUjXIAesmCZKveg0gY6aSPIzo=
Received: by 10.70.31.17 with SMTP id e17mr2385590wxe;
        Wed, 21 Sep 2005 01:03:34 -0700 (PDT)
Received: by 10.70.27.20 with HTTP; Wed, 21 Sep 2005 01:03:34 -0700 (PDT)
To: Pierre Ossman <drzeus-list@drzeus.cx>
In-Reply-To: <433107C7.60901@drzeus.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9029>

On 21/09/05, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> The import command of stgit does not handle stdin in a very sane way.
> The logic expects to be able to read the patch several times which isn't
> possible with stdin. So for it to work you have to give it the patch twice.

It works for me with the latest snapshot. What might happen in your
case is a missing "---" line after the patch description. The import
command reads the sys.stdin file descriptor until the first "---"
line. After that, the git.apply() function will read the rest of the
lines and pass them to git-apply. You can put some prints in the
git.apply() function to check where it starts reading from.

Patches without description cannot be read from stdin at the moment.
Maybe I could add another option to prevent it from reading the
description.

-- 
Catalin
