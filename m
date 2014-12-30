From: Stefan Beller <sbeller@google.com>
Subject: About my git workflow; maybe it's useful for others
Date: Mon, 29 Dec 2014 16:22:07 -0800
Message-ID: <CAGZ79kaK-uRAE9-rH=-5t8djAw5e9rwkPjZuw=+XWEq+V6R5Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 01:22:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5kZj-0007jv-Lk
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 01:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbaL3AWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 19:22:11 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:47032 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbaL3AWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 19:22:09 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so12940986iec.38
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 16:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=+d0R4fGSs+E9qA4d7PdVeDqabLoZgVS03xS36t3vxko=;
        b=QYyaAVyyGtbIYUIrXau7cZqWBKmyhQVagVOfK5BdeSKqMad+0pgka/IwvtfYysbkss
         CqkdcRCr4skLY2tU78BsOVEWAcObsFesOESc5Acz6YqRxvqAzT2QTI2oa1V89fnN+Z0i
         A83mVSJvHpEyH8o7hCKakSEffKzTjqmEsHyRa0MxcmMAAk/iQnXD8cPF0zEJeW+3Lv7O
         FgIO+NsZEZXHFFLNdxN5jYlTAXow3z1rA5bL9yYG7zhEpwAuluvDBU+3uF7IWavq8a8o
         AET3eGU7FtYcoXvy57qYfLhmAcIObrh7+22lCwJOIgsp4l8AR7NFozSuhh4mCcCKde33
         ZQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=+d0R4fGSs+E9qA4d7PdVeDqabLoZgVS03xS36t3vxko=;
        b=Z4qgivGFA+cSVTkQ+9zD4fWjFB4SCc0WEnzSIUmAOobHMNsMiwfT30ABXsXKdUf41f
         F7c1eHD95Ett87DVgKRvKW2WU42VJ1oA8e3nhlEJXbhgS1hlzkBhjC6t3TygN2YVCO1s
         APehvI0l7E6m2cOdOCicuSz/xFYoQFXzNdr76KL4dX9/DLfDnEoIvGQ1n2Fo6oIIkYcZ
         W6tBlctoLhujK24SVN9srT1HEF79e9JkU2cv5fCtR4vJEtnD5wXOsq17OAU6w3/oiOzJ
         Tv7KcRaH5n9qbVUb3QFrIU0oYDG0TsrrNXNwr9ybSPxKKu4cDTqTl/Mub5HUZj6af9LN
         Tklw==
X-Gm-Message-State: ALoCoQnDx7xb7iLYYu5KX5IUR+mlQcvYO5a/LNzK/8CCo/nrH02uncROEf4QrsspRPehNlkwzKh4
X-Received: by 10.43.82.72 with SMTP id ab8mr45696985icc.76.1419898927445;
 Mon, 29 Dec 2014 16:22:07 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Mon, 29 Dec 2014 16:22:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261900>

Hi,

so I have been sending commits to the git mailing list occasionally
for quite some time. In the last couple of weeks I send more and more
patches to the mailing list as it's part of my job now. Here is a
collection of practices I am following (or want to follow) and they
seem to be effective.

Most of this is already documented in various documents in Documentation/*
and this email is no news for the regular contributors. It may help new comers
though.

* Split patches up into logical pieces as you go.

It's easy to go wild and after hours of hacking you have implemented a cool new
feature. This the natural flow of hacking as it's the most fun. But
this approach
is not easy to be reviewed. So let me explain how reviewing works in
the git project.

        Reviewing works in the git project is quite liberal, anybody
is encouraged to
        comment on patches flying by. Junio, the maintainer then
decides which patches
        he picks up and merges them into the various stages of git
(pu, next, master, maint).
        The decision which patches are worth for inclusion is based on
the amount of discussion
        by the community and generally a patch only makes it if a
concensus is met.

* git send-email is the only email client I trust for sending patches

 While mail clients such as Thunderbird or the gmail interface are optimized
 to be used by everyday people it behaves differently than you would expect.
 For example these mail clients may convert tabs to white spaces depending on
 the configuration. The default configuration is usually not sane.
 To avoid that I tend to use git send-email only when sending patches
to the list.

 Here is my setup:
 git send-email needs a  SMTP client to talk to a server, as I am using Ubuntu
 I need to "apt-get install msmtp". Then there is a configuration file
.msmtprc which reads:

        defaults
        tls on
        # this may be different in other distributions:
        tls_trust_file /usr/share/ncat/ca-bundle.crt
        logfile ~/.msmtp.log
        account gmail
        host smtp.gmail.com
        port 587
        from <yourname>@gmail.com
        auth on
        user <yourname>@gmail.com
        password <yourpassword>
        # Set a default account
        account default : gmail

 The git configuration for sending email via msmtp is
        git config --global sendemail.smtpserver /usr/bin/msmtp
        git config --global sendemail.smtpuser <yourname>
        git config --global sendemail.from <yourname>

* Keep notes between different versions of your patch

 Look into the man page of git notes for the configuration variables. The only
 thing requried should be

        git config notes.rewriteRef refs/notes/*

 to enable keeping notes during a rebase.

* Make sure you're not embarassed by the patches you send out

 I fail this talking point often. Write a patch or incorporate
 just a one line fix and send it off to the list. What could go wrong?

 One line fixes and small patches tend to look so easy that you forget
 to compile check or run the test suite, which then promptly breaks.
 To prevent such disasters, I want to do a:
        git rebase origin/master --exec=make --exec="make test"
 before sending the patch series to the list.

* Wait with sending out iterations of patches
  "patience is a virtue I do not have"

  So you successfully send your patches to the mailing list. By
successful I both
  mean it worked technically as well as you got actually reviews and comments.
  Usually the comments are feedback how to improve the patch. Now it's easy to
  fall in the trap and fix all the problems the reviewers point out and resend
  the patches again to the list again.

  Waiting for roughly 24 hours helps a lot I found out. This brings
you the following
  advantages:
        * You may get more comments from people in other time zones.
Git contributors
          are quite international folks. So it would be impolite to not wait for
          everyone to at least have a look at it. They might be
sleeping currently.
        * You will find yourself reviewing your patches twice. Once after fixing
          all the problems the review unveiled and once again before sending out
          the new iteration of the patch series.

Stefan
