From: "Ben Lynn" <benlynn@gmail.com>
Subject: Re: git bugs
Date: Wed, 11 Jun 2008 13:57:50 -0700
Message-ID: <832adb090806111357y749a4e03qbddd37b0c077b1c4@mail.gmail.com>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
	 <832adb090806101931y754fa6b7nfcb58a9c34f0c582@mail.gmail.com>
	 <alpine.LFD.1.10.0806101935130.3101@woody.linux-foundation.org>
	 <832adb090806102258v3fd63605p8c45513690b78fe8@mail.gmail.com>
	 <832adb090806102318k5727bb06p6c3211a6aebbfbe9@mail.gmail.com>
	 <alpine.LFD.1.10.0806110752550.3101@woody.linux-foundation.org>
	 <832adb090806111052p32a750c2n5f2d43e0ed1b910d@mail.gmail.com>
	 <alpine.LFD.1.10.0806111105150.3101@woody.linux-foundation.org>
	 <832adb090806111148u5e13e9c5g7afc5b013e6f1223@mail.gmail.com>
	 <alpine.LFD.1.10.0806111151260.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 22:59:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6XPB-0004BK-Ml
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 22:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbYFKU5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 16:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbYFKU5x
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 16:57:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:56867 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbYFKU5w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 16:57:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2243019fgg.17
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VxiwThL0JYffqLjk1tDNaFyjVTgrfjJSyRK99hv8AD4=;
        b=o5Fbg//O0fgg2B38qMLhRMHD8GZHrvbGNDGpuoxeS8PbZ0juFHNeU+p1zRZ9rL7EJG
         tch5e9sZxfhyKIgr9vz3dia4bM8Cua5VCPqIe4njH/6nKy//IoVpHOAnAyrzjpHKMQaG
         YxfOa48iOYR6/W5gcHt3xur6Vz/S0dUqXzung=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=in+0Cyae6BFENpAAAlBnWzffJrlYx/izc8dTIdVbA9HqtKi3ZquNp6mqujyegTT5QF
         GwUxHqSalNyqe+1xlXpNMsQXOClkcOeE2wyXdR71Rk7uzImjP/0BIO6pOWEvKByO9yfb
         MdDH/8KRhCmpaz/azhSWfofJFjs4ZDDkNNdXU=
Received: by 10.86.70.11 with SMTP id s11mr935206fga.71.1213217870392;
        Wed, 11 Jun 2008 13:57:50 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Wed, 11 Jun 2008 13:57:50 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806111151260.3101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84661>

> So I really prefer not to. But you can take it up with Junio if you think
> it can be a big deal.

I began writing a patch but I abandoned it. I don't have much
experience with the code base and I'd almost certainly miss a bunch of
corner cases. Your patch seems to be the easiest way to go. I'm not
motivated to push pre-emptive smudging, even if it might be more
efficient. After all, how often does this race condition come up?

But I have a per-file flagged version of the index for personal use,
and it's good to know that it's a valid strategy.

> Historically, we *never* did it. In fact, it was a big deal. These days we
> do it opportunistically for "git diff" if we can, but making sure that it
> all still works for a read-only access (think gitweb etc - the reader is
> *not* necessarily the owner of the archive at all!)

I hadn't thought about this case. This is intriguing: why does gitweb
need access to the index? I thought the index was only to make
operations fast for users intending to make changes to the repo. Why
can't servers run stripped-down versions of git that don't bother with
an index?

-Ben
