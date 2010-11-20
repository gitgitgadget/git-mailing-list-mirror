From: Joshua Juran <jjuran@gmail.com>
Subject: Re: [PATCH] branch: support sorting branches by mtime
Date: Fri, 19 Nov 2010 20:22:19 -0800
Message-ID: <21836339-5F7E-4485-97CB-FC609CE4E364@gmail.com>
References: <1290090126-14471-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 20 05:22:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJey7-0004Gr-I9
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 05:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757568Ab0KTEWZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Nov 2010 23:22:25 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64388 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755152Ab0KTEWY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 23:22:24 -0500
Received: by pvh1 with SMTP id 1so830263pvh.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 20:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=5NwTrxh5IN5ruAOJvm/e5vkjRSPBArU8neGPeAJqRIQ=;
        b=B4a6LPyiQ5sB+n+HbAAYJkkIgKjh0gBitp1jqhZLxhN8ig4H/1tXxx7th3Y/K4sc7K
         RcIcn8mHjiykHJUfdu2kDbcAN8BE6KVXQ1GSso/KTLAvXdg9o9MXop7ze2LnmN7pyl+p
         +HU//G4wj5yR2TzEMaDb4FLjQuuDjlcOix9a0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=hVOgKl0ZiGavcMeorWmhllqT9IC9F+BCcBoJYFsVIsDAS8hFrHvBe3ed1NRisbQbMO
         ZVvLDUjD2D6+1T9D+jqAn1JeRFo3NVVbEel7YAI5GwvpesV69H6fQND+CcN/0RRQ6vOD
         OX/s7541orT2CrllRMM6LnzmOXz3RyRqxRLIo=
Received: by 10.142.172.9 with SMTP id u9mr2498277wfe.197.1290226943960;
        Fri, 19 Nov 2010 20:22:23 -0800 (PST)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id w27sm2746741wfd.9.2010.11.19.20.22.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 20:22:21 -0800 (PST)
In-Reply-To: <1290090126-14471-1-git-send-email-pclouds@gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161820>

On Nov 18, 2010, at 6:22 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
wrote:

> I lost in my branches again while looking for a topic that I feel lik=
e
> working on tonight. Too old branches are out of question.
>
> This throwaway patch demonstrates the idea. I should have looked into
> reflog for this kind of information, but my laziness won over me.
>
> OK Git's fun time is over..
> ---
> builtin/branch.c |   32 ++++++++++++++++++++++++++++----
> 1 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 87976f0..fdc2714 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -232,6 +232,7 @@ struct ref_item {
> 	char *name;
> 	char *dest;
> 	unsigned int kind, len;
> +	unsigned long mtime;
> 	struct commit *commit;
> };

It's possible to have 32-bit long and 64-bit time_t.

Josh
