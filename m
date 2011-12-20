From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git-p4: labels
Date: Tue, 20 Dec 2011 12:03:28 +0000
Message-ID: <CAOpHH-VUJBU5ygabw7YS_FHz6xMDtMkdWMNdH3Mnvp+Crbwh7Q@mail.gmail.com>
References: <4EEE3203.10605@diamand.org> <CAOpHH-W1hE6bw51NKXrdf1QtF3T+v4aLwxMn+_5xPP5j=uJr3w@mail.gmail.com>
 <20111220014753.GD20591@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, Git List <git@vger.kernel.org>,
	Michael Horowitz <michael.horowitz@ieee.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 13:04:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcyQT-00045p-EM
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 13:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646Ab1LTMED convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 07:04:03 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52186 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751223Ab1LTMEB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 07:04:01 -0500
Received: by lahd3 with SMTP id d3so143502lah.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 04:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WWDx6NgQl1rrvYnBUQihqMkNvfQwP5Jl9Ul86ocm+yE=;
        b=wfthWsY5CIA+UprA71USuIPYYOLlZm4BWU0LD0KpMoALI2MlH4g7nv0uT/QesXzyKH
         cDquYNtlP3NnxKfZ8qPx7ZyBLm5qA10W+lBGIkJCywO8y6xtpUZ1yT1+ARRzb9wWPauD
         7mbRvjtuJsH/h/U9iQXtd/OrcPmihjefknuhQ=
Received: by 10.152.104.47 with SMTP id gb15mr1379039lab.9.1324382639369; Tue,
 20 Dec 2011 04:03:59 -0800 (PST)
Received: by 10.152.5.105 with HTTP; Tue, 20 Dec 2011 04:03:28 -0800 (PST)
In-Reply-To: <20111220014753.GD20591@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187510>

On Tue, Dec 20, 2011 at 1:47 AM, Pete Wyckoff <pw@padd.com> wrote:
> But adding a new command to go back and look for _new_ labels
> makes sense too. =A0Finding the new ones isn't so bad, given that
> p4 can just print them directly, and we keep them as tags in git.

Now that you say that, it is now very difficult to detect branches on a=
n
already imported repository. Maybe the new command could also do that?
In this case I would call it "git-p4 resync".

> [...]
> But isn't there a step in label detection that looks an awful lot
> like branch point detection? =A0You've got a label, which is a
> bunch of files, not a p4 change number. =A0Now you have to figure
> out the change number so you can go hunt that down in the git
> history. =A0Vitor's take on this was to use git diff machinery to
> find it, not trawling through the p4 change/filelog/describe
> history, mainly because it's likely much faster to do it locally
> in git.

In labels this is easier and fast:

p4 changes -m 1 @label_name

Then we could diff the label against the changelist. If equal simply ta=
g
the commit, if different then we need to create a temporary branch to
commit the changes and tag that instead.

--=20
Vitor Antunes
