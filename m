From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cmd_struct
Date: Wed, 13 May 2015 16:31:46 -0700
Message-ID: <xmqq617w9hr1.fsf@gitster.dls.corp.google.com>
References: <CACnwZYe5i3p0f7cvprya=VdhFnnMW_H=K18BFqjq_Qn86cjXeA@mail.gmail.com>
	<CAPc5daUF1SaCOqb0iEZ527q-CgQn3YyMSWufOsQx9Lo1+aUBrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 01:31:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysg81-00075J-Ew
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 01:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbbEMXbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 19:31:49 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33629 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbbEMXbs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 19:31:48 -0400
Received: by igbpi8 with SMTP id pi8so2560590igb.0
        for <git@vger.kernel.org>; Wed, 13 May 2015 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=AbAo76PQBTSBaLhNDlAxh38BsLEBRYgLtYjIh82Qgnk=;
        b=QQnnSai/b2tVFUxwSFgFgZ06VygAzhQJfyWXxt0/pfly7pWXJJ4yAXF2i+UWFB0+sQ
         goz97nYD/3ZF/ZwouRVnMjX1yc2HW2lv/J919oIz8piXi7+o/dRgKE2gV/TqABReIPVT
         Hha4SfaqSMKUByU6ySmwA7Gpf0+wYEjkuzFS3PwM3aPGKquOBOGt9xpztbrxnSDCbjBx
         bCA8YpQuoAvvkrt3a+TvnFlA2MBfB640qyqYlplicbtWK5l5ps3AReJf5Ka+06Hqlaqz
         kT4hgUp//SvDicaqwsWoaD53Igv4HH9pxrgszSukcsbzlbLfFhw5lNxNNSfZhfp5g/IZ
         ifxQ==
X-Received: by 10.50.13.10 with SMTP id d10mr2261978igc.20.1431559907873;
        Wed, 13 May 2015 16:31:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id y18sm15316001ioi.18.2015.05.13.16.31.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 May 2015 16:31:47 -0700 (PDT)
In-Reply-To: <CAPc5daUF1SaCOqb0iEZ527q-CgQn3YyMSWufOsQx9Lo1+aUBrg@mail.gmail.com>
	(Junio C. Hamano's message of "Wed, 13 May 2015 16:24:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269019>

Junio C Hamano <gitster@pobox.com> writes:

> On Wed, May 13, 2015 at 4:10 PM, Thiago Farina <tfransosi@gmail.com> wrote:
>>
>> Would be too churn/noise (at this point) to rename cmd_struct to builtin_cmd?
>
> The name has served us well, I do not see a compelling reason to change it
> to anything else, and I suspect the name stayed unchanged because nobody
> else found such a reason, either.
>
> So... if you are unwilling to make a compelling case telling us why the current
> name does not work, I do not think it is likely that anybody finds such a change
> necessary, welcome, or even tolerable.

Having said that, I would agree that if I were writing git.c from
scratch today, I would have done

	static struct builtin_cmd builtin_cmd[] = { ...

insead of the current

	static struct cmd_struct commands[] = { ...

just because I think it makes more sense.  But that reason suggests
it is a mere code churn of no value, after all these years.

"Because the non-POSIX non-ANSI-C platform I am porting for stomps
on the end-user program's namespace, and cmd_struct is one of the
victims" could be a reason that is better than "just because I think
it makes more sense", but even then, there would probably be a
better ways other than renaming the symbols in end-user code
(i.e. Git) to solve such a name clash.
