From: Mika Fischer <mika.fischer@zoopnet.de>
Subject: Re: git slow over https
Date: Sat, 29 Oct 2011 17:15:17 +0200
Message-ID: <CAOs=hR+hWPRBNqmwwnizMkux_84MOu1=GrS6kkQRFe5mt0MNvw@mail.gmail.com>
References: <CAOs=hR+K_YZcjdAUq_jaz0wc9k8BRQ2-ny7A=GFaNL4R-W0UBw@mail.gmail.com>
 <alpine.DEB.2.00.1110282019510.28338@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Sat Oct 29 17:19:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKAgg-0006ng-O8
	for gcvg-git-2@lo.gmane.org; Sat, 29 Oct 2011 17:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932944Ab1J2PPm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Oct 2011 11:15:42 -0400
Received: from trillian.zoopnet.de ([85.214.111.199]:33117 "EHLO
	trillian.zoopnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932744Ab1J2PPm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Oct 2011 11:15:42 -0400
Received: from mail-gx0-f174.google.com (mail-gx0-f174.google.com [209.85.161.174])
	by trillian.zoopnet.de (Postfix) with ESMTPSA id 9AE3926E42FD
	for <git@vger.kernel.org>; Sat, 29 Oct 2011 17:15:40 +0200 (CEST)
Received: by ggnb1 with SMTP id b1so4553000ggn.19
        for <git@vger.kernel.org>; Sat, 29 Oct 2011 08:15:39 -0700 (PDT)
Received: by 10.236.152.2 with SMTP id c2mr9197954yhk.36.1319901339163; Sat,
 29 Oct 2011 08:15:39 -0700 (PDT)
Received: by 10.236.60.135 with HTTP; Sat, 29 Oct 2011 08:15:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110282019510.28338@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184454>

Thanks for the pointer. Doing it this way fixes things for me. I'll
send a patch soon. I'd appreciate it if you could check it quicky.

Best,
 Mika

On Fri, Oct 28, 2011 at 20:28, Daniel Stenberg <daniel@haxx.se> wrote:
> On Fri, 28 Oct 2011, Mika Fischer wrote:
>
>> 1) What's the purpose of the select in http.c:673? Can it be removed=
?
>> 2) If it serves a useful purpose, what can be the reason that it hur=
ts
>> performance so much in my case?
>
> The purpose must be to avoid busy-looping in case there's nothing to =
read.
>
> It should probably use curl_multi_fdset [1] to get a decent set to wa=
it for
> instead so that it'll return fast if there is pending data. The timeo=
ut for
> select can in fact also get extended with the use of curl_multi_timeo=
ut [2].
>
> 1 =3D http://curl.haxx.se/libcurl/c/curl_multi_fdset.html
> 2 =3D http://curl.haxx.se/libcurl/c/curl_multi_timeout.html
>
> --
>
> =C2=A0/ daniel.haxx.se
>
>
