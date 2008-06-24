From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] pre-commit hook should ignore carriage returns at EOL
Date: Tue, 24 Jun 2008 22:09:06 +0200
Message-ID: <200806242209.07135.jnareb@gmail.com>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com> <m363rylknc.fsf@localhost.localdomain> <alpine.LFD.1.10.0806241548140.32759@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Christian Holtje <docwhat@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Ian Hilt <Ian.Hilt@gmx.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 22:10:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEqA-000882-7j
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 22:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbYFXUJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 16:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753294AbYFXUJN
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 16:09:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:36067 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbYFXUJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 16:09:13 -0400
Received: by ug-out-1314.google.com with SMTP id h2so15940ugf.16
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 13:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Us6k732tNwTGtskiFK1+1FlK8vEZi49LVPC2hkewEhI=;
        b=cJlt2Acx7Unt8D2JUFtvZ3iRaQ4Wg/Ub5M9YKyDyHt73sCsGioZZU0Cu0wXPDlkzuD
         pBynh2AIqNq1WmvQHQtth0W+7ievtdTOdWnJc3Id6x1BBPfNcuc5Xkiko1glxtlKJeIx
         oSq6JF/apQcJh6CFjCaR8MTp4Vn2CnTxhijRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZxCM0WZ4BtLLAIL+KdLJbr2maygA5lN4upnRDBBMdJlvLqX7hn6Fq3pe2aaVnuPXOE
         wmJkGPt+9UVTcp5odhntnprkeaD6nhzcjkFyE3/uTYrX8W56SIep8FXRugOa99mn0jfp
         7GYtUsAlRzqRZAyeNcCOfYm7uzRsjpsIvJ0FQ=
Received: by 10.210.91.7 with SMTP id o7mr691408ebb.197.1214338151452;
        Tue, 24 Jun 2008 13:09:11 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.223.44])
        by mx.google.com with ESMTPS id z40sm10888382ikz.7.2008.06.24.13.09.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 13:09:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.10.0806241548140.32759@sys-0.hiltweb.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86134>

On Tue, 24 Jun 2008, Ian Hilt wrote:
> On Tue, 24 Jun 2008 at 12:05pm -0700, Jakub Narebski wrote:
> 
> > I don't think so, because you want next to test for whitespace
> > where it _doesn't_ end in \r, i.e. this condition is here
> > because of the 'else' clause.  IIRC.
> 
> What I'm suggesting is this,
> 
> 	if (/\s\r$/) {
> 		bad_line("trailing whitespace", $_);
> 	} else {
> 		if (/\s$/) {
> 			bad_line("trailing whitespace", $_);
> 		}
> 	}
> 
> Why only test for \r when all you want to know is whether there is
> whitespace before \r ?  If there isn't whitespace and \r at the end
> of a line, then only test for whitespace at the end of a line.

Unfortunately \r matches \s (is whitespace), so if line ends with CR LF
("\r\n") it wouldn't match first regexp, so it would go to 'else' 
clause, where it would match /\s$/ and it shouldn't.

-- 
Jakub Narebski
Poland
