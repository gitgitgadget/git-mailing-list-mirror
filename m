From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v5 02/12] ctype: support iscntrl, ispunct, isxdigit and isprint
Date: Sun, 14 Oct 2012 20:25:10 +0700
Message-ID: <CACsJy8B+6OPkP6ijMDzm+n0eHnDZ4Pj8UO_KasdfEP4wF+_hww@mail.gmail.com>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
 <1350182110-25936-3-git-send-email-pclouds@gmail.com> <507AB73D.8010406@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Oct 14 15:26:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNODI-00008Y-6f
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 15:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab2JNNZl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 09:25:41 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52409 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab2JNNZl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 09:25:41 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so6664252iea.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=c7R/T1NzNjSZzmxyiiSbvku0tQ/nkP2W5SBGoNQOHsQ=;
        b=SPpTgs8sZE4uK6TegBj2Vsp4/I1CMall4v7x0x2RmJm407CfjV6W4KwC+1cv0IDo5H
         myNn6NwH86zPO7OLkw2fmI++RZ2MxFGMZzhknlO46VRHM0dxBj8kgW9lsWdV9v4inNbu
         JKZpn8DbWPYxzCy+PoWTyqv3IpUMKc9uGV0GSBx/nRY9VMdrMVVW9OqC9KDmuaPvp/aQ
         aDpwcvpfNuRyhpiLX14HF9mJEW/bRrS+0CC1DwHiKMacSq8JN7QMIdZJlFqT5afoMkyO
         xIKuXEzJB7bW2qqEzQPG7Xb3PP+n4g6/0JxF2v3TyN0hS+QjUDhrfe/eabhyLypgxjFb
         5icg==
Received: by 10.50.212.97 with SMTP id nj1mr6413587igc.26.1350221140426; Sun,
 14 Oct 2012 06:25:40 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Sun, 14 Oct 2012 06:25:10 -0700 (PDT)
In-Reply-To: <507AB73D.8010406@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207662>

On Sun, Oct 14, 2012 at 7:59 PM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
>> +const unsigned char sane_ctype2[256] =3D {
>> +       CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, =
CN, /*
>> 0..15 */
>> +       CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, =
CN, /*
>> 16..31 */
>> +       0,  PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, =
PU, /*
>> 32..47 */
>> +       XD, XD, XD, XD, XD, XD, XD, XD, XD, XD, PU, PU, PU, PU, PU, =
PU, /*
>> 48..63 */
>> +       PU, 0,  XD, 0,  XD, 0,  XD, 0,  0,  0,  0,  0,  0,  0,  0,  =
0,  /*
>> 64..79 */
>> +       0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  PU, PU, PU, PU, =
PU, /*
>> 80..95 */
>> +       PU, 0,  XD, 0,  XD, 0,  XD, 0,  0,  0,  0,  0,  0,  0,  0,  =
0,  /*
>> 96..111 */
>> +       0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  PU, PU, PU, PU, =
CN, /*
>> 112..127 */
>
>
> Shouldn't [ace] (65, 67, 69) and [ACE] (97, 99, 101) be xdigits as we=
ll?

Hmm.. I generated it from LANG=3DC. I wonder where I got it wrong..

> But how about using the existing hexval_table instead, like this:
>
>         #define isxdigit(x) (hexval_table[(x)] !=3D -1)
>
> With that, couldn't you squeeze the other two classes into the existi=
ng
> sane_type?

No there are still conflicts: 9, 10 and 13 as spaces (vs controls) and
123, 124 and 126 as regex/pathspec special (vs punctuation).

> By the way, I'm working on a patch series for implementing a lot more
> character classes with table lookups.  It grew out of a desire to mak=
e
> bad_ref_char() faster but perhaps got a bit out of hand by now; it's =
at 24
> patches and still not finished.  I'm curious how long we have until i=
t
> escapes. ;-)

I don't think the series is going to graduate any time soon :)
--=20
Duy
