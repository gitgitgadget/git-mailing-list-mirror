From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Narrow clone implementation difficulty estimate
Date: Sat, 16 May 2009 15:17:01 +1000
Message-ID: <fcaeb9bf0905152217g418c7f38w229f71dd047bb466@mail.gmail.com>
References: <200905141404.30695.angavrilov@gmail.com> <m38wl0klxt.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org,
	Asger Ottar Alstrup <asger@ottaralstrup.dk>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 16 07:17:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5CH5-0006De-Vv
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 07:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbZEPFRY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 May 2009 01:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbZEPFRX
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 01:17:23 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:52366 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbZEPFRW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 May 2009 01:17:22 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1326518ywb.1
        for <git@vger.kernel.org>; Fri, 15 May 2009 22:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zH62vK9GpbV9ntuTcuuclpldswbHTZdDaASfKUWnT00=;
        b=ImF/4kGT+dsnGe5JzRC58zhv/FtkDbz/YkW5onh2PztLAzx73Yg67SRvAJOl8xSpJb
         Tp4b9Wor5OSMxnSmtt5UCbTVL5Hh5hkC5gAvHcOnCc4sCi+LGjN6tnEIcwi8f1k9ewEx
         3NSQsfeu40QZC9KbbyWGt4mcYzEzQT9PnJuJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LYkRgeGo0mFUdoJtbjJZ1bSSeQdTY4r1PfqA26esy/yw71QLHo8PFlxFkGEAir+v2m
         rvwAGRMlyKTROBWJf81r5/FrdoDRz3GSo4CbI/xuRGHBFm9AY5mQ3LT57BvuezM+6LU/
         Pls+8kS3g3WfesjIGl2k9mjZoxyDpPezfL33I=
Received: by 10.100.46.4 with SMTP id t4mr281849ant.80.1242451043041; Fri, 15 
	May 2009 22:17:23 -0700 (PDT)
In-Reply-To: <m38wl0klxt.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119336>

On Thu, May 14, 2009 at 8:39 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Alexander Gavrilov <angavrilov@gmail.com> writes:
>
>> We are considering using Git to manage a large set of mostly binary
>> files (large images, pdf files, open-office documents, etc). The
>> amount of data is such that it is infeasible to force every user
>> to download all of it, so it is necessary to implement a partial
>> retrieval scheme.
>>
>> In particular, we need to decide whether it is better to invest
>> effort into implementing Narrow Clone, or partitioning and
>> reorganizing the data set into submodules (the latter may prove
>> to be almost impossible for this data set). We will most likely
>> develop a new, very simplified GUI for non-technical users,
>> so the details of both possible approaches will be hidden
>> under the hood.
>
> First, there were quite complete, although as far as I know newer
> accepted into git, work on narrow / sparse / subtree / partial
> *checkout*. =C2=A0IIRC the general idea about extening or (ab)using
> assume-unchanged mechanism was accepted, but the problem was in the
> user interface details (I think that porcelain part was quite well
> accepted, except hesitation whether to use/extend existing flag, or
> create new for the purpose of narrow checkout). =C2=A0You can search
> archive for that
> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/89900
> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/90016
> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/77046
> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/50256
> =C2=A0...
> should give you some idea what to search for. This is of course
> only part of solution.

=46WIW I still maintain the patch series as a merged branch "tp/sco"
under my branch "inst" here

http://repo.or.cz/w/git/pclouds.git?a=3Dshortlog;h=3Drefs/heads/inst
--=20
Duy
