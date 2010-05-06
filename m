From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: newbie: should git bare repositories (forked ones) have an origin 
	defined?
Date: Thu, 6 May 2010 01:49:29 +0100
Message-ID: <u2n86ecb3c71005051749m95977244oa5c5ee809599dc4c@mail.gmail.com>
References: <q2r408104421005050940k2d054b20zad05552623ba2338@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 02:50:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9pHo-0002fc-IC
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 02:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261Ab0EFAtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 20:49:50 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41715 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab0EFAtt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 20:49:49 -0400
Received: by pva18 with SMTP id 18so801607pva.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 17:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=yG1ZwYo4ZEealrkTgmbnLJ5nHH9aDDnLb2qogUcTHTE=;
        b=h3KudG3kPQbUrjtbQUkixdvM1J5d6cIbrXEj5AWABBA359H0sLdnrAx6Im1FcX14XF
         Ir747ghh3lOrZ2gMXyBE0x0fvYhF/ujnQkIaPi5Usmay58wjOyjHp8MeqBCfs8SSC8Kj
         GTmdH9VLe4CiBcXXrib8O/lzk7WyFvBjvg0w8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=YATPwAJRx3Hyve+OdYXf43ya6Xd6wEO8rO/jJu5HO11ZIc/038ttMhe88qDw5Pof0v
         LmBml2emQDwGhebF889wlEW48wGMhZJ9ua4z/k+vWy8grrE9aEpqIT+6euczUR1CFC5F
         Znup+3uZyRt8KvvyIa1NVpiZrNjhm2auBXdog=
Received: by 10.142.247.21 with SMTP id u21mr103748wfh.115.1273106989189; Wed, 
	05 May 2010 17:49:49 -0700 (PDT)
Received: by 10.142.191.1 with HTTP; Wed, 5 May 2010 17:49:29 -0700 (PDT)
In-Reply-To: <q2r408104421005050940k2d054b20zad05552623ba2338@mail.gmail.com>
X-Google-Sender-Auth: 49ae8030dc26baa7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146431>

On 5 May 2010 17:40, Robert Buck <buck.robert.j@gmail.com> wrote:
>
> Question:
>
> Is what I am inquiring about reasonable, or is there a good reason to
> not have remote refs embedded into the public forked repository?
> How should public forked repositories ("next" in the use case above)
> be initially created on its host?
>
> Thank you,
>
> Bob


"origin" & "master" are just the default names for a remote & where
HEAD points to on remote repository.


A bare repository usually doesn't have any refs/remotes/* instead it
just has refs/heads/*

When you clone a bare repository refs/heads/* from bare repository are
pulled into refs/remotes/<remotename>/*

look at your .git/config to see how flexible this is.

you can do

[remote "qa-branches"]
      url = ../qa
      fetch = +refs/heads/qa-stable:refs/heads/stable
      fetch = +refs/heads/qa-appprove:refs/heads/next
      fetch = +refs/heads/qa-pending:refs/heads/dev

[remote "bob"]
      url = ../bob
      fetch = +refs/heads/qa-rejected:refs/heads/experimental

This repository can be public and you can have many remotes defined
all fetching into refs/heads.

Now set-up bare repositories that you like and set-up as many remotes
as locations you need to fetch from, figure out which heads to you
need to fetch & how you want to call them and you are done =)
