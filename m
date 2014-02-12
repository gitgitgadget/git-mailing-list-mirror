From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: pack bitmap woes on Windows
Date: Wed, 12 Feb 2014 15:49:24 +0100
Message-ID: <CABPQNSZRfnp8aZuKBc=y=iDVdMUo8mKPsLsqg0E+bK1TdNvfkA@mail.gmail.com>
References: <52FB2268.7080906@viscovery.net> <87mwhwa3s1.fsf@fencepost.gnu.org>
 <52FB7196.7060209@viscovery.net> <87ioska2iu.fsf@fencepost.gnu.org>
 <CACsJy8CW0shw5JYtXScQHMYJ+D18-UJ6HanP-5OCuv87kHbnBg@mail.gmail.com> <CABPQNSabAcHEO0+ht7te9ScVigGOoCLdtiD10ye8AqqeLMagLw@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Kastrup <dak@gnu.org>, Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 15:50:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDb8f-00080m-NL
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 15:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbaBLOuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 09:50:06 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34208 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbaBLOuF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 09:50:05 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp18so10586953obc.36
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 06:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qVKo34SRqsJZOtkNuu1GeDahUMUVc1gl2KoganajkF0=;
        b=carNk7TT6Y8lW48ZSD20Mz4WfuebyoiTUnEv1Md01KCi5hQOEo4IQItnSgdT5QKWuD
         PSv+A3C0SXPj62gHsybPZNj6WBFSu4SJ8bDoz2Le1ev3oB/ByJGYO/oi48s8M/Ck0wTR
         bOG31+Gap6miKaDcNU/CzZk3k8/fcq/Kd1erKZKEiY/vGGh8C8y4axFRnfZF8lhBtCYg
         Pqj02pHLwl6I/+a0dVkTuOiPh2QxJeVd7dUSrTr1H5wSZJayF9vBrQoaLJGX59D1lVkZ
         k1oyJ09UlVhR/fUNvYOI9lF+gv2Sklda/36zgh+iDjDd+qgSpJ3Zuekb1E/9LecTX80C
         nGbw==
X-Received: by 10.60.229.4 with SMTP id sm4mr37777805oec.9.1392216604175; Wed,
 12 Feb 2014 06:50:04 -0800 (PST)
Received: by 10.76.85.103 with HTTP; Wed, 12 Feb 2014 06:49:24 -0800 (PST)
In-Reply-To: <CABPQNSabAcHEO0+ht7te9ScVigGOoCLdtiD10ye8AqqeLMagLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241994>

On Wed, Feb 12, 2014 at 3:22 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Wed, Feb 12, 2014 at 3:09 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Wed, Feb 12, 2014 at 8:23 PM, David Kastrup <dak@gnu.org> wrote:
>>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>>
>>>> Am 2/12/2014 13:55, schrieb David Kastrup:
>>>>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>>>>
>>>>>> Running test suite of 'next' on Windows fails in t5310-pack-bitmaps with
>>>>>> the following symptoms. I haven't followed the topic. Have there been
>>>>>> patches floating that addressed the problem in one way or another?
>>>>>>
>>>>>> (gdb) run
>>>>>> Starting program: D:\Src\mingw-git\t\trash
>>>>>> directory.t5310-pack-bitmaps/..\..\git.exe rev-list --test-bitmap
>>>>>> HEAD
>>>>>> [New thread 3528.0x8d4]
>>>>>> Bitmap v1 test (20 entries loaded)
>>>>>> Found bitmap for 537ea4d3eb79c95f602873b1167c480006d2ac2d. 64 bits
>>>>>> / 15873b36 checksum
>>>>>
>>>>> Does reverting a201c20b41a2f0725977bcb89a2a66135d776ba2 help?
>>>>
>>>> YES! t5310 passes after reverting this commit.
>>>
>>> Oh.  I just looked through the backtrace until finding a routine
>>> reasonably related with the regtest and checked for the last commit
>>> changing it, then posted my question.
>>>
>>> Then I looked through the diff of the patch and considered it
>>> unconspicuous.  So I commenced reading through earlier commits.
>>>
>>> I actually don't have a good idea what might be wrong here.  The code is
>>> somewhat distasteful as it basically uses eword_t and uint64_t
>>> interchangeably, but then this does match its current definition.
>>
>> Perhaps __BYTE_ORDER or __BIG_ENDIAN is misdefined and the ntohll() is skipped?
>
> That is indeed the case.

Looking a bit at it, the whole byte-order detection mess seems insane to me.

MinGW falls inside the "defined(__GNUC__) && (defined(__i386__) ||
defined(__x86_64__))"-block, but does not define __BYTE_ORDER.

It seems the author of a201c20b41a2f0725977bcb89a2a66135d776ba2
assumes __BYTE_ORDER was guaranteed to always be defined, probably
fooled by the following check:

#if !defined(__BYTE_ORDER)
# error "Cannot determine endianness"
#endif

However, that check is only performed if we're NOT building with GCC
on x86/x64 nor MSVC (which I don't think defined __BYTE_ORDER either)

The following would make __BYTE_ORDER a guarantee, and show that MinGW
does not define it:

---8<---

diff --git a/compat/bswap.h b/compat/bswap.h
index 120c6c1..c73bf0e 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -109,10 +109,6 @@ static inline uint64_t git_bswap64(uint64_t x)
 # endif
 #endif

-#if !defined(__BYTE_ORDER)
-# error "Cannot determine endianness"
-#endif
-
 #if __BYTE_ORDER == __BIG_ENDIAN
 # define ntohll(n) (n)
 # define htonll(n) (n)
@@ -123,6 +119,10 @@ static inline uint64_t git_bswap64(uint64_t x)

 #endif

+#if !defined(__BYTE_ORDER)
+# error "Cannot determine endianness"
+#endif
+
 /*
  * Performance might be improved if the CPU architecture is OK with
  * unaligned 32-bit loads and a fast ntohl() is available.

---8<---

But another level of insanity (IMO) is defining double-underscore
macros. These symbols are reserved for the implementation. Sure,
knowing we're on a given implementation and defining something *else*
dependent on them is fine. But defining them is just yuckiness, and
not very standard-kosher.

IMO, we should rather do the definition the other way around:

#if !defined(BYTE_ORDER)
# if defined(__BYTE_ORDER) && defined(__LITTLE_ENDIAN) && defined(__BIG_ENDIAN)
#  define BYTE_ORDER __BYTE_ORDER
#  define LITTLE_ENDIAN __LITTLE_ENDIAN
#  define BIG_ENDIAN __BIG_ENDIAN
# endif
#endif

...and only referred to BYTE_ORDER, LITTLE_ENDIAN and BIG_ENDIAN.


That way we'd follow closer to where opengroup are heading:

http://www.opengroup.org/austin/docs/austin_514.txt
