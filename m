From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] unpack-trees: do not abort when overwriting an existing
 file with the same content
Date: Mon, 21 Jan 2013 08:35:44 +0700
Message-ID: <CACsJy8C-vRVsC5uj8xqucwMBZ2TEtwSF-58xM2oTSp6RtNAWMg@mail.gmail.com>
References: <1358594648-26851-1-git-send-email-pclouds@gmail.com> <7va9s3n1my.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 02:36:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx6JQ-0000IP-Hc
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 02:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600Ab3AUBgQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2013 20:36:16 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:45014 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab3AUBgP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2013 20:36:15 -0500
Received: by mail-ob0-f180.google.com with SMTP id wd20so5509285obb.11
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 17:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=KfDenAcDSQlIzs9dixseYeLo+6zCNvTAMuhffAzJVVw=;
        b=zRDTWPaQg4/tB86KWwI65RRy+9txHuRPc/87paciaT3aINvFz6YeRqA8mvSot2ljnh
         PeqWJtgEQd4tOXf4XrsMxc+IeISaTLTvBYsaJKok9HfuchRXXigLr4DO1j8taaMGjcUn
         y5SXDfEcRWxtibxVGeJL/OG//QPT9sFigmyaCloyjbYmU3F885MDLzA+qPIN0+IOZk6z
         GJaFT5WHWdsWtukSC6DCKHGuKCsv5XhLEHFf5qOMbUudRPUid88LIbKODJ2WMHr8W6+u
         zwg8q/drLRnkRWF5TcNQ2HgtkmnY8q8Sqow24VQTRPlEHqtbsyLtvv1Cm04azlwjuN56
         d0UQ==
X-Received: by 10.182.0.19 with SMTP id 19mr12859246oba.15.1358732174566; Sun,
 20 Jan 2013 17:36:14 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Sun, 20 Jan 2013 17:35:44 -0800 (PST)
In-Reply-To: <7va9s3n1my.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214068>

On Mon, Jan 21, 2013 at 1:35 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> +     /*
>> +      * If it has the same content that we are going to write down,
>
> write down???

hmm.. "overwrite" then.

>> +      * there's no point in complaining. We still overwrite it in t=
he
>> +      * end though. Permission is not checked so it may be lost.
>> +      */
>
> That is a regression, isn't it?  Is it too cumbersome to avoid
> losing the permission bits by stopping in that case?

I'm not sure how to deal with this case. (Lack of) Executable bit can
be easily restored (unlike file content) if we give the user the list
of changed files. On the other hand, not everybody runs git with a
huge scrollback buffer and warnings can be lost. I guess abort is a
safe choice.
--=20
Duy
