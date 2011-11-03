From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: git svn dcommit COMMIT silently checks in everything if COMMIT is
 not a complete revision
Date: Thu, 3 Nov 2011 16:56:03 +0100
Message-ID: <CAH6sp9N9_nTnpEFBWHw39umcBageNwMKaxD5963CPaRv0UnUfw@mail.gmail.com>
References: <CAOnWdoj1eUipRd8M=jsAPdDTNcgEbT7adWR78iU5Oac9DvODkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Reuben Thomas <rrt@sc3d.org>
X-From: git-owner@vger.kernel.org Thu Nov 03 16:56:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLzeE-0007Qm-MD
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 16:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933800Ab1KCP4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 11:56:05 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62807 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933779Ab1KCP4E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 11:56:04 -0400
Received: by qabj40 with SMTP id j40so1212457qab.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Gu74VVORgrCD2ZBA6P8aSfDrZHGRueiJyQLFrInlEek=;
        b=RJjLnTemYjobFBAGfPcK4hc/njJgxwpg33PewgXMgkq/F2o4INuXuWCwjY+sUkO0As
         NN2tqakf57uQ3cwhYI+myB8wP4e2wDnHbixW2LGafVVfTjeEEcQ5HklJ+RkOPyMa+MSW
         ZNOQooU0Z2c8yDZ6mU9QQh7/T7zm/2gsoWABc=
Received: by 10.224.194.193 with SMTP id dz1mr4864508qab.62.1320335763097;
 Thu, 03 Nov 2011 08:56:03 -0700 (PDT)
Received: by 10.224.80.149 with HTTP; Thu, 3 Nov 2011 08:56:03 -0700 (PDT)
In-Reply-To: <CAOnWdoj1eUipRd8M=jsAPdDTNcgEbT7adWR78iU5Oac9DvODkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184723>

Hi,

On Thu, Nov 3, 2011 at 4:12 PM, Reuben Thomas <rrt@sc3d.org> wrote:
> If I run
>
> git svn dcommit COMMIT
>
> with COMMIT being an unambiguous, but partial revision string, it
> behaves like git svn dcommit, i.e. commits everything. (If I remember
> to copy and paste the whole nine yards of the revision string, it
> works as expected, i.e. commits just that revision.)
>
> I'd expect it to work like other git commands, and understand partial
> revision strings, or at least bail out saying it was an invalid
> revision.


Sounds like git-svn skips the rev-parse, or doesn't verify. Which
version of git is this?

Workaround would probably be something like

dcommit.sh:
#!/bin/sh
COMMIT=$1
THINGY=$(git rev-parse --verify $COMMIT) || exit $?
git svn dcommit THINGY

$ dcommit.sh COMMIT


Meh. Better fix git-svn.

Cheers,
Frans
