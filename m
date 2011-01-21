From: Patrick Doyle <wpdster@gmail.com>
Subject: Move git-stash from one machine (or working copy) to another
Date: Fri, 21 Jan 2011 09:54:50 -0500
Message-ID: <AANLkTin2M+dLUOFnAKqNvYn04NumCmmQ331Yfb9ieW-D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 21 15:55:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgIOY-0008Gm-3I
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 15:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab1AUOzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 09:55:12 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45009 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab1AUOzL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 09:55:11 -0500
Received: by fxm20 with SMTP id 20so1849716fxm.19
        for <git@vger.kernel.org>; Fri, 21 Jan 2011 06:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=KogtkiFXvFHSsldCaZVniqkrFMl9zjdyZcWuCykYtkU=;
        b=C0Z8DLo1LvyPl8651D44clk/AslpfsfXHlClbOzJ0kn0yx1xLgQdc/47VnICQ97frQ
         zn7ycqOyZeJ7ZVcmct4eQ3ZIVovveG/sbzthjgcYKzmcJOtRelY2r8296L8aVEDfAGnm
         v+1SmgD4CHg/yW8e9TCh7K3wcv9GAAAop/wvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=BoWmqX/nKu0wmbrLXhGGLjkK5HYlKcL088CcYeCpNnBn201eJgQWGVofM1sK0EoFx2
         qW0ZJKpNOtA4HH5TCmKdMlx0CNvDRQaefeteNKigJ2tIhs0J6o02BBPpmWcdbNYlC0Zj
         DdN4pgmNxfztYss7NBLMijhF2EpTp3FEHAiy4=
Received: by 10.223.79.66 with SMTP id o2mr743828fak.80.1295621710358; Fri, 21
 Jan 2011 06:55:10 -0800 (PST)
Received: by 10.223.121.147 with HTTP; Fri, 21 Jan 2011 06:54:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165374>

Is there an easy way to move work in progress from one machine to another?

One way to do it might be something like this:

machine1$ git checkout -b movewip
machine1$ git add .
machine1$ git commit -m "Moving work in progress"
machine1$ git push origin movewip:movewip

machine2$ git fetch origin movewip:movewip:
machine2$ git checkout movewip
machine2$ git reset HEAD^
machine2$ git stash
machine2$ git checkout master
machine2$ git stash pop

# go through and delete movewip branches on machine1, machine2, and
the origin server

Except for some possible typos, this seems like it would work, but
seems to be awfully clumsy.  Is there a more elegant way to accomplish
this?

It seems to me that if I could git-stash on machine1, take that stash
with me (somehow) to machine2, and then pop it there, that would be
easier.
--wpd
