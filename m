From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] send-email: do not prompt for explicit repo ident
Date: Wed, 14 Nov 2012 09:18:27 -0800
Message-ID: <20121114171827.GE6858@elie.Belkin>
References: <20121113164845.GD20361@sigill.intra.peff.net>
 <20121113165327.GF12626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 14 18:18:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYgbt-0005SH-1O
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 18:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423080Ab2KNRSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 12:18:31 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47378 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422781Ab2KNRSb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 12:18:31 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so506791pbc.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 09:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=r0Id4pBGFjuAal7MEMOpJz+b07eWtJyN65SY7H+/75Y=;
        b=e6mz/2tvGSWtAY/pmZ7dNnYEcFTbjIjqcd7+OU0ThUFXiE+1BPjD7t43MpT/vv5YNm
         ixCt7F6aAblZS1/SIxgicyeiunFyzh5hDXxMOJ/grFoKuU35xtf7zWpL3TYkvqP/gELn
         e7LOViQqj3JaWZxlsDLAKOLO/VWkDR4K0FM3wh307kZZoHn5b3TlRz6KYN5pd0TRyBFg
         YenwbogHhmXE6DKWENlFWm2DTVxf+gy8xzZUb2nlNMRgDeLzXDt3cZ/FSgYefbXsEmBV
         i90pw1n7xld64ui3i5uC0FahmaqBRki65AdmffXyH/xRERpDTlnlzm3MhMOTFtFsWLPC
         Tevw==
Received: by 10.68.224.8 with SMTP id qy8mr72486316pbc.88.1352913510650;
        Wed, 14 Nov 2012 09:18:30 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id is6sm8009682pbc.55.2012.11.14.09.18.29
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 09:18:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121113165327.GF12626@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209730>

Jeff King wrote:

> If git-send-email is configured with sendemail.from, we will
> not prompt the user for the "From" address of the emails.
> If it is not configured, we prompt the user, but provide the
> repo author or committer as a default.  Even though we
> probably have a sensible value for the default, the prompt
> is a safety check in case git generated an incorrect
> implicit ident string.

I haven't read the code carefully, but this behavior sounds sensible,
so for what it's worth,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> The test scripts need to be adjusted to not expect a prompt
> for the sender, since they always have the author explicitly
> defined in the environment. Unfortunately, we cannot
> reliably test that prompting still happens in the implicit
> case, as send-email will produce inconsistent results
> depending on the machine config (if we cannot find a FQDN,
> "git var" will barf, causing us to exit early;

At first this sounded like a bug to me --- how could the user keep
working without the sysadmin intervening?

But then I remembered that the user can set her name and email in
.gitconfig and probably would want to in such a setup anyway.

When someone writes such a test, I think it could check that git
either prompts or writes a message advising to configure the user
email, no?  Waiting until later for that seems fine to me, though.

Thanks,
Jonathan
