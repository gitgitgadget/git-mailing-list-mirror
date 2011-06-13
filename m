From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] zlib: zlib can only process 4GB at a time
Date: Mon, 13 Jun 2011 06:52:22 -0500
Message-ID: <20110613115222.GA10501@elie>
References: <1307736948-16956-1-git-send-email-gitster@pobox.com>
 <1307736948-16956-7-git-send-email-gitster@pobox.com>
 <BANLkTikmLDZj2qdkmF-kBUkB33o9EjtBpg@mail.gmail.com>
 <7v4o3uspiy.fsf@alter.siamese.dyndns.org>
 <BANLkTi=sT_LxRaJSM3Cj-QkSwqGan29K7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 13:52:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW5h5-0008G8-Od
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 13:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab1FMLwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 07:52:31 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54071 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851Ab1FMLwa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 07:52:30 -0400
Received: by iyb14 with SMTP id 14so3732998iyb.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 04:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4U94b7r++vzHfYACJ1EGDupsY6BcSn2PT5YZNROXsps=;
        b=cLe1szoxgnrIC8gMsL8eDcNTLynpyrQeZrUtABYb9KF8njg6lHgVuejrBqzqSMnRwj
         ZqipQ2r4/0QTREBWjS2Elk0GNsVoSoD4+oWdxRB73BBFhRR3HweasgQ5LlL+0DEpRJmO
         0UF7mkXeXNhtTKoDt5JpgSDeW6zW6rfun0Ds0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ij+1ZejBmPgV+qzSmUL/lypbSvkhXgX5zSVbC6IhLHeTW+1/+DEDhytE4jXY2zlnGI
         D+VRCPKedS7esiquLAiTaw1K6Q5it4THSh2sWlXQ4KoJ7oct2zJ+p4OQGEZlCo2m41Fm
         PY4yTgrKM5y4bTBjdfKKQFw1d6NIdOVa+Tc3Q=
Received: by 10.42.142.130 with SMTP id s2mr2691133icu.334.1307965950005;
        Mon, 13 Jun 2011 04:52:30 -0700 (PDT)
Received: from elie (adsl-68-255-110-0.dsl.chcgil.ameritech.net [68.255.110.0])
        by mx.google.com with ESMTPS id s2sm4704884icw.5.2011.06.13.04.52.28
        (version=SSLv3 cipher=OTHER);
        Mon, 13 Jun 2011 04:52:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=sT_LxRaJSM3Cj-QkSwqGan29K7A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175698>

Erik Faye-Lund wrote:

> Looking a bit more at the code, it seems that we currently use
> "unsigned long" a lot of places where "size_t" should have been used.

As Junio's comment about 32-bit platforms hints, when it comes to be
the time to change all those places, wouldn't off_t be a better
choice?

Thanks --- it is exciting to watch this topic move forward, inch by
inch.  And thanks for the hint about invalid word size == sizeof(long)
assumptions on Windows.
