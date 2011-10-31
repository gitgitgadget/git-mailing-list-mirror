From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: New Feature wanted: Is it possible to let git clone continue
 last break point?
Date: Mon, 31 Oct 2011 04:07:18 -0500
Message-ID: <20111031090717.GA24978@elie.hsd1.il.comcast.net>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com>
 <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mail List <git@vger.kernel.org>,
	Tomas Carnecky <tom@dbservice.com>, Jeff King <peff@peff.net>
To: netroby <hufeng1987@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 10:07:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKnq9-0002bm-IL
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 10:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266Ab1JaJH3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Oct 2011 05:07:29 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39785 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119Ab1JaJH2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2011 05:07:28 -0400
Received: by iaby12 with SMTP id y12so6971536iab.19
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 02:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+/irhY84I7bwp+E1Oak5K5a8VyRsmUYpmmUjGkULZsA=;
        b=blNwOqGspDj9WInSmfIc0spiae2edQDyAtLOsn2ZPp6vm5czVCPdKQARPi/RgWBZaY
         1WwYmOxuqSHAMZxCGpgTYulAL1UrzqX8Ts0h5r2i6cAHq64Z7XMnuO8ggXMrd4rMpwHU
         YBHIpVIgYQoe4/a9td9+5gZoNPASp4SmV/B0g=
Received: by 10.231.42.74 with SMTP id r10mr4964841ibe.72.1320052047669;
        Mon, 31 Oct 2011 02:07:27 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id g16sm25612491ibs.8.2011.10.31.02.07.25
        (version=SSLv3 cipher=OTHER);
        Mon, 31 Oct 2011 02:07:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184497>

Hi,

netroby wrote:

> Is it possible to let git clone continue last break point.
> when we git clone very large project from the web,=C2=A0 we may face =
some
> interupt, then we must clone it from zero .

You might find [1] useful as a stopgap (thanks, Tomas!).

Something like Jeff's "priming the well with a server-specified
bundle" proposal[2] might be a good way to make the same trick
transparent to clients in the future.

Even with that, later fetches, which grab a pack generated on the fly
to only contain the objects not already fetched, are generally not
resumable.  Overcoming that would presumably require larger protocol
changes, and I don't know of anyone working on it.  (My workaround
when in a setup where this mattered was to use the old-fashioned
"dumb" http protocol.  It worked fine.)

Hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/181380
[2] http://thread.gmane.org/gmane.comp.version-control.git/164569/focus=
=3D164701
    http://thread.gmane.org/gmane.comp.version-control.git/168906/focus=
=3D168912
