From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Make 'git request-pull' more strict about matching
 local/remote branches
Date: Wed, 22 Jan 2014 14:07:58 -0800
Message-ID: <CA+55aFwhrfbxVZDjf8mcaTOXqGEjjirTq_S-8N2H60VcVP7P6w@mail.gmail.com>
References: <alpine.LFD.2.11.1401221243090.18459@i7.linux-foundation.org>
	<xmqq1tzzy9ip.fsf@gitster.dls.corp.google.com>
	<CA+55aFxSiKhM=4GtFaruWNZFNaUgCpVHsJOWJ9Qcd19nz6YYTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 23:08:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W65xr-0007FX-DB
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 23:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbaAVWH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 17:07:59 -0500
Received: from mail-ve0-f177.google.com ([209.85.128.177]:45249 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbaAVWH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 17:07:59 -0500
Received: by mail-ve0-f177.google.com with SMTP id jz11so615057veb.8
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 14:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6hTt/nk5lHCHlKbE+eVd3kczbdoE+6BytOvY6f0V0ak=;
        b=Btrfg56N8/dLBczSXbwaR5uDSAsBsPKjHXChyr1Elza6Z9MtJB3E/psK1Ob7fMJ+E7
         5AzfzR7v11yhJ77LGTXXj5CuOuDnLbaQHnc/uOOPlhMCwb4ozB/aNh3H2Tc9/bhpcOnY
         T0/Gr9aEK2E+vPhvpRdFFtq4evsEehhj0VY6weOKbzK2PrPSqrKXHUc2WRD9zzfEdq73
         1xauEsHiDd3Rodm5oHX9xZ8oecpDV0pV0hrgBCgBhrHQ4W1KWt8eIpYT0xvSjhJXq2F8
         W54WAcvZVMPBlctS+YkZRPvxC1Y9Viekglo3U0LXfEn3Sr2fCvwSlM9uuuKPKyJjFKhr
         kqeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6hTt/nk5lHCHlKbE+eVd3kczbdoE+6BytOvY6f0V0ak=;
        b=O2TbMGshdJmoGyCsi4XeZnhKPqhvroL2kCxIpVB2j/6jI2qVIBPJL+B/sQ34j0wGgy
         Nni6C5RJqIm+Ibnd27B38rzoQlruF+mlY/TmV+EBPeXAcKso2s2JZzmAvz/5zWTGPq2x
         oj5IYSdSj50OU9x87djuQcUpgtGtLozWsQPQg=
X-Received: by 10.58.255.233 with SMTP id at9mr2670935ved.20.1390428478544;
 Wed, 22 Jan 2014 14:07:58 -0800 (PST)
Received: by 10.221.8.73 with HTTP; Wed, 22 Jan 2014 14:07:58 -0800 (PST)
In-Reply-To: <CA+55aFxSiKhM=4GtFaruWNZFNaUgCpVHsJOWJ9Qcd19nz6YYTw@mail.gmail.com>
X-Google-Sender-Auth: kJTjIAbesZTuLgbUUcPy6RfGZE0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240866>

On Wed, Jan 22, 2014 at 2:03 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Any ideas? The hacky way is to do "| head -1" to take the first
> show-ref output, and then check if you get a different result if you
> re-do it using "show-ref --tags". But that sounds really excessively
> hacky. Is there a good way to do it?

Using "git show-refs --tags --heads" would work for the common case
(since that ignores remote branches), but would then disallow remote
branches entirely.

That might be ok in practice, but it's definitely wrong too.

I'm probably missing some obvious solution.

                    Linus
