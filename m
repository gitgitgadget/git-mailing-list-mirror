From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: -C option with pull doesn't seem to be respected in aliases in
 git 2.6.4.
Date: Mon, 21 Dec 2015 16:57:09 +0700
Message-ID: <CACsJy8BDCqX4+i0krS-8Xq2q-4-siwdCcG5+Maqa8XEUU3sVOg@mail.gmail.com>
References: <96FA4EE3-B68F-49B9-896F-38F37E12676D@apple.com> <CACsJy8D=a4NUi+zWj=DVrzRdCxzWA6hp8kCaPAN_Cwv7H7Ohkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Tan <pyokagan@gmail.com>
To: Cameron Esfahani <dirty@apple.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 10:57:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAxDz-0008L6-QZ
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 10:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbbLUJ5n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Dec 2015 04:57:43 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34109 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbbLUJ5l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Dec 2015 04:57:41 -0500
Received: by mail-lb0-f174.google.com with SMTP id pv2so26112631lbb.1
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 01:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FPZzM14wsrOeoOTMb+XMIs5XRsT+2pzcgnaNP4Iq8HE=;
        b=QlmfI+JUiULDsnpUfGhTF8yaYuz67VIt9sdc9VSadqqqy5Vn7+RXnjOoS+6vSwgWeC
         /D6Ze3bvLeNnVSl16wOXc4lRZbInySm8Ji5UiHc384rJaHV9FasxKAqql9qIriEDoHvE
         xSuidagJ+ik8Xhb1MYMQ900FYrxWho8PzPHmYI84vqAs/O5YqDE0iuBWGuFK6sfPzqrR
         YlSv0W1lSVJt6aDAoaA/q0/Yg7TRGLMP/zkkQF/6L519G5G3SFLUNtLsZ621keiMhiXo
         KM/FbqIdspJ1lcyppMuvEMvAxvcO5cEymOTIjG5+e02KKFyMXKygLFtj1Z83bRfmg6lo
         jr8A==
X-Received: by 10.112.202.168 with SMTP id kj8mr5696586lbc.12.1450691859287;
 Mon, 21 Dec 2015 01:57:39 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Mon, 21 Dec 2015 01:57:09 -0800 (PST)
In-Reply-To: <CACsJy8D=a4NUi+zWj=DVrzRdCxzWA6hp8kCaPAN_Cwv7H7Ohkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282788>

On Mon, Dec 21, 2015 at 8:17 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Dec 18, 2015 at 8:35 AM, Cameron Esfahani <dirty@apple.com> w=
rote:
>> I have git project checked out at ~/llvm.  Inside of there, inside o=
f a =E2=80=9Ctools=E2=80=9D directory, I have another project checked o=
ut as =E2=80=9Clldb=E2=80=9D:
>>
>> ~/llvm/tools/lldb
>>
>> I wrote an alias which would help me update all my projects:
>>
>>         all =3D !find . -type d -name .git | sed 's:/.git::' | xargs=
 -I{} -t git -C {} $1 && :
>>
>> This would allow me to be inside of ~/llvm and type "git all pull" a=
nd get all my projects updated.
>>
>> It seems that at some point this broke.  If try to use this alias un=
der git 2.6.4, it only updates the llvm project.
>>
>> The interesting thing is that if I pass fetch, instead of pull: "git=
 all fetch", then it seems to work correctly.

Because the difference between git-fetch and git-pull in git.c is
NEED_WORK_TREE. Can you try to unset GIT_WORK_TREE before "find"? This
could be yet another regression from d95138e (setup: set env
$GIT_WORK_TREE when work tree is set, like $GIT_DIR - 2015-06-26)
--=20
Duy
