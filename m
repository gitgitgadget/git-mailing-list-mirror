From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Compiling git with makepp patch
Date: Mon, 23 Aug 2010 20:27:30 +0000
Message-ID: <AANLkTinbTph=cggp4V=avorzrf9BT7vPtpanDtDtXm=q@mail.gmail.com>
References: <84FD9808A65CDF4C959FDB41FC3D134CBCF306D6@MSSRVS4.atlas.de>
	<4C71A53F.2020108@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "John 'Warthog9' Hawley" <warthog9@kernel.org>
To: occitan@esperanto.org
X-From: git-owner@vger.kernel.org Mon Aug 23 22:32:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ondgm-0001zA-8Q
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 22:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab0HWU1d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Aug 2010 16:27:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36091 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab0HWU1c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 16:27:32 -0400
Received: by fxm13 with SMTP id 13so3311672fxm.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 13:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XvqiQxnMbjeMe5sPyJdAdHgX/77mSpnRZ25jVPsGGRc=;
        b=DYsBct9oOvbMq5ZybjEcKdzuzTB2WBMch8h3/0Jg45JrBAyW1vVZ+hmbja+5zEEluM
         WFTKtpfPFS2ZtMZYBWs5kCNG8y/nFTEhxS9n8DcqqV+STr6YGn+pqZY+9/72GLde1ZiR
         k+ZnGQObJvIZMoeyzX/RlBLu5yV8ybXpTWEbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BATSZJdOn9TvDmkAscUbhWFaiZbUUX/jl5e0L8HbkGHLCJBjR2LRbQw1G04KkTzB0Y
         oUQeo6vxupLFVX1BRsJs4v5POmQwSQAo5g9MEr0wJAflG0D2gcRt6dnhtuBznXjzPvd8
         Lg2sSjXQBAqBCoQteJRkTBDCig4E77ZlhpdXY=
Received: by 10.223.126.84 with SMTP id b20mr4928255fas.98.1282595250695; Mon,
 23 Aug 2010 13:27:30 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Mon, 23 Aug 2010 13:27:30 -0700 (PDT)
In-Reply-To: <4C71A53F.2020108@t-online.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154253>

On Sun, Aug 22, 2010 at 22:31, Daniel Pfeiffer <occitan@t-online.de> wr=
ote:

> Git has been giving our promise of Gnu make compatibility a hard
> time.

Aside from our bugs you can't make that promise if projects like Git
need patches to work with makepp :)

> The other thing caused me quite a headache before I understood:
>
> PERL_PATH_SQ =C2=A0=3D $(subst ','\'',$(PERL_PATH))#'
>
> I suppose you added the comment for Emacs' syntax highlighting, to ha=
ve an
> even number of unescaped quotes.

That was added by John 'Warthog9' Hawley, I wonder if that also came
with a M-x report-emacs-bug, e.g. cperl-mode deals with that case,
sounds like an easy-to-fix bug in makefile-gmake-mode.

> The problem is makepp parses this line
> just like Emacs, so it doesn't find the comment, adding in the #' at =
the
> point of use, which completely screws the sed command. =C2=A0(You mig=
ht want to
> apply my fix to a few other makefiles, which have SQ variables, albei=
t
> without the syntax highlighting workaround, so they are only visually
> defect.)

The reason Emacs has issues is because it uses an ad-hoc regexp based
parser that favours speed above correctness for syntax
highlighting.

I'm surprised you've gotten this far with makepp if you don't tokenize
comments and throw their contents away.
