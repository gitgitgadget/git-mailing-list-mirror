From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: ls-tree and wildcards
Date: Sat, 12 May 2012 22:40:49 +0700
Message-ID: <CACsJy8A73D_39ND-aqF0nECcKqjLHeqvEJ_XbT3BJd-0cLV1Nw@mail.gmail.com>
References: <4FAE7CBD.3020605@rotorised.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ryan McCue <lists@rotorised.com>
X-From: git-owner@vger.kernel.org Sat May 12 17:41:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STERo-00065i-A0
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 17:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619Ab2ELPlW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 May 2012 11:41:22 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38147 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab2ELPlV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 May 2012 11:41:21 -0400
Received: by wibhj8 with SMTP id hj8so406427wib.1
        for <git@vger.kernel.org>; Sat, 12 May 2012 08:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PS223lI1TAjyLQv+3NaW11hjiGkafb5+jL94rxLA4M4=;
        b=I1ww93ahfU8iOtNIL4EnI0V/xXqM2bnRLUURobHm5RSp88JSME6Fcu0FOCeNQ2czD1
         LiKU/68XFKuFN1NVwZA7/TXUzMA6yQmGk+TBOuDwmqs9riQU1DJ/XrldvaZDdemqYqU2
         yY4nZk1fE+tAUHLcgp7F4MyWJEF8Eqgjf0d3K06ksung5d2Jz58Ol0kiJDWMUQyl7ad/
         84/jVytCdYe771WLHrkbg2q8rrxkgAYTTx1GsL4FeLQArEArQvNWAc4as2J5ZiyEuPGN
         HXLozX1e/SJ5TtfkFJSSlY0aTo1QhNDjBpq/ttrn9AA5ogQyVXP8cSNO/y2uf0Rj88hh
         /13w==
Received: by 10.180.106.9 with SMTP id gq9mr5056753wib.17.1336837280471; Sat,
 12 May 2012 08:41:20 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Sat, 12 May 2012 08:40:49 -0700 (PDT)
In-Reply-To: <4FAE7CBD.3020605@rotorised.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197736>

On Sat, May 12, 2012 at 10:07 PM, Ryan McCue <lists@rotorised.com> wrot=
e:
> Good evening folks,
>
> I'm attempting to grab relevant information for files in a tree match=
ing a
> given pattern with wildcards. The help for ls-tree indicates that it =
can
> accept a pattern of files to match, however I'm not able to see that.
>
> $ git ls-tree origin/master
> ...
> 100644 blob 8c391e8fb44a38e1389a710ebf8af79612e592a6 =C2=A0 =C2=A0scr=
eenshot-1.png
> 100644 blob ecb7159c1c02567e9cd5da83c254c538d331f733 =C2=A0 =C2=A0scr=
eenshot-2.png
> 100644 blob f58eea7e27f98c01038262b823aa73ccd64cb01e =C2=A0 =C2=A0scr=
eenshot-3.png
> 100644 blob 07e64def408145660cee657a46947077374762cc =C2=A0 =C2=A0scr=
eenshot-4.png
> $ git ls-tree origin/master screenshot*
> $
>
> (I've also tried quoting to ensure it's not bash playing up)
>
> Is there some issue with the command I'm issuing? The documentation s=
eems to
> indicate that I should be getting back the files which match the patt=
ern.

I don't think it ever does. There's a mention of "patterns" in ls-tree
man page, which is misleading. We have the facilities to do that now
("lstree -r patterns" actually) but that might break backward
compatibility. For now I guess you can just do

GIT_INDEX_FILE=3D/tmp/some-temporary-index git read-tree origin/master
GIT_INDEX_FILE=3D/tmp/some-temporary-index ls-files <patterns>

A question that might help us understand your use case and give a
better advice, or improve the system: why do you need that?
--=20
Duy
