From: Eric Kidd <git@randomhacks.net>
Subject: Re: [RFC/PATCHv2] git submodule split
Date: Sat, 14 Feb 2009 09:11:16 -0500
Message-ID: <431341160902140611x69a915e6lc3ee482f1ca66dc8@mail.gmail.com>
References: <431341160902121350x45076c8cj26afab0b7a51cac5@mail.gmail.com>
	 <1234578258-48870-1-git-send-email-git@randomhacks.net>
	 <7v3aeh3a84.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0902141245080.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>,
	Ping Yin <pkufranky@gmail.com>, Lars Hjemli <hjemli@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 15:27:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYLTt-0007Lo-UF
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 15:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbZBNOLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 09:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbZBNOLU
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 09:11:20 -0500
Received: from ag-out-0708.google.com ([72.14.246.241]:59134 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbZBNOLT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 09:11:19 -0500
Received: by ag-out-0708.google.com with SMTP id 26so2587342agb.10
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 06:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=OivB5bepKwxVWoXAQvr5c5rWE7ZzMudScrjjQLxP8Mc=;
        b=i9Yns4A3GTDmYp4xrY6M6IUkcYJ+nQk1cggw2NuYjbYwgKOlMgRYtBuVEQDTxboJfc
         p0AWaAtTxVZqDlfceZTRaIKk6ft4Ablk1liBcBnLE7/Gr55Upt3GOoHM2iXm65JSt/FF
         o43QHR2m7/nHLofdAoij6w9+x5sQ9xiSZWt9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=u6CPlNTs68W2xq3aO7SmIjK6wF/gVhE5MHE38LhctQuL+0+VyGWg28MkngQ8QDQ9wa
         bwzlEpoWyuN48zFNtYU7e4Nh0UWpe0R+v/beHIs9UBYbIuKvTLJwDblODoHu9rCYpOcL
         XSKfjWq9xyfOAyrw3AMQRAdbjHr+D/5BZKkI0=
Received: by 10.150.124.2 with SMTP id w2mr155035ybc.213.1234620676775; Sat, 
	14 Feb 2009 06:11:16 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902141245080.10279@pacific.mpi-cbg.de>
X-Google-Sender-Auth: eafebd2db306dd8d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109869>

On Sat, Feb 14, 2009 at 6:46 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> As I said to Eric already, I would like this to be part of git-submodule
> proper, as I expect a lot of people needing it.

I'm happy to do whatever people want. :-) Even if this goes into
contrib/, I want to include everything a regular git command would
have: unit tests, a man page, portable sh code, etc. And I want to
make 'git-submodule-split' useful to as many people as possible.

Which brings me to a design question: Would 'git-submodule-split' be
useful to more people if it were actually two commands?

1) git submodule split: Create the new submodule, update the working
copy, but do not change any history in the super-project. This would
be useful for existing projects that don't want to rewrite existing
commits, but which want to spin off a submodule.

2) git submodule split --rewrite-history: Update the history of the
project to use the rewritten submodule. This would be most useful when
migrating repositories to git.

I've already implemented (2), but frankly, it feels like a special
case of a larger command. It would be very easy to implement (1) and
make it the default.

Cheers,
Eric
