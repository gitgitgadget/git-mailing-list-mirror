From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/5] enter_repo: avoid duplicating logic, use
 is_git_directory() instead
Date: Sun, 13 Sep 2015 07:49:37 +0700
Message-ID: <CACsJy8CD+cNdM5EppcStJViRA7yPpyAHyUX=ct4LEK6RCrJrFw@mail.gmail.com>
References: <20150715132552.GA28574@lanh> <1440204002-7638-1-git-send-email-pclouds@gmail.com>
 <1440204002-7638-3-git-send-email-pclouds@gmail.com> <xmqq8u8i9okf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, bjornar@snoksrud.no
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 02:50:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZavVC-0005i3-PI
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 02:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884AbbIMAuI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2015 20:50:08 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:33338 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827AbbIMAuH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2015 20:50:07 -0400
Received: by iofh134 with SMTP id h134so133768146iof.0
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 17:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=dh3jS4SRLG6Hhm17smMDKiGUxzfNEL5LqC2laOR0WgI=;
        b=elTpkFmrRZr4h1V21DH3rcXWtnh/24vv5HSr9gGceHoRWlDK/sTDd5xYgntUpHucPH
         jsB9z9Thw4tmx9G+VKPPvL3KGvtzzc6AkkSucbAhSGJRUV9tJ+fjNNiXmgbNFr2DJ2oM
         Mn5q6KmYD0D5dUUDd7kaQIFgmTV+JrW5Af0aliuJLmz2axI3Lv4r3DX5qgWlGPfP8Hfb
         qGakI0tLaE3GcXExWluVpIMJTVv7aW5esnDnzFueV/j+YbJ2lSBBkfndeRGl0FWGeUFk
         vDO+UKb+sw+bDCqRSD8FQZwAONo3vkl7jZJcgJfJV3mMD3iNC2lLNO0gvQWs3UzW+VYk
         RC2g==
X-Received: by 10.107.131.134 with SMTP id n6mr13802576ioi.192.1442105406680;
 Sat, 12 Sep 2015 17:50:06 -0700 (PDT)
Received: by 10.107.19.227 with HTTP; Sat, 12 Sep 2015 17:49:37 -0700 (PDT)
In-Reply-To: <xmqq8u8i9okf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277742>

On Mon, Sep 7, 2015 at 11:33 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> The cover letter talks about "local clone", and in this entire
> series, I saw new tests only for the local case, but doesn't this
> and the next change also affect the case where a Git daemon or a
> upload-pack process is serving the remote repository?
>
> And if so, how is that case affected?

People who serve .git-dir repos should not be affected (I think we
have enough test cases covering that). People can serve .git-file
repos as well, which is sort of tested in the local clone test case
because upload-pack is involved for providing remote refs, I think.
--
Duy
