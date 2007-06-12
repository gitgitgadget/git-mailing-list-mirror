From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 12:03:10 -0700
Message-ID: <7vfy4xhu6p.fsf@assigned-by-dhcp.pobox.com>
References: <20070611225918.GD4323@planck.djpig.de>
	<11816319211097-git-send-email-hjemli@gmail.com>
	<20070612080402.GQ955MdfPADPa@greensroom.kotnet.org>
	<8c5c35580706120127p649227d8gc706cb8b364d02b9@mail.gmail.com>
	<466E7A17.CEB0F196@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>,
	skimo@liacs.nl
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 21:03:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyBe5-0003Pe-ML
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 21:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbXFLTDM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 15:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbXFLTDM
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 15:03:12 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60422 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbXFLTDL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 15:03:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070612190309.KGBC4247.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 Jun 2007 15:03:09 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Aj3A1X00C1kojtg0000000; Tue, 12 Jun 2007 15:03:10 -0400
In-Reply-To: <466E7A17.CEB0F196@eudaptics.com> (Johannes Sixt's message of
	"Tue, 12 Jun 2007 12:48:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49989>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> Lars Hjemli wrote:
>> Multiple checkout paths for a single submodule will bring havoc on
>> this plan, so I need to ask: what is the use-case for multiple
>> checkout paths?
>
> A use-case is the admin directory in the KDE repository. It has:
>
> KDE (superproject)
>  +- kdelibs (subproject)
>  |   +- admin (subproject)
>  |   +- subdir1
>  |   +- ...
>  +- kdebase (subproject)
>  |   +- admin (subproject)
>  |   +- subdir2
>  |   +- ...
>  +- kdenetwork (subproject)
>  |   +- admin (subproject)
>  |   +- subdir3
>  |   +- ...
>  ...

If these three instances of 'admin' are truly the same project
created in multiple places in the directory hierarchy, what is
the reason that it is not arranged like this instead?

    KDE
     +- admin
     +- kdelibs
     |   +- subdir1
     |   +- ...
     +- kdebase
     |   +- subdir2
     |   +- ...
     +- kdenetwork
     |   +- subdir3
     |   +- ...
     ...

When kdelibs/subdir1 needs to access stuff in admin, instead of
going to ../admin, it could very well go to ../../admin couldn't
it?

It makes me wonder if the KDE's layout you quoted is a good
practice we would want to recommend for other people to follow.
If not, I doubt it is a good idea to model our important concept
after that layout to begin with.
