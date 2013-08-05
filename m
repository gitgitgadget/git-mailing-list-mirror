From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] commit: reject non-characters
Date: Mon, 5 Aug 2013 13:48:28 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1308051346530.3657@ds9.cixit.se>
References: <cover.1372957719.git.sandals@crustytoothpaste.net> <20130704171943.GA267700@vauxhall.crustytoothpaste.net> <alpine.DEB.2.00.1307051345260.11814@ds9.cixit.se> <7vfvvozvx4.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1307091213090.2313@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 14:50:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6KDQ-0005hI-65
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 14:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab3HEMso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 08:48:44 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:48501 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752205Ab3HEMsn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 08:48:43 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r75CmUAN008815
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 5 Aug 2013 14:48:30 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id r75CmSrG008811;
	Mon, 5 Aug 2013 14:48:29 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.DEB.2.00.1307091213090.2313@ds9.cixit.se>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Mon, 05 Aug 2013 14:48:30 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231649>

Peter Krefting:

> -		/* U+FFFE and U+FFFF are guaranteed non-characters. */
> -		if ((codepoint & 0x1ffffe) == 0xfffe)
> +		/* U+xxFFFE and U+xxFFFF are guaranteed non-characters. */
> +		if ((codepoint & 0xffffe) == 0xfffe)
> +			return bad_offset;

Drats, there is an F too many in the bitmask, it should be:

  +		if ((codepoint & 0xfffe) == 0xfffe)

-- 
\\// Peter - http://www.softwolves.pp.se/
