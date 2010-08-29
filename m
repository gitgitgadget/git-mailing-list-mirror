From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: git peer-to-peer project: info needed
Date: Sun, 29 Aug 2010 22:56:27 +0100
Message-ID: <AANLkTi=xLJ4w1D4=p40f8nUQfLu5hpEfNORnjroffM1v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 29 23:56:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opprd-0006wt-V8
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 23:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab0H2V43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 17:56:29 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36425 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab0H2V42 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 17:56:28 -0400
Received: by vws3 with SMTP id 3so4495914vws.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 14:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=kvRUmJMDh0iqHqrLFB24Hj5xyH7bUIUZXwBdsw5Gwdg=;
        b=b7vUMheutbCUFnl60XpmSILulpA+/NKo7uwxgp50F79Fy2IxI2xinT5QONQPsP3LbA
         p9TkSsAMxbfsNM9YzhVU0oHVrpkxL3GUGqeoIH6OFL+g9nepDWR9mQu3YSpOmrldyvCD
         zMb6uJKkpCGWyj2hwTOgsU/pg+29lZqcHhjvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=oebGlg4E/4Ur4Uy6GmsiKNjPE16sXX6NmSnx1PfDZl92SC2HXDaG5cdr5hgPOD6BoK
         dypknjrheMYaU+4pYr0sjy2jbwR5SiE6EuJxXgFRwkcmH4JE4EvfnFs9Tegrg2oTgAz8
         PaidjJzxpZTU+qwQb6HLa9JmjRXAlZd7SvVV0=
Received: by 10.220.123.218 with SMTP id q26mr2209631vcr.247.1283118987862;
 Sun, 29 Aug 2010 14:56:27 -0700 (PDT)
Received: by 10.220.98.14 with HTTP; Sun, 29 Aug 2010 14:56:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154724>

hi folks,

[please could you kindly cc on responses because i am subscribed with
"no mail" set]

i need some guidance on what i should be doing, to add peer-to-peer
networking to "git fetch".  i can take care of the peer-to-peer
networking side: the bit i'm unsure about is what sequence of events
are required to happen.  i'm presently looking at the use of
walker_fetch in builtin-http-fetch.c which gives me some idea.
however as i aim to implement this first in python not c, i need to be
using git via command-line only.

perhaps... does anyone know of an implementation of "git fetch" in
say... shell-script (or perhaps in python) or just absolutely any
language _other_ than c?

i believe... i believe i may need the git rev-list and git
pack-objects commands, would that be right?  rev-list gives the list
of commit revisions; pack-objects, if i can merely transfer the .pack
file and .index file over the peer-to-peer network, the job's half
done, am i right?

(the only missing step is to have a way to find the list of objects at
the remote end - i know how to do that)

following that, i can do "git unpack-objects" on the .pack file(s)

and... i've just done a test on that (manually, by running
git-pack-objects --thin --all --stdout and then git-unpack-objects)
... um.... :)  i'm missing the "tag updating", aren't i?  the objects
are now in the .git repo but they're "hanging about", as can be seen
with git fsck:

$  git fsck
dangling commit af87b49b9fbcae28ae19b86ca04af5bd4a9f6778

so... my next step iis... ermm... update the head ref?  err? :)  i see
that gitpython is simply writing [the above ref] into
.git/ref/heads/master or whereever is specified (must begin with refs)
which is kinda cheating but perfectly reasonable... err.. but wait...
i'm into what "git-pull.sh" is doing at this point, aren't i?

soo... i kinda don't have to worry about that bit, am i right?  as
long as i get to complete the "git-unpack-objects" stage, the rest can
be handled by git-pull.sh, am i right?

much obliged some answers so that i can get this done, as free
software, and provide people with a peer-to-peer distributed version
of git.

l.
