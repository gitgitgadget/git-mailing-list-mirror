From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/3] Fix some constness errors in fetch-pack and parseopt conversion
Date: Wed,  2 May 2012 21:38:07 +0700
Message-ID: <1335969490-9181-1-git-send-email-pclouds@gmail.com>
References: <4FA13835.7080204@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 16:42:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPalD-0005Zz-Qw
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 16:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704Ab2EBOmD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 10:42:03 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62615 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab2EBOlo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 10:41:44 -0400
Received: by pbbrp8 with SMTP id rp8so1178845pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=o6kIz0iBRMV5/vnc3dgtLylnTPVtDH5Bu5TnMqtaT8A=;
        b=foX6J0ONfrhtkuR5d9VpVsih+hfmUls6d6WzSW9EHJd9ODUmFE+vGpyKuu+oaDQsSi
         dUEv09sofBOcihldCqgDHo7erDpXI+Bz75d2CaXEGcbvk9j7TG6Mrycsre0PGorgWpZh
         TtOgxXLqswpLUiXoqxSNW5UTa/Adwh7axVtKIHMbPaRUaJjWoShQJrKeK0OXs27LOfoX
         LZO/r9b5ZqU2NtphoqZr7AD9Li3SLTOK2AWQP2Z9P03Uesg7yyl89b2t+miyuuuz86cS
         zBHPJINmMpzJ/w+V5D6682fY5w06cJGO1Y2Vkcx9PIAD+X0d7ZVg+m4PLjQTXcHybDM2
         3KnQ==
Received: by 10.68.226.35 with SMTP id rp3mr38779971pbc.44.1335969703718;
        Wed, 02 May 2012 07:41:43 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id x1sm2147473pbp.50.2012.05.02.07.41.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 07:41:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 02 May 2012 21:38:11 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <4FA13835.7080204@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196830>

On Wed, May 2, 2012 at 8:35 PM, Michael Haggerty <mhagger@alum.mit.edu>=
 wrote:
> On 05/02/2012 01:14 PM, Nguyen Thai Ngoc Duy wrote:
>>
>> On Wed, May 2, 2012 at 5:40 PM,<mhagger@alum.mit.edu>  wrote:
>>>
>>>                const char *arg =3D argv[i];
>>>
>>> -               if (*arg =3D=3D '-') {
>>> -                       if (!prefixcmp(arg, "--upload-pack=3D")) {
>>> -                               args.uploadpack =3D arg + 14;
>>> -                               continue;
>>> -                       }
>>> [...]
>>
>> Ugh, perhaps you can convert the above to parse_options() too while
>> you're making changes in this part? You can say no, I'll do it (my
>> itch anyway).
>
>
> Sorry, I have too many balls in the air already.  But feel free to ve=
to my
> patch if my changes make it harder to switch to parse_options().

No problem. My new patch may slow down your patches to master though.

Michael Haggerty (2):
  cmd_fetch_pack(): declare dest to be const
  cmd_fetch_pack(): fix constness problem and memory leak

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  fetch-pack: use parse_options()

 builtin/fetch-pack.c |  138 ++++++++++++++++++++----------------------=
--------
 fetch-pack.h         |   20 ++++----
 2 files changed, 65 insertions(+), 93 deletions(-)

--=20
1.7.8.36.g69ee2
