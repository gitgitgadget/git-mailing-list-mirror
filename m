From: "Ping Yin" <pkufranky@gmail.com>
Subject: "git add sub1/ sub2/" doesn't work as expected when sub1 and sub2 has .git under them
Date: Mon, 12 Jan 2009 16:36:26 +0800
Message-ID: <46dff0320901120036h97d4162ucd37c17b9dfb6217@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 09:37:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMIIx-0000Fy-CH
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 09:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbZALIg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 03:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbZALIg1
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 03:36:27 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:3065 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbZALIg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 03:36:27 -0500
Received: by wa-out-1112.google.com with SMTP id v27so5536033wah.21
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 00:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=vlCWk39jNUJdb/WpfgnfrifhhdfSkowKUceKLkvyCMg=;
        b=DFSNakwyLLLnqNor18N56Vg1AoPrDt+9lAT8HoEupjaSlqLAgaPzafqhzVOYdUtCFm
         qlhgRN8OcvNaJK36iPVessSjvxjALp/MAC/YyN7VwRwcUCX5Cb+wDq8bLeEhZgslMK4L
         HAyWCfrYi8JYSOPbXmsdZqg0ddhPpndvtY7Co=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=R0/tfr8egL486WQ4t0MENJb07Gu2wMwT0qwHSzZ/H0/TIChbjmGGGhiuXH1V3WZ/Xb
         Ek1aPN9Cd9QKg6Exb7zSLYoCJ+mDO51och5ZzeGuizF8Jl61TIG3e47jiSVhIo0K/97p
         3jHpb3voAS4mkoqfyAEGTI5LGUiQ6xZmsDlkE=
Received: by 10.114.25.19 with SMTP id 19mr18918411way.89.1231749386142;
        Mon, 12 Jan 2009 00:36:26 -0800 (PST)
Received: by 10.115.93.12 with HTTP; Mon, 12 Jan 2009 00:36:26 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105302>

Assume directories sub1 and sub2 have .git under them. "git add sub1/"
works as expected (files under sub1/ are added), howerver "git add
sub1/ sub2/" doesn't work as expeced (sub1 and sub2 are added as
submoudle).

$ git --version git version 1.6.0.4.617.g2baf1

# create repo super
$ mkdir super && cd super && git init && git commit --allow-empty -m
"Initial commit"

# create repo super/sub1 with file sub1-file
$ mkdir sub1 && cd sub1 && touch sub1-file
$ git init && git add . && git commit -m "Initial commit" && cd ..

# create repo super/sub2 with file sub2-file
$ mkdir sub2 && cd sub2 && touch sub2-file
$ git init && git add . && git commit -m "Initial commit" && cd ..

# to intend to add files under sub1 and sub2, but submodules are added
$ git add sub1/ sub2/
$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file:   sub1
#       new file:   sub2
#

$ git rm --cached sub1 sub2

# to intend add files under sub1, ok
$ gtad sub1/
$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file:   sub1/sub1-file
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       sub2/


Ping Yin
