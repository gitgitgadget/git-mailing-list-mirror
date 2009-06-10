From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Wed, 10 Jun 2009 22:07:32 +0800
Message-ID: <be6fef0d0906100707r64d489fub328a44d34927a77@mail.gmail.com>
References: <20090602174229.GA14455@infidigm.net>
	 <7vmy8p8947.fsf@alter.siamese.dyndns.org>
	 <20090603191050.GB29564@coredump.intra.peff.net>
	 <20090603191555.GL3355@spearce.org>
	 <be6fef0d0906040545j7bd754e0j2c60af833e2ac4a4@mail.gmail.com>
	 <20090604160152.GA13984@sigill.intra.peff.net>
	 <be6fef0d0906070331y5fd596d1k67893a96a4d872ac@mail.gmail.com>
	 <be6fef0d0906070421j7913b0d7w6f7bb97aa7fd6814@mail.gmail.com>
	 <20090608122430.GD13775@coredump.intra.peff.net>
	 <be6fef0d0906100703j57d109d5mb38e41330caa089b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 10 16:07:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEOT0-00011V-R9
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 16:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784AbZFJOHc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 10:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756545AbZFJOHc
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 10:07:32 -0400
Received: from mail-px0-f200.google.com ([209.85.216.200]:61475 "EHLO
	mail-px0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756510AbZFJOHa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 10:07:30 -0400
Received: by pxi38 with SMTP id 38so716374pxi.33
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Za5pi9B50YG8jNikuPDKrUT/fnW1vi5cIeOeHSIa8Co=;
        b=CZ3vmozUyM/6EWnPgg1YT7sYdjBRi/hpcu32MthLCcLIoO2wnoek+n8/ImfWXyk5t3
         fAziXbf2gQx4qv5gRU4kpuJl/VciwFe7YlPGGc9AGZJnNkD54N2fff4275zJiHnofm7U
         pV2x8OpWpF1ExW1qnFG504ZN5LNeBTpV2ArVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DrU5z9OsJkkj8SjsuyhTWZBub2C5a4W3/HoHFOpYu9isUfWBt9wo6NUbmnEneHVklN
         ElqsB+sHH3y+ev/Pe6XA7USkNz2rIg6Bu1HhQjd53dvoTL07ppJ8PcpbtzYu3Sy3fx8+
         /jbUc21jnnlyCJTbZ82XiRlfmwMR90BZkdVdc=
Received: by 10.142.43.7 with SMTP id q7mr587771wfq.346.1244642852860; Wed, 10 
	Jun 2009 07:07:32 -0700 (PDT)
In-Reply-To: <be6fef0d0906100703j57d109d5mb38e41330caa089b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121277>

Hi,

On Wed, Jun 10, 2009 at 10:03 PM, Tay Ray Chuan<rctay89@gmail.com> wrot=
e:
> On Mon, Jun 8, 2009 at 8:24 PM, Jeff King<peff@peff.net> wrote:
>> =A0Fetching 0 objects (got 2 of 320, 0 alt) and pack: =A0 8%
>> =A0(241096602/302989431), 229.78 MiB | 668 KiB/s
>> =A0...
>> =A0Fetching 0 objects (got 2 of 320, 0 alt) and pack: =A0 4%
>> =A0(270741882/302989431), 257.93 MiB | 690 KiB/s
>>
>> Those are two cut-and-pastes from the same fetch. You can see it
>> progressing in terms of absolute numbers, but the percentage values =
make
>> no sense. The "total downloaded" and throughput numbers look roughly
>> correct. I don't know if this is caused by multiple simultaenous
>> downloads.
>
> It's likely that your guess (about simultaneous downloads) is causing
> the inconsistent % completed, but then packs aren't downloaded
> simultaneously. I'll have to check this again.

the linux-2.6 repo has only 1 pack (and no http-alternates), so this is=
 weird.

--=20
Cheers,
Ray Chuan
