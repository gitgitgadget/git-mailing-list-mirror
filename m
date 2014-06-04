From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4] Add an explicit GIT_DIR to the list of excludes
Date: Wed, 4 Jun 2014 20:52:28 +0700
Message-ID: <CACsJy8A_CtC_05mja3L-udM_CYwGA46UoN122Xp6kxaUGkFYSw@mail.gmail.com>
References: <1401163007-5808-1-git-send-email-pasha.bolokhov@gmail.com>
 <CACsJy8By-58wBoV8BydWbpDkpUG6jJhM16aO+Ed8J2ucq66VcQ@mail.gmail.com>
 <CAKpPgvfvrdBr7oxyKg2G1XDHwS=Dzs9=K9MmQLtLzUx-Zi+1dA@mail.gmail.com>
 <CACsJy8Dy2quFrXynH7g5DzNMikwkOiyJZGMoSqLyjxzzvRreYQ@mail.gmail.com> <CAKpPgvcv10-DNM4xetfmcckG6ancfEn_y7i8EJ3mWQLaELDdUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 15:53:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsBcn-0003cQ-SD
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 15:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbaFDNxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 09:53:00 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:46395 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbaFDNw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 09:52:59 -0400
Received: by mail-qa0-f48.google.com with SMTP id i13so7097117qae.7
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=e3YSH/TcrJ+M70A8OrXf980kaN+FKBiTkSnklFR3tHY=;
        b=Oqi/SL+QoY9fZY9+TAzzk8T41zDqFbPg6mymEP/RzDVPeZWON9WezkyObGQ3m0A34A
         EzTAAXQ27/5tTuXmgwFzgAikTCnNtcxGgk1h6MOIpS9+mjZu90lsEgHb215Tv0H4TJY+
         KreMSdiWezZdc4AqHrRAAOFuIPm2zTB4joTleV76h6r7pldEk+5JC4NYLbp0QffiMxBa
         e6iW2188E52W02iw/F+vz5g9xcP30+gmg19oMvHbALWe/RskYVxchNVc3+D4QkX32z6U
         K8+oNhRIgMuwrFqwrutcZxhUeL7VdcgHO/1rqpkk8Hvvtk3s3B8OHPnmEcoU8D5UHkLo
         OpFg==
X-Received: by 10.229.27.198 with SMTP id j6mr71430694qcc.12.1401889978914;
 Wed, 04 Jun 2014 06:52:58 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 4 Jun 2014 06:52:28 -0700 (PDT)
In-Reply-To: <CAKpPgvcv10-DNM4xetfmcckG6ancfEn_y7i8EJ3mWQLaELDdUQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250728>

On Wed, Jun 4, 2014 at 3:55 AM, Pasha Bolokhov <pasha.bolokhov@gmail.com> wrote:
>> The case when $GIT_DIR points to a _file_ seems uncovered.
>> setup_git_directory() will transform the file to the directory
>> internally and we never know the .git file's path (so we can't exclude
>> it). So people could accidentally add the .git file in, then remove it
>> from from work tree and suddenly the work tree becomes repo-less. It's
>> not as bad as .git _directory_ because we don't lose valuable data. I
>> don't know if you want to cover this too.
>
> That's right, there is no way of knowing what the original .git file
> was. I guess the only way to work around this problem is to modify
> "read_gitfile()" so it saves the name of the original file. Then we
> can add both that .git-file and GIT_DIR to the exclude list. Not a big
> problem with me, but need to see what you guys think

My view is this non-standard $(basename $GIT_DIR) is a corner case.
Unless people who care about it (e.g. you) do something that affects
the common ".git" case, or really mess up the code, I don't think it's
a problem if you decide to ignore some smaller cases.
-- 
Duy
