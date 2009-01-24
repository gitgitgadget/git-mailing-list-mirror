From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH] Use time_t for timestamps returned by approxidate() 
	instead of unsigned
Date: Sat, 24 Jan 2009 12:14:47 -0500
Message-ID: <32c343770901240914n3fc76fe0vbe844e50cbc0bbf@mail.gmail.com>
References: <1232665622-5110-1-git-send-email-tim.henigan@gmail.com>
	 <alpine.DEB.1.00.0901240726070.13232@racer>
	 <32c343770901240813k2eeb19b0q65b533f829cb44d4@mail.gmail.com>
	 <alpine.DEB.1.00.0901241757140.13232@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 18:16:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQm7l-0001EB-46
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 18:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbZAXROv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 12:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbZAXROu
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 12:14:50 -0500
Received: from mu-out-0910.google.com ([209.85.134.187]:13938 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbZAXROt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 12:14:49 -0500
Received: by mu-out-0910.google.com with SMTP id g7so3340088muf.1
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 09:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vP48Gx7oO+7Boew1QwUY1OalJ3S/tHzlmUewebk225w=;
        b=VcmN79NiyW51TXh5ej4S43pibBi7C2NUEoxiy0QweURi4b8LRVb5N0Li+6ALYZTRi6
         TtWRtjHajhYBDBaxaJOQMTdP8OxCsmixWxE3/QW2DqieIBLGSOvKbupY8aePxEvFPHkq
         UweocJSMZJMBETli3fMxVoJd9DY5zlJJ3Qw5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XwgJSkL3MjOb2/LyudBnR3wzflq9XF5PtlnRI7c/l5+zHAuP1qq8naIqMSVrsJH3Tj
         q1c846+BlDo8tHrcpm6XjD/qF3LTpxnsoP3qisLMdRJjPu0oe+gtlTxhjjWkHRyVKIpJ
         3VAnG3pxS4nIvBI6391MiuZL9E+1I3AsMSSso=
Received: by 10.103.178.17 with SMTP id f17mr3297620mup.45.1232817287679; Sat, 
	24 Jan 2009 09:14:47 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901241757140.13232@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106978>

On Sat, Jan 24, 2009 at 11:58 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> Should I update the GitWiki page to remove this Janitor task or do you
>> keep it as a test to see if people are properly searching the mail
>> archives?
>
> Yes, please!

I did some more digging and found this last comment on the subject by Linus:
https://kerneltrap.org/mailarchive/git/2008/11/6/4014344

Given this, should the janitor task simply be deleted (since using
unsigned longs are safe until year 2038 is considered) or should it be
updated to change all timestamps to 64-bit values?

Also, there are still ~37 references to time_t in the code (e.g. the
index_state struct in cache.h).  Should these be phased out in favor
of unsigned longs (or perhaps 64-bit types)?

Perhaps the Janitor task should be changed to do this so that all the
code handles timestamps consistently?  (btw, I will volunteer to do
this if desired).

Thanks,
Tim
