From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 02/12] completion: simplify __gitcomp
Date: Sun, 8 Apr 2012 16:07:47 +0300
Message-ID: <CAMP44s0nSH7ZjC4T=7pXS2MyAkZ133hOXa_tn3q4er+FbcOc_w@mail.gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-3-git-send-email-felipe.contreras@gmail.com>
	<20120408124652.GN2289@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Apr 08 15:08:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGrr1-00053V-Eq
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 15:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996Ab2DHNHt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Apr 2012 09:07:49 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42312 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490Ab2DHNHs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Apr 2012 09:07:48 -0400
Received: by eaaq12 with SMTP id q12so935297eaa.19
        for <git@vger.kernel.org>; Sun, 08 Apr 2012 06:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=a7xmKJqs/MAfe2gdJHhq96avLQsj1xnHYhpySqCDQh0=;
        b=cROPxmcqxBR12fLQeLgRgMgSSkX4whdoMpaG2pT4a6xGCGzhLVqVLYoK71lDbuBxmv
         H85R5YoF5yQyHJ99JITiYtd0/REk/brDa0LBcrCcFDO/X7RxWOCL8jqzQC2vNX/B3ec+
         3qnDN75jHGaE7RACBjFiZpHvIBaF50hXwe6HVPyrYH6EJimEt2aRPDlPn4UcU+6vmMdh
         1kLEsVKw8vZqNhIu2dTTOAGv76Os7G4ZbcsUx76fWW8RxkfcF0K1cOx5yzSr8UzIRYhV
         o6knUD//27DsPEsBXE1BSryi+eBeu1o75xjuyOXUxTHVVCLvTYeQextYY038A35k65Mg
         jVuA==
Received: by 10.213.20.201 with SMTP id g9mr244626ebb.105.1333890467157; Sun,
 08 Apr 2012 06:07:47 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Sun, 8 Apr 2012 06:07:47 -0700 (PDT)
In-Reply-To: <20120408124652.GN2289@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194996>

2012/4/8 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> On Sun, Apr 08, 2012 at 06:07:49AM +0300, Felipe Contreras wrote:
>> The suffix is never used.
>
> The suffix was used to offer completion after 'git config
> branch.<TAB>' ending with a period. =C2=A0It is not used by git's
> completion script anymore, because nowadays this case is handled by
> the __gitcomp_nl helper() function.
>
> However, users can provide custom completion functions to their
> aliases or additional git commands, and there might be a custom
> completion function out there that passes a suffix to __gitcomp().

Yes, there _might_ be, and they would have to be fixed; APIs change.
However, this is highly theoretical, what suffix could anybody
possibly want? I believe __gitcomp_1 already does the job of adding
sensible suffixes, and there's nothing else anybody else could
possibly want.

In any case, shouldn't compgen -S "${4-}" do the trick?

> We don't want to break those custom completion functions, so I think
> the suffix should stay.

So we should never make any cleanups because some custom completion
functions might theoretically break? I think at some point we need to
accept that nobody is using this argument anyway (and they should).

Cheers.

--=20
=46elipe Contreras
