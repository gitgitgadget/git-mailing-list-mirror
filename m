From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH/PATCH] prefix_path(): disallow absolute paths
Date: Mon, 28 Jan 2008 18:45:48 -0800
Message-ID: <7v7ihts61v.fsf@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>
	<alpine.LSU.1.00.0801272043040.23907@racer.site>
	<7v3asiyk2i.fsf@gitster.siamese.dyndns.org>
	<20080128003404.GA18276@lintop>
	<7vodb6wtix.fsf@gitster.siamese.dyndns.org>
	<479D805E.3000209@viscovery.net>
	<7vprvmuykw.fsf@gitster.siamese.dyndns.org>
	<479D9ADE.6010003@viscovery.net>
	<alpine.LSU.1.00.0801281210440.23907@racer.site>
	<7vwspts9vj.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801290234590.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 29 03:46:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgUj-0000bl-Oo
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 03:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbYA2CqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 21:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbYA2CqA
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 21:46:00 -0500
Received: from rune.pobox.com ([208.210.124.79]:35251 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbYA2Cp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 21:45:59 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 25DE218EB50;
	Mon, 28 Jan 2008 21:46:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4646818EA7A;
	Mon, 28 Jan 2008 21:46:12 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801290234590.23907@racer.site> (Johannes
	Schindelin's message of "Tue, 29 Jan 2008 02:37:59 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71921>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This is not to be applied (especially before auditing the callers), but 
>> to be thought about.  Although it passes all the tests...
>
> It certainly is tempting.
>
>
>> +			while (c == '/')
>> +				c = *src++;
>> +			src--;
>
> This is ugly.  I would like this better:
>
> 			while (src[1] == '/')
> 				src++;

Whatever.  That was just for discussion.

>> +const char *prefix_path(const char *prefix, int len, const char *path)
>> +{
>> +	const char *orig = path;
>> +	char *sanitized = xmalloc(len + strlen(path) + 1);
>
> There _has_ to be a way to avoid malloc()ing things that will _never_ be 
> free()d again with every second patch ;-)

Huh?  prefix_path() already allocates for rewritten pathspec
entries; this is nothing new.
