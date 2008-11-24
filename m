From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: Not-quite-a-bug in pickaxe
Date: Mon, 24 Nov 2008 16:08:30 +0100
Message-ID: <237967ef0811240708t58d48c84ud0626ba3aaed47b6@mail.gmail.com>
References: <alpine.DEB.1.00.0811241238450.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 24 16:09:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4d4N-0005dQ-Ae
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 16:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbYKXPIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 10:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbYKXPIb
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 10:08:31 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:5115 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbYKXPIb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 10:08:31 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1010228wah.21
        for <git@vger.kernel.org>; Mon, 24 Nov 2008 07:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=RKo8ZG1Tb0KEtxzUw9y1qbuZgLOsXfYMf4RkVEnnthY=;
        b=NLtcS8vC6u3Yh76O7Yotbkq7J31a9tKf0Puav8+xMh2PZgGpi5u0l1jzfi8R1oqPIj
         Npw6HFnEnDeIUIAPJkAtmJeSqQ42otWIDTqPUFgv0A/7wyNKGV31QJYuRGFrFfLoV+tv
         D0BPXv6dGjkylYMvjQJzbTIiLd78XYOIapukQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ae1g7KOulk+vZk70/SsdP1mmezKj8yfYWGI4RRUPXBzvDZvc5nAcpV3FlfXr+VqEvF
         BwFGs/7jGbh4YtoCFl9LrEAaUy7tvrQQS9fvVEsugX50CAax+lBbM00HtUjOWAJB1s7m
         DfLhybxRHTItN5JEZsUdu8vIqqjD1R4JW6aTc=
Received: by 10.114.157.1 with SMTP id f1mr1953077wae.221.1227539310149;
        Mon, 24 Nov 2008 07:08:30 -0800 (PST)
Received: by 10.114.153.10 with HTTP; Mon, 24 Nov 2008 07:08:30 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811241238450.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101607>

2008/11/24 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi people,
>
> I do not know if I hit that behavior before,

I'm pretty sure it has,
http://thread.gmane.org/gmane.comp.version-control.git/100113/focus=100115
(at least i think that's the same case?)

> but now it hit me big time:
> if a commit moves a certain string from one place to another, "git log
> -S<string>" does not pick up that commit.  The code responsible for this
> is in diffcore-pickaxe.c:
>
>                        else if (!diff_unmodified_pair(p) &&
>                                 contains(p->one, needle, len, regexp) !=
>                                 contains(p->two, needle, len, regexp))
>                                has_changes++;
>
> Basically, the "contains()" method says how often the needle was found,
> and pickaxe just assumes that a move of a string is not interesting
> enough.
>
> Now, this behavior is probably intended, as searching files is much
> cheaper than generating the diffs between them, yet it is something you'll
> have to keep in mind when using "-S".

-- 
Mikael Magnusson
