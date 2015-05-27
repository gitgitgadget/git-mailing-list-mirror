From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/2] git rebase -i: Warn removed or dupplicated commits
Date: Wed, 27 May 2015 12:20:05 -0700
Message-ID: <xmqqwpztltei.fsf@gitster.dls.corp.google.com>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1432676318-22852-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<loom.20150527T105315-517@post.gmane.org>
	<vpqy4ka5jyp.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Kelly <steveire@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 27 21:20:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxgsG-0002xN-3I
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 21:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbbE0TUN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2015 15:20:13 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33770 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbbE0TUI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 15:20:08 -0400
Received: by iebgx4 with SMTP id gx4so21509870ieb.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 12:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=oBKdZeCE6d8LL4W8o//N7XwXTZb4JWa0u9LXz+bCZBo=;
        b=FYBvfha/iI3WToE2So9tsMyiCuEy/9RQXvIpoO7lLF2b4KRg42fNWQpED7hzuycgM+
         zZrJ3CSZlfu6xGpKICrDson/kvGGTJZ2lMHZJMPJHR/R43VUyDs0gAn1H0xi3EiC6Ey3
         MDvlawlazHxY3zjYhmNkJqMdLpTWc/7qQnkEqdYn7B5GX5XR2O896ZYmc6haPBEQ+iZU
         U645b8LfmTSe4RRsxwnO0+OLTDlzA1a5KcOJlw6zNzcBPoBzXexCdbMDOnJLgJRA/O/8
         ykU+F1oOYGdd7zgAFGSTDDTrS2bOb09FCl6xon9nLcaWi2e5+6pe/M906z6eAvaLv2Sx
         FSTQ==
X-Received: by 10.43.125.200 with SMTP id gt8mr5395530icc.90.1432754407100;
        Wed, 27 May 2015 12:20:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id d4sm2481452igl.1.2015.05.27.12.20.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 12:20:06 -0700 (PDT)
In-Reply-To: <vpqy4ka5jyp.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	27 May 2015 13:38:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270069>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Stephen Kelly <steveire@gmail.com> writes:
>
>> Galan R=C3=A9mi <remi.galan-alfonso <at> ensimag.grenoble-inp.fr> wr=
ites:
>>
>>>=20
>>> Check if commits were removed (i.e. a line was deleted) or dupplica=
ted
>>> (e.g. the same commit is picked twice), can print warnings or abort
>>> git rebase according to the value of the configuration variable
>>> rebase.checkLevel.
>>
>> I sometimes duplicate commits deliberately if I want to split a comm=
it in
>> two. I move a copy up and fix the conflict, and I know that I'll sti=
ll get
>> the right thing later even if I make a mistake with the conflict
>> resolution.
>
> The more I think about it, the more I think we should either not warn=
 at
> all on duplicate commits, or have a separate config variable.

Yeah, I'd say we shouldn't warn, without configuration to keep
things simple.

>
> It's rare to duplicate by mistake, and when you do so, it's already e=
asy
> to notice: you get conflicts, and you can git rebase --skip the secon=
d
> occurence. Accidentally dropped commits are another story: it's rathe=
r
> easy to cut-and-forget-to-paste, and the consequence currently is sil=
ent
> data loss ...
