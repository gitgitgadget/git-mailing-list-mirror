From: Stefan Beller <sbeller@google.com>
Subject: Re: Segfault in the attr stack
Date: Thu, 2 Jun 2016 09:56:42 -0700
Message-ID: <CAGZ79ka7sXKwOdY4_WK15c3HHOp2pRtcUgeZ6rDAt8hSvcx1=Q@mail.gmail.com>
References: <CAGZ79ka_4vZfNhgOyMeFKdossO-S5Q7RVnvEzB8YAJNc1YQ+uQ@mail.gmail.com>
 <CAGZ79kbSKgS42nAShsK3JV78geam3k84=ipWRx7vbRODuHcmcA@mail.gmail.com>
 <CAPc5daXuQAeWvJAciRA_Kzyoxa=atEntGzKhqzjiN+ho6TnQyg@mail.gmail.com>
 <xmqqh9dcwmrr.fsf@gitster.mtv.corp.google.com> <xmqq8tyowias.fsf@gitster.mtv.corp.google.com>
 <xmqqshwvvaxq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 18:56:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8VvM-0000ZU-9K
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 18:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161105AbcFBQ4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 12:56:44 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33678 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbcFBQ4o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 12:56:44 -0400
Received: by mail-qg0-f41.google.com with SMTP id 52so61658288qgy.0
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fcI6WURebvk/Ib2BJVwKWckLYtHsyIqkbg2kbbbDjEY=;
        b=pfLFxzI+E8qOAgdPVXoHQUh43wz4/OWATwVH8h5dxa+uWdRJld5w7Ribvx3TecPGxr
         8wew7WSL+gcAChQdxc0IEs/iYUfyXGKuTYm9vc7iRzZQPo3E/YI/8AQV+4+QYElIRjR5
         2QB+d30qDhJm0oRdsEhS4NFHuNz/7DS2DJTNUJjRO0GPov67J1ft1oLnZmmV1SldlgLo
         zDSgDn5tHCgEt1TcFKO3kds3dIkSbBH/VrckgZ5gsInJ35raT7hBaSPUxN2vjQ9Es86C
         LYpLNG2jJfTpBemCAROFTcgF5x5w88VlLcM6GU1tLTWxgBbFIh87xtsY5+fK22H/m9yh
         xdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fcI6WURebvk/Ib2BJVwKWckLYtHsyIqkbg2kbbbDjEY=;
        b=hYXlN/mGf60dP2P7gyFbaDFe6zbGpKGp08N//nsaaXEEWfi38f2H74DglACTfmfP4F
         Djv2y8zHe/EsP/JFc5eKaXk63HjZAMzFbkkz/81rt3gk/UwW1swFBXotoQMnzBOMNttJ
         rWSG1/Cl+nvfGV8YUs7aLnyaa61Ifz/GoA/FUn0W9La+dgDYeUBwBgfW176Mg9r4FaYK
         jcmSRUewmWHThH7Meun3EwBBtnqhJHi4B8luaCfDISa/0dhBuDBAxaa07o4pQO9yAeQ4
         10J81zTJCgkMcrfSBn9fT7sH6sfiQaK+3tymMLlsBo4pRd60WCA+zRV17iBp99IHieiE
         WJnA==
X-Gm-Message-State: ALyK8tJtsUeNjnhjgFAP4wpjKBg7FRDsWHHWgHOqSMZtx/6tsVigKcUUWAkpFea6E/OUkbqGbkw357rH8R6PD86q
X-Received: by 10.140.23.180 with SMTP id 49mr43260591qgp.9.1464886602791;
 Thu, 02 Jun 2016 09:56:42 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Thu, 2 Jun 2016 09:56:42 -0700 (PDT)
In-Reply-To: <xmqqshwvvaxq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296215>

On Thu, Jun 2, 2016 at 8:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>>> Gaah, of course.
>>>>
>>>> This is coming from the cache preload codepath, where multiple threads
>>>> try to run ce_path_match().
>>>> It used to be OK because pathspec magic never looked at attributes,
>>>> but now it does, and attribute system is not thread-safe.
>
> I'll look into teaching a threadble interface to the attribute
> subsystem, but for now, this should get you unstuck, I think.

Thanks for looking into this!
(I was about to do that if you would not have stepped up, as the bug
only surfaces when using the pathspec labels.)

>
> +       /* Do not preload when pathspec uses non-threadable subsystems */
> +       if (pathspec && pathspec_is_non_threadable(pathspec))
> +               return; /* for now ... */

This fixes the problem for now; I'll look into the comma escaping then.

Thanks,
Stefan
