From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [tig] Feeding specific revisions to tig
Date: Mon, 27 Apr 2009 12:21:05 +0200
Message-ID: <2c6b72b30904270321t3d73e2c5o5e3ac8d4b627e5ab@mail.gmail.com>
References: <ae63f8b50806041152v11a2997y9411c5ea3ebc9598@mail.gmail.com> 
	<20080604192916.GB17327@sigill.intra.peff.net> <ae63f8b50806041304i20de789ej492681f4b9306934@mail.gmail.com> 
	<20080604230858.GA27136@sigill.intra.peff.net> <2c6b72b30808060406u10d7b332g22ea28fe5470ddb1@mail.gmail.com> 
	<20080808211916.GA30583@sigill.intra.peff.net> <2c6b72b30808100216j2c719bf2yb7dfba651db901e3@mail.gmail.com> 
	<ae63f8b50904230755p12170753qf3fc273b48afe4d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jean-Baptiste Quenot <jbq@caraldi.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 13:51:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyNxv-0000c1-Gk
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 12:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbZD0KVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 06:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752297AbZD0KVX
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 06:21:23 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:52280 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbZD0KVW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 06:21:22 -0400
Received: by fxm2 with SMTP id 2so2202037fxm.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 03:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=KtCa4MqkAJNt6zA8uTRMPtDQ0NxP+XAYPG9J3EJsreI=;
        b=wuic9o3mUv2XLnRQHQLeEVH6gT4IyyTy8bFlV4tP5rNSs2RB7WJvUzJp59nJELnkiI
         8cVODM8fxuRVIY+yaNJkhIyuT22hbxyNBnbKke8ojXA1DtgVoWvVtzm8o7yx2SdpsW6j
         r0X7h1SuCoux3T2FauIaElqMUJHYxZkwReaXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YoeILbLrLNOojuKeQxCFjaDKgznvQoeHvIThTsNK2cO8OfuPRh8FW/wet4BcwAjsX3
         DhAROyLOGSXXFP3Vf5mrmLF7F1fr1y+ZyzTapE2EZOtZm6lJlQp11QoRUCdBob3rMWtq
         86JP/ZDgD0M1Gd6oiRAGYY1ldUPclMWm541xI=
Received: by 10.103.244.4 with SMTP id w4mr3103296mur.90.1240827680208; Mon, 
	27 Apr 2009 03:21:20 -0700 (PDT)
In-Reply-To: <ae63f8b50904230755p12170753qf3fc273b48afe4d4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117664>

Sorry for the slow reply ...

On Thu, Apr 23, 2009 at 16:55, Jean-Baptiste Quenot <jbq@caraldi.com> wrote:
> 2008/8/10 Jonas Fonseca <jonas.fonseca@gmail.com>:
>>> So here is my cut-and-pastable version:
>>>
>>>  tignowalk() {
>>>    tmp=$(mktemp)
>>>    cat >"$tmp"
>>>    TIG_MAIN_CMD="git rev-list --pretty=raw --no-walk --stdin <$tmp" \
>>>      tig </dev/tty
>>>    rm "$tmp"
>>>  }
>>
>> Thanks for the fixed up version.
>
> Restarting this old thread again.  Starting from 0.13 the
> *tignowalk()* hack does not work anymore.  What's the preferred way to
> feed specific revisions using stdin now?

I don't know if it is preferred, but it works. First add a git alias:

[alias]
        tignowalk-helper = !git rev-list --pretty=raw --no-walk --stdin<

Then modify tignowalk by replacing the line calling tig to say:

TIG_MAIN_CMD="git tignowalk-helper $tmp" tig </dev/tty

... and it should work. Maybe more git alias functionality can
simplify the hack.

-- 
Jonas Fonseca
