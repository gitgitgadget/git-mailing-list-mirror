From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/3] Windows: a test_cmp that is agnostic to
 random LF <> CRLF conversions
Date: Sat, 2 Nov 2013 21:47:35 +0100
Message-ID: <CAHGBnuOHHAZUD_1WWu+WrAYKB1f0BonztbAFzVqhxP0bjAkyfw@mail.gmail.com>
References: <cover.1382814437.git.j6t@kdbg.org>
	<e64878fec3f026802e8d3958a1e6213428cab778.1382814437.git.j6t@kdbg.org>
	<52756198.2070900@gmail.com>
	<52756332.50404@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, msysGit Mailinglist <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBDZMLEGXWQLBB2GJ2WJQKGQEFQCKW4Y@googlegroups.com Sat Nov 02 21:47:37 2013
Return-path: <msysgit+bncBDZMLEGXWQLBB2GJ2WJQKGQEFQCKW4Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f58.google.com ([74.125.82.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBB2GJ2WJQKGQEFQCKW4Y@googlegroups.com>)
	id 1Vci6b-0005Cn-58
	for gcvm-msysgit@m.gmane.org; Sat, 02 Nov 2013 21:47:37 +0100
Received: by mail-wg0-f58.google.com with SMTP id l18sf107857wgh.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 02 Nov 2013 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=IhO9Fq/BJ4xe4djr4/w6fZaHbZe2n/F/LCnOn+2Edlg=;
        b=tk6a2Jwi2OJi2GqPZ1mXAsWknqTHvSsj1GmC9CrUM19SUFo2d33yH8e62bAHn+su11
         7Bk5UZyshHWmIr6Qn/u5cyWN9GbJgyfRe9rMoFXY0wflr0fEsbtN7aPFfJhc5vMo8icr
         5LIVVP2mZfTvSrFYWk0oCNRBDR/0LcIdnvq4z4IFAAdEPOSmgPF0yOmSHMGJQFcZ+5UX
         HzVJqoc65VlONRghGYUet1t0adfLTT/S2cW4DJbQVlwBN5udEAXFTqqT+XhrK4xr3G7/
         UDU2m2yOzDhsIFpvRHvl11ZLZPQCIUF6OOkCvNP5YM/eM0Q8RDskr2CA/j91tQqT5OJo
         dAQA==
X-Received: by 10.152.1.197 with SMTP id 5mr132550lao.1.1383425256852;
        Sat, 02 Nov 2013 13:47:36 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.1.225 with SMTP id 1ls67552lap.3.gmail; Sat, 02 Nov 2013
 13:47:36 -0700 (PDT)
X-Received: by 10.112.126.10 with SMTP id mu10mr3402176lbb.5.1383425256365;
        Sat, 02 Nov 2013 13:47:36 -0700 (PDT)
Received: from mail-la0-x234.google.com (mail-la0-x234.google.com [2a00:1450:4010:c03::234])
        by gmr-mx.google.com with ESMTPS id qy6si1210258bkb.3.2013.11.02.13.47.36
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 02 Nov 2013 13:47:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c03::234 as permitted sender) client-ip=2a00:1450:4010:c03::234;
Received: by mail-la0-f52.google.com with SMTP id ev20so2599514lab.39
        for <msysgit@googlegroups.com>; Sat, 02 Nov 2013 13:47:36 -0700 (PDT)
X-Received: by 10.152.22.131 with SMTP id d3mr702520laf.35.1383425256019; Sat,
 02 Nov 2013 13:47:36 -0700 (PDT)
Received: by 10.114.201.134 with HTTP; Sat, 2 Nov 2013 13:47:35 -0700 (PDT)
In-Reply-To: <52756332.50404@kdbg.org>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c03::234
 as permitted sender) smtp.mail=sschuberth@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237252>

On Sat, Nov 2, 2013 at 9:40 PM, Johannes Sixt <j6t@kdbg.org> wrote:

>>> In a number of tests, output that was produced by a shell script is
>>> compared to expected output using test_cmp. Unfortunately, the MSYS
>>> bash--
>>> when invoked via git, such as in hooks--converts LF to CRLF on output
>>> (as produced by echo and printf), which leads to many false positives.
>>
>> As you correctly point out the LF vs. CRLF issues are caused by MSYS
>> bash. Then why are the functions called mingw_* instead of msys_*? I'd
>> prefer to make very clear that not MinGW but MSYS is the culprit
>> concerning the LF vs. CRLF issues (and also the path mangling issues).
>
> It's a historical accident. We already have the prerequisite MINGW to
> work around various annoyances, most of which are caused by MSYS bash. I
> didn't want to invent a new prefix.

So maybe it's a good point now to also change the MINGW prerequisite
name to MSYS as part of your patch, and then name the functions more
appropriately?

-- 
Sebastian Schuberth

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
