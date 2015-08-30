From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Sat, 29 Aug 2015 21:20:00 -0400
Message-ID: <CAPig+cSspbWKUcnp6NJ1rjYyWQV8bO3ZmV7L_J7QaHRFRh3-wg@mail.gmail.com>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
	<20150825171238.GB9674@sigill.intra.peff.net>
	<xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
	<20150825185210.GA10032@sigill.intra.peff.net>
	<20150825185414.GA10895@sigill.intra.peff.net>
	<CAPig+cQ1COjZuBq2YWKNdQ7zrzfvrppX-84vc9i1mJ6-yp_ZiQ@mail.gmail.com>
	<20150826021517.GA20292@sigill.intra.peff.net>
	<CANy2qHd_GTxr2CsjxLiNCvdwMLtEqcmURUTfFv9+t16FMEjuiw@mail.gmail.com>
	<CANy2qHcCDkszLeOm-aJDCvkUaFFngtEy_VN+_B46K7KTQf4_Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Gabor Bernat <bernat@primeranks.net>
X-From: git-owner@vger.kernel.org Sun Aug 30 03:20:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVrIS-0004NK-Kl
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 03:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbbH3BUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 21:20:03 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:32951 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbbH3BUB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 21:20:01 -0400
Received: by ykdz80 with SMTP id z80so48699642ykd.0
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 18:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QQHp2x1FdOaWND7vieMv+n9yV0UdLqA52iquGY7GimE=;
        b=DdYXk6ioq0VYMrH2MI8ZFAupSDn7Q4PGB+mU1l+nAf3jNPGaQStMW84f4YchzpKJAm
         tzudjkJvqqCpvYXKHIHCj/ePkbkZ98p052g7nip2w3lNk3cFFVGudPoSbZAbShq2+vTF
         NwGcxmAeaIGFyucVfMTDxrosW2ds3p/eflNRoX9AYBqN1LzgxC8Xclj6848SoEVQatHC
         swZIsXlPXcTKD+B51RZfS0uA9onJx5B+sw3qdq+m7A7vKjapmuxPcBRlSeShOlOsx3Rk
         2sk57mWGTNRVxdGP4ySrLEBfwBp109upem7iarR5fKasL5THDmc6tp1xT2pYMppxj9o0
         aHag==
X-Received: by 10.129.70.215 with SMTP id t206mr15642338ywa.4.1440897600671;
 Sat, 29 Aug 2015 18:20:00 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sat, 29 Aug 2015 18:20:00 -0700 (PDT)
In-Reply-To: <CANy2qHcCDkszLeOm-aJDCvkUaFFngtEy_VN+_B46K7KTQf4_Sg@mail.gmail.com>
X-Google-Sender-Auth: SNNCeVla5i_G_41npOEXbkVrXZ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276795>

On Sat, Aug 29, 2015 at 9:29 AM, Gabor Bernat <bernat@primeranks.net> wrote:
> Amended, the latest version is at https://github.com/gaborbernat/git/commit/ :)
> Does this looks okay, should I create a patch from this?

Excerpt:

    now=$(date +%s)
    elapsed=$(($now - $start))
    remaining_second=$((...))
    eta=$(($now + $remaining_second))
    finish_by=$(date -d "@$eta")

Unfortunately, -d is not portable. On Mac OS X and FreeBSD, -d sets
the kernel's value for Daylight Saving Time, rather than displaying
the specified time as in Linux.
