From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] add: add --bulk to index all objects into a pack file
Date: Fri, 4 Oct 2013 14:19:45 +0700
Message-ID: <CACsJy8DOziJ9z2p-2BttJf=zZUC6GsRVtKru3R6Kn32-B0tAdA@mail.gmail.com>
References: <1380772811-15415-1-git-send-email-pclouds@gmail.com>
 <1380869871-31631-1-git-send-email-pclouds@gmail.com> <vpqfvshecjg.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 04 09:20:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRzgU-00037T-Ip
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 09:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867Ab3JDHUQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Oct 2013 03:20:16 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:57950 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab3JDHUP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Oct 2013 03:20:15 -0400
Received: by mail-oa0-f47.google.com with SMTP id i1so3552874oag.34
        for <git@vger.kernel.org>; Fri, 04 Oct 2013 00:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4qmwKEpaCxvL9zWj3tSe6k6Mn8O417esaiPMEJtJKyw=;
        b=aN5GpvP5bpN7ngxMXhuPoB6slX+dNuiH094pfB8MB/W6cmUMd5zHRYBhFHXxMMx+IE
         3o6FrBfwmqsYiHMsdBzbx/kn1/6YamHNTEaz0o3INPoyjqPf9XPcModH6hZToxwYmL3H
         +ZW3sF/ii3v0fPqeyzfs84C7nuxTNgYNKUkFWaxJIgg0CYIaGFdvlEKOUCXwtL07KpWo
         K9uxKOKY141qltRzB+tJHfafnUQj+zawNt4FSJtnWGn7R5Avp6r3z+K2HCsNE7XWtKVs
         6jKtJQbtMUwpLFunNLkQ4VNPrr0whfbIhNNZT4EryoektOYyaAkpH6lpg42VvDnVJqyO
         hm6A==
X-Received: by 10.60.52.244 with SMTP id w20mr19465250oeo.30.1380871215170;
 Fri, 04 Oct 2013 00:20:15 -0700 (PDT)
Received: by 10.76.131.130 with HTTP; Fri, 4 Oct 2013 00:19:45 -0700 (PDT)
In-Reply-To: <vpqfvshecjg.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235702>

On Fri, Oct 4, 2013 at 2:10 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> except that it does not deltifies nor sort objects.
>
> I think this should be mentionned in the doc. Otherwise, it seems lik=
e
> "git add --bulk" is like "git add && git repack".

Yep. Will do.

> BTW, will the next "git gc" be efficient after a "add --bulk"? I mean=
:
> will it consider the pack as "already pack" and let it as-is, without
> deltification, or will it get a chance to actually repack efficiently=
?

gc does "repack -A" so all separate packs will be merged. It may delay
gc time though because it'll take more time to hit the loose object
limit. I think pack-objects will try to deltify so we're good. If we
produce bad deltas in --bulk then that's another story because
pack-objects will try to blindly reuse them.
--=20
Duy
