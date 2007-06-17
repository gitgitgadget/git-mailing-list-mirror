From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 1/2] git-submodule: move cloning into a separate function
Date: Sun, 17 Jun 2007 17:56:15 +0200
Message-ID: <8c5c35580706170856n64747190xeaf88fc2deafd273@mail.gmail.com>
References: <11810357523435-git-send-email-hjemli@gmail.com>
	 <11810357522478-git-send-email-hjemli@gmail.com>
	 <46653DB2.997A3ABD@eudaptics.com> <op.ttf34qd99pspc6@localhost>
	 <20070617143802.GV955MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <J.Sixt@eudaptics.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jun 17 17:56:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzx6y-0003xd-Px
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 17:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbXFQP4Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 11:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520AbXFQP4Q
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 11:56:16 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:49639 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbXFQP4P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 11:56:15 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1851166wah
        for <git@vger.kernel.org>; Sun, 17 Jun 2007 08:56:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bFoFUac4W9XH77LP/1CCc861WGhL1DJHL4BhLhLGNNN/EbmzAIiJvPmKJr47m689o6q5vpRqoS6Bfejjxe7USh9T2s058RV00dyr+LwhrdtmLAHq68ECiLAjZMyS1O4ZaoB0IOLZvcN/vrNtZyvys5ZpEFBTTMzYUELcWSXovCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KgRVxU+eXfysdWDybLNUxA5bzOY2fJ0AvShwRWS6Nd+kPgM51FD0EU2EiJbxsB7+9gQPYn9sAafWMHHveOMPdJvEgkV6CvuMoc8i9cdLiJfStDc7zzOrRLIXD2MMplbuPiWvm2iE7lRG2R13YANSchYX4iIf9Zjq7zfLSA0G7SA=
Received: by 10.114.160.1 with SMTP id i1mr5275654wae.1182095775472;
        Sun, 17 Jun 2007 08:56:15 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Sun, 17 Jun 2007 08:56:15 -0700 (PDT)
In-Reply-To: <20070617143802.GV955MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50355>

On 6/17/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Tue, Jun 05, 2007 at 01:13:28PM +0200, Lars Hjemli wrote:
> > +module_clone()
> > +{
> > +     path=$1
> > +     url=$2
> > +
> > +     # If there already is a directory at the submodule path,
> > +     # expect it to be empty (since that is the default checkout
> > +     # action) and try to remove it.
> > +     # Note: if $path is a symlink to a directory the test will
> > +     # succeed but the rmdir will fail. We might want to fix this.
> > +     if test -d "$path"
> > +     then
> > +             rmdir "$path" 2>/dev/null ||
> > +             die "Directory '$path' exist, but is neither empty nor a git repository"
>
> What makes you say that '$path' is not a git repository?
>

The function assumes it's only invoked when no repo is present in $path/.git.

-- 
larsh
