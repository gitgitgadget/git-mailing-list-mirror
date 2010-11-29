From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Make the tab width used for whitespace checks
 configurable
Date: Mon, 29 Nov 2010 11:16:29 -0600
Message-ID: <20101129171629.GM8037@burratino>
References: <4CF366B1.8070400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 29 18:16:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN7LJ-0004OO-PL
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 18:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396Ab0K2RQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 12:16:40 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60125 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab0K2RQk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 12:16:40 -0500
Received: by fxm8 with SMTP id 8so299619fxm.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 09:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FS0DDlttx/mKyrkOtdkfHbmJfhUzX9oVxxney3o4Dmo=;
        b=pFgnVmjK2zkPzHrKee5X9AaM5djWH7iPti90SL0zkc+98cploUyYu+ABaKc27tIESG
         cyMv+AlwldbJiE856B2EAoF1dL/ZD/GOPsfsoZW3jpgHJtrPYcHPu8c3+ExkAr57M2wf
         H3bhQCoSAvkh8xqT/xhQKgFhI6vZePWkZY2XM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BT2lhyJKsorR1WK4AGQhtR8h22hkOT1QGsOawn3NDec0FDkMV66qfa3aWOWPgtreal
         z5M6cVWcnoTnCaTdiVKfBxrcqxaW6ESGEdcnfoWSJmr/NFs9kvQXaJAvaDD1K+modsUa
         tAjCFgz0X3QwFm8MpbacrN1GghcsndNZzrovE=
Received: by 10.223.71.207 with SMTP id i15mr3585866faj.9.1291050997827;
        Mon, 29 Nov 2010 09:16:37 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id n6sm1289269faa.28.2010.11.29.09.16.35
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 09:16:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CF366B1.8070400@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162406>

Johannes Sixt wrote:

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  I have a project that uses tab width 4, and which has a lot of whitespace
>  errors. This is very helpful to spot them when lines are changed that
>  are indented with 4 spaces.

Thanks.

For what it's worth, I like the idea and the patch looks good.
(I haven't checked for missed spots or read the test in detail,
though.)

> +                       if (0 < tabwidth && tabwidth < 0100)
> +                               rule &= ~WS_TAB_WIDTH_MASK, rule |= tabwidth;

Tab widths are recognized with atoi and out-of-range tab widths are
silently ignored.  Could we help the user spot typos somehow?
