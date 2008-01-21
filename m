From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 15:14:16 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0801211509490.17095@ds9.cixit.se>
References: <478E1FED.5010801@web.de> <200801162251.54219.jnareb@gmail.com>
 <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org>
 <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org>
 <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
 <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org>
 <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org>
 <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
 <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org>
 <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com>
 <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org>
 <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
 <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
 <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
 <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
 <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Junker <mjscod@web.de>, Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 15:15:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGxQq-00044w-Hj
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 15:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbYAUOOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 09:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbYAUOOy
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 09:14:54 -0500
Received: from ds9.cixit.se ([193.15.169.228]:33193 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900AbYAUOOx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 09:14:53 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m0LEEK3X018248
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 21 Jan 2008 15:14:21 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m0LEEGfP018234;
	Mon, 21 Jan 2008 15:14:20 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 21 Jan 2008 15:14:21 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71283>

Linus Torvalds:

> Fuck me with a spoon.

I'd prefer not to.

> .. and this is relevant how? They are different strings. Not the same.

It is relevant because the Mac OS file system stores file names as a
sequence of Unicode code points, in a (apparently slightly modified)
normalized form, whereas Git prefers to see file systems that store
file names as a sequence of octets, which may, or may not, actually map
to something that the user would call characters.

I happen to prefer the text-as-string-of-characters (or code points,
since you use the other meaning of characters in your posts), since I
come from the text world, having worked a lot on Unicode text
processing.

You apparently prefer the text-as-sequence-of-octets, which I tend to
dislike because I would have thought computer engineers would have
evolved beyond this when we left the 1900s.

But the real issue is that Git cannot use it's filenames as string of
octets on Mac OS X, since the file system doesn't handle it. So Git
needs to do something sensible. That's part of porting. Preferrably
that would involve supporting real Unicode file names, which would also
work on Windows (through it's UTF-16 file APIs), and in part on other
systems (through conversion to the systems' locale encoding).

-- 
\\// Peter - http://www.softwolves.pp.se/
