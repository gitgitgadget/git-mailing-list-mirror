From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: object/pack size x5 larger than a fresh clone?
Date: Sat, 24 Jul 2010 22:57:47 +0100
Message-ID: <AANLkTimL+wfu+yMPutq2VHD6vO2AtaF_7FpWt8aZPm1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 23:58:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcmjN-0005h5-1J
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 23:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823Ab0GXV5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 17:57:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39665 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab0GXV5s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 17:57:48 -0400
Received: by fxm14 with SMTP id 14so5592282fxm.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 14:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=+vKHWjOaUTsraMWwiNpZWZ9TZCIV79CaPZamNSr5UNg=;
        b=SJA2zOawDGelZhupv16v5qrden8tFIts3fBfX31T9vgwbTKAxiIp7skf2WW146ZHwd
         cSPK/hZkasDhZvaE577unaiJTCM0SdE8EcKugI7QyzWFixLRbXJLA5pvDj2rHXG01fV9
         YUn8QUiacrns5vFj93vWSV+P0JSdP/S84DW+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=WX+w68PPqwCWacxDQE8C8Ug1K9KeZAu8wXMbLFpWb29hWQlpe/pt9Lrs8KqKbrIS2O
         Ub+6cHJuKIs6yc14LWAoTOIDoGX6rQqBeupTMSwAqe76z4RYk1YtE2gGl2sWTyh+xTNp
         OSkBiFzQYmkU30lWIDTO1x2PyVt8a5OhxuKrw=
Received: by 10.223.106.203 with SMTP id y11mr4771882fao.16.1280008667080; 
	Sat, 24 Jul 2010 14:57:47 -0700 (PDT)
Received: by 10.223.94.156 with HTTP; Sat, 24 Jul 2010 14:57:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151678>

Is there any reason why a fresh git clone has a object pack around
140MB but one that has been updated over the years has it over 700MB?
(even with git gc --aggressive --prune=now and git fsck?)

$ du .git/objects/
711364	.git/objects/pack

$ du *wine/.git/objects/pack
144692	git-wine/.git/objects/pack
144604	wine/.git/objects/pack

I had a problem with git fetch  "Cannot obtain needed object" from
wine's git repository (which seems to be something to do with http
proxy, although AFAIK I don't have one) since about 2 weeks ago which
obviously does not apply to anybody else as I would have heard from
wine-devel.

Editing .git/config to switch from a http url to git url cure it...
but in the course of investigating, I git clone fresh (there are only
about 3 local changes so I could just git-format-patch them and move
them)

http://source.winehq.org/git/wine.git
git://source.winehq.org/git/wine.git

and I am a bit surprised that the new clones are so much smaller than
the one I have been working on these last few years. (I have had the
old one for at least 3-4 years).
