From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 23 Mar 2010 14:08:54 +0800
Message-ID: <41f08ee11003222308r63e2edabu5f352a50eea6e0a7@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	 <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	 <4BA544FC.7050007@gmail.com>
	 <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
	 <4BA61CF9.7040104@gmail.com>
	 <41f08ee11003212052p6b0a7495j2e38f24839541ffb@mail.gmail.com>
	 <alpine.DEB.1.00.1003221924110.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 23 07:09:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtxIa-000711-5e
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 07:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab0CWGI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 02:08:56 -0400
Received: from mail-qy0-f182.google.com ([209.85.221.182]:58569 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab0CWGIz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 02:08:55 -0400
Received: by qyk12 with SMTP id 12so3325129qyk.5
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 23:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sJmAQnp8DMuWHmdnRgF/4FcJ7k9a4M6paQQhO/KOo3I=;
        b=V7Pkfuk7Zkgv2FtUyX7LR2B9eDT075Pbjyomubq56MccP8EnyKKjkIX4VdnJRVANOF
         MlF6wzqxCnxKq+nRaYEUcwtLvTkJna+S7qy95kKDfY/lsOh6q3NMY4zBpXMMnh6vuciQ
         jPNAylLNjCyghzYF+kdjVDRWWVZW2HVRCWAVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ul6Ln6IQ+r+8YKeQD4iwnWTwhsFR3eiRcDV0jaljLRoe0GGkXTrsNAaoxoU771ytyA
         5zArvb1RNT3W+cLbkyKhuM4wTRqIFVGPDTVfs7MtBKjPUQtSJgnGcfiM0hSYX7zaalLF
         aShs4b1qiAwd45+wY/c4h8lphH19RCEek553o=
Received: by 10.229.221.78 with SMTP id ib14mr280983qcb.28.1269324534368; Mon, 
	22 Mar 2010 23:08:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1003221924110.7596@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142989>

Hi,

>> Note that, the history may not always be a single thread of commits.
>> If there are more than one commit which produce the specified line
>> range, the thread of history will split.
>
> Do not forget the case where there are more than one source of a code
> move. Think "refactoring".

Yeah, I really ignore such a condition. Thanks a lot!
And any new added code can be moved/copied from multiple source. This
will really be a new problem for the fuzzy matching.

>> =3D=3D=3D=3D=3DWork and technical issues=3D=3D=3D=3D=3D
>> =3D=3DCommand options=3D=3D
>> This new feature should be used for exploring the history of changes
>> for certain line range of code in one file.
>>
>> git log [-m<num>] [-I] [-d depth] [--fuzzy] =A0-L file1@rev1:<start
>> pos>,<end pos> =A0file2@rev2:<start pos>,<end pos>
>
> I would like this not to be specified too much here. For example, we =
do
> not know yet, whether the matching will be fuzzy, or whether we find
> something cleverer than that.

Ok, I will focus on express what I will support instead of command line=
 options.

>
>> =3D=3D=3D=3D=3DMilestones and Timeline=3D=3D=3D=3D=3D
>> In this summer, we will add support of line level history browser fo=
r
>> only one file. The multiple ranges support is currently not in this
>> project.
>>
>> The milestones of the project are:
>> 1. Simple modification change history.
>
> IMHO this should be split into
>
> =A0 =A0 =A0 =A01a) have an initial version which does nothing else th=
an parse
> =A0 =A0 =A0 =A0 =A0 =A0git-log options and a single additional -L, re=
quiring exactly
> =A0 =A0 =A0 =A0 =A0 =A0one file to be specified
>
> =A0 =A0 =A0 =A01b) implement the xdiff callback and identify the comm=
its touching
> =A0 =A0 =A0 =A0 =A0 =A0the line range (this is not completely trivial=
 due to merges)
>

I will make a more specified milestones and timeline, thanks!

Regards!
Bo
