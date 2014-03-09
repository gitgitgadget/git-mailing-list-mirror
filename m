From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 28/28] count-objects: report unused files in $GIT_DIR/repos/...
Date: Sun, 9 Mar 2014 18:25:02 +0700
Message-ID: <CACsJy8DGSTYxam7Xws=y7as+h7Mppj9yXr_FwDywQxG8p3dr=g@mail.gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com> <1394246900-31535-29-git-send-email-pclouds@gmail.com>
 <CAPig+cQpzYo_VzJfjMCevYm4__bHPSaFLNZSv2MFMA3ondJoSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 12:25:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMbrY-0001Jn-Q4
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 12:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbaCILZe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Mar 2014 07:25:34 -0400
Received: from mail-qa0-f43.google.com ([209.85.216.43]:52023 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbaCILZd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Mar 2014 07:25:33 -0400
Received: by mail-qa0-f43.google.com with SMTP id j15so5793936qaq.2
        for <git@vger.kernel.org>; Sun, 09 Mar 2014 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=xZM6dUNEDr7kS5ywstuYkEQvdxjYQws9Cl7c/MVT1xc=;
        b=xO6z8qf0JrHJrP+SmS5TwTznUtbXNc1SBE73pH4LoLYQ++AbjnP1wdBx6FjhkbiTsr
         HHFKwphjLE90F35IS1wD3gV6o/0d5xw9qRP6xgGRRd0CRORRF4YkqhK1IJdqMA9UL1+u
         Yj+HFWjZAHVFZzsG/5f8hRCfFSSHRDf2XoOq2wrJckPrac6bvpB9y4WiblvJmdTjAM3a
         vf6i3LBPERXjVM+qKcALavPdYBunVDqdSzDX74el9UmwTTn/JNMWTrmtVSOjtHi8BCs7
         if2mQ+GgA9ji9QmcjAJ7bdKxW2apFqbpWzDtRCDi0COIxxfBMj1sKjVbhDSpXuY17XrO
         K4mg==
X-Received: by 10.224.26.71 with SMTP id d7mr1012071qac.89.1394364332385; Sun,
 09 Mar 2014 04:25:32 -0700 (PDT)
Received: by 10.96.215.102 with HTTP; Sun, 9 Mar 2014 04:25:02 -0700 (PDT)
In-Reply-To: <CAPig+cQpzYo_VzJfjMCevYm4__bHPSaFLNZSv2MFMA3ondJoSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243696>

On Sun, Mar 9, 2014 at 3:21 PM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Fri, Mar 7, 2014 at 9:48 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> In linked checkouts, borrowed parts like config is taken from
>> $GIT_COMMON_DIR. $GIT_DIR/config is never used. Report them as
>> garbage.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> diff --git a/path.c b/path.c
>> index ddb5962..5a7dc45 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -4,6 +4,7 @@
>>  #include "cache.h"
>>  #include "strbuf.h"
>>  #include "string-list.h"
>> +#include "dir.h"
>>
>>  static int get_st_mode_bits(const char *path, int *mode)
>>  {
>> @@ -91,9 +92,9 @@ static void replace_dir(struct strbuf *buf, int le=
n, const char *newdir)
>>  }
>
> Do you want to add a comment here explaining what the "!" prefix on
> some entries means, or is it sufficiently self-evident to anyone
> looking at the consumers of this array?

I was hoping it was clear from the patch how this "!" was used (or "/"
in the patch that introduces common_list[]). But if any reader thinks
otherwise, I'm happy to add a comment.
--=20
Duy
