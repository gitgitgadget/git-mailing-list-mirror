From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Windows performance / threading file access
Date: Fri, 11 Oct 2013 02:51:28 +0200
Message-ID: <52574B90.3070309@gmail.com>
References: <CAHOQ7J_ZZ=7j-5ULd7Tdvbiqg4inhwi+fue_w6WAtNRkvZSwsg@mail.gmail.com> <52570BC1.2040208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Stefan Zager <szager@google.com>, git@vger.kernel.org, 
 msysGit <msysgit@googlegroups.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: msysgit+bncBCH3XYXLXQDBBD4X3WJAKGQE4UMSNJQ@googlegroups.com Fri Oct 11 02:51:29 2013
Return-path: <msysgit+bncBCH3XYXLXQDBBD4X3WJAKGQE4UMSNJQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f64.google.com ([74.125.82.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBD4X3WJAKGQE4UMSNJQ@googlegroups.com>)
	id 1VUQwy-0000eM-Pg
	for gcvm-msysgit@m.gmane.org; Fri, 11 Oct 2013 02:51:28 +0200
Received: by mail-wg0-f64.google.com with SMTP id b13sf316553wgh.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 10 Oct 2013 17:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=2z/M9nz1HwmVtb33AdIw6V/LwsuyCDiOkg/2jlxmKU8=;
        b=KkgfTOPfU2EYyQmEgw8LZA4nCrfqOUuwLui956/wFcqtaxCtVl5Dr2M05i4vqunb84
         SJRDs1gBXxi1HRljf+IkwZ16jzyeigVEEUtAh8kqmm4GUENUtWKn6l8p2rZXR0q5JupL
         rUP5himseiDXrzT1/PJ161B4AHCcJmZntK9FpLbqdKizTGXIZHi3W+jp0xOyclSWpUNV
         1NkrSihs70llD/ZenTzoR8Lm9JmUVHO0alwu7nbPtl6UrUu1gkkF4jqF/ShN/ixfoZAT
         JHqXiHP8PNlhfX3mTKgV/gAPB/D5UQ5QVVUvaqpDIUCTBIPpQ2wVfvcLOtMwSxiDtrVN
         c+pg==
X-Received: by 10.180.109.130 with SMTP id hs2mr14741wib.6.1381452688437;
        Thu, 10 Oct 2013 17:51:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.37.17 with SMTP id u17ls84188wij.7.gmail; Thu, 10 Oct 2013
 17:51:27 -0700 (PDT)
X-Received: by 10.181.13.208 with SMTP id fa16mr678188wid.0.1381452687118;
        Thu, 10 Oct 2013 17:51:27 -0700 (PDT)
Received: from mail-ee0-x22d.google.com (mail-ee0-x22d.google.com [2a00:1450:4013:c00::22d])
        by gmr-mx.google.com with ESMTPS id cd45si8945589eeb.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 17:51:27 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::22d as permitted sender) client-ip=2a00:1450:4013:c00::22d;
Received: by mail-ee0-x22d.google.com with SMTP id c50so1533927eek.4
        for <msysgit@googlegroups.com>; Thu, 10 Oct 2013 17:51:27 -0700 (PDT)
X-Received: by 10.14.177.199 with SMTP id d47mr24685945eem.14.1381452686936;
        Thu, 10 Oct 2013 17:51:26 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id n48sm107991472eeg.17.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 17:51:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <52570BC1.2040208@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::22d
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235891>

Am 10.10.2013 22:19, schrieb Sebastian Schuberth:
> Please keep in mind to CC the msysgit mailing list for Windows-specific s=
tuff. I'm also CC'ing Karsten who has worked on performance improvements fo=
r Git for Windows in the past.
>=20

Thanks

> Thanks for bringing this up!
>=20
> --=20
> Sebastian Schuberth
>=20
>=20
>> Hi folks,
>>
>> I don't follow the mailing list carefully, so forgive me if this has
>> been discussed before, but:
>>
>> I've noticed that when working with a very large repository using msys
>> git, the initial checkout of a cloned repository is excruciatingly
>> slow (80%+ of total clone time).  The root cause, I think, is that git
>> does all the file access serially, and that's really slow on Windows.
>>

What exactly do you mean by "excruciatingly slow"?

I just ran a few tests with a big repo (WebKit, ~2GB, ~200k files). A full =
checkout with git 1.8.4 on my SSD took 52s on Linux and 81s on Windows. Xco=
py /s took ~4 minutes (so xcopy is much slower than git). On a 'real' HD (W=
D Caviar Green) the Windows checkout took ~9 minutes.

That's not so bad I think, considering that we read from pack files and wri=
te both files and directory structures, so there's a lot of disk seeking in=
volved.

If your numbers are much slower, check for overeager virus scanners and pro=
bably the infamous "User Account Control" (On Vista/7 (8?), the luafv.sys d=
river slows down things on the system drive even with UAC turned off in con=
trol panel. The driver can be disabled with "sc config luafv start=3D disab=
led" + reboot. Reenable with "sc config luafv start=3D auto").

>> Has anyone considered threading file access to speed this up?  In
>> particular, I've got my eye on this loop in unpack-trees.c:
>>

Its probably worth a try, however, in my experience, doing disk IO in paral=
lel tends to slow things down due to more disk seeks.

I'd rather try to minimize seeks, e.g.:

* read the blob data for a block of cache_entries, then write out the files=
, repeat (this would require lots of memory, though)

* index->cache is typically sorted by name and pack files by size, right? P=
erhaps its faster to iterate cache_entries by size so that we read the pack=
 file sequentially (but then we'd write files/directories in random order..=
.)


If you want to measure exactly which part of checkout eats the performance,=
 check out this: https://github.com/kblees/git/commits/kb/performance-traci=
ng-v3

Bye,
Karsten

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
