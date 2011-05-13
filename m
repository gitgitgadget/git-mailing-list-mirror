From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [BUG?] read_directory(), core.ignorecase and pathspec
Date: Fri, 13 May 2011 07:39:31 +0700
Message-ID: <BANLkTimZuzj0o57TOnp8ftnqXse=nRv8HQ@mail.gmail.com>
References: <BANLkTimqJvLoWGxMzeSs9n7LrrLaE-azwQ@mail.gmail.com> <7vwrhvdhwg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 02:44:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKgUe-0007bt-C0
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 02:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775Ab1EMAkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 20:40:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48664 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab1EMAkE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 20:40:04 -0400
Received: by bwz15 with SMTP id 15so1736309bwz.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 17:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=CAqpvAjlp1rSmpkB6ld6ju4eEfe5X9XctY7xsPvCcmY=;
        b=bgFty7Zp5tJLc3fHUBZxqVqRar34LihJHnFlvlhbVpnKlq6QidYJWBgFVoo+JWtOSz
         KdBHGkPL5yLkPWlc1vDtpBzYaA6TWxeaWuVGQdwrzKA7InMvlsHH50CH6vbpVQil0n2o
         FMONW3Z23Lfivxb8y3QCIXagfFEO8ThPkjDX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=bt7ZQMFq8P1FrR7DTsNpNcaF3NTPNJhBrFUtkbn19fIzHPTkBSlqO3PuAXLvnvX2ld
         MOy2dqh1c4nBSt1qFQ5qqjGKqLz1SSfH9BmTZxYdNzg7V+cdgw786Av5Hhho39DXYFZf
         paFigAZqTpl8MLFt5B8rqAhmIbZQf4E5mk/i8=
Received: by 10.204.35.206 with SMTP id q14mr748727bkd.128.1305247202127; Thu,
 12 May 2011 17:40:02 -0700 (PDT)
Received: by 10.204.53.13 with HTTP; Thu, 12 May 2011 17:39:31 -0700 (PDT)
In-Reply-To: <7vwrhvdhwg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173502>

On Thu, May 12, 2011 at 11:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> I was looking at how read_directory() uses pathspec, and it seems that
>> simplify_away(), the function that cuts out directories early if
>> they're definitely outside given pathspec, does exact match (ie.
>> memcmp) regardless core.ignorecase. This means "git add -- '*.c'" may
>> not work as expected when core.ignorecase is on.
>
> I don't think for '*.c' it would make any difference, but it is very
> plausible that 'frotz/*.c' will cull 'Frotz/anything' as "never going to
> match".

Right, it only checks prefix.

>> The whole simplifying thing in read_directory() will eventually be
>> replaced with real pathspec matching as we put more magic in pathspec.
>
> That should be done not "as" but "before". Get the foundation right before
> going fancier.
>

Right, again.
-- 
Duy
