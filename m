From: Elliott Cable <me@ell.io>
Subject: `format:%>` padding and `git log --graph`
Date: Sun, 20 Dec 2015 10:41:44 -0600
Message-ID: <CAPZ477ObN53VffNVvHVuqT0MQ2Csu70i0+himmmjvPj1wfXjUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 17:42:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAh3q-0003fI-Ly
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 17:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933398AbbLTQmJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Dec 2015 11:42:09 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36104 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305AbbLTQmG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Dec 2015 11:42:06 -0500
Received: by mail-vk0-f52.google.com with SMTP id f2so51021736vkb.3
        for <git@vger.kernel.org>; Sun, 20 Dec 2015 08:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ell.io; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=wwuTMfsLXkE0+PnvunYlGoTUPqmRZch+gbO35B8eZW8=;
        b=gHaPK/iIt6+TTF7nA2rnBlvi3L2+M0ANDsj26W7gl6Zs9TOynTUo+ZaowouxtnIFQ2
         bBDd5PILH8M2u4etxu1kZIXUxhXbtXhabNGS7Jc/vc5XeEMZS7O3VdjgQSfmDPFgO/T5
         mjUwkr5DjYJqWS+KWvaVo20WbnV90DLCFjnlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=wwuTMfsLXkE0+PnvunYlGoTUPqmRZch+gbO35B8eZW8=;
        b=Bs/E9raD1PGuVjEBjsHDvxR/zeTmxyRXhR1EtFkS7YvdILPRNJNXZQ3L12TZb7Zfso
         LFojjlLpJqr980Ey4DeIz4aIlem5bSXC2Hteap2iENmy9+e4Iyp7mgzlCQjhUYDO79MN
         XIxWOw5/y/v8rf1TfBtpj4FAkvPeUEOIRz2GtK4ktuNHi4Ovsna2nZWtO3fR+BP+fUek
         WWxKBkomAqer5K/HRTSwwdfKpVVaK81WVF4lLX7qYC860G34IvEU+WvitstvR/mnzXuu
         M0u9i/0XXdNj+6IkkHM3QYkJF9mT5Xi3IyaO0V6Hx/w+qVYlJGNChwSHBw7TsXEJ7IUZ
         8usQ==
X-Gm-Message-State: ALoCoQkJHRiNfAsjvStEiib9t8HjAp6yP+THLajv1Ix5OtVaNRBrZpmzelHgbAYGHX+s4UMV3Jewq5FQIwPXvgIWHv0PZj6xcA==
X-Received: by 10.31.8.83 with SMTP id 80mr9546941vki.105.1450629724884; Sun,
 20 Dec 2015 08:42:04 -0800 (PST)
Received: by 10.103.74.29 with HTTP; Sun, 20 Dec 2015 08:41:44 -0800 (PST)
X-Originating-IP: [204.14.154.133]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282771>

I'm not sure what version the `%>` / `<|` / etc padding showed up in,
but they're truly excellent for building beautiful one-line `git log`
output.

This may be a long-shot, but, unfortunately, these new formats sort of
fall flat in the presence of `git log --graph`: The =E2=80=98pad until =
column=E2=80=99
feature, which when reading the manpage, I desperately hoped
*specifically exists* to replace the normal =E2=80=98pad with spaces=E2=
=80=99 in
situations where `--graph` adds an un-known number of characters to the
start of the line ... unfortunately doesn't seem to work that way.

=46or instance, here's some truncated output from a basic `--graph`:

    $ git log --graph --abbrev=3D8 --pretty=3D"tformat:%h %s"
    ...
    * | a4402023 + basic boilerplate for Liability / LiabilityFamily
    * |   32ed6de8 Merge branch 'queueless' into queueless+
    |\ \
    | * \   1e53ea10 (merge misc) Bring in some `bats` fixes, and re-st=
y
    | |\ \
    | | |/
    | | * c8c270ff (!! new doc) Add rationale for basically *all* of th=
e

Here's what `%>|(16)%h` gives me:

    $ git log --graph --abbrev=3D8 --pretty=3D"tformat:%>|(16)%h %s"
    ...
    * |         a4402023 + basic boilerplate for Liability / LiabilityF=
a
    * |           32ed6de8 Merge branch 'queueless' into queueless+
    |\ \
    | * \           1e53ea10 (merge misc) Bring in some `bats` fixes, a=
n
    | |\ \
    | | |/
    | | *         c8c270ff (!! new doc) Add rationale for basically *al=
l

Here's something like what I'd *like* to have seen:

    $ git log --graph --abbrev=3D8 --pretty=3D"tformat:%>|(16)%h %s"
    ...
    * |     a4402023 + basic boilerplate for Liability / LiabilityFamil=
y
    * |     32ed6de8 Merge branch 'queueless' into queueless+
    |\ \
    | * \   1e53ea10 (merge misc) Bring in some `bats` fixes, and re-st=
y
    | * \   1e53ea10 (merge misc) Bring in some `bats` fixes, and re-st=
y
    | |\ \
    | | |/
    | | *   c8c270ff (!! new doc) Add rationale for basically *all* of =
t

So: Is this nigh-unimplementable? I once [dove into the git-log
source][patch], and I recall the `--graph` code being terrifying; so if
this is difficult to support, I can see why it would be left out.

If I'm off, though, and this is just an oversight, it'd be really neat
to see somebody implement it! (=3D


=E2=81=93=E2=80=89ELLIOTTCABLE=E2=80=84=E2=80=94=E2=80=84fly safe.
=E2=80=83=E2=80=89http://ell.io/tt

   [patch]: <http://article.gmane.org/gmane.comp.version-control.git/22=
6387>
