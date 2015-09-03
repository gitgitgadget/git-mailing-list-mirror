From: John Medema <john.medema@uniteddrugs.com>
Subject: Feature Request: enhance Git-GUI's Checkout Branch screen
Date: Thu, 3 Sep 2015 10:08:24 -0700
Message-ID: <CALsXy+0FN1A-E-GF-chPrOpZSt-Wg8afL8BReqaUnBHDj=3NXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, SysAdmin <sysadmin@uniteddrugs.com>,
	IT Dev2 <john.kobinski@uniteddrugs.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 19:08:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXY0G-0002zI-Iz
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 19:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbbICRIp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 13:08:45 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36554 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322AbbICRIo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 13:08:44 -0400
Received: by ioii196 with SMTP id i196so65575491ioi.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 10:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=9KvYVvhUUaPPZy0LsizsDB6xQ8KtxC9Bzjx+s6thQkQ=;
        b=WmDwyY468EnKFnHa1nfq1Q509KpRgm1vOEa7f8CF5trEOsHEdRzbcMecieT8FiekA6
         wJa/Ww302MZubaEL5LKIgmx07akPL2wHeVojEUwywhoPy3iwExEwKY00/cBDoJPgoEFY
         MWNtvY4C9IDa9YXixrVZQcqD9ZiuqoSOiJcTTXgzA3mXSEt4rsJAYIka5RV2ErpBRhI8
         AoBj8uGc2+75qPT4LFIpqL0H1l07mYPlU60hJKc3Bey6Z2p+6KfHHbn/zdvj633rY9rl
         +pQfdJj8BmQMYVP5kWvbSW+FEgBwANUbEFCXROBERr82eoagEmViOQ11iuv+iKa8/hvV
         6auA==
X-Gm-Message-State: ALoCoQk8zV6kdC+HpdKcIMXzCHOMVo4z/QuS69qD17YHCTEkU8fz4ghjiSIQkLLwy7ysP2+/iOAAjLzd5cWwcfN637xI17+WyrGVOb/tBgJX8qGK8gp75BArO0hGoE/Vu/uWvfNqI4Sx
X-Received: by 10.107.6.21 with SMTP id 21mr155845iog.9.1441300123827; Thu, 03
 Sep 2015 10:08:43 -0700 (PDT)
Received: by 10.107.135.155 with HTTP; Thu, 3 Sep 2015 10:08:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277233>

Git gurus, throw this one on your to-do list:

This is a feature request to enhance the Git GUI to make it easier to
checkout non-existing branches that exist upstream. Apologies if this
is not the correct place for feature requests.

Scenario: Upstream repo has 4 branches - master, develop, maint, test.
Local repo has only a master branch. In the command line, to switch to
a local copy of the test branch, it is a simple "git checkout test".
The git command automatically realizes your requested branch doesn't
exist but origin does have a branch named test, so it a) creates a
local branch off of origin/develop, b) sets the appropriate pull link,
and c) sets the appropriate push link. In effect, the git command line
hides the fact that the user doesn't know the branch doesn't exist and
creates it as the user was expecting it to exist as. The Git GUI has
no shortcut like this.

=46or reference, from the man page for git-checkout:
"If <branch> is not found but there does exist a tracking branch in
exactly one remote (call it <remote>) with a matching name, treat as
equivalent to "git checkout -b <branch> --track <remote>/<branch>".

Currently, in order to checkout a non-existing branch in the GUI you
must go to the Branch Menu, click Create, select the "Tracking Branch"
radio, select the branch, then go back up and name the branch the
exact same name (to ease new user confusion). For a new user who just
wants a copy of the remote branch, it is very unintuitive to create a
new branch.

=46ortunately, you already have some explicit warning messages after th=
e
Checkout Branch screen if the user intuitively tries to checkout the
tracking branch, but even then a new user rarely realizes what they
have gotten themselves into. At best, they know that they must find
help (just for trying to checkout a branch).

In order to implement this feature effectively, I suggest that the
Checkout Branch screen be modified in one of two ways (exclusive):

Option A:
Merge the Local and Tracking Branch lists into one box keeping their
entries separate by their full name ("master" and "origin/master"). If
a user selects a remote branch, ask the user whether to create the
local branch or move to the detached HEAD state (current
functionality).

Option B (preferred):
Keep the Local and Tracking Branch lists separate (as they are now),
and keep the Tracking Branch list as-is. However, on the Local Branch
screen, select include the existing branches in normal font but also
include potential local branches based off of the remote in italics
(or greyed-out, or asterisked, etc). Selecting an italicized entry
creates the new branch from the tracking branch, without user
interaction.


Thanks,

John Medema
Systems Administrator
United Drugs, a Subsidiary of AAP (American Associated Pharmacies)
john.medema@uniteddrugs.com
7243 N 16th Street, Phoenix, AZ 85020
Office:  602-678-1179 x126
=46ax:  602-639-4631

--=20
HIPAA NOTICE:  It is against United Drugs=E2=80=99 policy to receive or=
 send=20
un-encrypted or non-secured email correspondence containing Protected=20
Health Information (PHI) as defined by HIPAA law.
=20
Please use fax or phone for correspondence containing PHI.

--=20
This email message is for the sole use of the intended recipient(s) and=
 may=20
contain confidential and privileged information. Any unauthorized revie=
w,=20
use, disclosure or distribution is prohibited. If you are not the inten=
ded=20
recipient, contact the sender by reply email, and destroy all copies of=
 the=20
original message.=20
