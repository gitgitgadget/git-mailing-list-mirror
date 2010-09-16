From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] dir.c: fix uninitialized memory warning
Date: Thu, 16 Sep 2010 23:13:11 +0000
Message-ID: <AANLkTim4SiuX=aWLeYXKpgvD+Nh1trH8qgf3V36iVa9w@mail.gmail.com>
References: <1284670403-90716-1-git-send-email-patnotz@gmail.com>
	<1284670403-90716-2-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 01:13:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwNdx-0008KQ-S0
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 01:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111Ab0IPXNN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 19:13:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56754 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425Ab0IPXNM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 19:13:12 -0400
Received: by iwn5 with SMTP id 5so1408489iwn.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 16:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5Fir5lY4UNOFXMwcOB6TYX8oVz5yYGZMVRN5NhpsU5E=;
        b=o7rKUqY3xvXVV0ES3NbSsEVbKltIQbqQET1igNZY4asAfo9STGqi208oVMTkCy/Hd8
         MkJhOKhlB2S5GflSVLAymptLN6GizDR1gnoDst9zg+YMCD+EZyoXce8C4r8umuSFBZgU
         xoMYhQdqKlljYNQgypProNeFplFa+hWZ1dUnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=giBfPSsVsAHNezANWHMycOpmk/FcL46Aef6qZnbNn3scq+dSQMSoBpkF5k/urgvN3c
         TTCePrKlg8ABWjZqN5Tass+KEmQebrPZi2T7ZyctPxmjD9mICnw9y+cfn1KVkqaGO3ae
         dioiCCVLVirRjkWhacK/0Y0rWgl/EdvNFUhZw=
Received: by 10.231.182.196 with SMTP id cd4mr4035535ibb.191.1284678791526;
 Thu, 16 Sep 2010 16:13:11 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 16 Sep 2010 16:13:11 -0700 (PDT)
In-Reply-To: <1284670403-90716-2-git-send-email-patnotz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156362>

On Thu, Sep 16, 2010 at 20:53, Pat Notz <patnotz@gmail.com> wrote:
> GCC 4.4.4 on MacOS warns about potential use of uninitialized memory.
>
> Signed-off-by: Pat Notz <patnotz@gmail.com>
> ---
> =C2=A0dir.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 133f472..d1e5e5e 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -232,7 +232,7 @@ int add_excludes_from_file_to_list(const char *fn=
ame,
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stat st;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int fd, i;
> - =C2=A0 =C2=A0 =C2=A0 size_t size;
> + =C2=A0 =C2=A0 =C2=A0 size_t size =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *buf, *entry;

What does the GCC warning say exactl? I.e. what line does it complain
about?

Maybe this is a logic error introduced in v1.7.0-rc0~25^2? I haven't
checked.
