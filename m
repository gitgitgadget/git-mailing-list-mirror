From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git diff <file> HEAD^:<file> error message
Date: Fri, 13 Jan 2012 00:34:50 +0700
Message-ID: <CACsJy8AFE0R3nfhfJkuZTkvWBmOR8+sPZDqA6SUdH17hgmTnMA@mail.gmail.com>
References: <20120111111831.GB15232@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 18:35:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlOYj-00024l-7r
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 18:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700Ab2ALRfY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 12:35:24 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36419 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275Ab2ALRfX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 12:35:23 -0500
Received: by eaal12 with SMTP id l12so741295eaa.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 09:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=w+m+c8egedTY1vyMB5r7cznZ00BeBqK5cwAn1Y9X9w4=;
        b=iymHkb7Kme73/WxH14iyBij6Qu/KqUgRUBb+3DhKek1vPXteMxpPLIe5ro/dWa0/ka
         NzhDlWUs30S/1/IwvIdecgxnh0QDxfMb/fpd+0g1nQeMKcvIp3Es0bOq9zmJKCRpUMZB
         VlNt4/jn6uEFjaCnKwkcqOPc6M6PLYQ1JsZJw=
Received: by 10.204.128.197 with SMTP id l5mr1618095bks.58.1326389722387; Thu,
 12 Jan 2012 09:35:22 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Thu, 12 Jan 2012 09:34:50 -0800 (PST)
In-Reply-To: <20120111111831.GB15232@beez.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188460>

On Wed, Jan 11, 2012 at 6:18 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.de=
> wrote:
> Hello,
>
> I was trying to figure out why running
>
> =C2=A0 git diff HEAD^:RelNotes RelNotes
>
> gives the expected output (on maint it tells me that the stable
> version changed from 1.7.8.3 to 1.7.8.4) but swapping the arguments
> doesn't.
>
> =C2=A0 git diff RelNotes HEAD^:RelNotes
>
> doesn't show the opposite patch but tells me that RelNotes doesn't
> exist in HEAD^ which is clearly a lie (it sounds like it's a
> misunderstanding on git's part, but it's certainly not the truth).

I find Jonathan's comment [1] interesting: "Meanwhile, there is no
plumbing command to compare two blobs. Strange".

I _think_ the main purpose of git diff is to compare a stage (a
revision, index, worktree) with another stage, filtered by path and
blob-to-blob diff is a minor thing that is needed to support "git diff
<tag> <tag>" where both tags point to a tag. It'd be better to start a
new command that diff between two blobs (or files in worktree/index).
Something pretty close to --no-index. You would not need to mess up
with setup_revisions() or verify_filename().

[1] ed84e6d (Documentation: diff can compare blobs - 2010-10-11)
--=20
Duy
