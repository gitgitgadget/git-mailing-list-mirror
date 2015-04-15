From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: support git+mosh for unreliable connections
Date: Wed, 15 Apr 2015 21:25:44 +0200
Message-ID: <1429125944.16649.2.camel@kaarsemaker.net>
References: <552E628C.7040809@debian.org>
	 <552E6D07.5030903@drmicha.warpmail.net> <552E732E.20107@debian.org>
	 <0cf0485caae569a71a8bd1aa8d1033cb@www.dscho.org>
	 <20150415153317.GA21768@tsaunders-iceball.corp.tor1.mozilla.com>
	 <31749ad9ba57ada7f9c553191ffaddb3@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Trevor Saunders <tbsaunde@tbsaunde.org>,
	Pirate Praveen <praveen@debian.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, git-owner@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 15 21:25:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiSwc-00037V-Um
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 21:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbbDOTZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 15:25:50 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36208 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932598AbbDOTZs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 15:25:48 -0400
Received: by wgsk9 with SMTP id k9so57635213wgs.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2015 12:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=mWuZIU1jWM7/a3n//YKYnwMWTrQ1nBO9L6fdDKAU7xk=;
        b=CoNpxU/9qNOKjF4MFFTUmm/xy9NP0UigbzovMsUgfSZnosCEZoR9PxdjfRFaC+J/w5
         GBEBUlMqblyV9TP5/q/dymHvmHYE/tJyG3bCyOfbsZbYozgvV2f23S3gtaLgtQ/nBQ9N
         kg6oHz5POP15UHFOcLzAkJFfF4+HEqZtsDmyFpZekX7T37u0dkS0SaajhDInbLb4QdgC
         DPokYDnfF8Gpqqflv4kl/3U5pT9KsfXEJBqe7pDaNIPxewkLUwGJjLhXR0Q3Y9gXP9wB
         G6oASgAprCd57MBbQQf/FbWmspwTt4hHEO8hK/qEyvRVfP5e0/zF/zLUoA2CQEGRXvq8
         +Bkg==
X-Gm-Message-State: ALoCoQmCcebH29G97tYNHRDRCRhjdrRoxDtMdGLHAe5D6yO/+YCH7ZqoUES1nvJNTQS13DnDhtCK
X-Received: by 10.194.59.199 with SMTP id b7mr53265400wjr.26.1429125947691;
        Wed, 15 Apr 2015 12:25:47 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net (82-171-80-33.ip.telfort.nl. [82.171.80.33])
        by mx.google.com with ESMTPSA id xy2sm7235981wjc.14.2015.04.15.12.25.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2015 12:25:46 -0700 (PDT)
In-Reply-To: <31749ad9ba57ada7f9c553191ffaddb3@www.dscho.org>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267232>

On wo, 2015-04-15 at 19:46 +0200, Johannes Schindelin wrote:
> On 2015-04-15 17:33, Trevor Saunders wrote:

> > but it certainly does support ssh <host> <command>
> > and then doing IO.
> 
Yes, in interactive sessions. mosh synchronizes terminal state, it
doesn't allow random I/O between client and server.

> Ah, so mosh's README lied to me!
> 
> If `mosh <user>@<host> <command>` works, then a simple `GIT_SSH=mosh`
> should work out of the box, too. Have you tried it?

It does not and cannot work. The way mosh works, is that it uses ssh to
log in and launch a mosh-server daemon. This daemon and the mosh client
then communicate via a custom UDP protocol. The SSH connection is closed
after the mosh-server has been launched as it is no longer needed.

The communication between the mosh client and server synchronizes
terminal state, somewhat like what screen/tmux do.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
