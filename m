From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v12 03/13] ref-filter: introduce the ref_formatting_state
 stack machinery
Date: Thu, 20 Aug 2015 15:59:44 +0530
Message-ID: <CAOLa=ZRRscZO2kJEtsLX6QkVb4Ae+ri0KsJZSQfT85jQq2tRGQ@mail.gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
 <1439923052-7373-4-git-send-email-Karthik.188@gmail.com> <vpqvbcb2uoi.fsf@anie.imag.fr>
 <CAOLa=ZTy8QO=H9g9g3SKU4HaG=qg71GidGuXKLXNgu7Su3FQ9A@mail.gmail.com>
 <vpqa8tn2sgy.fsf@anie.imag.fr> <CAOLa=ZSzXyQZJksNqyroU6Td+LG7ZRTF_WNNryusAGZxTYTmDg@mail.gmail.com>
 <CAOLa=ZRBTrWa5EEOxa-Rf+J+8DWP7gSGGEYaG75EsR=A1DofRA@mail.gmail.com> <vpq7foq1kpe.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 20 12:30:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSN70-0007we-Hf
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 12:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbbHTKaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 06:30:16 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36339 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbbHTKaO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 06:30:14 -0400
Received: by obkg7 with SMTP id g7so28188989obk.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 03:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5Id/Q2wqaIFTYTTRXXhz7/zUfUP3HUo2Z8V4RQcEK2k=;
        b=E/yEmkiPiKOlQBm+1E103mxGGBCr721s+EipxJnPZR/rZNd3fVt6MqSN7/gKvU/aMB
         Pju7+BeCMvDZSUyKmP0JuTPRel0gTx3ohz05EPgAHJ9XN7lciUKMkDjqbwGk4075oLjq
         sm9C6/ICCoQbIKhGTbK78d0AktpHsSy8DNCOhurvA0PFcpCHIw+RjCIQxh9RgePgrOuk
         J5w8qZJkQLCN4xaGWRtx5DamWiDl3Yu+UpupuTsEYelb1qJpQnB46KeSAiq+5kHcJgLJ
         0E9UwUCfzSBkLXI1/Czz3mmx2NBMbXnoLSrAI+gBWnWCb1khDm6aN27JzCH7q+86FWMJ
         ksXw==
X-Received: by 10.60.92.37 with SMTP id cj5mr2057348oeb.30.1440066613917; Thu,
 20 Aug 2015 03:30:13 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 20 Aug 2015 03:29:44 -0700 (PDT)
In-Reply-To: <vpq7foq1kpe.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276233>

On Thu, Aug 20, 2015 at 12:59 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Speaking of quote_value, The quote doesn't work well with color's
>> for e.g.
>> git for-each-ref --shell --format="%(color:green)%(refname)"
>> '''refs/heads/allow-unknown-type'''
>> Seems like an simple fix, probably after GSoC I'll do this :)
>
> Anyway, the %(color) is really meant to be displayed on-screen, and the
> quoting is really meant to feed the value to another program, so I can
> hardly imagine a use-case where you would want both.
>
> But the current behavior seems fine to me: the color escape sequence is
> quoted, which is good. For example, you can
>
> x=$(git for-each-ref --shell --format="nocolor%(color:green)%(refname)" | head -n 1)
> sh -c "echo $x"
>
> it will actually display "nocolor" without color, then a green refname.
> I'm not sure the quoting is really necessary, but it doesn't harm and it
> makes sense since the escape sequence contains a '[' which is a shell
> metacharacter.
>

Thanks for explaining that! I agree with whatever you've said.

-- 
Regards,
Karthik Nayak
