From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] send-email: allow multiple emails using --cc, --to and --bcc
Date: Tue, 02 Jun 2015 10:19:25 -0700
Message-ID: <xmqqbngy3u5e.fsf@gitster.dls.corp.google.com>
References: <1433168042-28269-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433168042-28269-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<xmqqiob78nij.fsf@gitster.dls.corp.google.com>
	<xmqqmw0j74mg.fsf@gitster.dls.corp.google.com>
	<CA+V2YBvP89=b5SFbkUVnEzaPT2aCiK9XN1Hd6qsN8HCmxxB+GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?utf-8?Q?R=C3=A9mi?= Lespinet <remi.lespinet@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 19:19:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzpqe-000470-TD
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 19:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbbFBRT3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2015 13:19:29 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33505 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbbFBRT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 13:19:28 -0400
Received: by iebgx4 with SMTP id gx4so137806297ieb.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 10:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=c5TO87atSMf94JH1q4PCL5clrbNXUnQFjQqZC7aRkrk=;
        b=uSDn8D0Vz7Edb+nT9ijH/oJj4kY9KmaZsxa6w9PkVzdwkQl9k3AWcGy7OdCPPbdqOZ
         ThAyxwwRrLtecbZG3G5Q4n268NDLmBpgSKTlUB4hxnPyriLJJKdaD/4sPit6s9F1ZKn5
         MSwq2VXghl5DoiGuKu0sZHgKEVsFcgcIF2qREevxXwlymLgRrOrW3p+HXgafWxmftbsM
         8n0C9xCl8uaXB60d3ptKarvdvUZeldbNj8qlaH+8IOS+No6i1/0+QHtM0MLNt84qmUek
         qt8tFaqctWgdS8jK/87b9m5GMX2i6k/uBcch/GfZocjL1IvD646ECX9tULxmDPH3JTJa
         gFUQ==
X-Received: by 10.107.167.73 with SMTP id q70mr1707202ioe.82.1433265567562;
        Tue, 02 Jun 2015 10:19:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f9ca:66ee:8cb4:7220])
        by mx.google.com with ESMTPSA id j5sm11165183ioo.8.2015.06.02.10.19.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 10:19:26 -0700 (PDT)
In-Reply-To: <CA+V2YBvP89=b5SFbkUVnEzaPT2aCiK9XN1Hd6qsN8HCmxxB+GA@mail.gmail.com>
	(=?utf-8?Q?=22R=C3=A9mi?= Lespinet"'s message of "Tue, 2 Jun 2015 10:26:11
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270566>

R=C3=A9mi Lespinet <remi.lespinet@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The reason why we have the "verify the input" thing, allow users to
>> supply multiple --to/--cc/etc., and do not try to split the
>> addresses ourselves is because we want to avoid mistakenly splitting
>> a single address like the above into two and producing syntactically
>> incorrect addresses.  People have relied on the current behaviour
>> for a long time, without manually dropping comma when they send
>> their patches with --to=3D'"Jane, Doe" <jdoe@example.com>'.
>
> Yes, but they couldn't send with --to=3D'"Jane, Doe" <jdoe@example.co=
m>'
> anyway since 79ee555b (Check and document the options to prevent
> mistakes. 2006-06-21).  So I don't think that this part is a
> regression.

Ahh, stupid me.  Thanks.

Then starting with the "split at the comma" implementation is
perfectly fine.  People will learn not to use '"Doe, Jane" <jdoe>'
because that will not work while the implementation is limited, and
later when it is enhanced, they can start using that form.
