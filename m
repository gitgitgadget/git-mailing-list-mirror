From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 2/2] commit: reject overlong UTF-8 sequences
Date: Mon, 1 Jul 2013 08:14:02 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1307010812470.21709@ds9.cixit.se>
References: <20130629174140.GC226907@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, gitster@pobox.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Jul 01 09:14:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtYJn-0004aV-7R
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 09:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab3GAHO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 03:14:27 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:51195 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752420Ab3GAHO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 03:14:26 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r617E2ns022641
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 1 Jul 2013 09:14:02 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id r617E2JU022638;
	Mon, 1 Jul 2013 09:14:02 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20130629174140.GC226907@vauxhall.crustytoothpaste.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Mon, 01 Jul 2013 09:14:02 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229295>

brian m. carlson:

> 	int offset = 0;
> +	static const unsigned int max_codepoint[] = {
> +		0x7f, 0x7ff, 0xffff, 0x1fffff
> +	};

Since Unicode is not defined beyond U+10FFFF, you can easily make the 
last range end at U+10FFF. Doing that, ...

> 		if (codepoint > 0x10ffff)
> 			return bad_offset;

... you can also drop this test, as it will have been tested by the 
max test already.

-- 
\\// Peter - http://www.softwolves.pp.se/
