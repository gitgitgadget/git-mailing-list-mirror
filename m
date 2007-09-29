From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 1/1] --color and --no-color git-log options don't need diffs to be computed.
Date: Sat, 29 Sep 2007 15:06:16 +0200
Message-ID: <e5bfff550709290606k71cc3c50h5ea42441223dede@mail.gmail.com>
References: <e5bfff550709290429n291968f2md8068a945ff7a79e@mail.gmail.com>
	 <20070929123724.01BB045EC@madism.org> <85ve9t8wh7.fsf@lola.goethe.zz>
	 <20070929125633.GC32142@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Pierre Habouzit" <madcoder@debian.org>,
	"David Kastrup" <dak@gnu.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 15:06:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibc1a-0003Pt-Ep
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 15:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156AbXI2NGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 09:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756127AbXI2NGT
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 09:06:19 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:4194 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756036AbXI2NGS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 09:06:18 -0400
Received: by an-out-0708.google.com with SMTP id d31so493026and
        for <git@vger.kernel.org>; Sat, 29 Sep 2007 06:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6gbn6wq6wNb6/7y0bXVoFQaM4sFIYGDdOOdJ+J/+Zv8=;
        b=uAd/JHWdf6z3EIuPm/xRu0fTcEKtxWS+f5cS/oGAfXJUTf7XRxnO0F43EXxLePRy50ZKuF0OZgbLSAX44S0VnT6g6gfIDfcB7EvY0iFfEM+HleiHhFMHAd+5ZN8Vfadn0C7Bh0Eq4sFvceGgLUlJz9LeFqeeDGDLObfjnIfWmBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qu0ormNU5ZJz35IlfifBroH2FGQQlmcyQXDB32NWRv4uWwd37AovGpNFZ2AtZ5vNe3vuToXvRjqwf0bilsaTkV6ICWkEnbf+wiHFlhF+NFe8ParDe1vmlh4gcWBdY2BhZFsRsdyTVJbEiXDQy7932c22I/OGqhkulEvS3MB7WJg=
Received: by 10.90.91.14 with SMTP id o14mr3107203agb.1191071176867;
        Sat, 29 Sep 2007 06:06:16 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Sat, 29 Sep 2007 06:06:16 -0700 (PDT)
In-Reply-To: <20070929125633.GC32142@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 9/29/07, Pierre Habouzit <madcoder@debian.org> wrote:
> >
> > > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> >
> > > -                           if (strcmp(argv[i], "-z"))
> > > -                                   revs->diff = 1;
> > > +                           revs->diff = strcmp(argv[i], "-z")
> > > +                                   && strcmp(argv[i], "--color")
> > > +                                   && strcmp(argv[i], "--no-color");
> > >                             i += opts - 1;
> > >                             continue;
> >
> > This can clear a previously set value of revs->diff.
>
>   Good catch, that should be |= of course.
>

Perhaps also with an 'if' before to avoid clearing an already set
revs->diff if the passed option does not match any of the three.

Marco
