From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 1/2] entry.c: convert checkout_entry to use strbuf
Date: Wed, 23 Oct 2013 15:06:16 +0200
Message-ID: <CALWbr2wypVuPQWEiM8ci_5RK_+R9c7O48=hXs4XrUiRUp+yf0A@mail.gmail.com>
References: <20131021193223.GC29681@sigill.intra.peff.net>
	<1382532907-30561-1-git-send-email-pclouds@gmail.com>
	<CALWbr2z90_LysnZiPaGr-X98EceX_d0yJ6_y_te16bC818xAEQ@mail.gmail.com>
	<CACsJy8Cnf6o=hLcMOT3iXP+q=b8E4pE=68whxDi364N4MNgUYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Erik Faye-Lund <kusmabite@gmail.com>, 
	Johannes Sixt <j6t@kdbg.org>, =?UTF-8?Q?Torsten_B=C3=83=C2=B6gershausen?= <tboegi@web.de>, 
	Wataru Noguchi <wnoguchi.0727@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?UmVuw4PCqSBTY2hhcmZl?= <l.s.r@web.de>, 
	msysGit <msysgit@googlegroups.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: msysgit+bncBD3NZH6HQMJBBSMTT6JQKGQEUWFEYTA@googlegroups.com Wed Oct 23 15:06:21 2013
Return-path: <msysgit+bncBD3NZH6HQMJBBSMTT6JQKGQEUWFEYTA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f191.google.com ([209.85.215.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD3NZH6HQMJBBSMTT6JQKGQEUWFEYTA@googlegroups.com>)
	id 1VYy8g-0002pp-2f
	for gcvm-msysgit@m.gmane.org; Wed, 23 Oct 2013 15:06:18 +0200
Received: by mail-ea0-f191.google.com with SMTP id o10sf90553eaj.28
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Oct 2013 06:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=qYbX8J8RHPnv7EAqrj7c0cX1dC4ClbrxwHKaS8vwkNA=;
        b=XfF7ER0afrLnnobtnlji/WyfygaYmLl5LGZ7bDrUyyoqlVP2C6rplA/Orl+CEo1x5D
         2gOikBFGXEx4jxQ1LOZM64hHQhsM+HZ04VEQzRegTFhzhY4qoSfz1JQ0nbemuIm4iI+o
         UwA+/BkJWamVUwjPUXAGDIZOCV1vt8LlisQm6VKDILRM0/6n/fnaZKhcvN0KB1Dq90bS
         YqdHicqYcMZr6MQubmF+FZ8aj7z0XSMzNqaBA3quZEFVtwsIYPX+NT/bZAQcCF3imRAm
         6A2hj02uiAb5TDdFEuoA0y1ddUNLfeNy8NjhyFMNyKHess2a1YOYICWvYvOkS40qPbd7
         koMw==
X-Received: by 10.152.28.3 with SMTP id x3mr6519lag.33.1382533577783;
        Wed, 23 Oct 2013 06:06:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.27.3 with SMTP id p3ls116245lag.64.gmail; Wed, 23 Oct 2013
 06:06:17 -0700 (PDT)
X-Received: by 10.152.21.165 with SMTP id w5mr626291lae.3.1382533577103;
        Wed, 23 Oct 2013 06:06:17 -0700 (PDT)
Received: from mail-la0-x22c.google.com (mail-la0-x22c.google.com [2a00:1450:4010:c03::22c])
        by gmr-mx.google.com with ESMTPS id re4si2068203bkb.1.2013.10.23.06.06.17
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Oct 2013 06:06:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of apelisse@gmail.com designates 2a00:1450:4010:c03::22c as permitted sender) client-ip=2a00:1450:4010:c03::22c;
Received: by mail-la0-f44.google.com with SMTP id ep20so635574lab.31
        for <msysgit@googlegroups.com>; Wed, 23 Oct 2013 06:06:16 -0700 (PDT)
X-Received: by 10.152.29.103 with SMTP id j7mr1158937lah.7.1382533576747; Wed,
 23 Oct 2013 06:06:16 -0700 (PDT)
Received: by 10.112.50.240 with HTTP; Wed, 23 Oct 2013 06:06:16 -0700 (PDT)
In-Reply-To: <CACsJy8Cnf6o=hLcMOT3iXP+q=b8E4pE=68whxDi364N4MNgUYQ@mail.gmail.com>
X-Original-Sender: apelisse@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of apelisse@gmail.com designates 2a00:1450:4010:c03::22c
 as permitted sender) smtp.mail=apelisse@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236511>

On Wed, Oct 23, 2013 at 3:04 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Oct 23, 2013 at 7:58 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>>> diff --git a/entry.c b/entry.c
>>> index acc892f..d955af5 100644
>>> --- a/entry.c
>>> +++ b/entry.c
>>> @@ -237,16 +237,18 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
>>>  int checkout_entry(struct cache_entry *ce,
>>>                    const struct checkout *state, char *topath)
>>>  {
>>> -       static char path[PATH_MAX + 1];
>>> +       static struct strbuf path_buf = STRBUF_INIT;
>>> +       char *path;
>>>         struct stat st;
>>> -       int len = state->base_dir_len;
>>> +       int len;
>>>
>>>         if (topath)
>>>                 return write_entry(ce, topath, state, 1);
>>>
>>> -       memcpy(path, state->base_dir, len);
>>> -       strcpy(path + len, ce->name);
>>> -       len += ce_namelen(ce);
>>> +       strbuf_reset(&path_buf);
>>
>> I think this is not required
>
> If you mean strbuf_reset, I think it is. path_buf is still static (I
> don't want to remove that because it'll add a lot more strbuf_release)
> so we can't be sure what it contains from the second checkout_entry()
> call.

Of course, I forgot about the static,
Thanks :-)

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
