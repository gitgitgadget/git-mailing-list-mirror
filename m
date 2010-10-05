From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: large files and low memory
Date: Tue, 5 Oct 2010 01:07:04 +0000
Message-ID: <AANLkTinF5-WoYKDOSwMQudnK9SP-EUx3wWhUMi4z1kv3@mail.gmail.com>
References: <20101004092046.GA4382@nibiru.local>
	<AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
	<20101004185854.GA6466@burratino>
	<20101005005715.GB2768@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: weigelt@metux.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 03:07:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2vzv-0005ex-4R
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 03:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755925Ab0JEBHH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 21:07:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52632 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092Ab0JEBHG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 21:07:06 -0400
Received: by iwn5 with SMTP id 5so7604624iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 18:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=mu7dWiEXaB2NIj+ptNtFDRP3gJ/XbUkDJhX2eOzyFSc=;
        b=tKuyhooe0XCdi3e30bXGumOABBPlw1oZFNUTLiXHfTP0DErq3D25H3Bwk9nV1pAx9V
         EH3UuZ0LDiDsn/fVGbdG2khBrQ88ydHz/ZowcwujMs15QJiLsVS8/XGK4SouLHsbqmua
         wpY9+dAOA2MH9LbEEtPrr6LIvTvF5mK9THGEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=oEH1FPCWdUYg8YG2unOagXltbc5y+YyVFtRDnTLgjbDFsz/uzMvIu593YEsuNo2lCe
         b/DYAhWlzSafsy4s2Ca2Hils1tiO0EokWDQsAbzDjOSAjyt7zJb7OzKNbvFCu1+JN+0Q
         mWKotkmxu8lIldkKulg3vQMvgbl0XIQtx/Cmg=
Received: by 10.231.35.11 with SMTP id n11mr3114465ibd.168.1286240824949; Mon,
 04 Oct 2010 18:07:04 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 4 Oct 2010 18:07:04 -0700 (PDT)
In-Reply-To: <20101005005715.GB2768@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158151>

On Tue, Oct 5, 2010 at 00:57, Enrico Weigelt <weigelt@metux.de> wrote:
> * Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Shawn Pearce wrote:
>>
>> > The mmap() isn't the problem. =C2=A0Its the allocation of a buffer=
 that is
>> > larger than the file in order to hold the result of deflating the =
file
>> > before it gets written to disk.
>>
>> Wasn't this already fixed, at least in some cases?
>>
>> commit 9892bebafe0865d8f4f3f18d60a1cfa2d1447cd7 (tags/v1.7.0.2~11^2~=
1)
>> Author: Nicolas Pitre <nico@fluxnic.net>
>> Date: =C2=A0 Sat Feb 20 23:27:31 2010 -0500
>
> I guess I'll have to do a update.
>
> But: latest tag (1.7.3.1) doesnt build:
>
>
> =C2=A0 =C2=A0CC read-cache.o
> =C2=A0 =C2=A0read-cache.c: In function `fill_stat_cache_info':
> =C2=A0 =C2=A0read-cache.c:73: structure has no member named `st_ctim'
> =C2=A0 =C2=A0read-cache.c:74: structure has no member named `st_mtim'
> =C2=A0 =C2=A0read-cache.c: In function `read_index_from':
> =C2=A0 =C2=A0read-cache.c:1334: structure has no member named `st_mti=
m'
> =C2=A0 =C2=A0read-cache.c: In function `write_index':
> =C2=A0 =C2=A0read-cache.c:1614: structure has no member named `st_mti=
m'
> =C2=A0 =C2=A0make: *** [read-cache.o] Fehler 1
>
> Is my libc too old ?

Those lines are accessing members called st_ctime, i.e. with an "e" at
the end, but your errors just report "st_ctim". What gives?
