From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/9] i18n: add PO files to po/
Date: Tue, 4 Oct 2011 09:53:12 +1100
Message-ID: <CACsJy8C1-YaON868Vtn0=o8U0hL=OChVOKydz6A1SmjpSkgUUw@mail.gmail.com>
References: <1317668297-2702-1-git-send-email-avarab@gmail.com> <20111003220659.GA19537@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?Q?Marcin_Cie=C5=9Blak?= <saper@saper.info>,
	Sam Reed <sam@reedyboy.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 00:53:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RArOW-0002Uv-S3
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 00:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab1JCWxo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 18:53:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33767 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab1JCWxn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 18:53:43 -0400
Received: by bkbzt4 with SMTP id zt4so5835277bkb.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 15:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oTyuld2nTTw0nJM33eipXjw6FljEBiyq8/52bFWNnNo=;
        b=R6ACxPF6vxjfOMkGQ1OgXGYPxqPKHu85c1792IPkJ0J0Tr+sYQUOt4CHn2PqPaCPOF
         JJ++JNhYz2kL12H4gKQSomjH30vSMleGFtOMwkc+187Pv63frsoLfQlM5oDpWIiBLM0/
         vPXL5XdDhRm/+za7INxHz8pD29p+LP+Eks64E=
Received: by 10.204.154.136 with SMTP id o8mr219523bkw.355.1317682422098; Mon,
 03 Oct 2011 15:53:42 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Mon, 3 Oct 2011 15:53:12 -0700 (PDT)
In-Reply-To: <20111003220659.GA19537@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182718>

On Tue, Oct 4, 2011 at 9:06 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> 3. Maybe some hero will implement
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git log -p --exclude=3Dpo/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# or
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git log -p -- :(not)po/
>
> to complement "git log -p -- po/". ;-)

I was pursuing the latter, but think again, maybe reuse exclude code
to implement --exclude would be wiser.

One of my motives for negative pathspec is to narrow/extend a narrow
clone. Narrow clone itself should reuse sparse checkout for worktree
part, and sparse checkout uses exclude code already. If I go with
negative pathspec for narrow clone, I would need to invent another
negative-path-based sparse checkout.. That does not make much sense.

I believe a couple of lines in process_trees() in list-objects.c and
adding struct exclude_list* to struct rev_info would be enough for
--exclude, if you want to try.
--=20
Duy
