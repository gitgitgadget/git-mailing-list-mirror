From: hasen j <hasan.aljudy@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 17:47:13 -0600
Message-ID: <q2y600158c31005071647i80871db0z7a55ae77e738d0d4@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com> <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org> 
	<384AA932-227B-43B0-9D38-560A3567918A@gmail.com> <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org> 
	<m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com> 
	<alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071504280.901@i5.linux-foundation.org> 
	<h2q32541b131005071534r22cc2092t2a21bfad6d4bfd81@mail.gmail.com> 
	<alpine.LFD.2.00.1005071601470.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 08 01:47:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAXGd-0006mt-J7
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 01:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666Ab0EGXrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 19:47:35 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47663 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab0EGXre (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 19:47:34 -0400
Received: by gwj19 with SMTP id 19so978478gwj.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 16:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=ZE9h/MjdcMOWtns6S8NUzOgeU0FNwvl6BuYm4Iozdrg=;
        b=ZvRT8qChSKRZLWoaCfaxlOZv225LcBIex+OSGHXpSznmJ/S+fKwlHCvxHFfxZco0Jp
         2rmNACtkWpmVZI0XH8VkR8m70m6bjilkM9060Zy79BeXWBCVEcxVgd8pq9E/cFIFsmqd
         tF8ZkEX01v8djRmphtnWcqTvqSm/WgpSQRDHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fmUgXSEa6Z+tW9EOlrSp4XNiJ9e8LKcx+QzCxfpCyeU+osruBYpNXJFPR6I3l9m8EE
         hF28nBMJ1IwJ6dsVFpTuPq1LN0UcBEXkPq0vVX5KNm4fMDZsZx5AUrR46GiBozGpWJNC
         q56mqpkyqWUML+I7iq/Vxod00R4DH6JprW7bw=
Received: by 10.90.179.14 with SMTP id b14mr773582agf.69.1273276053102; Fri, 
	07 May 2010 16:47:33 -0700 (PDT)
Received: by 10.90.79.17 with HTTP; Fri, 7 May 2010 16:47:13 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071601470.901@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146620>

>
> The only reason to ever support 'lf' is
> if you're a total moron of a SCM, and you save files you know are text in
> CRLF format internally. That's just f*cking stupid.
>

What if:

- The entire history of the file is stored in CRLF
- It's a windows-only file where the official "tool" that reads it
barfs on LF line endings.
- Third party tools also expect (or at least, handle) CRLF line endings.

Even if you end up deciding to store it with LF line endings
internally, it should still be *always* checked out with CRLF endings.

And no, just because I want certain files to be checked out with CRLF
endings, doesn't mean that I want all files to be checked out that
way. This is one of the areas where git's crlf handling is lacking
right now.

Also, git-diff should ignore eol differences by default, unless
explicitly asked not to (currently it's the other way around).
