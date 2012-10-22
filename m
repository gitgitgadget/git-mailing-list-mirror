From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] grep: remove tautological check
Date: Mon, 22 Oct 2012 14:20:50 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1210221416080.32103@ds9.cixit.se>
References: <1350753964-29346-1-git-send-email-dsp@php.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: David Soria Parra <dsp@php.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 15:21:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQHwj-0006PN-T5
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 15:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125Ab2JVNVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 09:21:07 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:54733 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753537Ab2JVNVE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 09:21:04 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id q9MDKpOb017271
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Oct 2012 15:20:51 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id q9MDKos5017267;
	Mon, 22 Oct 2012 15:20:50 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1350753964-29346-1-git-send-email-dsp@php.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Mon, 22 Oct 2012 15:20:51 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208182>

David Soria Parra:

> -		if (p->field < 0 || GREP_HEADER_FIELD_MAX <= p->field)
> +		if (GREP_HEADER_FIELD_MAX <= p->field)

A friend taught me this trick, which will check that it isn't negative 
for compilers that have the enumeration be signed (notably MSVC), 
while not complaining for compilers that have it unsigned (GCC, Clang):

   const unsigned int sign = 1u << (sizeof(p->field) * CHAR_BIT - 1);
   if (!(sign & (unsigned int) p->field) || GREP_HEADER_FIELD_MAX <= p->field)

-- 
\\// Peter - http://www.softwolves.pp.se/
