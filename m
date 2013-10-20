From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] Prevent buffer overflows when path is too big
Date: Sun, 20 Oct 2013 08:27:13 +0200
Message-ID: <526377C1.8020907@web.de>
References: <CABPQNSaqjKPGAQ4EKBSk+bQP2WMksc6M0YQxSkB91UrnFF28xQ@mail.gmail.com> <1382179954-5169-1-git-send-email-apelisse@gmail.com> <52636E5A.1080909@web.de> <20131020060517.GA8436@domone.podge>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org, 
 Wataru Noguchi <wnoguchi.0727@gmail.com>,
 Erik Faye-Lund <kusmabite@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>, 
 msysGit <msysgit@googlegroups.com>
To: =?UTF-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>, =?UTF-8?B?VG9yc3Q=?=
 =?UTF-8?B?ZW4gQsO2Z2Vyc2hhdXNlbg==?= <tboegi@web.de>
X-From: msysgit+bncBCUZ3EUT2ADRBQ7PRWJQKGQE2PSPJUI@googlegroups.com Sun Oct 20 08:27:17 2013
Return-path: <msysgit+bncBCUZ3EUT2ADRBQ7PRWJQKGQE2PSPJUI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f188.google.com ([209.85.215.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCUZ3EUT2ADRBQ7PRWJQKGQE2PSPJUI@googlegroups.com>)
	id 1VXmTs-0003Uj-BG
	for gcvm-msysgit@m.gmane.org; Sun, 20 Oct 2013 08:27:16 +0200
Received: by mail-ea0-f188.google.com with SMTP id d10sf536547eaj.25
        for <gcvm-msysgit@m.gmane.org>; Sat, 19 Oct 2013 23:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=2noltRMuxTOi4nyzlBhEU7lbzMtEGSY+QegSEUYNc7A=;
        b=ZT/22WSvwDpujRf9ig2zzma8GBsPiH46ZePydT24cCC+z0he4Nrjld+FzDZ2Pw7phR
         GJewj10MF7t+eFxAzOy6I8hWs4gDD3zqNjFE4+5M9rzCmaJPIqrwOd2Y2wI/2qKKctLM
         K+HWSnU//rUalah4FaTwdTaopS/ysqhBRSexeILob2qm6oDWqXVich6LTff6RDgwUa1B
         bs499qxjhBrzfjfKWvSwe4DtmxuCSK3Zi8huj8zvn7rfrfzvN0hs1PptRoJTeUFtCNPs
         Zmck+h5dgOrIgJcdBTmMqGmEOgYcI5FForSBCB6s5JvSkG23HfNNu169f5yoY8YXj4cV
         znnw==
X-Received: by 10.152.44.162 with SMTP id f2mr255859lam.3.1382250435914;
        Sat, 19 Oct 2013 23:27:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.18.200 with SMTP id y8ls321007lad.14.gmail; Sat, 19 Oct
 2013 23:27:14 -0700 (PDT)
X-Received: by 10.152.121.34 with SMTP id lh2mr4069749lab.1.1382250434889;
        Sat, 19 Oct 2013 23:27:14 -0700 (PDT)
Received: from mout.web.de (mout.web.de. [212.227.15.3])
        by gmr-mx.google.com with ESMTPS id cd45si1876568eeb.0.2013.10.19.23.27.14
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Oct 2013 23:27:14 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of tboegi@web.de designates 212.227.15.3 as permitted sender) client-ip=212.227.15.3;
Received: from [192.168.209.20] ([78.72.74.102]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MCZfe-1VOOYq1VqM-009RlJ for
 <msysgit@googlegroups.com>; Sun, 20 Oct 2013 08:27:14 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <20131020060517.GA8436@domone.podge>
X-Provags-ID: V03:K0:THEENr2OCJs9DSCQbGuIT6frR8opJIlD+tDuHmScyttZ+SJ9AEQ
 5MmMsGi2m//+N0aIcLB8WLhGRE3YJ78Mxbi/fwRp8OMvJycu7viAprAgRpHW1rFyGMKbpdY
 DJ80IZBw0PWzCScaTdzfK/sWO2nDFUTWkj8QEkt8GoPR/MAPEHHrAZNPo2EWS6IQsH1SrWN
 ks6iKhYD6CBjegp4515Cw==
X-Original-Sender: tboegi@web.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of tboegi@web.de designates
 212.227.15.3 as permitted sender) smtp.mail=tboegi@web.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236415>

On 20.10.13 08:05, Ond=C5=99ej B=C3=ADlka wrote:
> On Sun, Oct 20, 2013 at 07:47:06AM +0200, Torsten B=C3=B6gershausen wrote=
:
>> (may be s/path is too big/path is too long/ ?)
>>
>> On 19.10.13 12:52, Antoine Pelisse wrote:
>>> Currently, most buffers created with PATH_MAX length, are not checked
>>> when being written, and can overflow if PATH_MAX is not big enough to
>>> hold the path.
>>>
>>> Fix that by using strlcpy() where strcpy() was used, and also run some
>>> extra checks when copy is done with memcpy().
>>>
>>> Reported-by: Wataru Noguchi <wnoguchi.0727@gmail.com>
>>> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
>>> ---
>>> diff --git a/abspath.c b/abspath.c
>>> index 64adbe2..0e60ba4 100644
>>> --- a/abspath.c
>>> +++ b/abspath.c
>>> @@ -216,11 +216,15 @@ const char *absolute_path(const char *path)
>>>  const char *prefix_filename(const char *pfx, int pfx_len, const char *=
arg)
>>>  {
>>>  	static char path[PATH_MAX];
>=20
> Why do you need static there?
Good point.
get_pathname() from path.c may be better.

>>> +
>>> +	if (pfx_len > PATH_MAX)
>> I think this should be=20
>> if (pfx_len > PATH_MAX-1) /* Keep 1 char for '\0'
>>> +		die("Too long prefix path: %s", pfx);
>>> +
>>>  #ifndef GIT_WINDOWS_NATIVE
>>>  	if (!pfx_len || is_absolute_path(arg))
>>>  		return arg;
>>>  	memcpy(path, pfx, pfx_len);
>>> -	strcpy(path + pfx_len, arg);
>>> +	strlcpy(path + pfx_len, arg, PATH_MAX - pfx_len);
>>
>> I'm not sure how to handle overlong path in general, there are several w=
ays:
>> a) Silently overwrite memory (with help of memcpy() and/or strcpy()
>> b) Silently shorten the path using strlcpy() instead of strcpy()
>> c) Avoid the overwriting and call die().
>> d) Prepare a longer buffer using xmalloc()
>>
> There is also
> e) modify allocation to place write protected page after buffer end.

Yes, I think this is what electric fence, DUMA or valgrind do:

http://sourceforge.jp/projects/freshmeat_efence/
http://duma.sourceforge.net/
http://valgrind.sourceforge.net/

Theses are very good tools for developers, finding memory corruption
(or other bugs like using uninitialized memory).

One of the motivation I asked for test cases is that a git developer can
run these test cases under valgrind and can verify that we are never out of=
 range.

For an end user a git "crash" caused by trying to write to a write protecte=
d page
is better than silently corrupting memory.

And a range check, followed by die(), is even easier to debug.
For an end user.
/Torsten

















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
