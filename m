From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 02/21] Add parse_pathspec() that converts cmdline args to
 struct pathspec
Date: Thu, 10 Jan 2013 15:26:25 -0800
Message-ID: <CANiSa6iUqZ7E9NWgMfR3bUxZoyhjO2Jz+Z=yjs9vkfmbit7SOg@mail.gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
	<1357453268-12543-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 00:26:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtRWI-00026n-1t
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 00:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab3AJX00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jan 2013 18:26:26 -0500
Received: from mail-ia0-f169.google.com ([209.85.210.169]:46433 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab3AJX0Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jan 2013 18:26:25 -0500
Received: by mail-ia0-f169.google.com with SMTP id r4so1055045iaj.28
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 15:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=A1VConVi6vdBarOLcSstePEposEQW1IY6YYqjU1rJ+o=;
        b=Dw8HnQU96yH/32tN+Jo5PlMZhbeVDd5oaWkUIG7sbek0ZJwftLJZ2IDpiR6p53o3HO
         z+7HcrlqUyogobMXBzFHIDqIOTCzOCubGWvIUWGOfaQ4Sn1X57uzgE87xRMPbMBuhNN/
         K15HjCGhcnIOfxTF80bUWrfoss/TlE2/5J2ErKFMwYSIGZ/3ZV6xkuR7pJZofyKwdpF0
         TqbbZESq55iXPQieVBtqucnP9znRS9rGjFrGvs8hM7/GaD2neAIhkRSlK0qkt2EjdcUG
         27h95Zes+gNRUNNbL4dA54ikacDppV6WiooQ2D/85WFOrUXzmiaKCG5GghEg3HTO2ZEx
         pS6g==
Received: by 10.43.17.199 with SMTP id qd7mr52082182icb.52.1357860385455; Thu,
 10 Jan 2013 15:26:25 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Thu, 10 Jan 2013 15:26:25 -0800 (PST)
In-Reply-To: <1357453268-12543-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213162>

On Sat, Jan 5, 2013 at 10:20 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> +
> +       /* No arguments, no prefix -> no pathspec */
> +       if (!entry && !prefix)
> +               return;
>
> +       /* No arguments with prefix -> prefix pathspec */

When working with the old get_pathspec(), I remember wondering if a
flag switching between "no argument -> prefix pathspec" and "no
argument -> no pathspec" would be worthwhile. I think e.g. 'add' and
'clean' would use the former , while 'reset' and 'commit' would use
the latter. Since you're now changing all the callers of
get_pathspec(), it seems like the perfect time to ask this question.
What do you think?
