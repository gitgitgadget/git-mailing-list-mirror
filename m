From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] builtin/receive-pack.c: use parse_options API
Date: Tue, 1 Mar 2016 13:54:13 -0500
Message-ID: <CAPig+cSSUJkkGKsfDdX7i7fdTkvGd3ppL1tdsqdB7d0hjwdOuQ@mail.gmail.com>
References: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
	<vpq60x62jvt.fsf@anie.imag.fr>
	<56D5D601.8030601@gmail.com>
	<vpqio1613p1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sidhant Sharma <tigerkid001@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 01 19:54:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aapR6-0006BZ-Kb
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 19:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbcCASyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 13:54:15 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34171 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbcCASyO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 13:54:14 -0500
Received: by mail-vk0-f41.google.com with SMTP id e185so177498876vkb.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 10:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=WXutdpWk34MyYTmuUhEiXp8uXBgjw4tJEWLJS51JvDA=;
        b=CVHE3Js9z3hfpLJfQYZpekBGeQyi6jpCySLI48SDDw29AhjjGKW4Fo4Qn2GZwvk9Kn
         WTa+HfdkvAbQGPqbF3AOTLpDpmyZYoOuACH/aVWc4qnjX5pUuPDNid8WYMVE1+sQ5xQc
         MNoOPfWrDh1kXdE2QWZ1CbbxicFZm63wkdyDDd0/RVEascBRwjjM4i745ptf8rmxP+Ko
         DV6kb40eptObxTPXS0HSLiJ2B1BLqVOX2GFWYeWEf9tUukyEyr1pRQVykLlWbEsYPt6w
         i+7HlzWhJyjf1KP+zFEChifSwNtEpfUoUY/kPpI7W8/kXDeyKnDEj5b0FQHkGE5WCmQt
         rx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=WXutdpWk34MyYTmuUhEiXp8uXBgjw4tJEWLJS51JvDA=;
        b=WHyu3ikyNNHdAA4k8OcPY7W36aLI+G8UAXKX+DXvceCmHiic0ULI3e2xTfYyWU+Xvr
         Te8ZHuOdw+/3E2ELJ68kbzfnSmVjvKNSp8SUtys92RTdv6QS8DnuEuxfAmVJ5AkbMNu/
         4x1UcOdn8gyvt2jnODpeJ6rW1Bs/EQaVYmpAUjr41W/n5AJYbZWFDGbKrFoaAZ3wPw+y
         +sNlY1Z1UYE9mykOHzcjUlyvyqbFqENR/uAMdXP9xvMAprBzefWtzzxgcQvhYWXbUatO
         3sqxzWUoBFHFHOAAM/lcHlJcKHHaI1cofHaaOt67EYoMOJEwLbOHrorDe+fPkuv70LSk
         cbcA==
X-Gm-Message-State: AD7BkJJVtvv4BBb4KUEcrXg8OxPS0AhF9JNEa/4QBLe8cLbHbD89XQOtAvl5i9xRdME2EE9ZggHgfe2ZTxqeNw==
X-Received: by 10.31.8.142 with SMTP id 136mr17290156vki.14.1456858453737;
 Tue, 01 Mar 2016 10:54:13 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 1 Mar 2016 10:54:13 -0800 (PST)
In-Reply-To: <vpqio1613p1.fsf@anie.imag.fr>
X-Google-Sender-Auth: 3ZG8ghhxN9l57YqX0tjMV_MtJR4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288052>

On Tue, Mar 1, 2016 at 12:57 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Sidhant Sharma <tigerkid001@gmail.com> writes:
>> Another thing I'd like to ask is when I prepare the next patch, should
>> it be sent as reply in this thread, or as a new thread?
>
> No strict rule on that, but I usually use --in-reply-to on the root of
> the thread for previous iteration. If you don't, include a link (e.g.
> gmane) to the previous iteration in the cover-letter.

It's good manners to include a link to the previous version even if
you do use --in-reply-to since not all reviewers will have the
previous thread in their mailbox.
