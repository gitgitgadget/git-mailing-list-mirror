From: Tony Maserati <abletony84@gmail.com>
Subject: Help creating script that mass-pulls Git(Hub) repos
Date: Sat, 21 Nov 2009 11:25:20 +0100
Message-ID: <dc191bcd0911210225k3cf946c6k54f1287c818af5a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 21 11:25:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBn9l-00032T-UO
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 11:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbZKUKZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 05:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbZKUKZP
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 05:25:15 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:56130 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbZKUKZO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 05:25:14 -0500
Received: by iwn8 with SMTP id 8so3094838iwn.33
        for <git@vger.kernel.org>; Sat, 21 Nov 2009 02:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=kPJdMOK+IUh3IfsHHblFPSzUygi2aK2De4vMQtwmsak=;
        b=hDNe9Gld2zvK1WLQEGoYXO1BAxhmqwmvkzjmsxoecj1v8hohrIXl28hbPW3VWKlKkM
         MnH9jweWJci33wlYBBXmHU4aZ6zXaCOmtqcCiTs3PKwC2S7rngUbL2oKXaiZBsd6Jqn7
         yszdw7drgI5c39rmt5oDOb/G4Tl+45POeUis8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=sE5wVMpjc/CfpX0wVQ2OO1bzdNB3R5P7C7QaxcG+ivj+/3IrRCIYkt6/JDgiUF9jkK
         sLLveJOHGr5J52HpJix0Rlp2sGuzgh7rhUAI6xFRbeKCCk2Pm04c0Ef2u036vKYgve+s
         ITst5PMJf3xZD6SQaH/tUE/Y2fIaypDkeENMQ=
Received: by 10.231.6.79 with SMTP id 15mr5479141iby.36.1258799120592; Sat, 21 
	Nov 2009 02:25:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133393>

Hi,

I got a bunch of repos I've cloned off GitHub and I'm looking for the
best way to keep them all up to date.

I got a working zsh script, but it lacks some stuff. For instance I
think it'd be neat if it could output the difference between the
commit dates as oppose to those long hashes. And if it could initiate
the pull only when necessary. Other ideas are welcome.

Does anybody have any suggestions to how I might complete or otherwise
improve the below scripts? Thanks in advance.

Here's the working version:

abletony84$ cat pull_all.sh

#!/usr/bin/env zsh

for folder in $PWD/**/.git(:h); do

  cd $folder

  git pull

done

-

This script lacks a proper if clause, and shows hashes instead of dates:

abletony84$ cat pull_all2.sh

#!/usr/bin/env zsh

for folder in $PWD/**/.git(:h); do

  cd $folder

  if this repo needs an update; then # git ls-remote has been suggested

    old=$(git rev-parse HEAD)

    git pull >& /dev/null

    new=$(git rev-parse HEAD)

    echo "$folder: $old -> $new"

  else

    echo "$folder: nothing to do"

  fi

done

-

A slightly different approach, even more incomplete than the previous:

abletony84$ cat pull_all3.sh

#!/usr/bin/env zsh

for folder in $PWD/**/.git(:h); do

  cd $folder

  if repo still exists at github; then

    git fetch >& /dev/null

    if a merge is needed; then

      git merge >& /dev/null

      echo "$folder: date_of_last_current_commit -> date_of_last_new_comit"

    else

      echo "$folder: nothing to do"

    fi

  fi

done

-

Thanks again!

Tony
