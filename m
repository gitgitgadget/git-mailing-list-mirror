From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] builtin/rm.c: Use ALLOG_GROW instead of alloc_nr and xrealloc.
Date: Mon, 13 Dec 2010 23:56:23 -0200
Message-ID: <AANLkTim7yC9ZZHBQFtRYeyABn7=BTfAdgwd6-aJhNd0c@mail.gmail.com>
References: <a09428c75202974dc69b613ae3c2096d82e5a0ca.1292290546.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 14 02:56:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSK7z-0005cw-9S
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 02:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758992Ab0LNB40 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 20:56:26 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:42381 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758985Ab0LNB4Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 20:56:25 -0500
Received: by bwz16 with SMTP id 16so200705bwz.4
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 17:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=bKzX+yB/NpN/xZ95DiQliRQKHDwhndJOqxYB/ab4YHs=;
        b=N8Vio++vqSGi/j12dGn3zVZghUbpRJNp20EHe6xwGGU+FCB2b4VZSxpiMHDBbxc4q0
         SJfeg0r0Y8t4G/wK7KLoRHD62sBL7t7pVXnYzhNVrwgYzQC49HEDKYECPQg95SuvdVXk
         HxVsJqunkLCCW0OihHk8R6/KKVZi2QZVPQDNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=pASIMgLMb0uF6AKI1kZYPjcL6LYMfSqtaJ0QvQbkr28pjf1qMhHj+tWYENztscDI1o
         vIH5yox6MT6vWfbrTqKW9UST+Lz7RsBnbj3EJ7cC3K2AlNYJ+8pGZyq76htxrndriV9s
         XuOFnR6mybKOy/+F3Kmc1L/F+6/A/OeQvjikw=
Received: by 10.204.75.79 with SMTP id x15mr3938840bkj.124.1292291783463; Mon,
 13 Dec 2010 17:56:23 -0800 (PST)
Received: by 10.204.141.82 with HTTP; Mon, 13 Dec 2010 17:56:23 -0800 (PST)
In-Reply-To: <a09428c75202974dc69b613ae3c2096d82e5a0ca.1292290546.git.tfransosi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163610>

On Mon, Dec 13, 2010 at 11:37 PM, Thiago Farina <tfransosi@gmail.com> w=
rote:
> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
> ---
> =C2=A0builtin/rm.c | =C2=A0 =C2=A05 +----
> =C2=A01 files changed, 1 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/rm.c b/builtin/rm.c
> index c7b7bb3..faeedfc 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -22,10 +22,7 @@ static struct {
>
> =C2=A0static void add_list(const char *name)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 if (list.nr >=3D list.alloc) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list.alloc =3D all=
oc_nr(list.alloc);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list.name =3D xrea=
lloc(list.name, list.alloc * sizeof(const char *));
> - =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 ALLOC_GROW(list.name, list.nr + 1, list.alloc)=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0list.name[list.nr++] =3D name;
> =C2=A0}
>

Disregard this, as I made a typo in the subject. Sent another patch
with the subject typo fixed. Thanks.
