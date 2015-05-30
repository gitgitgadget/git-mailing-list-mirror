From: Patryk Obara <patryk.obara@gmail.com>
Subject: Re: [PATCH 2/2] commit: fix ending newline for template files
Date: Sat, 30 May 2015 13:29:16 +0200
Message-ID: <CAJfL8+RtR+w+NQeFGJ7GPsPYgcn59XvWw8eXL12ph9EHwc14ww@mail.gmail.com>
References: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
 <1432620908-16071-3-git-send-email-patryk.obara@gmail.com>
 <CAPig+cTt5sQ=49qS2+8ZOtiX61kHjAisAvpP7K3XPhtNtCatOg@mail.gmail.com>
 <xmqqpp5kh8a0.fsf@gitster.dls.corp.google.com> <CAPig+cR=Mrgb+-ZZcM6m7AcL25gXYtmEVpO3c23k_UKXPgyQnA@mail.gmail.com>
 <xmqqwpzrb0kb.fsf@gitster.dls.corp.google.com> <CAPig+cTrW9f1TGvpr4KH+EcOsy=FWvGRj6ZQM6nsFyXc15c4qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat May 30 13:29:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yyexe-0000FI-TS
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 13:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757627AbbE3L3u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 May 2015 07:29:50 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34540 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757476AbbE3L3s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 May 2015 07:29:48 -0400
Received: by wibut5 with SMTP id ut5so2229152wib.1
        for <git@vger.kernel.org>; Sat, 30 May 2015 04:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=CB4vByzcI89AHkS+I7AUXT58OYxkCDShxeEJH0ah3Uw=;
        b=SyECqNpZrnXe/eCvqRivpfr6LXS+9EN0HeiGgFdVonj5p6nKmnJimkFpABdGj1/rHC
         cxocu3sSJegwq+uwuJmnv2MsMI7Iln8r9U4ObXvgnxxhOBBVE3ZsZYyCIljovUkh8zOl
         u8amwpYTNi3FtxOHpp+7hCywl/2ZsSdabt37efbCPfhodxW1Ehg5atNKOYcmUv3BCMji
         168UFhdSUoWm4FBfKRig9skPUb+EEu6kPUgA2hHb8W7AxgnBodtp4RDGTXbA3tGpojue
         luxsCz0ce81+8hZ3Tyuzf8FdIWXP61klb/e7lepCzQT6gq9EFiQSlSGSBH6eYm9zlEW5
         DNIw==
X-Received: by 10.194.78.14 with SMTP id x14mr23302075wjw.48.1432985386865;
 Sat, 30 May 2015 04:29:46 -0700 (PDT)
Received: by 10.28.153.141 with HTTP; Sat, 30 May 2015 04:29:16 -0700 (PDT)
In-Reply-To: <CAPig+cTrW9f1TGvpr4KH+EcOsy=FWvGRj6ZQM6nsFyXc15c4qg@mail.gmail.com>
X-Google-Sender-Auth: HeGvzJmTJY_oPBxp_OtSWMf53BI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270284>

@Eric, Junio
Thank you a lot for feedback - should I post new set of patches as new =
thread
with new cover letter, or reply to first mail in this thread?


On Thu, May 28, 2015 at 4:29 PM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> Did you consider the alternate approach of handling newline processin=
g
> immediately upon loading 'logfile' and 'template_file', rather than
> delaying processing until this point? Doing it that way would involve
> a bit of code repetition but might be easier to reason about since it
> would occur before possible interactions in following code (such as
> --signoff handling).

Yes. I opted to place it in here, because newline was appended previous=
ly
also in "if (use_editor)" block. But I agree, appending this newline af=
ter
loading file will be cleaner - and code repetition may be avoided, if I=
'll
separate file loading code into new function.


On Thu, May 28, 2015 at 4:29 PM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> Moreover, it lacks justification and explanation of why you consider
> the cleanup unnecessary. History [1] indicates that its application t=
o
> -F but not -t was intentional.

That commit suggests, that cleanup was unintentional in one case, it sa=
ys
nothing about it being intentional for -F. Short story: currently clean=
up
on commit msg is performed many times (I am not sure if "only 2 times" =
or
maybe more. I'll include more detailed analysis with second round of pa=
tches :)


On Sat, May 30, 2015 at 12:25 AM, Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
> I had a similar reaction. The one salient bit I picked up was that
> Patryk finds it aesthetically offensive[1] (...)

Yes, that is exactly issue, that I initially wanted to solve. I didn't =
even
notice, that my template had newline appended until I ran git-commit in=
 gdb.
Then I saw, that I can't actually test changes to newlines and rest fol=
lowed,
because I didn't want to leave code with more tests disabled.

nano, vim, gedit (and other editors, I guess) append _and_hide_ \n befo=
re
eof from user in default configuration. This newline appended by git be=
fore
status is completely unexpected (and unwanted) behaviour IMHO.


On Fri, May 29, 2015 at 4:17 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> in other words, "if your template ends with an incomplete line and
> it causes you trouble, then do not do that!".

1) But problem occurs, when template ends with complete line. To make i=
t
   disappear, user needs to somehow remove trailing newline from his fi=
le.
   In vim it involves switching to non-default binary mode, in nano or
   gedit it's impossible. Anwer "use emacs" would be a bit disrespectfu=
l
   towards end user ;)

2) That commit addresses different issue - when user intentionally left
   whitespace in template file, then commit should not clean it up, bec=
ause
   it might've beed a "form" to be filled.

3) Well, the exact same logic can be applied to logfile - it does not e=
xplain
   why logfiles and template files should be treated differently in thi=
s
   regard. In fact, when looking at 8b1ae67, I think that lack of this =
cleanup
   for logfiles might be an unintended ommision. After another look at =
that
   commit - included test doesn't actually verify implemented change (c=
ommit
   msg is stripped and "commit_msg_is" doesn't verify newlines anyway).

On Sat, May 30, 2015 at 12:25 AM, Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
> If the user specified with the --cleanup option not to
> clean-up the result coming back from the editor, then the commented
> material needs to be removed in the editor by the user *anyway*.

Why? Is it not ok to leave lines starting with hash in commit object?
--cleanup=3Dwhitespace|verbatim suggests, that it's a valid usecase.

--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
