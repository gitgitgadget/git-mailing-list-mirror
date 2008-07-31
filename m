From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Git vs Monotone
Date: Thu, 31 Jul 2008 21:19:41 +0200
Message-ID: <bd6139dc0807311219h670f782cm8bed74bed2b4558@mail.gmail.com>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
	 <20080731190209.GA8372@sigill.intra.peff.net>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>,
	"Craig L. Ching" <cching@mqsoftware.com>,
	"Petr Baudis" <pasky@suse.cz>,
	"Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Jul 31 21:21:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOdhc-0003cX-4w
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 21:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbYGaTTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 15:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754821AbYGaTTm
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 15:19:42 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:32020 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbYGaTTl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 15:19:41 -0400
Received: by wf-out-1314.google.com with SMTP id 27so925250wfd.4
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 12:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=00FL0lwylqsjn7LINErHTCuRvIOifs30lSLbsWloSOU=;
        b=t5MSU4ABRzbE2uigxj4FEOloWyuRz6Xvxm/TReoKqQZE0+DfcV3TKkwuG1bknfMbiI
         3X1BrEQ9qUcblmGxanwExL5TgWddp8ikmrxopnACpzicpie7b0lxigOkF9BrBGhM10Vz
         WrLfJQKiI00HiJMUcoRVoP/b6Z0ustYdDMfIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=epUKwfB4mkrnL//X40RR0/1QePUgsgEKxUjOr3dSJHIoIV6Rpw1M3rmwYeR/4ROfYw
         hWBW1WMKoNehp4wY8R560fLF4iDsCDUaJhs6EGwxw/N5ET763BEFrKWCbhZsbVgQUBmJ
         up4krFOQdgE2pldSkUJVPmgxv2Wi2rZ9QF+yw=
Received: by 10.143.5.7 with SMTP id h7mr3387485wfi.319.1217531981050;
        Thu, 31 Jul 2008 12:19:41 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Thu, 31 Jul 2008 12:19:41 -0700 (PDT)
In-Reply-To: <20080731190209.GA8372@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90970>

On Thu, Jul 31, 2008 at 21:02, Jeff King <peff@peff.net> wrote:
> and the _whole thing_ is 148M, including the working tree. His object db
> is only 88M. So he can do his 11 trees in 61 * 11 + 88 = 759M, saving
> 141M over monotone.

Yeah, that's rather unfair indeed, counting that way he'd have to add
the 229MB for the Monotone db too ;).

> And I am repacking with insane depth and window right now to see if we
> can get it smaller (though really, it is not that big a deal, since the
> size is dominated by his 11 working trees).

I repacked with --depth=100 and --window=100, I tried out 500 at first
but it was just insanely slow (on a VM with one 2.4Ghz Core
available). This resulted in a .git dir of 76MB. With that dir I did
the following:
$mkdir pidgins
$git clone --no-hardlinks --bare pidgin pidgin-bare
$mv pidgin-bare pidgins
$cd pidgins
$for i in 1 2 3 4 5 6 7 8 9 10 11; do git clone pidgin-bare pidgin$i; done
$ du -sh .
742M    .

So... monotone, eat your heart out ;).

-- 
Cheers,

Sverre Rabbelier
