From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] http-push: refactor request url creation
Date: Thu, 29 Jan 2009 19:49:13 +0800
Message-ID: <be6fef0d0901290349i65d75dfel49dda4ce0becf970@mail.gmail.com>
References: <4980D9FF.7020307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 12:50:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSVPu-0006YO-0L
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 12:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbZA2LtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 06:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbZA2LtP
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 06:49:15 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:38987 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbZA2LtO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 06:49:14 -0500
Received: by wa-out-1112.google.com with SMTP id v33so1288163wah.21
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 03:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Z9d/47OOZ/DQs5UpabHd89mSn5GYlZGN4IR2PpfRAYA=;
        b=IffUxg7mK5yK5Tan8IDOkF7u88/A7XH4t4M7tq6xAqoy8q7f7/1mNVG3s1aDga3Jzi
         fBtni0UKlyi8Xtc/q6ynRdprCzi6L++GrrudGUAwEpbxKme0HWAqk67Wa3CGHv6H1pFh
         sq40iZawn2YOufcQGZrYS6q8b3tErqrOf4FXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=d3bc+S1QXyZGcjXguvAZi1UU7jkjqu0KW2I4UH1ISqY4xcoYzxUhCcAmPZjwYnPlc+
         FaW8fSZW2uWDC2u90AFLcwr5SF3q3TjHhXYDn9ns9ABtueKgFJb2lINWp2NMuMrMjVyZ
         Bp6BGJgXkZrTVmcr0+xikmaSx/rObyRNBrAd4=
Received: by 10.114.208.20 with SMTP id f20mr5228897wag.46.1233229753501; Thu, 
	29 Jan 2009 03:49:13 -0800 (PST)
In-Reply-To: <4980D9FF.7020307@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107662>

Hi,

On Thu, Jan 29, 2009 at 6:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> What's with these loooooooooooooooooooooooooooooong lines?
>
> I thought at least you did not have these overlong lines in your earlier
> attempts, and Dscho may have acked one of those, but I doubt he would give
> his Ack to this one.  I certainly wouldn't Ack it myself.
>
> By the way, aren't you sending format="flowed"?  Please don't.  It damages
> whitespaces.

I used Thunderbird since Gmail kept wrapping lines in the patch, guess
i"ll have to manually wrap the commit lines.

> Daniel Stenberg did a research on the safety of your "since curl stdrup's
> it" claim, and found that it unsafe for earlier versions of the library
> before 7.17.0.
>
> It seems that we earlier found out that anything older than 7.16 were not
> usable for git-http-push (see Release Notes for 1.5.4), but 7.16 is still
> older than 7.17, so either we declare you _must_ have 7.17 or newer to use
> http-push, or keep an extra copy around and free it later like the
> original code does.
>
> Even Debian is at 7.18.2 these days, so requiring 7.17 or newer may not be
> an issue in practice, but there are people who keep running things on
> older distros with proven stability (and known features limitation).
>
> The refactoring looked sane otherwise, but I think we would want to opt
> for safety by keeping an extra string around.

Hmm, since that string won't be released in start_fetch_loose, or
anywhere else, would this be considered a memory leak?

-- 
Cheers,
Ray Chuan
