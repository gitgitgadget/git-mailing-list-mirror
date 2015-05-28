From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2] create a skeleton for the command git rebase --status
Date: Thu, 28 May 2015 12:50:58 -0700
Message-ID: <xmqq382gh465.fsf@gitster.dls.corp.google.com>
References: <1432822837-10320-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<CACRoPnRa1wrOJr=wGnR4NayZfe2yJ4F7Abv_sjqRpgQnicxm1g@mail.gmail.com>
	<1141577560.115469.1432827789020.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqiobcy9yt.fsf@anie.imag.fr>
	<xmqqtwuwh8fv.fsf@gitster.dls.corp.google.com>
	<vpqlhg8pk1o.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 21:51:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy3ph-00026j-NR
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 21:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbbE1TvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 15:51:06 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:32922 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657AbbE1TvA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 15:51:00 -0400
Received: by igbpi8 with SMTP id pi8so1464871igb.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 12:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IpuuvtH4OsUY59dsT1GfjFib2+KehmYsZsaB7iI6PBU=;
        b=p7jhIqoCvE2fpYDvdJEi1VLTHkgEgLVHyxdVp0aEE3X36JSLD51ZW7P08AdkP9mpFI
         Fjv991eTJ9BBN8RpA91W/r1FPGx6m/P81CnBpV5D1ExvG09cE9jW06lXRzvruhL9Crmd
         cY7WMXoai0MXsRirAjDoELFNfdzF6d9+HtFxhSSf3KCuUNCCGfDaXyrhoFEROAyqgPhY
         7yDE+RX49QIQyhWNW6IMIsKGNRAIz3egvUfKXZOJX3yXhmE/kez1U6dfgpqvp00DbmeC
         9C6QkVaevNZdyXNzzkOi+yXGzSY1+yuBpt/c9RnQVBXpv7sx/vxdXB/PKkf5xMZ+dx/i
         yQsw==
X-Received: by 10.50.138.74 with SMTP id qo10mr13518364igb.39.1432842660034;
        Thu, 28 May 2015 12:51:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id z195sm2481883iod.33.2015.05.28.12.50.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 12:50:59 -0700 (PDT)
In-Reply-To: <vpqlhg8pk1o.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	28 May 2015 21:40:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270187>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> If this topic enhances 'git status' with the in-progress rebase
>> information, I'd view it as turning 'git status' from 'a more or
>> less useless command during rebase' to 'a useful command'.
>
> For day-to-day operations, what we already have in status already
> qualifies as 'useful command' to me:
>
> $ git status
> rebase in progress; onto 7f9a792
> You are currently rebasing branch 'master' on '7f9a792'.
>   (fix conflicts and then run "git rebase --continue")
>   (use "git rebase --skip" to skip this patch)
>   (use "git rebase --abort" to check out the original branch)

Not really.  How would you decide if 7f9a792 is worth keeping or
rebase is better be aborted without knowing where you are?

> I like the output of "git status" to be concise.

Sure, as long as concise and useful, I am all for it.  The above
however does not show anything I already know in my prompt.  I would
say no thanks to "concise and useless".

> OTOH, there are tons of information in .git/rebase-merge/ that
> could be displayed to the user.

Surely, that is why "git status" during a rebase should show them.
