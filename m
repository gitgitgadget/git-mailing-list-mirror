From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] stripspace: Implement --count-lines option
Date: Fri, 16 Oct 2015 10:35:49 -0700
Message-ID: <xmqq8u72g1hm.fsf@gitster.mtv.corp.google.com>
References: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
	<1444911524-14504-3-git-send-email-tklauser@distanz.ch>
	<xmqqoag0ggjh.fsf@gitster.mtv.corp.google.com>
	<20151016075134.GM11304@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 16 19:36:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn8v7-0002cW-1r
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 19:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344AbbJPRfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 13:35:52 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33031 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803AbbJPRfv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 13:35:51 -0400
Received: by pabrc13 with SMTP id rc13so126311641pab.0
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 10:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sJac3IMyIIiN8JteoRvxhfOVTVNP7AAeiTS6S93mLuU=;
        b=f9sIFKLqoOPEqQUFNCECsuRY9Y1POB6k5OpAYT5Z4Q91U3QqmT8J/ftMCAlJT/P2A6
         our94dnuor2qkmJHw2r37KpP8nRBoAL6IiPZcmnaVLwOQjBLQ/p4SJiBs6mammQ9Px0H
         tcHtg7EUWPZEyJ8UBeZcm8Kj3Yg/SJcNcWnQ/FEb2eueipp+qGVwPAayWR5OJ/euycDO
         qYkd0iEq8Gv/dMlKG5/z3e/YS5S6XZLBrjX0AOwRZ6AfCkVQbCVi9ahwjNxZRl/jmILq
         uAffdna1yveHVEtdRY+9UArltDD53qLFxYks6zw6AtZPkooYrnRbL+3QuL4AO2H6iWDU
         NU9w==
X-Received: by 10.67.4.9 with SMTP id ca9mr17747680pad.90.1445016950768;
        Fri, 16 Oct 2015 10:35:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:458e:bb5:8827:32a1])
        by smtp.gmail.com with ESMTPSA id dy8sm22483625pab.38.2015.10.16.10.35.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 10:35:50 -0700 (PDT)
In-Reply-To: <20151016075134.GM11304@distanz.ch> (Tobias Klauser's message of
	"Fri, 16 Oct 2015 09:51:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279758>

Tobias Klauser <tklauser@distanz.ch> writes:

>> So this is your output code, which gives only the number of lines
>> without the cleaned up result.
>
> This should better be a simple printf("%zu\n", lines) I guess?

I think we actively avoid using %z conversion that is only C99.

If you really want to, you could count in size_t and use %lu with
appropriate casting, which I think is what we do in the rest of the
codebase.

For this one, I think it is sufficient to just count in int and
print as int with %d, though.
