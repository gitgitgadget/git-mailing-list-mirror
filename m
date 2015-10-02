From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/9] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date: Fri, 02 Oct 2015 13:54:05 -0700
Message-ID: <xmqqlhbl3sb6.fsf@gitster.mtv.corp.google.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 22:54:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi7LJ-00037W-Qu
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 22:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbbJBUyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 16:54:09 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36118 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbbJBUyH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 16:54:07 -0400
Received: by pablk4 with SMTP id lk4so115199184pab.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 13:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qmtSmRuwwxxmjrf/2IwzMt6FFF2mIX0k5P0gF8JqNJc=;
        b=EJ8U+8vG8bOiUR6Ttctztc24118YepA/ZSv49plfFKleDEEC0bla6XXBCLvGT2Xvjt
         xPjXIrgnUBI464f9fUxEyGUHudriYcNAVOFlzu28kqfw1reD/kAEk1nqluL0yjaV+SQ8
         nvkm5XeimdpGTlgVmo9FXohCB81ZaZlEiEM1QPhUarLnBLX9szrympnl81GtVnN2vM5r
         Iw3vpy3dmKAqctZH3kBJ0wyfXncYU8GJMJYjHhS1nUrPe0Kdga7gnXOlS8yoLqwKcoCn
         pKSktDx6nj7XjlYKSkQK5jGL+8E/teaABsi/bS0okfRgbvXOtffoXplFtqv5jLHid74q
         GCjA==
X-Received: by 10.68.143.4 with SMTP id sa4mr22315298pbb.111.1443819246562;
        Fri, 02 Oct 2015 13:54:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:5831:5c0e:ce5f:86ea])
        by smtp.gmail.com with ESMTPSA id cs5sm13618390pbc.15.2015.10.02.13.54.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 Oct 2015 13:54:05 -0700 (PDT)
In-Reply-To: <1443807546-5985-3-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Fri, 2 Oct 2015 23:08:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278947>

Karthik Nayak <karthik.188@gmail.com> writes:

> Implement %(if:equals=<string>) wherein the if condition is only
> satisfied if the value obtained between the %(if:...) and %(then) atom
> is the same as the given '<string>'.
>
> Similarly, implement (if:notequals=<string>) wherein the if condition
> is only satisfied if the value obtained between the %(if:...) and
> %(then) atom is differnt from the given '<string>'.
>
> Add tests and Documentation for the same.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---

The fast that the patch touches only the narrow parts that are
specific to %(if),%(then) and %(else) and does not have to touch any
generic part (other than the populate_value() parser for obvious
reasons) is a good signal that tells us that the basic structure of
the code is very sound.  I very much like the direction in which
this series is going ;-)
