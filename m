From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] entry.c: convert checkout_entry to use strbuf
Date: Wed, 23 Oct 2013 20:04:03 +0700
Message-ID: <CACsJy8Cnf6o=hLcMOT3iXP+q=b8E4pE=68whxDi364N4MNgUYQ@mail.gmail.com>
References: <20131021193223.GC29681@sigill.intra.peff.net> <1382532907-30561-1-git-send-email-pclouds@gmail.com>
 <CALWbr2z90_LysnZiPaGr-X98EceX_d0yJ6_y_te16bC818xAEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Erik Faye-Lund <kusmabite@gmail.com>, 
	Johannes Sixt <j6t@kdbg.org>, =?UTF-8?Q?Torsten_B=C3=83=C2=B6gershausen?= <tboegi@web.de>, 
	Wataru Noguchi <wnoguchi.0727@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?UmVuw4PCqSBTY2hhcmZl?= <l.s.r@web.de>, 
	msysGit <msysgit@googlegroups.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: msysgit+bncBC2ZN5PHQUMBBYUST6JQKGQEKXPWEDQ@googlegroups.com Wed Oct 23 15:04:36 2013
Return-path: <msysgit+bncBC2ZN5PHQUMBBYUST6JQKGQEKXPWEDQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBYUST6JQKGQEKXPWEDQ@googlegroups.com>)
	id 1VYy71-0001gS-KH
	for gcvm-msysgit@m.gmane.org; Wed, 23 Oct 2013 15:04:35 +0200
Received: by mail-qc0-f186.google.com with SMTP id u20sf175588qcx.23
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Oct 2013 06:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=kbdjSgkmjNt88qWB4CYT8j5DRQ+r2BhB/Fpszz0hhfo=;
        b=fNGW3Kkpc7mHSasjxoP2+ReTX8OkgWoiL/4he3mKLED4yiy1jCP2VexttfUP4fb9+z
         9IU8bojitH7mvxxaG88ONx1Ig4VQ7y0xMk6DVvS/nLvMKB4YxupsFiOJKF41QT5GquOt
         IQbleWBNws5+/FCpbXxIbAYDawcYvRPaMNxpD6O6f4mkUkOpXBhZ/jFTAtB8uSI5jIXI
         67rU01TBgx1vSthVQTBRS2IOw6r4g/PtAJa98O8xUTuqONChBfltEX5T0gpkNRE0HDyw
         M1U53n+VK1b3ZltkuYptP925/gM5hF4elpQ7vidP6stprwCLptOBE6idUrXv9KYdLc2u
         Pxgw==
X-Received: by 10.182.45.170 with SMTP id o10mr55obm.41.1382533474760;
        Wed, 23 Oct 2013 06:04:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.143.70 with SMTP id sc6ls85obb.93.gmail; Wed, 23 Oct 2013
 06:04:34 -0700 (PDT)
X-Received: by 10.182.61.109 with SMTP id o13mr610594obr.6.1382533474091;
        Wed, 23 Oct 2013 06:04:34 -0700 (PDT)
Received: from mail-qe0-x232.google.com (mail-qe0-x232.google.com [2607:f8b0:400d:c02::232])
        by gmr-mx.google.com with ESMTPS id bc1si968563qcb.1.2013.10.23.06.04.34
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Oct 2013 06:04:34 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c02::232 as permitted sender) client-ip=2607:f8b0:400d:c02::232;
Received: by mail-qe0-f50.google.com with SMTP id 1so430195qee.37
        for <msysgit@googlegroups.com>; Wed, 23 Oct 2013 06:04:34 -0700 (PDT)
X-Received: by 10.224.7.194 with SMTP id e2mr3875719qae.46.1382533473938; Wed,
 23 Oct 2013 06:04:33 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Wed, 23 Oct 2013 06:04:03 -0700 (PDT)
In-Reply-To: <CALWbr2z90_LysnZiPaGr-X98EceX_d0yJ6_y_te16bC818xAEQ@mail.gmail.com>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c02::232
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236510>

On Wed, Oct 23, 2013 at 7:58 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>> diff --git a/entry.c b/entry.c
>> index acc892f..d955af5 100644
>> --- a/entry.c
>> +++ b/entry.c
>> @@ -237,16 +237,18 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
>>  int checkout_entry(struct cache_entry *ce,
>>                    const struct checkout *state, char *topath)
>>  {
>> -       static char path[PATH_MAX + 1];
>> +       static struct strbuf path_buf = STRBUF_INIT;
>> +       char *path;
>>         struct stat st;
>> -       int len = state->base_dir_len;
>> +       int len;
>>
>>         if (topath)
>>                 return write_entry(ce, topath, state, 1);
>>
>> -       memcpy(path, state->base_dir, len);
>> -       strcpy(path + len, ce->name);
>> -       len += ce_namelen(ce);
>> +       strbuf_reset(&path_buf);
>
> I think this is not required

If you mean strbuf_reset, I think it is. path_buf is still static (I
don't want to remove that because it'll add a lot more strbuf_release)
so we can't be sure what it contains from the second checkout_entry()
call.
-- 
Duy

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
