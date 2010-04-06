From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] fix weird git --paginate behavior
Date: Tue, 6 Apr 2010 09:00:03 +0200
Message-ID: <x2zfcaeb9bf1004060000s7672df7dw5804ad54cb272a18@mail.gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com> 
	<1270492888-26589-44-git-send-email-pclouds@gmail.com> <20100406040145.GA30403@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 09:00:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz2lz-0008QC-0N
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 09:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757306Ab0DFHA0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 03:00:26 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:45018 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877Ab0DFHAY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 03:00:24 -0400
Received: by ewy20 with SMTP id 20so307556ewy.1
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 00:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=yuGp24dOcQFkXD0p0Tk8PQGO0GABqgLLELOkSs6xHxM=;
        b=CRkubDJ0jJfCn/VyaiSdgt1Up1MIii9OZWZmCZhVNGxL3Rxl1hrQg0hnll9VuqLYQf
         aAZxN78TpKfwVoSkaoOkjwQvUs3L5rCrcnjiGRssCtFulXRfnw35P8ldnBHKDpU/+ZaP
         dRhHDQzLHbzzpjvj+klMvg2Yhz4voQzVvNzDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Xewd0yZIgGw+xmqCRqNLDV/YjEnXGLqazeFtF3tO8zov/1Tnax8fX0G8vEQFUXyOaw
         AcZj+3wFfgXNiaIoRrqJJsUpenkZVl1v/m/W6ZdmjWh+xhi9bjZQcVPdMV/iI04y+RMv
         pz3l/5AbljxVTZ50bkLT4i58KXDAr7JOGO0kw=
Received: by 10.213.105.130 with HTTP; Tue, 6 Apr 2010 00:00:03 -0700 (PDT)
In-Reply-To: <20100406040145.GA30403@progeny.tock>
Received: by 10.213.97.24 with SMTP id j24mr3622443ebn.48.1270537223190; Tue, 
	06 Apr 2010 00:00:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144108>

2010/4/6 Jonathan Nieder <jrnieder@gmail.com>:
> Hi,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Thanks for posting this series.  I had not read it in full before.
>
> The series is very long and it is hard to make certain it does not
> introduce regressions.  Here is my idea for working around this: the
> idea is to grab patches from the series to form short, independently
> justifiable mini-series.  Once most of the functional changes are
> merged, it should be a lot easier to evaluate the core code change
> that makes setup more brittle (which I like a lot).
>
> What do you think?  Is it worth the trouble?

I don't know. There are few independent patches like this. Most of
them will need startup_info struct, introduced in 01/43. I splitted
the series in two parts, with hope that the first (simpler) part could
graduate early. But as you pointed out, even the first part introduced
a regression.

Anyway if you want to pick them out, candidates are:
 - 19-20/43: calculate prefix anyway and remove the hack in index-pack
 - 22-23/43: moving enter_repo(). This makes enter_repo() more
consistent with setup_git_dir*, no real gain.
 - 24/43: the bug only exposes when set_git_dir() is used extensively
in setup_git_dir*, so this patch alone seems useless.

So that's 7 patches shorter if all of them are sent independently.
--=20
Duy
