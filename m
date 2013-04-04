From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Thu, 4 Apr 2013 12:44:22 -0700
Message-ID: <CA+55aFw+2wgUufJn7BcXACBQqywAGBAcZWS6N_UV8UA91G447Q@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
	<CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
	<CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
	<CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
	<CALkWK0mQt7cE0zUECDF4ZC2-9Q+pEL=XGPdaOksyWzae2_W1CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:44:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNq5b-000692-Ou
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764715Ab3DDToY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:44:24 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:58222 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764631Ab3DDToX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:44:23 -0400
Received: by mail-vc0-f177.google.com with SMTP id ia10so2631514vcb.22
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 12:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ZvP33gEoMTeJiS5sIxtGlyldTLhe733fbMjPgLW/ahE=;
        b=L52zgOJIGj2Hy+8/ZMC6dsizrfl0fL1vjuUBBpq1QgSCqfxq8RAIB8U4Nc9SzfHK9d
         LdmF1HyXYp1zbcCs16/Hs9Kl8mf1P6CiiYMNXGon3wx8nC5/MbtK72kVsXz5Pr7Xgurk
         KVUYp8Y4gTMU1xlwCFDqJX5I1wc6ecSQzf2/3bx3v4Fh8AMlPT4Mqy+165kebqilQ8mR
         USPRRUrKM2TlAym34hjc0ia4ccBD0hfEMVxI8uwqGdVNTP3/9ldND6lWr8Bz9SuVxbGX
         qat1x1G6NhZtQeFgmmyTED2PiNgr4dDumWlw6uIBdZM4Q5BUV0JYKqIdmROguPYCnddY
         fMGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ZvP33gEoMTeJiS5sIxtGlyldTLhe733fbMjPgLW/ahE=;
        b=blvZWmDFPA7rP8Ry9cQ10YjRZVEHHZlpLiXOxsx9zKFEhqkmy8RJVftC3/5Lqj1/WT
         q7q2YRYjccFx9PwkE5D+95ODAMWn9gbG21UecyBwpctHNClLFHIAFM5TvWkHDLrwPIDc
         Weig4dTZ5QGwzMg4LhMB8Iu1GFmVyLPINAExk=
X-Received: by 10.58.154.229 with SMTP id vr5mr5981515veb.11.1365104662536;
 Thu, 04 Apr 2013 12:44:22 -0700 (PDT)
Received: by 10.220.236.130 with HTTP; Thu, 4 Apr 2013 12:44:22 -0700 (PDT)
In-Reply-To: <CALkWK0mQt7cE0zUECDF4ZC2-9Q+pEL=XGPdaOksyWzae2_W1CA@mail.gmail.com>
X-Google-Sender-Auth: wR9ZxKKEC8390HficdVYMzjnzco
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220079>

On Thu, Apr 4, 2013 at 12:36 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
>
> Let's compare the two alternatives: .gitmodules versus link object.
> If I want my fork of .gitmodules, I create a commit on top.

Or you could also just edit and carry a dirty .gitmodules around for
your personal use-case.

I don't know if anybody does that, but it should work fine.

And I don't see what you can do with the link objects that you cannot
do with .gitmodules. That's what it really boils down to. .gitmodules
do actually work. Your extensions would work with them too.

               Linus
