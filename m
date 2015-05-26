From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 00/56] Convert parts of refs.c to struct object_id
Date: Tue, 26 May 2015 10:37:29 -0700
Message-ID: <CAGZ79kbxrPhcMUFx3OY1s_qk4TkUcBgscDwqSvrLtDXmF1YwWw@mail.gmail.com>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
	<xmqqa8wsbgd8.fsf@gitster.dls.corp.google.com>
	<20150525194007.GH26436@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 26 19:37:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxInH-0006GC-A4
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 19:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbbEZRha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 13:37:30 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33100 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbbEZRh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 13:37:29 -0400
Received: by qkhg32 with SMTP id g32so11401518qkh.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=8iiBwQH7ECQy4tZ8ghKa2MZ/Z2+Riw4qiEk8gwgNaOQ=;
        b=iRk7XPMevR6B98jrGPtQqJHXejqlxK/9JthmtUkPMURzGpu4KnGJWdNRzoQ+me6nA5
         1J15CJjzAn+FXro3+vwRgMkmXuXL1ataE37TK0AOFjuTf31SuVfu1wEx+VNwiGrH6n84
         lLBGVw2KNEkmqP3pl2RGouvWh4tvwzqMqocYQn8KhzopfpObszqeOF0Xhy+HCelmtOep
         bpJMHOqdsDPbEkQBI+T5QA/HaT0GiFPi6J+ycqPqBoCq2j6CqxCpquxPAYzAhYdFGA0P
         HO3exSimGNioMva+6XCh/UEDFKPzvtz7wuZ8af9flGValpJlyzwMJvz6mihXZbxeVcXR
         Dr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=8iiBwQH7ECQy4tZ8ghKa2MZ/Z2+Riw4qiEk8gwgNaOQ=;
        b=mB9EjpFF4xpXlgnVFuTbkszn3+lIvMA3FYOhGa5ZN1btvF6m3Onaa6UI6/z0AZr8YZ
         WPP1kOBWggwZTIpJLqOeWW+oCM9ewdopS+rw8n7XYgpLuxq1m19Z4+f22xoZEc8F43vy
         /TPIpn4+UD+jb/+0c9U5+bC+V1Akrwo3V+xlAXQPnZiJRlybPRHq8HBc94wBAC7e3Mi5
         ZexmmPyfydB0fKPxoQc3YYq10SiOhg87kUi8h3LxkPLWRhZhvhjWFrj9T9fl1qFXdGsB
         Lasox0R2A5YOL+lDkkybRYplm80h4VK+00arurhZTNaiU132gQtG7AVvuB3MhegON4uL
         5K6w==
X-Gm-Message-State: ALoCoQkIaNhWxFve0M+ul8b2bp7chZYVoXHPf/rdlSWZalYA4YiFjoO3YH8P5gslxiTMK87ZX7Xj
X-Received: by 10.140.133.9 with SMTP id 9mr31457975qhf.5.1432661849152; Tue,
 26 May 2015 10:37:29 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 26 May 2015 10:37:29 -0700 (PDT)
In-Reply-To: <20150525194007.GH26436@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269957>

On Mon, May 25, 2015 at 12:40 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, May 25, 2015 at 12:34:59PM -0700, Junio C Hamano wrote:
>> [PATCH 01/56] was authored by you but has Michael's sign-off, which
>> looked somewhat odd to me, though.
>
> Yes, it does.  He picked it up from me, and signed off, and I took his
> branch.  I don't believe he changed it, but I didn't check for certain.
> So technically, although I wrote it, I also received it from him without
> changing it, so both (a) and (c) of the DCO apply.

At least in the kernel, the sign offs are also used to track a patchs way
of life, so essentially whenever somebody touches that patch (either as
an author, or as a patch shoveling sub Lieutenant), you'd add a sign off.

So if we were to handle the sign offs just as the kernel people, I would
have assumed a sign-off block like

Sign-off: you
Sign off: Michael
Sign-off: you

as that would indicate that Michael did not author it from scratch but
based his work on yours. That's just my understanding of the sign off
process for linux and I guessed we'd follow a very similar process. But
no objections from me regarding the signing.

All patches have been
Skimmed-over-and-run-test-suite-by: Stefan Beller <sbeller@google.com>
if that helps.

> --
> brian m. carlson / brian with sandals: Houston, Texas, US
> +1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
> OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187
