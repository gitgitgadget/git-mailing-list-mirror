From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 00/17] Port branch.c to use ref-filter's printing options
Date: Tue, 17 May 2016 13:34:13 +0530
Message-ID: <CAOLa=ZQ5nUazL61eqj34-v06rueyjzvvJHzp8du7HHGi5=7TMA@mail.gmail.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com> <xmqq4m9x1wl2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue May 17 10:04:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Zzr-0002f2-Up
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 10:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065AbcEQIEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 04:04:51 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33411 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036AbcEQIEn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 04:04:43 -0400
Received: by mail-qk0-f196.google.com with SMTP id q184so742393qkf.0
        for <git@vger.kernel.org>; Tue, 17 May 2016 01:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:cc;
        bh=KQ/sug+r0WlbtYTM859pID3n9XAQdRdD52y7C4OcO2s=;
        b=DZ4dKc2f4QJUV/1Jc4I2P35jCL2f9N8vpUEBDZKl3zlyiPTOb7wK6SvZRBOwy/3no4
         SEPwdxtc5+e8LB00IJn2qHtPElyHL8p0tWmY1V0+cmoQmtrnOoKdWG2q0f4cVt7i4vYZ
         kJAwSFH4SdiFdP13bs1KWZq/uXlL5iXfQDyiC7LDzIhBTgqnVuCIk2LPz0TBJmbsUx//
         86DYxjPerTM2ovqXx5/KPLjXSyrnpm3gOKy/yfflZpOM4Qlr8GwsbWHfYhN7HZFoIi9k
         2Th1rlou24CY2rHxM+IRqbzme8Dw2iNhR4LzIENeo1uRRnyhFDD9HeoP/+amL0lNkqzm
         L7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:cc;
        bh=KQ/sug+r0WlbtYTM859pID3n9XAQdRdD52y7C4OcO2s=;
        b=k+Jv6n4jpWlOKuARZs9XobpKE1rOXp+IWMJkpmPYcu37CteShGMQhJ1xarN7j61X0C
         UcOGUKO0Ngn05b7rZ/L0xhXrJgzoS1t8exjKvyCPszD7o7T84nC48QD+Bb4Dd5he+iYD
         u7PcWPfM0U0eNJve+yZsuTSPKUzYXqhDcLgNN8kXLJNIurrWGp0UbEPO5q/0jyjaRZJA
         OEY5qcsK4UoRoyGBIY6KhUSNfCYdAQy9XBgJMW2YXYXo5M70m610hL9bKNPZfhxPswLX
         S2jPGuUh1XcyJqcayykwZ0eZYX0jL7vxqgQkN9DXpVnTQUlT/H4heMUcUXX6NR3KWNnc
         7b2w==
X-Gm-Message-State: AOPr4FXzc4tawrpUFkoh0EXIrkAChSHmVkRqTn0iWEMP/5Q2Girj0OCmjqNTkPYF+aI6HdpfhUe2c9YH/dBVFg==
X-Received: by 10.55.74.14 with SMTP id x14mr36613489qka.70.1463472282759;
 Tue, 17 May 2016 01:04:42 -0700 (PDT)
Received: by 10.140.92.178 with HTTP; Tue, 17 May 2016 01:04:13 -0700 (PDT)
In-Reply-To: <xmqq4m9x1wl2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294858>

On Tue, May 17, 2016 at 3:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > This is part of unification of the commands 'git tag -l, git branch -l
> > and git for-each-ref'. This ports over branch.c to use ref-filter's
> > printing options.
> >
> > Initially posted here: $(gmane/279226). It was decided that this series
> > would follow up after refactoring ref-filter parsing mechanism, which
> > is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).
>
> 9606218b?
>

I believe it should be 50cd83dca100174ba95baa9f6ed8426bce731ac2

>
> > Changes in this version:
> >
> > 1. Rebased on top of f307218 (t6302: simplify non-gpg cases).
>
>
>   $ git checkout f307218
>   $ git am 0001-ref-filter-implement-if.txt
>   Applying: ref-filter: implement %(if), %(then), and %(else) atoms
>   error: patch failed: Documentation/git-for-each-ref.txt:181
>   error: Documentation/git-for-each-ref.txt: patch does not apply
>   Patch failed at 0001 ref-filter: implement %(if), %(then), and %(else) atoms
>   The copy of the patch that failed is found in: .git/rebase-apply/patch
>   When you have resolved this problem, run "git am --continue".
>   If you prefer to skip this patch, run "git am --skip" instead.
>   To restore the original branch and stop patching, run "git am --abort".

Hello, sorry for the confusion, it's built on top of 'next' which contains
f307218 (t6302: simplify non-gpg cases). The merge conflict is due to the
commit made by you 1cca17df (Documentation: fix linkgit references).

--
Regards,
Karthik
