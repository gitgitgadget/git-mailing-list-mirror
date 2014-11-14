From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Fri, 14 Nov 2014 20:11:18 +0100
Message-ID: <546653D6.7040505@kdbg.org>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com> <20141109014354.GA23883@peff.net> <20141109015918.GA24736@peff.net> <5463C106.5090803@kdbg.org> <20141112215923.GB6801@peff.net> <546470D0.3080809@kdbg.org> <20141113090832.GA8329@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Blume <blume.mike@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCJYV6HBKQINXJ4ZUMCRUBCRRUIMS@googlegroups.com Fri Nov 14 20:11:24 2014
Return-path: <msysgit+bncBCJYV6HBKQINXJ4ZUMCRUBCRRUIMS@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f56.google.com ([74.125.82.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQINXJ4ZUMCRUBCRRUIMS@googlegroups.com>)
	id 1XpMHD-0000rv-JH
	for gcvm-msysgit@m.gmane.org; Fri, 14 Nov 2014 20:11:23 +0100
Received: by mail-wg0-f56.google.com with SMTP id b13sf1409774wgh.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Nov 2014 11:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=9TmHqFGyg2Xs+0DngZPKsW7w36V7lYNvPDa2YkjHvTE=;
        b=lDn0R2AoNyoxoItSZ0Km7Gmb7AheXKFBgQBwJCGFg9vhRgFsAtm0mRN7vlwVMiiXgW
         uXk6Q7wWbzlI4VSY3Z1w6wxKEbxS2yMFIfhQ8zkTZ3zFPWPhF/rbOoJwkw521u98rCW6
         MZymbxAscNzOSDga5R6Lp16JYXA3gFthEcWO7dbcrUUXDlovAkDWxbWfXCKIJXOSzDZ1
         HMk3kwn39wlkGU4YvZY6jmujrlbl1qcwkiIfNgRuIf1NstCvu5ZLeTD+H+j/vu3kdEzx
         TlqRcWz3J03R0Usxz5EWP3+DSszl3xLm1opNOOU4bnsRQ+98Q+zwd3bcCgLNFxxb5Gmq
         +ThQ==
X-Received: by 10.180.211.239 with SMTP id nf15mr49687wic.0.1415992283328;
        Fri, 14 Nov 2014 11:11:23 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.83.133 with SMTP id q5ls405312wiy.31.canary; Fri, 14 Nov
 2014 11:11:22 -0800 (PST)
X-Received: by 10.180.100.100 with SMTP id ex4mr1424776wib.2.1415992282711;
        Fri, 14 Nov 2014 11:11:22 -0800 (PST)
Received: from bsmtp.bon.at (bsmtp3.bon.at. [213.33.87.17])
        by gmr-mx.google.com with ESMTPS id jw5si197317wid.2.2014.11.14.11.11.22
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Nov 2014 11:11:22 -0800 (PST)
Received-SPF: none (google.com: j6t@kdbg.org does not designate permitted sender hosts) client-ip=213.33.87.17;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jfTmm5zh4z5tlD;
	Fri, 14 Nov 2014 20:11:19 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 34B6619F75B;
	Fri, 14 Nov 2014 20:11:19 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141113090832.GA8329@peff.net>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=none
 (google.com: j6t@kdbg.org does not designate permitted sender hosts) smtp.mail=j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

(+cc msysgit)

Am 13.11.2014 um 10:08 schrieb Jeff King:
> On Thu, Nov 13, 2014 at 09:50:24AM +0100, Johannes Sixt wrote:
> 
>>> That looks more like it is failing the actual test (i.e., the creation
>>> of branch "one" when there is cruft in the reflog). My guess is that
>>> calling open() on a directory is giving us EACCES instead of EISDIR. Can
>>> you verify that?

That is indeed the case. It's an ancient bug in our wrapper
mingw_open().

>>> If that is the case, then this isn't a new breakage, I think, but just
>>> code we weren't previously exercising. It would be interesting to know
>>> whether:
>>>
>>>   git config core.logallrefupdates true
>>>   git branch one/two
>>>   git branch -d one/two
>>>   git branch one
>>>
>>> works (even without my patch). If so, then there's probably something
>>> else going on.
>>
>> Don't know what you mean with "my patch" (the one I was responding to
>> touches only t1410).
> 
> The patch you are responding to is a fix-up for 9233887, which tweaked
> the code and added those tests in the first place (I doubt it would work
> for you, though, as it has a problem on case-insensitive filesystems).
> 
>> But the sequence works as expected with a version built
>> in September:
> 
> Hmph. So that would mean my theory is not right. Or maybe I am not
> accounting for something else in my analysis.
> 
> I guess it is odd that the test right before the failing one passes (it
> is basically that same sequence, with reflogs turned on for both
> operations), which implies that we are properly getting EISDIR. The only
> difference in the failing test is that reflogs are turned off for the
> "git branch one" operation. But I cannot see why that would be broken if
> the other one passes.

Not a comment, on this paragraph of yours, but while I was walking
through the code with gdb, I was wondering why the reflog directory is
being touched at all when core.logallrefupdates is off (in
log_ref_setup via log_ref_write). With the patch below I now get the
same unlink warning as on Linux.

--- 8< ---
Subject: [PATCH] Windows: correct detection of EISDIR in mingw_open()

According to the Linux open(2) man page, open() returns EISDIR if a
directory was attempted to be opened for writing. Our emulation in
mingw_open() does not get this right: it checks only for O_CREAT. Fix
it to check for one of the write flags.

This fixes a failure in reflog handling, which opens files with
O_APPEND|O_WRONLY, but without O_CREAT, and expects EISDIR when the
named file happens to be a directory.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 2ee3fe3..fc64b73 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -312,7 +312,7 @@ int mingw_open (const char *filename, int oflags, ...)
 		return -1;
 	fd = _wopen(wfilename, oflags, mode);
 
-	if (fd < 0 && (oflags & O_CREAT) && errno == EACCES) {
+	if (fd < 0 && (oflags & (O_WRONLY|O_RDWR)) && errno == EACCES) {
 		DWORD attrs = GetFileAttributesW(wfilename);
 		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))
 			errno = EISDIR;
-- 
2.0.0.12.gbcf935e

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
