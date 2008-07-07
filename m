From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] better git-submodule status output
Date: Mon, 7 Jul 2008 10:57:39 -0400
Message-ID: <32541b130807070757s4ba03e28tf4701f479e27b687@mail.gmail.com>
References: <20080701150119.GE5852@joyeux>
	 <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de>
	 <20080706160758.GA23385@jhaampe.org>
	 <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness>
	 <20080707062142.GA5506@jhaampe.org>
	 <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com>
	 <alpine.DEB.1.00.0807071533240.18205@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sylvain Joyeux" <sylvain.joyeux@dfki.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Lars Hjemli" <hjemli@gmail.com>, "Ping Yin" <pkufranky@gmail.com>,
	"Mark Levedahl" <mlevedahl@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 16:58:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFsAx-0003h9-QL
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 16:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbYGGO5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 10:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753679AbYGGO5l
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 10:57:41 -0400
Received: from el-out-1112.google.com ([209.85.162.183]:21745 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751AbYGGO5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 10:57:40 -0400
Received: by el-out-1112.google.com with SMTP id z25so157547ele.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 07:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=riCkYugTS2C21RMWyKcYQ/YLMj51RtwWqigvuDwYjUo=;
        b=OOvcziwYHJI0fF5RpB0e/RBC9bKQxazHPVHcfCheWFsis9IvaYypt51r3HDHaUYwGK
         JTotMvZC3p9MJ2kX0fUeQWa977FMP6rIPWRa8+pDuYvzZBQV2woYgIoSxwtSblpod65C
         34MpYG32ZCH4xTKKR3SUrc6dSJrmsjQOS9QJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bsu3FdwEVzsRO8tYZ6ZTfnZOKRCvt+zvOVa13RDKZjy9WoFJg1UGpxTc+dgCnF+9cS
         oAs/j3LWHYW435NZBiDppaD644sn8RX/5rcWVok+pNWgm5Q96Xbi6V9FyP+LgZkXGHUV
         nyvXtXKQaSJrZRnEu/jlmUFOGBH2f5xirRf+w=
Received: by 10.151.13.7 with SMTP id q7mr8292789ybi.204.1215442659470;
        Mon, 07 Jul 2008 07:57:39 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Mon, 7 Jul 2008 07:57:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807071533240.18205@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87620>

On 7/7/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  On Mon, 7 Jul 2008, Avery Pennarun wrote:
> > Thus, I'd say the best fix would be to find a way to have "git pull" or
> > "git fetch" in the supermodule also do a fetch in the submodule.
>
> Noooooo!
>
>  If I am actively working on the submodule, the supermodule has _no
>  business_ trying to wreck my state.

Hmm... how does doing a fetch wreck your state?  I thought fetch was
supposed to be a pretty harmless operation.  We're not talking about
doing a "git submodule update" automatically (which would be deadly,
albeit only because "git submodule update" is so destructive at
present).

All I'm suggesting is, when doing a "git fetch" in the supermodule,
simply do a "cd submodule && git fetch" automatically.  Probably
should be optional, but seems like it could make sense for most uses,
and avoids the (probably much more common) annoyance of fetching in
the supermodule and taking my laptop on the road, only to find out
that I don't actually have all the objects I need.

On the other hand, for my own workflow I'm shifting increasingly
toward having all my "submodules" share a single repo anyway, in which
case fetching in the supermodule *would* automatically fetch all my
relevant submodule objects too.

Have fun,

Avery
