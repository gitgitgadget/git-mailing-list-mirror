From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Tue, 20 Nov 2012 23:06:43 +0100
Message-ID: <CAMP44s3+vnKfhhh=qqU2vuKvWwhii4CQ7=YAuhFiceX1EDaVKQ@mail.gmail.com>
References: <20121119151845.GA29678@shrek.podlesie.net>
	<7vk3thxuj2.fsf@alter.siamese.dyndns.org>
	<20121119225838.GA23412@shrek.podlesie.net>
	<CAMP44s0f0zYa1FVf9RhNuwYJbkQ7zPwgJ6=ty3c5knjo5a2TNw@mail.gmail.com>
	<7vlidxuowf.fsf@alter.siamese.dyndns.org>
	<20121120073100.GB7206@shrek.podlesie.net>
	<20121120075628.GA7159@shrek.podlesie.net>
	<CAMP44s38gTB_3Ao1rFZgMo2EAuiNb+h88-qRFcQPRMJNxo3CAQ@mail.gmail.com>
	<20121120115942.GA6132@shrek.podlesie.net>
	<m2lidw11yb.fsf@igel.home>
	<20121120212126.GA12656@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Balbi <balbi@ti.com>, git@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 23:07:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tavy7-0000zP-0G
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 23:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360Ab2KTWGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 17:06:44 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36581 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab2KTWGo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 17:06:44 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so6436350obb.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 14:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=H6yxQt1FsgUQXENuGj3a3ZR+bfOEkDpl+chwIioFOW8=;
        b=GHam7LIh7vzUJfzhLKuyuR2Thy/twWaAs6LoxfDIzw6/zcSBzqp0eWW9zgjONS983w
         ivliuivbKNnLc7vMbe9TUYEQNutBgLZFQt0o7lm+ppLc4BNpBV18B7qJFWbCeWb7li7u
         M6TJiqbu8Qan9AeMEoLeqCAD5iYqdbu+gzPv7yi0hx1scQXTpY3CriiWbXq+/JWfg+Gi
         6txLFRd0hS5uynXo98oCglRmcexXxCuHDRooWQAGAZGhVrtGleM603v1LW2fczlvhTUY
         cEZ8Hkjdge8jfmcr1Hp6zKYfPX8dNNtxlFG12DqFzzsuHuykPPM2e9yWQQUmJBsCndPl
         kNhQ==
Received: by 10.182.245.20 with SMTP id xk20mr14573713obc.89.1353449203545;
 Tue, 20 Nov 2012 14:06:43 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Tue, 20 Nov 2012 14:06:43 -0800 (PST)
In-Reply-To: <20121120212126.GA12656@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210115>

On Tue, Nov 20, 2012 at 10:21 PM, Krzysztof Mazur <krzysiek@podlesie.net> wrote:

> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -924,6 +924,10 @@ sub quote_subject {
>  # use the simplest quoting being able to handle the recipient
>  sub sanitize_address {
>         my ($recipient) = @_;
> +
> +       # remove garbage after email address
> +       $recipient =~ s/(.*?<[^>]*>).*$/$1/;

That won't work for 'foo@bar.com # test'. I think we should abandon
hopes of properly parsing an email address and just do:

$recipient =~ s/(.*?) #.*$/$1/;

Cheers.

-- 
Felipe Contreras
