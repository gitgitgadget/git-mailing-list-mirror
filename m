From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH 3/3] commit: Show the committer ident when is different from the parent
Date: Fri, 2 May 2008 11:25:38 +0200
Message-ID: <8aa486160805020225p47230100m86f9ee251dabc161@mail.gmail.com>
References: <1209545236-4266-1-git-send-email-sbejar@gmail.com>
	 <1209545236-4266-4-git-send-email-sbejar@gmail.com>
	 <20080430145017.GA922@sigill.intra.peff.net>
	 <20080430163701.GA6544@sigill.intra.peff.net>
	 <8aa486160804301223w574fe425n5d0678020ff1e7b4@mail.gmail.com>
	 <20080430192639.GC30344@sigill.intra.peff.net>
	 <8aa486160805010134l4746f9afhec546a9d49fd7a6d@mail.gmail.com>
	 <20080501135109.GA10135@sigill.intra.peff.net>
	 <7vd4o5zw2s.fsf@gitster.siamese.dyndns.org>
	 <20080501222801.GA21731@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Alex Riesen" <raa.lkml@gmail.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 02 11:26:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrrXI-0000Ki-5O
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 11:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759339AbYEBJZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 05:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758905AbYEBJZt
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 05:25:49 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:32618 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757852AbYEBJZs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 05:25:48 -0400
Received: by yw-out-2324.google.com with SMTP id 5so734747ywh.1
        for <git@vger.kernel.org>; Fri, 02 May 2008 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=I1q0zBE9Ls4DvT6+KeqcKgLFOiFvTvfHBI/sMnWZdCs=;
        b=Ywuu6P2GNrXnVrYaB7W2decFKlG7xwRB4e/0oKBAYjvG7n6474mgNXc1x2qji+/vjAgWdvHlDc+UNRSb/FUkkxjlCd26zBsk4duTf+lQYmO5BMmLSBlUq+ear7nyJKtGi3nlTryE42kVXvQqPkDP2xkDb8RwdR7eaoM1aKmd2nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VFD3ytQeTDR8pN1H8KwoQ4OMo0Yakbl6Cr+l31sI1JB1VrCMZOsmSPyaIoHESg/AKOUrlTN2zMrauiaTB9s3AEDNigG4GUwUlkUu3NlGnr8QaML9qpnIV0eGjrO2i6gIxhf0EwRt4gxxQDY7vNn8a8zsDGlfNHJ891VNo3jghkc=
Received: by 10.150.51.9 with SMTP id y9mr3289389yby.42.1209720338463;
        Fri, 02 May 2008 02:25:38 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Fri, 2 May 2008 02:25:38 -0700 (PDT)
In-Reply-To: <20080501222801.GA21731@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80972>

On Fri, May 2, 2008 at 12:28 AM, Jeff King <peff@peff.net> wrote:
> On Thu, May 01, 2008 at 12:02:51PM -0700, Junio C Hamano wrote:
>
>  > Once you have a good algorithm to see when to trigger the warning that the
>  > user might be using an unintended committer identity, I do not think you
>  > should refrain from issuing the warning when you see the offending
>  > committer ident and whose commit you are building on top of should not
>  > affect it.  Otherwise, the user will get the warning once (or not even get
>
>  I think I must not be writing very clearly,

It was clear, but I think there is more than this, especially the
definition of what is a wrong committer depends on the user. I was
trying to not annoy too much to some users (those who like the
automatic committer).

Let's find the definition of "wrong committer":

1) user.{name,email} or GIT_COMMITTER_{NAME,EMAIL} is not a wrong committer.
2) automatic without a domain name (user@hostname.(none)) is a wrong committer.
2) automatic or partially set ident:
    a) wrong committer for some users
    b) right committer for others

I see different strategies. Show the committer:

1) always
2) when user.warn = yes (defaulting to yes)
3) when it is automatic
    a) always
    b) and different from parent
    c) and different from a list of valid committer idents
    d) and when user.WarnAutomatic = yes (defaulting to yes)

(the names of the configs are just ideas)

I prefer in order: 3a, 3d, 2, 1.

>
>  I also think you could argue that we should just show the committer all
>  the time. But I don't think anyone has made that argument.

>From past threads and the "precious screen state" I thought it was
totally discarded.

Santi
