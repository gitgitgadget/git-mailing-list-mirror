From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with non-ascii characters
Date: Wed, 26 Mar 2008 07:59:48 +0200
Message-ID: <200803260759.48922.tlikonen@iki.fi>
References: <7caf19ae394accab538d2f94953bb62b55a2c79f.1206486012.git.peff@peff.net> <20080325230321.GB17744@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 07:01:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeOh9-0004j0-2s
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 07:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbYCZGAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 02:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbYCZGAK
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 02:00:10 -0400
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:61934 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750887AbYCZGAK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2008 02:00:10 -0400
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout4-sn1.fre.skanova.net (7.3.129)
        id 47A7970A002B304C; Wed, 26 Mar 2008 06:59:51 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <20080325230321.GB17744@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78259>

Jeff King kirjoitti:

> We always use 'utf-8' as the encoding, since we currently
> have no way of getting the information from the user.
>
> This also refactors the quoting of recipient names, since
> both processes can share the rfc2047 quoting code.

These patches seem to work except that the quoting of Subject field 
works only if user types a non-Ascii text to the "What subject should 
the initial email start with?" prompt. If she changes the subject in 
editor it won't be rfc2047-quoted.

Thank you anyway, I think we're going to right direction. I think 'git 
send-mail --compose' is nice way to produce introductory message to 
patch series. If --compose doesn't support MIME encoding reasonable 
way, user may have to write and send intro message with real MUA and 
find out the Message-Id for correct In-Reply-To field for the actual 
patch series.

E-mail agents KMail and Mutt have setting for preferred encodings for 
outgoing mail. It's a list of encodings, 
like "us-ascii,iso-8859-1,utf-8". The first one that fits (including 
From, To, Cc, Subject, the body, ...?) is used, so there is some kind 
of detection of content after the message has been composed.

If portable content encoding detection is difficult or considered 
unnecessary, then I think a documented configurable option is fine 
(UTF-8 by default).
