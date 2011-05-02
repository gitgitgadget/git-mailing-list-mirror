From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC 0/4] grep: support to match by line number
Date: Mon, 2 May 2011 20:54:16 +0200
Message-ID: <BANLkTinVvJgE0+gxm8SdDi30-a11P2HnNA@mail.gmail.com>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
	<7vfwoxoy5c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:54:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGyGF-0002b8-NY
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 20:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261Ab1EBSyS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 14:54:18 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49830 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab1EBSyR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 14:54:17 -0400
Received: by fxm17 with SMTP id 17so3828762fxm.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 11:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zXHzyFW61CEo1Wuq5UKbsH1pwos63P0+jsrgVEJeG5c=;
        b=hBm3J3Dc94CYjcbk8hcJ0M5lRS8JsupddeXbRsrS/tkFzNrTveyZN3TvGAreQr9lE2
         FyA8ne+mbbPnMg3QJTiL5H9F2fPfo/GZ2n8H6dwICZnBrVJucwmDMEOHQ0NJNbWtTfdN
         J+ZVkYF6VShb5cscW7h2mEOFjqZfLeeyCF7hM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q6CkoSd8CgSxMWU4JPF32u4jiRm3Q6CEJm+shzLyfP9Ui+Voak8ObXfTZD6MMkUoJP
         E3GV3ifeYyOHb1SRv8f/nbiuTVaSw0JVzuuHGE4K2PnJ+9rhQ9iTJkCmmyzk/bwH43L4
         z5FFxSPUNHwhmNCl4xMxIjy2bmrhx4CRYUwmQ=
Received: by 10.223.77.92 with SMTP id f28mr3078019fak.37.1304362456234; Mon,
 02 May 2011 11:54:16 -0700 (PDT)
Received: by 10.223.71.205 with HTTP; Mon, 2 May 2011 11:54:16 -0700 (PDT)
In-Reply-To: <7vfwoxoy5c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172615>

On Mon, May 2, 2011 at 18:38, Junio C Hamano <gitster@pobox.com> wrote:
> I am personally not thrilled by what this series attempts to do, but =
first
> a few questions:
>
> =C2=A0- Are there existing non-git "grep" implementations that do thi=
s?

I didn't know of any, until Jakub mentioned the ack tool. And I didn't
look for one. I will answer you 'yes'-questions only in context of my
proposal.

>
> =C2=A0- If yes:
> =C2=A0 - what command option letter do they use to specify line numbe=
r?

I have no strong argument for -@, it was short and -l and -L are
taken, but I wont use this that often on the command line, so a long
option like '--line=3D' is ok for me too.

> =C2=A0 - do they not support a range notation (e.g. -@ 25-30,32-40)?

That was already on my todo list and also mentioned in the last paragra=
ph.

> =C2=A0 - what do they do when given more than one file?

Like the content patterns, they try to match.

>
> =C2=A0- If no:
> =C2=A0 - why not? =C2=A0Is it a sign that this is ill-thought out mis=
feature?

Printing only some lines of a file isn't that hard, and there are
obviously some standard tools which do this fine, but combining this
with the -C and --show-function feature isn't easy. So extending grep
with this feature sounds like the best bet.

> =C2=A0 - perhaps people use something like "sed -n -e 25,30p file" an=
d be
> =C2=A0 =C2=A0 happy?

How would you combine this with git grep HEAD or with multiple files?

Bert
