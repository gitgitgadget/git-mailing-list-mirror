From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] Git.pm: teach "ident" to query explicitness
Date: Wed, 14 Nov 2012 09:12:13 -0800
Message-ID: <20121114171213.GD6858@elie.Belkin>
References: <20121113164845.GD20361@sigill.intra.peff.net>
 <20121113165320.GE12626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 14 18:12:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYgVu-0000jC-5n
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 18:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291Ab2KNRMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 12:12:18 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:48883 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188Ab2KNRMR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 12:12:17 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so266174dak.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 09:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TV/ZNOzmG3gqZVuHzTmAygEoBNk46IqIRCOhMR24OCU=;
        b=HmzxOcXo8alJFoua1FD66l1JDM6y1SXYNxTUwHmotFSpD6qcP06XeyD4eriYhNmSJh
         NExYk2PXadWp2kufmZnh5skQOfpzDLllxvn992HWVahpjCE70elDgKB3Sawi4eyqu748
         ixN7SwC7K+kFPcZM/NxXrgo9zA9leiSzVmGLaLvgQnFBkxhL9MmQmTKK3SZXKF8+57XF
         x3Pf06xjddQYdp0ormoLARb0ON8R1wgrrYmk7MFVke0F2/Yoj+WlsAPMsD2LxIBLTN8A
         Ge0Mi/n18IK2oIwJz9MKFg0IMT8taVkDuYqCoxgeG8uZGk+gHpf/1E8SWnAITN6vY2d8
         0hpg==
Received: by 10.66.84.163 with SMTP id a3mr8457561paz.2.1352913136796;
        Wed, 14 Nov 2012 09:12:16 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id gu5sm8012301pbc.10.2012.11.14.09.12.15
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 09:12:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121113165320.GE12626@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209728>

Jeff King wrote:

> "git var" recently learned to report on whether an ident we
> fetch from it was configured explicitly or implicitly. Let's
> make that information available to callers of the ident
> function.

Sounds sensible.  Quick nits:

[...]
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -737,7 +737,7 @@ sub remote_refs {
>  }
>  
>  
> -=item ident ( TYPE | IDENTSTR )
> +=item ident ( TYPE | IDENTSTR [, options] )
>  
>  =item ident_person ( TYPE | IDENTSTR | IDENTARRAY )
>  
> @@ -750,6 +750,10 @@ and either returns it as a scalar string or as an array with the fields parsed.
>  Alternatively, it can take a prepared ident string (e.g. from the commit
>  object) and just parse it.
>  
> +If the C<explicit> option is set to 1, the returned array will contain an
> +additional boolean specifying whether the ident was configure explicitly by the
> +user.

s/configure/configured/

I'd suggest adding "See GIT_COMMITTER_EXPLICIT in git-var(1) for
details" to make the semantics crystal clear.  What do you think?

Thanks,
Jonathan
