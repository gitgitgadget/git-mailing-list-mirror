From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Git SSH Authentication
Date: Sat, 11 Feb 2012 15:53:55 +0530
Message-ID: <CAMK1S_hxUDx8M+JpiDguUETkUhfQzmpHj-s6++BXrknGRMR7vg@mail.gmail.com>
References: <loom.20120211T045801-602@post.gmane.org>
	<CAMK1S_jmY5KvBH8z6YKszroMai4O5ULeCBYGAGFT4CgVUAfmwg@mail.gmail.com>
	<7vty2xn6tl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: isawk <kwasi.gyasiagyei@4things.co.za>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 11:24:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwA7e-0001yj-Q8
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 11:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732Ab2BKKX5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 05:23:57 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:49068 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754550Ab2BKKX4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 05:23:56 -0500
Received: by obcva7 with SMTP id va7so4744646obc.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 02:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=aijDfqJm8/fGWOhqnEsujk/zkvU6JASikcK0oAMhq5M=;
        b=OxAKi7cBSV8py94+X8Wc//VgJKl8MWadPW+JfTZt+th5hzkvRBx9P+N+HoSo3yPjFq
         pibfDeX81qiXWzN6PBR5WZgyWWGD4Gx5zQF1kXxSKKYNSNhgn1Gwe2SroGFzNTOTK0l2
         gdUR4P5yHIccId9neJk4NIMZ7Iabx1e3YV4pU=
Received: by 10.60.12.230 with SMTP id b6mr1635073oec.54.1328955836052; Sat,
 11 Feb 2012 02:23:56 -0800 (PST)
Received: by 10.182.28.161 with HTTP; Sat, 11 Feb 2012 02:23:55 -0800 (PST)
In-Reply-To: <7vty2xn6tl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190507>

On Sat, Feb 11, 2012 at 1:24 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> Common causes of pubkey access fail:
>>
>> =C2=A0 - wrong pubkey being offered: if you are using ssh-agent, mak=
e sure
>> you have 'ssh-add'ed the key you want to offer. =C2=A0Confirm with '=
ssh-add
>> -l'
>
> A failure related to this I saw is to have (too) many keys in ssh-age=
nt,
> and running ssh without telling it which exact key to use. =C2=A0The =
client
> tries each key in turn and the server rejects the connection attempt =
after
> seeing too many keys tried. =C2=A0"ssh -v" is useful to diagnose this=
 mode of
> failure, and an entry in ~/.ssh/config like:
>
> =C2=A0 =C2=A0Host example.com
> =C2=A0 =C2=A0 =C2=A0 =C2=A0User myusernameoverthere
> =C2=A0 =C2=A0 =C2=A0 =C2=A0IdentityFile ~/.ssh/id_rsa-for-example.com
>
> would fix it.

Interesting... I didn't know this, so I checked man sshd_config
looking for exactly how many keys it would fail after.  The setting
seems to be MaxAuthTries, and defaults to 6.

--=20
Sitaram
