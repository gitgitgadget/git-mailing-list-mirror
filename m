From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/7] Extract, test and enhance the logic to collapse
 ../foo paths.
Date: Wed, 26 Sep 2012 14:38:32 -0700
Message-ID: <20120926213831.GB30131@elie.Belkin>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-4-git-send-email-schwern@pobox.com>
 <20120730195108.GA20137@dcvr.yhbt.net>
 <5016F2A5.1090102@pobox.com>
 <20120926194504.GA5013@elie.Belkin>
 <20120926205851.GA2166@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Sep 26 23:38:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGzJf-0007zp-5u
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 23:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338Ab2IZVih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 17:38:37 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40778 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab2IZVig (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 17:38:36 -0400
Received: by pbbrr4 with SMTP id rr4so2522380pbb.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 14:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=h4szj6Q2GCMNTlwoPI8+CvPD3WNCx1PvZhdJH8P+Q7k=;
        b=ZBRHbxVDWAPwuv6FRWAi5IvwAMJbfAnI9Sgbm1mWABEjwOTMvIeGsN5u6lEbYn/bzX
         jS4nU2sKISveAFNB4cu8zRqbOmYFxl+XPSgMGWNNpyUZw/cpBTTu6noguVbIRYa8Z4fv
         zFAvGaS92vqDiQRUp57tA6hF1+QDINsHaEgZS76Rkw4gp7BlmTVR5QL2TbDlwbCM87lI
         puePRvL5sWK641GSj0d8Gdy8w4bcEwvsuqQ37LsoziDP9AVBVbHiYc2NJ2uI/T8UdIzE
         s9+TdnyN8Rw7o3RbC/dTd/EqoNMRh8Csbtq8Sb/OWVazGPa6Q8FbozOpDu8SfvAeGZlT
         3Cew==
Received: by 10.68.189.164 with SMTP id gj4mr5998872pbc.48.1348695515979;
        Wed, 26 Sep 2012 14:38:35 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id h10sm2500547pav.28.2012.09.26.14.38.33
        (version=SSLv3 cipher=OTHER);
        Wed, 26 Sep 2012 14:38:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120926205851.GA2166@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206447>

Eric Wong wrote:

> That said, I'd favor an implementation that split on m{/+} and
> collapsed as Michael mentioned.

Sounds sensible.  Is canonicalize_path responsible for collapsing
runs of slashes?  What should _collapse_dotdot do to
"c:/.." or "http://www.example.com/.."?
