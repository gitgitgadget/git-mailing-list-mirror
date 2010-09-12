From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: possible gitattributes eol bug with new eol=crlf | lf support?
Date: Sun, 12 Sep 2010 15:58:43 -0400
Message-ID: <AANLkTi=9Wv9_s2zDEdpc8Dn7qXSRepZSToKkOrAoTQnR@mail.gmail.com>
References: <AANLkTinC8g9m=2ka=7LiHH4MtfxC-NbxbsYQEbmMyXmN@mail.gmail.com>
	<1F2D74A7-1C9C-47D9-9C3D-E430E446CB94@gmail.com>
	<AANLkTi=xPpPZzUqVEHEkH2sKvSVZH+MzunET6vEA_tw5@mail.gmail.com>
	<4F27AD7B-2B2D-4378-B1D5-6F380396E0FF@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 12 21:58:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OushS-0000GS-Uj
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 21:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544Ab0ILT6s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Sep 2010 15:58:48 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61028 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab0ILT6p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Sep 2010 15:58:45 -0400
Received: by ewy23 with SMTP id 23so2452381ewy.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QKEv4mpShl1L4LPLFgBTmz07ZymJO6Aya28yxlgMEnw=;
        b=W0dJ7FVe9R5LkDR8YS4qT6U4LVN9x25e1Ev6Oxom+LuavylMGy7JlLc4LGDr4fw2u0
         TxAUJTAHjbGgmChy2zV2Wv5tNq1rtG+NHoUqPzJgA9LfeSyZ0KYJA6+oMBJpFDcDJxjC
         ocsndl0KLlNiWOJHKayqBvMJOnue9IvhdPT0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=htkDqLX79OPLM3fb/av2l/c21v4mUN96IAD3QlnRwarE7rt7S2d3nwJloM05tO6RGN
         PFTC0+LsE3WqoCr/AcuDsYscUjpcNeIX0QQEWhS7BAplezcv2g+msn/TIzzAuMyRgdze
         R5Rbq77pxMeCnjMduME+GMnpnsBOHfM4pYLJc=
Received: by 10.14.53.1 with SMTP id f1mr2104935eec.36.1284321524041; Sun, 12
 Sep 2010 12:58:44 -0700 (PDT)
Received: by 10.14.4.11 with HTTP; Sun, 12 Sep 2010 12:58:43 -0700 (PDT)
In-Reply-To: <4F27AD7B-2B2D-4378-B1D5-6F380396E0FF@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156047>

Thanks Eyvind,

I tried it on an experimental repository and it worked. Thank you for
your recommendation.

I also found the following link at github which achieves a similar
effect. Adding this for the record in case someone else searching for
a solution in the future wanted more detail.

    http://help.github.com/dealing-with-lineendings/

The one thing I find curious about the github article is that it seems
to recommend using autocrlf=3Dtrue for ALL platforms once the linefeeds
have been normalized.

Let me ask for an opinion about this... Given we have an environment
of mixed Windows, Mac, and Linux developers, that we have just
migrated from svn and over 2000 files in the repository have messed up
line-endings, what would be your recommendation for autocrlf settings?
Oh, important note, because neither cygwin nor msysgit support newer
versions of git, we do not have the flexibility of running your new
"eol" support on Windows, while Linux developers do.

So if we did this one-time normalization on all repositories, all
branches, what holistic approach (eol, autocrlf) would keep our files
sane for a mix of 1.7.2 and later, and 1.7.0.1 and earlier, Windows,
Mac, and Linux?

Thanks Eyvind.

-Bob

On Sun, Sep 12, 2010 at 7:46 AM, Eyvind Bernhardsen
<eyvind.bernhardsen@gmail.com> wrote:
> On 10. sep. 2010, at 23.27, Robert Buck wrote:
>
>> I don't understand the inner workings of .git/index, but is removing
>> that file destructive to history or anything? What are the
>> implications of that delete-command?
>
> Removing the index will lose the changes you've staged ("git add"ed) =
for the next commit, but your working directory won't be touched. =C2=A0=
If you've added a file and then modified or deleted it, you would lose =
the version of that file that was in the index.
>
> "git reset" then rebuilds the index identically to the HEAD commit, b=
ut without the staged changes and (importantly) the stat cache. =C2=A0T=
he point is to make git re-check every file to see if it has been modif=
ied.
>
> Sorry, I should have mentioned the downsides.
>
> - Eyvind
>
>
