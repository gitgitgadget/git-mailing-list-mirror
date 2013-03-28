From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: propagating repo corruption across clone
Date: Thu, 28 Mar 2013 09:48:34 -0400
Message-ID: <CAOx6V3YdKUm4gr+_6UwOKfdn1EdND6B06Ne2wdbC=202aCfifA@mail.gmail.com>
References: <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
 <20130324192350.GA20688@sigill.intra.peff.net> <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
 <20130325145644.GA16576@sigill.intra.peff.net> <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
 <20130325155600.GA18216@sigill.intra.peff.net> <CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com>
 <20130325200752.GB3902@sigill.intra.peff.net> <CAOx6V3ZWB1ZpmXcaBeSaPOvHqmAMF3U1rTXuwinFGmEZQwFGYQ@mail.gmail.com>
 <20130326165553.GA7282@sigill.intra.peff.net> <1364340037755-7580771.post@n2.nabble.com>
 <7vr4j1qzao.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rich Fromm <richard_fromm@yahoo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 14:49:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULDCl-0005WC-Og
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 14:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755844Ab3C1Nsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 09:48:55 -0400
Received: from mail-vc0-f173.google.com ([209.85.220.173]:55488 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739Ab3C1Nsz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 09:48:55 -0400
Received: by mail-vc0-f173.google.com with SMTP id gd11so7616807vcb.4
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 06:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mr3caPv/gs4ZBgqhSxYfSB/ygRzzgHl4FewB4HcJbQM=;
        b=05rNC5D3KA5aQyzXfBN7qWRO/M0zKhEaebuucMJ3VbqeIBUy7jRd2irU/SbwrLtTwW
         lDzOvbqMsURjDf2/nU+EvWO0bAGSRfOwyQe2LEmv3yBWhLBw2iU3LZ8AgTiKsTnvE9qL
         MC/XZgEicJkedAXSCHP/XYO6YIvtFyIG+an0UdMXXAhF5nBTDXGvPdgnjN0iEdx4xD3l
         hf5w3DrXf80iUWbnR9tLt7QACAznkUATgPnXeP2Fs+XlXfFE3ThP+AxCVSjaB654BGDk
         Ht/pryNCWewdDA/o5yRnOdSANBkJ3JohqXT3YXwftnOtiavLZwlsXPa6B0HfDjBImshi
         vkDQ==
X-Received: by 10.58.94.234 with SMTP id df10mr26816379veb.4.1364478534526;
 Thu, 28 Mar 2013 06:48:54 -0700 (PDT)
Received: by 10.59.7.37 with HTTP; Thu, 28 Mar 2013 06:48:34 -0700 (PDT)
In-Reply-To: <7vr4j1qzao.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219395>

On Tue, Mar 26, 2013 at 11:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The difference between --mirror and no --mirror is a red herring.
> You may want to ask Jeff Mitchell to remove the mention of it; it
> only adds to the confusion without helping users.  If you made
> byte-for-byte copy of corrupt repository, it wouldn't make any
> difference if the first "checkout" notices it.

Hi,

Several days ago I had actually already updated the post to indicate
that my testing methodology was incorrect as a result of mixing up
--no-hardlinks and --no-local, and pointed to this thread.

I will say that we did see corrupted repos on the downstream mirrors.
I don't have an explanation for it, but have not been able to
reproduce it either. My only potential guess (untested) is that
perhaps when the corruption was detected the clone aborted but left
the objects already transferred locally. Again, untested -- I mention
it only because it's my only potential explanation  :-)

> To be paranoid, you may want to set transfer.fsckObjects to true,
> perhaps in your ~/.gitconfig.

Interesting; I'd known about receive.fsckObjects but not
transfer/fetch. Thanks for the pointer.
