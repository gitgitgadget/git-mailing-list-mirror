From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: "git fsck" hanging (v1.7.3.2)
Date: Sun, 24 Oct 2010 12:06:40 -0500
Message-ID: <20101024170640.GA7238@burratino>
References: <AANLkTinFRnK=NnnUPX1VUE1aY_MHCR=OZ99RuQ1G3nSG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Leo Razoumov <slonik.az@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 24 19:10:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA45r-0001sR-7w
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 19:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824Ab0JXRKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 13:10:37 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43087 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203Ab0JXRKe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 13:10:34 -0400
Received: by yxn35 with SMTP id 35so1616601yxn.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RYaxgICR0IPC+EpypO3ygR4Guq2T8CCzhfd6CuCgWmU=;
        b=q8+1Tf6GfR9TLB+gsuNF3I2OZ9aWx6tUg6I8f4ZDCFlyIDl5RmoXblt3ximhKmQQGA
         5JVxPEg8xYP+wWzAEJe3evZggvFrQ2K3jCfXdLwqb+PL2rKqIg0ceat2MtEsTWxIHLtv
         Wy+RB6l5nPns+qQUl5MJw9QT8a9sHgFBNZdDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mY4ldC2w3PWYrY/Sd5zcb7E1rDDs9K2BkHl8s1QkrPcwrYgB33jObFcQ7XON2XFkS5
         /+WYDwJlYp42BvVW7Bluz3vGmVgdYpGLTRUIHSdckK1vb3X5zlUQuqMGyGJVJn5/34hN
         vcs4Z3/5wVck5ch0KMtZwRgoOUYie4SC1jR50=
Received: by 10.150.226.5 with SMTP id y5mr813362ybg.68.1287940234051;
        Sun, 24 Oct 2010 10:10:34 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 28sm7192484anv.26.2010.10.24.10.10.32
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 10:10:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinFRnK=NnnUPX1VUE1aY_MHCR=OZ99RuQ1G3nSG@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159886>

Hi Leo,

Leo Razoumov wrote:

> And then it sits there spinning CPU (99%) and nothing happening for
> over a minute or so and then it proceeds to conclusion. The whole
> thing takes about 2 minutes
> 
> ~/git-1.7.3.2> time git fsck
> git fsck  98.27s user 2.78s system 98% cpu 1:42.48 total
> 
> I previously compiled git-1.6.5.8 in exactly the same way on the same
> system and had no problems of any kind.
> "git fsck" was completing in seconds even for large repos.

You are right --- there was a significant change in fsck 1.6.6:

Notes on behaviour change [1]
-------------------------

 * In this release, "git fsck" defaults to "git fsck --full" and
   checks packfiles, and because of this it will take much longer to
   complete than before.  If you prefer a quicker check only on loose
   objects (the old default), you can say "git fsck --no-full".  This
   has been supported by 1.5.4 and newer versions of git, so it is
   safe to write it in your script even if you use slightly older git
   on some of your machines.

Hope that helps.

[1] Documentation/RelNotes/1.6.6.txt
