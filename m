From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] git-remote-svn: Week 8
Date: Wed, 23 Jun 2010 18:22:13 +0200
Message-ID: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 23 18:21:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORShI-0000uJ-LR
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 18:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372Ab0FWQVC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 12:21:02 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:46926 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab0FWQVA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 12:21:00 -0400
Received: by wwc33 with SMTP id 33so1178857wwc.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=9XRXuMxYjdz9gPPOh/Q4DDcSb9DNGBeHBtagQM8Ad18=;
        b=DJxXIS4fOq7O2+jilyeDBC3qpLdO/Y5JL+Rrl4o0sAtnBGbIebJVfKclM/YNDHWedh
         ldglNr3G4R73A0wAcTmHOJJAlNUwFECKpxL/2hd7DF6uRnnHbZdIb+LS1bnd5B7gwt/Q
         zODQmwG+7iYzURbUY2bGIpbGiRNUCZ2yiZOxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=E7FxwWZn2M+GAqZOaYRepiVhz6a25XB56AXfY5xenVM+wWlG6VaHZEjCv5jgmv7gTG
         6vZDhSTE7YacfaVg/LiUuHiT4bVjIOOAlm3vZToUDuxxpt7kbOUSjsXCv59WU1Cz5iot
         /P7/7M4/H3Cs88HRc4jI8fiPNQBAY/aiHn7Mo=
Received: by 10.216.184.136 with SMTP id s8mr6109901wem.102.1277310055439;
        Wed, 23 Jun 2010 09:20:55 -0700 (PDT)
Received: from localhost ([130.226.133.98])
        by mx.google.com with ESMTPS id h46sm1102543wej.36.2010.06.23.09.20.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 09:20:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149510>

Hi,

I've been very productive over the last few days. The good news is
that I finally managed to a (badly-formatted, broken, abridged) dump
of the text and properties. The bad news is that the program only
seems to work by accident- it segfaults all over the place without
reason, I don't know what to make of the backtraces, and documentation
is thin as usual. I plan to go back in history to do a major cleanup/
refactor before proceeding, now that I've learnt how to trigger the
dumping.
 
I got this far mainly because of the help I got from Subversion
developers like Daniel- A big thank you to them. The plan is to finish
this, get it reviewed/ acked by Daniel and the other Subversion
developers, and test it with David's exporter before merging it into
git.git. Once it's merged, I plan to write a series for Subversion,
get it merged there, and remove it from git.git in favor of simply
linking to the feature. The reason for this roundabout dance is
simple- things are much easier to test in Git-land.

Another thing that I think we should give some thought- how do I get
this merged into git.git? Should I post a single patch with the
(probably 1000-line) dump editor? In my opinion, the revision history
is very valuable- can we get a clean series of 6~8 patches merged
instead?

-- Ram

Ramkumar Ramachandra (7):
  Add skeleton RA svnclient
  Add stripped dump editor
  Import dump_node to dump what changed and cleanup whitespace
  Replace deprecated svn_path_join
  Trigger dump_node in change_dir_prop
  Add file_baton and trigger dump_node in change_file_prop
  [WIP] Dump the text delta

 LICENSE        |   14 ++
 Makefile       |    4 +
 debug_editor.c |  413 +++++++++++++++++++++++++++++++++++
 debug_editor.h |    6 +
 dump_editor.c  |  652 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 dump_editor.h  |   10 +
 svnclient_ra.c |  138 ++++++++++++
 7 files changed, 1237 insertions(+), 0 deletions(-)
 create mode 100644 LICENSE
 create mode 100644 Makefile
 create mode 100644 debug_editor.c
 create mode 100644 debug_editor.h
 create mode 100644 dump_editor.c
 create mode 100644 dump_editor.h
 create mode 100644 svnclient_ra.c
