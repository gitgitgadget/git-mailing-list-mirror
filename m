From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-p4.py: Don't try to rebase on submit from bare repository
Date: Fri, 19 Feb 2016 13:40:45 -0500
Message-ID: <CAPig+cQA4sJ2RneG8zRsUx+bDPAMYVtmhFjZx5SOGDqnsKNUaQ@mail.gmail.com>
References: <xmqqy4agd3b1.fsf@gitster.mtv.corp.google.com>
	<1455906431-32140-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>
X-From: git-owner@vger.kernel.org Fri Feb 19 19:40:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWpz1-0005dp-CP
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 19:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1949325AbcBSSkr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2016 13:40:47 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34136 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948884AbcBSSkq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2016 13:40:46 -0500
Received: by mail-vk0-f42.google.com with SMTP id e185so82222566vkb.1
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 10:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=edRRo50BYOmF+oNHe45y3BKy2n/9NtslcwlhIv6L+FA=;
        b=evi041yAPEhp0McpE8Jmqhq8EfyfZt0uU0NGF7kPPKGrzmSLvprd0DT0j3sIgB1la2
         h8qaEhF0FbY7jR55PQ4SXLeJq56+Rwzx9Mak9SGSpieOnzqXbmZ472J62mosF8xwCMp2
         kExoOzpEWu89zmi4Rz3rrXbCn2Hk8JMIxfNccFzERUM2KNHGPkkpQAAJMv7WpBIiqlSK
         hkS5JohS8FysxCUHDM4gL2hIVYFXAY4KG5EfUeQD/k1n1RFVv/+DGGmOLhyUx0stxV7P
         t3z9GORGJ5TPqX0h3ErDk87dLOyUZqL2PYSovm1tCt3r16idDIrYJkrFVX5x0/C7M5ei
         JSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=edRRo50BYOmF+oNHe45y3BKy2n/9NtslcwlhIv6L+FA=;
        b=OnxTYVquccH4MXc2Bxg0qjikPebTinWW91/hgyYIaVhYhKlYfY16JibtjsEbeZ8FwE
         UezpHvQNzHK03cCr33rpkqWIXREuW7i//UYdw3NlHmlB1ojHHAUAjz1VC+/+uyD2StoT
         3DR4cheszPiPxJLDydToCncyc01PClj9FntQg4trZsoLTYhxaHyyb/3kWirIufVJu82W
         ivLRCrIupIkoAStymx53a/wz76TC/IzVn2NT21rsTbP2SR0uSjBwJHNrkk7/3iE9uuJs
         P1BLuhPBMcFPpMVRMUoQRRdpB89g9L9C9aTtOdy6319WgBlIMZ9Rh5PpHG1et9vA/wLU
         kcjg==
X-Gm-Message-State: AG10YOSMMDJQNFmGp3MXC+de+CJwGvZ+fD6KJCOgeeLknOlwwnlMOGWZ/Omd4OqE66WupRgG8At0UHDG6v72HA==
X-Received: by 10.31.150.76 with SMTP id y73mr12114635vkd.84.1455907245824;
 Fri, 19 Feb 2016 10:40:45 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Fri, 19 Feb 2016 10:40:45 -0800 (PST)
In-Reply-To: <1455906431-32140-1-git-send-email-aidecoe@aidecoe.name>
X-Google-Sender-Auth: 9_MJepXcIt4C22xDU3OuCiIV4yA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286738>

On Fri, Feb 19, 2016 at 1:27 PM, Amadeusz =C5=BBo=C5=82nowski
<aidecoe@aidecoe.name> wrote:
> git-p4 can be successfully used from bare repository (which acts as a
> bridge between Perforce repository and pure Git repositories). On sub=
mit
> git-p4 performs unconditional rebase. Do rebase only on non-bare
> repositories.

As a person who does not use Perforce, it is not obvious to me from
the commit message why this change is beneficial or even what the
consequences are. Will Perforce users understand this change given
only the explanation above? If not, perhaps it would be helpful to
expand the commit message to explain more thoroughly the impact of
this change and why it is a good idea.

Thanks.

> Signed-off-by: Amadeusz =C5=BBo=C5=82nowski <aidecoe@aidecoe.name>
> ---
>  git-p4.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index c33dece..e00cd02 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2059,8 +2059,9 @@ class P4Submit(Command, P4UserMap):
>                  sync.branch =3D self.branch
>              sync.run([])
>
> -            rebase =3D P4Rebase()
> -            rebase.rebase()
> +            if not gitConfigBool("core.bare"):
> +                rebase =3D P4Rebase()
> +                rebase.rebase()
>
>          else:
>              if len(applied) =3D=3D 0:
> --
> 2.7.0
