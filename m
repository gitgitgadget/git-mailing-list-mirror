From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] entry.c: convert write_entry to use strbuf
Date: Fri, 25 Oct 2013 06:47:08 +0700
Message-ID: <CACsJy8D0PiY487N-OB5KuJOvz26vyu8dtUtbxticqZVScomaDA@mail.gmail.com>
References: <20131021193223.GC29681@sigill.intra.peff.net> <1382532907-30561-1-git-send-email-pclouds@gmail.com>
 <1382532907-30561-2-git-send-email-pclouds@gmail.com> <xmqqeh7bri1h.fsf@gitster.dls.corp.google.com>
 <CACsJy8Ap005pUBZH0k=7F9nON9Vb5SoO-1McPAwRkLCC0YoPMQ@mail.gmail.com> <xmqq8uxio3ed.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Git Mailing List <git@vger.kernel.org>, Erik Faye-Lund <kusmabite@gmail.com>, 
	Johannes Sixt <j6t@kdbg.org>, Antoine Pelisse <apelisse@gmail.com>, 
	=?UTF-8?Q?Torsten_B=C3=83=C2=B6gershausen?= <tboegi@web.de>, 
	Wataru Noguchi <wnoguchi.0727@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?UmVuw4PCqSBTY2hhcmZl?= <l.s.r@web.de>, 
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBC2ZN5PHQUMBBG7DU2JQKGQEZNAV2RA@googlegroups.com Fri Oct 25 01:47:42 2013
Return-path: <msysgit+bncBC2ZN5PHQUMBBG7DU2JQKGQEZNAV2RA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gg0-f192.google.com ([209.85.161.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBG7DU2JQKGQEZNAV2RA@googlegroups.com>)
	id 1VZUcw-0008Nk-9X
	for gcvm-msysgit@m.gmane.org; Fri, 25 Oct 2013 01:47:42 +0200
Received: by mail-gg0-f192.google.com with SMTP id a5sf44355ggn.19
        for <gcvm-msysgit@m.gmane.org>; Thu, 24 Oct 2013 16:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=Win55u98LzMg7yDcBplpAAhW4Fv1WC+sQB1YTeoiZm0=;
        b=sUjLuBirzD4pA3yqqwET8Mh0NybJUIIeogLUxfNOjWPv5swtgDu3vppGoAh1VCtlul
         xtVqnWDHk1k4AUDcCG7jP7CJLX2S/4mHmSLpsevo8dO8rh84aeBu9kDGiLd98XhJqjo5
         3Xw3V97Of5omneuOOPAxcAVUGl9tDypZQPeOr7cdEwOQpAHwEoVWO1HQPHXGx63nnFOa
         7dIdetDKUlNFce+eFEh4aFDF9DbSiyzJcgLJ2vQL3OQ6gLfYwa8BE2NO1we6A+1Swyjj
         2XKnzeTBTE0CgSFnpmXzSEP5LPvIud/9Q0F7iyHJsyk9875vlW1Su9dPS2jfbm2ZwvK7
         Ag6w==
X-Received: by 10.50.66.101 with SMTP id e5mr1258igt.12.1382658461321;
        Thu, 24 Oct 2013 16:47:41 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.62.4 with SMTP id u4ls112916igr.33.gmail; Thu, 24 Oct 2013
 16:47:39 -0700 (PDT)
X-Received: by 10.66.221.137 with SMTP id qe9mr2350077pac.4.1382658459217;
        Thu, 24 Oct 2013 16:47:39 -0700 (PDT)
Received: from mail-qa0-x235.google.com (mail-qa0-x235.google.com [2607:f8b0:400d:c00::235])
        by gmr-mx.google.com with ESMTPS id t6si870273qcj.3.2013.10.24.16.47.39
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Oct 2013 16:47:39 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c00::235 as permitted sender) client-ip=2607:f8b0:400d:c00::235;
Received: by mail-qa0-f53.google.com with SMTP id k15so186952qaq.5
        for <msysgit@googlegroups.com>; Thu, 24 Oct 2013 16:47:39 -0700 (PDT)
X-Received: by 10.49.15.129 with SMTP id x1mr7105660qec.49.1382658459059; Thu,
 24 Oct 2013 16:47:39 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Thu, 24 Oct 2013 16:47:08 -0700 (PDT)
In-Reply-To: <xmqq8uxio3ed.fsf@gitster.dls.corp.google.com>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c00::235
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236639>

On Fri, Oct 25, 2013 at 2:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Thu, Oct 24, 2013 at 12:52 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>>>
>>>> The strcpy call in open_output_fd() implies that the output buffer
>>>> must be at least 25 chars long.
>>>
>>> Hmph, where does that 25 come from?
>>>
>>> [snipped]
>>
>> Much better. Thanks.
>
> So where does that 25 come from?
>
> We strcpy ".merge_link_XXXXXX" or ".merge_file_XXXXXX" into path[]
> and run mkstemp() on it, and these templates are 18 bytes long, so I
> am puzzled.
>
> Is 25 "just a small random number that is surely longer than these
> templates--did not bother to count how long the templates are"?

Yes. I was too lazy to subtract precisely the column number from
between the quotes, so I just made sure the number is large enough to
cover the columns..

> That's fine by me; I am just trying to make sure I am not missing
> anything that turns these templates into a longer filename.
--=20
Duy

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
