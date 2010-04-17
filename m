From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [BUG] Git add <device file> silently fails
Date: Sat, 17 Apr 2010 19:32:22 +0200
Message-ID: <n2i81b0412b1004171032v713f156ase295cbe7bbedf1f6@mail.gmail.com>
References: <201004171624.17797.agruen@suse.de>
	 <u2s81b0412b1004170744u4cc3c0e1z6d7019fe405a67ec@mail.gmail.com>
	 <7v4oja3uh7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 19:32:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Bsc-0006rl-Vn
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 19:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab0DQRcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 13:32:25 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48495 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab0DQRcY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 13:32:24 -0400
Received: by gwaa18 with SMTP id a18so1903102gwa.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 10:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=o1N7NSbcr703K3O1iQOzrvPwv4ImaIi3IXOSOMqBiTU=;
        b=YIb7mR75OnI2AK4B5C1u3oYkIP+uR2Rs+IL+7oi+57xGBqzsDNvqJveuyB0TWdsJeB
         kzwp+wUUlQQpmfZdQ0Ra5xCFaRjrfjgJnsbDiDdFSVkGWrcG4DzNHSiVh9ZyxuXt2TVd
         7Iiu60EM18JtMhel7w4AMEN9ExSjAqt9QPg2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=FYLjl0OFYtMjlFSrBiapWgswXDzvhFgEnnL8TWsgp9MQfiH/OHy1+YN3GG3xodiMkW
         6VGcAZJxjEMJQRi1g5Oqk5R5A4Bnn0kTAsjf3Hra9EcL2u2s7Fi+iK1d5PGiBcBeN064
         pEeYVL5C5abMS1ggPI9YRo6tnM5hqQ2KYR5f0=
Received: by 10.100.212.9 with HTTP; Sat, 17 Apr 2010 10:32:22 -0700 (PDT)
In-Reply-To: <7v4oja3uh7.fsf@alter.siamese.dyndns.org>
Received: by 10.101.210.6 with SMTP id m6mr7147299anq.207.1271525542993; Sat, 
	17 Apr 2010 10:32:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145161>

On Sat, Apr 17, 2010 at 18:38, Junio C Hamano <gitster@pobox.com> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> I think something like this should make the accident more
>> noticable:
>
> The early skippage done in dir.c (read-directory-recursive) should treat
> these as ignored just like paths that are ignored with .gitignore
> mechanism, and if we do so, we shouldn't need this patch to add another
> codepath to give notification to the user (we would however still need
> to reword "'add -f' if you really want to add it", though).
>

I see. Special files are not treated as ignored yet (and there will be
no way to un-ignore them). I have to read the code for a while,
ignored pathnames are sometimes stored for later use too.
