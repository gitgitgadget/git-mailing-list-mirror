From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Mon, 29 Jun 2015 09:40:10 -0700
Message-ID: <xmqq8ub2cvth.fsf@gitster.dls.corp.google.com>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
	<CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
	<558F8B55.1070708@alum.mit.edu>
	<CAPc5daWmhkqDL0pNYne4-kRoxWK7ObcOKxtE5DsfHA2cnMM1pQ@mail.gmail.com>
	<558F9854.5080605@alum.mit.edu>
	<xmqqwpyoe1aj.fsf@gitster.dls.corp.google.com>
	<558FDAF9.3010300@alum.mit.edu>
	<xmqqh9prekdw.fsf@gitster.dls.corp.google.com>
	<vpqegkvnfe5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 29 18:40:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9c6W-0006vC-Mi
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 18:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbbF2QkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 12:40:16 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35441 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbbF2QkO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 12:40:14 -0400
Received: by iecuq6 with SMTP id uq6so19624606iec.2
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 09:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=azbDk2CRvlweN3ci7bnIp8shbhcqvj5s3/3eUMZf5Ao=;
        b=oHdQTsYVgVbg7z4PY6BHzN5h0Up5p53Tt7kUDyFHbBzIf3Rv+/i1HWLPPp2Qds3cdf
         Xb0Yn5lKUiwNsBnGUocaZc4fYijRMkjbIKEFlU1Cd4ulCQRd+oApgkwsQcP5LZ6dTGv6
         Nddy71fgmLNTw2TuUbIfwzcbYlYKrgi87eZXPaZ02jfx5HoqQ65475SliZqxHNSzhlDL
         v7CngJ/+wRP8H30M/YdlTyUItzOve/iPIVxiQSIx60B7MbJmzLSyFbkapngJVqv/BcsP
         8NSxI7J8fZFgfbs2JkrFETKVIebQjOxqLOfoelOg0mBBTs7Aew43VqD80A3pPf1x+vTQ
         LDsA==
X-Received: by 10.42.163.137 with SMTP id c9mr18503894icy.51.1435596013379;
        Mon, 29 Jun 2015 09:40:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id 191sm28060111iof.18.2015.06.29.09.40.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 09:40:11 -0700 (PDT)
In-Reply-To: <vpqegkvnfe5.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	29 Jun 2015 09:27:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272971>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> So, my proposal would be to remove the "old/new" patch from the series,
> and keep the other patches.
>
> What do you think?

Let me answer after reading v11 through.

>> but now it would be more clear that $name_good and $name_bad is a bad
>> way to name internal variables and files in $GIT_DIR. The inferred 'ah
>> you are hunting for regression' mode would call old ones 'bad' and new
>> ones 'good', they have to be given value neutral names, e.g. $name_old
>> and $name_new.
>
> Ideally, the whole code would be ported to use old/new, but the more I
> read the code the more I agree with Christian actually: we still have
> many more instances of good/bad in the code (e.g. functions
> check_good_are_ancestors_of_bad, for_each_good_bisect_ref, ...), so
> having just name_new/name_old would make the code very inconsistant.

Oh, no question about that.  I was hoping that we would at least get
the concensus that we should move all to old/new and these good/bad
in code no longer make sense.

It just was that introducing new variables and functions whose names
follow the convention that reflects the world view that is no longer
valid (i.e. good is always old and bad is always new) in a series
that introduces the new world view somehow felt wrong.
