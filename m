From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] diff: bugfix: binary file permission regression
Date: Fri, 11 Jun 2010 09:24:37 +0200
Message-ID: <AANLkTikWNaEY5aErPF7OkBMleN_hiFRholfdFXLF1cJO@mail.gmail.com>
References: <1276194685-28098-1-git-send-email-ayiehere@gmail.com>
	<AANLkTimwmkMnaqMY44SeHz1L8hE2Lp324PXPY4eqvTGb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 09:24:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMybb-0000J3-Ga
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 09:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab0FKHYj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 03:24:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35628 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869Ab0FKHYi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jun 2010 03:24:38 -0400
Received: by fxm8 with SMTP id 8so426282fxm.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U5dQzh8gs9xmNJBusx5AjlQhRm7PLdmeabGxvboEpyA=;
        b=U1a0dh9r+opPgndA11UgWvS/dx5JZap8lDAKyAwqKPUjM+2kylt4nqbisKtsOQhW9I
         smmV26EhtS5rMIvWG2+lhUpWmndOIWdz26xYwqEGwtHEmrNMDP7MYRq9Umx0umstl6bm
         x9BcITIu1/U3Abdf1lmvNjMmyXvcKY6RaGmu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GHFGGu4zs1bnfpTsQzAIv9YTX72JG2aOucQBQhjS3vcMg9b13wDDdm3bLj42VSS/hL
         LMgsZjEhNuXKQ6nv6dfv/d6iICykctZ97vQ3UC8uS6GfHk04EnsdaArBgQ1QCOCu9B94
         rET5hUQ1MN9396S+Pnnae5xaXA3r+/bcWFT6w=
Received: by 10.102.210.18 with SMTP id i18mr371303mug.92.1276241077066; Fri, 
	11 Jun 2010 00:24:37 -0700 (PDT)
Received: by 10.103.221.13 with HTTP; Fri, 11 Jun 2010 00:24:37 -0700 (PDT)
In-Reply-To: <AANLkTimwmkMnaqMY44SeHz1L8hE2Lp324PXPY4eqvTGb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148928>

On Fri, Jun 11, 2010 at 9:06 AM, Nazri Ramliy <ayiehere@gmail.com> wrot=
e:
> On Fri, Jun 11, 2010 at 2:31 AM, Nazri Ramliy <ayiehere@gmail.com> wr=
ote:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0(!textconv_two && diff_filespec_is_binary=
(two)) )) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (fill_mmfile(&mf1, one) < 0 || fil=
l_mmfile(&mf2, two) < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("unable to read f=
iles to diff");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(o->file, "%s", header.buf);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_reset(&header);
>
> =A0Since the fill_mmfile()s could result in a die maybe it's
> =A0better if the header is printed before the read attempt?:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0(!textconv_two && diff_filespec_is_binary(=
two)) )) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(o->file, "%s", header.buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_reset(&header);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (fill_mmfile(&mf1, one) < 0 || fill=
_mmfile(&mf2, two) < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("unable to read fi=
les to diff");
>
> I did this on my work tree and ran 'make' in the test directory and n=
o errors
> were reported.

Hi,

Please have a look at this thread:

http://thread.gmane.org/gmane.comp.version-control.git/147732/

The patch resulting from the thread is currently in next and pu.

Thanks,
Christian.
