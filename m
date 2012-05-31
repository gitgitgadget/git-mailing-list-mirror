From: David Michael Barr <davidbarr@google.com>
Subject: Re: [PATCH 7/7] vcs-svn: fix clang-analyzer warning
Date: Thu, 31 May 2012 21:34:59 +1000
Message-ID: <CAFfmPPPmnS4f4+JVhLFqcNM+taj4VO6ZVMv8RCoEiQqKHGy_1g@mail.gmail.com>
References: <1337868259-45626-1-git-send-email-davidbarr@google.com>
	<1337868259-45626-8-git-send-email-davidbarr@google.com>
	<20120524143337.GB3732@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 13:35:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa3ep-0001Mt-Jz
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 13:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893Ab2EaLfD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 07:35:03 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51438 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625Ab2EaLfA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 07:35:00 -0400
Received: by yhmm54 with SMTP id m54so555743yhm.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 04:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=O9yDbYPXJkV9EJRiLAhcRr0QkoJCRWxWK2c9Z5LzJgA=;
        b=CVlVgxEeDPQ0EIVW68wRFC7jZ1PjsflmUtMRK++OL/4MN0EOU+fO0j6mkHY6Pgn9iW
         UuhIcQ/BsK/+pIm4n/U1clizIDGFCH+W4IbXnxj2ebRqr6uPrWJpEcluXMinO0s4xotG
         nQ4leAU+BQ2T0fx9wGOM5mnq79W0zCVQ/xwJP1vACfmo7KDc6CrfTufh/kCZgvxJ9kAv
         VL/u2vOIqH/OnGPt99GF35sNEfDAyXtmvdhTNohsgQWC+HF2h25veD/v2gYRffUJ3q0O
         4Peq9B8CpLOcDgz57QJgEbMr5Ud2STGfepskx41E0gLcaGGaal0+nEaHLSHFZjtwv3Ld
         r4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=O9yDbYPXJkV9EJRiLAhcRr0QkoJCRWxWK2c9Z5LzJgA=;
        b=P00M4fDlS1HxiFA7gddxOPgizdvyoDCxH74tsWNES1i4KMZJeA2DNtrQWPzubLhVNW
         44ItzdBdFmZop+0jkLW9kagOLyCY21W3CaEuzQ+rCO+Tr38POtv3BDipcs4ctvShQfs3
         aakpKM1xAvWhm4hMH2vpaSkgbaE5Iq823OwPuF8kz+sKS1b9yQcld5FJBMYmfE6R6laS
         NlcDrZWq6wOmIi3LsXRRSsvw37iR/vSNVJ9p79rBAUbpq3gub8+SiR+VgvxHdGpyhrwo
         0Sl8NuRWzCMeGtCCqUB+QWd3o97Iq30wWnVFSQRWCMJyyezj/La+UuCel2rWp/oESku7
         ZGzA==
Received: by 10.236.161.73 with SMTP id v49mr1921060yhk.89.1338464099983;
        Thu, 31 May 2012 04:34:59 -0700 (PDT)
Received: by 10.236.161.73 with SMTP id v49mr1921050yhk.89.1338464099868; Thu,
 31 May 2012 04:34:59 -0700 (PDT)
Received: by 10.101.155.23 with HTTP; Thu, 31 May 2012 04:34:59 -0700 (PDT)
In-Reply-To: <20120524143337.GB3732@burratino>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQleCFM5hkaw8tmnL9CHYPaDn7VO0eqGHrhrBJStJhjnQN0nBfui2+sbzrlJ+hG5WvsZldnqrWKPXsY6UBDs9g6Vi5x7Ai98e9E/bSFXdIy37ZG4rP1ECPpSHPXiFqkK25UWJUFQ1AIIiLYEGmBeyF1ZLJT+cg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198883>

On Fri, May 25, 2012 at 12:33 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> David Barr wrote:
>
>> vcs-svn/svndiff.c:278:3: warning: expression result unused [-Wunused=
-value]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error("invalid delta: incorrect post=
image length");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~
>> In file included from vcs-svn/svndiff.c:6:
>> vcs-svn/compat-util.h:18:61: note: instantiated from:
>> #define error(...) (fprintf(stderr, "error: " __VA_ARGS__), -1)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^~
>
> Yuck. =A0Would you be ok with an inline variadic function?
>
> =A0static inline int error(const char *fmt, ...)
> =A0{
> =A0 =A0 =A0 =A0va_list ap;
>
> =A0 =A0 =A0 =A0fprintf(stderr, "error: ");
>
> =A0 =A0 =A0 =A0va_start(ap, fmt);
> =A0 =A0 =A0 =A0vfprintf(stderr, fmt, ap)
> =A0 =A0 =A0 =A0va_end(ap);
>
> =A0 =A0 =A0 =A0fprintf(stderr, "\n");
>
> =A0 =A0 =A0 =A0return -1;
> =A0}
>
> The error() macro above also seems to leave out a newline.
>
>> --- a/vcs-svn/svndiff.c
>> +++ b/vcs-svn/svndiff.c
>> @@ -258,6 +258,7 @@ static int apply_window_in_core(struct window *c=
tx)
> [...]
>> @@ -275,16 +276,15 @@ static int apply_one_window(struct line_buffer=
 *delta, off_t *delta_len,
>> =A0 =A0 =A0 if (apply_window_in_core(&ctx))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_out;
>> =A0 =A0 =A0 if (ctx.out.len !=3D out_len) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 error("invalid delta: incorrect postimage =
length");
>> + =A0 =A0 =A0 =A0 =A0 =A0 rv =3D error("invalid delta: incorrect pos=
timage length");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_out;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 if (write_strbuf(&ctx.out, out))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_out;
>> - =A0 =A0 window_release(&ctx);
>> - =A0 =A0 return 0;
>> + =A0 =A0 rv =3D 0;
>> =A0error_out:
>> =A0 =A0 =A0 window_release(&ctx);
>> - =A0 =A0 return -1;
>> + =A0 =A0 return rv;
>
> That said, if this change is justified by saying that it avoids havin=
g
> to repeat the cleanup code, it already looks like a good change. =A0T=
he
> commit message could mention that the original motivation and a
> side-benefit is to help the standalone version that has a slightly
> crazier definition of error().

I'll rework the commit message and requeue.

--
David Barr.
