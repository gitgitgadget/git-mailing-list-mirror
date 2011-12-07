From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Debugging git-commit slowness on a large repo
Date: Wed, 7 Dec 2011 09:08:55 +0700
Message-ID: <CACsJy8Dbd+v+8FzvQS9a4C8DQSxQGgqQNGaLhL1cHv-yMnaCJQ@mail.gmail.com>
References: <20111203002347.GB2950@centaur.lab.cmartin.tk> <CB04005C.2C669%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Tomas Carnecky <tom@dbservice.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 03:09:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY6wu-0007wx-NF
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 03:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414Ab1LGCJ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 21:09:28 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53677 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab1LGCJ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 21:09:27 -0500
Received: by eekd41 with SMTP id d41so37107eek.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 18:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YQ3ONYYXQWsFxNa737cgMSFXdiyQ9OI14GbNn6AMMJU=;
        b=oOJnakmq8dL0ysfePnDzrL8BW8EOLUQtdj1ZtsBsFFzpiPUe/bnZ3YsdOMQwDBi0gD
         /IybOA5U5RaDHR6SWZG+fTuDkwV2BrPsctlo4fHnqPLA2jmU/hsck4cYT87PhKiDrb9k
         NAQMZcHbGn+DkDUdo6vOxgKL5LFwpnok6lg0I=
Received: by 10.14.23.129 with SMTP id v1mr3041298eev.227.1323223766260; Tue,
 06 Dec 2011 18:09:26 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Tue, 6 Dec 2011 18:08:55 -0800 (PST)
In-Reply-To: <CB04005C.2C669%joshua.redstone@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186413>

On Wed, Dec 7, 2011 at 8:48 AM, Joshua Redstone <joshua.redstone@fb.com=
> wrote:
> I tried doing a 'git read-tree HEAD' before each 'git add ; git commi=
t'
> iteration, and the time for git-commit jumped from about 1 second to =
about
> 8 seconds. =C2=A0That is a pretty dramatic slowdown. =C2=A0Any idea w=
hy? =C2=A0I wonder
> if that's related to the overall commit slowness.

How big is your working directory? "git ls-files | wc -l" should show
it. Try "git read-tree HEAD; git add; git write-tree" and see if the
write-tree part takes as much time as commit. write-tree is mainly
about cache-tree generation.

> @Carlos and/or @Junio, can you point me at any docs/code to understan=
d
> what a tree-cache is and how it differs from the index? =C2=A0I did a=
 google
> search for [git tree-cache index], but nothing popped out.

Have a look at Documentation/technical/index-format.txt. Cache tree
extension is near the end.
--=20
Duy
