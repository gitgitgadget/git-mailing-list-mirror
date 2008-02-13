From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Can a git repository be initialized with a bundle?
Date: Wed, 13 Feb 2008 10:02:15 +0100
Message-ID: <8aa486160802130102k42158154t7c81b37171a29243@mail.gmail.com>
References: <m3abm56zc9.fsf@assurancetourix.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Tom Koelman" <tkoelman@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Feb 13 10:03:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPDW2-0001SY-2A
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 10:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbYBMJCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 04:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753079AbYBMJCS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 04:02:18 -0500
Received: from el-out-1112.google.com ([209.85.162.180]:43790 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbYBMJCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 04:02:16 -0500
Received: by el-out-1112.google.com with SMTP id v27so2211041ele.23
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 01:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=f+nWSC8uYxd80FixXAZlPZWDuMtP9l0k9MkcmmGD+Nw=;
        b=bdx72468offdEnfcsW9ZPGI13ELdNKe4hm0dZ90B+s0P5eyUJkq4AVZtH23kdElaW2pL6Dk73089aTf9belntwtI2mHGyRUUMpMH3NSipSWQsp1kEncPGd9P7+bm9xgKutK1zzI97NDGXj1rWKNp0ZLmTy2M8e2ZSAnw9aeFYlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fnCjOe7m4jJQCYAHIFZi9BgK9OK7k6g3an0Vn2FLyoDKo4zhWsDSMVzTEeXnzcNM0ndhng5ua80W4PQMBVthwBABguAJ0nOwskVrmu25xToXuc9narFJqaDlRDjaI42rk+rPDBj0BJSIBRkz5GpKWhQn5DaUxCBHCkjg6xdPpRg=
Received: by 10.151.156.2 with SMTP id i2mr874794ybo.177.1202893335113;
        Wed, 13 Feb 2008 01:02:15 -0800 (PST)
Received: by 10.150.205.9 with HTTP; Wed, 13 Feb 2008 01:02:15 -0800 (PST)
In-Reply-To: <m3abm56zc9.fsf@assurancetourix.xs4all.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73758>

On Feb 13, 2008 9:21 AM, Tom Koelman <tkoelman@xs4all.nl> wrote:
>
> Hi,
>
> I got some repository from which I created a bundle like so:
>
> $ git bundle create all.bundle --all

--all does not imply HEAD, so:

$ git bundle create all.bundle --all HEAD

> Now I want to recreate this repository somewhere else:
>
> $ mkdir tmp ; cd tmp ; git init
> Initialized empty Git repository in .git/
> $ git fetch all.bundle
> fatal: Couldn't find remote ref HEAD

you have to say explicitly the branches you want as:

$ git fetch all.bundle master:bundle/master

or with a remote:

$ git remote add bundle all.bundle
$ git fetch bundle

>
> It doesn't matter whether I try to fetch, pull, or add -f to the command
> line, I always get this response.

The same happens with a normal remote repository without a HEAD.

>
> Am I trying to accomplish something that can't be done or am I doing it
> wrong?

I sent a path to support bundles in clone, but it was late for 1.5.4
and at some point "git clone" will be converted to C (now it is a
script). For now you have to do the "git init ; git remote add -f
...", or similar.

Santi
