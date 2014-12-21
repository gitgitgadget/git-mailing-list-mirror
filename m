From: Jim Hill <gjthill@gmail.com>
Subject: Re: [PATCH w/signoff] pre-push.sample: Remove unwanted `IFS=' '`.
Date: Sun, 21 Dec 2014 11:12:45 -0800
Message-ID: <CAEE75_0Ff7NfQYUPrA414N9E0AE6LsS2zs0kL=BJ25bjPgom_w@mail.gmail.com>
References: <1419185665-19988-1-git-send-email-gjthill@gmail.com>
	<1419186337-20348-1-git-send-email-gjthill@gmail.com>
	<xmqqtx0obzwm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Aaron Schrab <aaron@schrab.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 20:12:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2lvx-0006wz-FC
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 20:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbaLUTMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 14:12:46 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:38955 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbaLUTMp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 14:12:45 -0500
Received: by mail-ob0-f178.google.com with SMTP id gq1so18690932obb.9
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 11:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xPyNWbVnu1/yunbGKyKWLX3KbrKERADOZBWCBB57h2w=;
        b=Xwwy8k9Da0AtUIsejv8me/QwFVSwIYK8R31Z1p2p1xFl4HsJyjKets+EsaU9YHqIiY
         ZC4TCbzZKHb5YJsAx5gH0UrvJ2TEVnqvfZRHucRjgxyU6vmfumoiAozeB2B/CapCIsqQ
         XdpmL6s2/jND1nMQgeX4XTgR/hvsdfGPfTmg59AJDqgbFdXz1QuLZjCkxOpXbVNRTcSB
         h+F5rTqGE6gO5qm0wXlIpof4WSp80u8MpSbjAoeDbzMK1diSCj/8oLzoJeuOcenTzf5v
         qP2MfziFdihc3/7hVLDumynqaPi3wiGqSIxcgnLu0pT4kG5/0Ox9eu/RSoaCQmUqpGda
         hIug==
X-Received: by 10.60.124.34 with SMTP id mf2mr11020954oeb.6.1419189165217;
 Sun, 21 Dec 2014 11:12:45 -0800 (PST)
Received: by 10.202.201.216 with HTTP; Sun, 21 Dec 2014 11:12:45 -0800 (PST)
In-Reply-To: <xmqqtx0obzwm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261622>

I call it unwanted because the default works fine with the actual
input and explicitly limiting whitespace this way breaks most command
substitution.  For instance, attempting to check only new commits with

    range="$local_sha $(
            git for-each-ref --format='^%(refname)' refs/remotes/$remote
    )"
    # ...
    commit=`git rev-list -n 1 --grep '\bbad string\b' $range`


fails, because the newlines are passed verbatim instead of being
treated as whitespace.

See http://stackoverflow.com/a/27392839/1290731 for the motivation.

Sorry for the capsing, and also for presuming ESP.
