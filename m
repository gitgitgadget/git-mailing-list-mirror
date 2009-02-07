From: David Symonds <dsymonds@gmail.com>
Subject: Re: Article about "git bisect run" on LWN
Date: Sat, 7 Feb 2009 23:55:34 +1100
Message-ID: <ee77f5c20902070455h360d8476re76294735673b4ca@mail.gmail.com>
References: <200902050747.50100.chriscool@tuxfamily.org>
	 <20090205141336.GA28443@elte.hu>
	 <200902060623.16046.chriscool@tuxfamily.org>
	 <200902070541.29955.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Jeff Garzik <jeff@garzik.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 07 13:57:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVmk3-0003rm-Hv
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 13:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbZBGMzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 07:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752785AbZBGMzh
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 07:55:37 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:36313 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbZBGMzg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 07:55:36 -0500
Received: by ewy14 with SMTP id 14so1809302ewy.13
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 04:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zUnp1qCZ+yMKZxQV/ag0rcZI+R0HCBFXvJLaPdGXuzU=;
        b=wLKjbAAN1nxiM7ZKOGIvNIe+54Gkr4/Ww+4QQIFsZl6c7PUTsCVYOu8qalm4qxPOdU
         AbRPnOhJuic4TDlbuVTNAsg0mf/wXoqmnmgXKDnqTDYP1cBmIIfeWeoM+un9SYAi5GAd
         mcmj5ayjZa7TFhZDKa4Jkavm9F98CzJ8A0HiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k655gx6NlpHIK32StEobSi493ONUZztEpiQbUt66paU/EwJODy4eoqXOQSTGTLu0OY
         Ue7UKfgVGUtBzO/LeOXSn1lyYliWu/Gh1MPjIhE52x3kt1CflKDhMOcUU8lCWzYy0N6E
         q6R8Gg5aO62lYyQIpJyfbJ9FujrZPGGmgpJ5A=
Received: by 10.210.35.17 with SMTP id i17mr924500ebi.70.1234011334714; Sat, 
	07 Feb 2009 04:55:34 -0800 (PST)
In-Reply-To: <200902070541.29955.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108847>

On Sat, Feb 7, 2009 at 3:41 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:

> It might be useful to have a list of always good commits too, and use it
> like this:
>
> $ git bisect start <bad> <good> $(cat always_good.txt)
> $ git bisect skip $(cat always_skipped.txt)
> $ git bisect run ./my_test_script.sh

Your test script could just do this at its start instead:

  if cat always_good.txt | grep $(rev-parse HEAD); then
    exit 0
  elif cat always_skipped.txt | grep $(rev-parse HEAD); then
    exit 125
  fi


Dave.
