From: Joshua Juran <jjuran@gmail.com>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Tue, 27 Jul 2010 16:39:14 -0700
Message-ID: <9E67A084-4EDB-4CCB-A771-11B97107F4EF@gmail.com>
References: <20100727122018.GA26780@pvv.org> <AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 01:39:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odtk2-0002h7-0K
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 01:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab0G0XjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 19:39:17 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41651 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551Ab0G0XjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 19:39:16 -0400
Received: by pzk26 with SMTP id 26so1589966pzk.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 16:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=PexcMOvZMqOGiKSg6LzE+stDY8J7qRavPXGC64bzQqA=;
        b=n+aaDnlZGh/G6sOJi2hC16R84jJtdDMXjHyfgq9Bu32fTFJQoL/UcqGO1RJh2o9SD9
         XfpzLvfmz5V/DVrnPlwmRUN3I1gztdR1Mjm6JvtwmK2xYpGLaTwcuZba6kKBM2RKgiGD
         6eaZue8McbtVfX96Ph80yybj8KV/YgTG/SAUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=SO8IWmrcpwNDj3saSrgFL7Vqc7FWhTXIaqfsrbJlxGDZ7jYNNV9Kl8FRiU90QWxvKx
         D39Te8XudliRr1yQh9ihelffNp8wmhtuwgNf6v0JN3VoJgW47mfVXuIfOpTkUXHWcrZc
         Zf4O0nC7Ee5rdnnBrh9N5i3D25slNo31YEYWk=
Received: by 10.142.153.8 with SMTP id a8mr11092357wfe.55.1280273956070;
        Tue, 27 Jul 2010 16:39:16 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id 33sm6275106wfg.9.2010.07.27.16.39.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 16:39:15 -0700 (PDT)
In-Reply-To: <AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152016>

On Jul 27, 2010, at 4:29 PM, Avery Pennarun wrote:

> An inotify daemon could easily keep track of which files have been
> added that aren't in the index... but where would it put the list of
> files git doesn't know about?  Do they go in the index with a special
> NOT_REALLY_INDEXED flag?

One option is not to write it to disk at all.  The client could  
consult the daemon directly.

Josh
