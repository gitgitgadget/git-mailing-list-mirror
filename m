From: Tim Visher <tim.visher@gmail.com>
Subject: `git (submodule update|fetch|pull) --continue` similar to `curl -C 
	-`?
Date: Mon, 12 Apr 2010 11:00:52 -0400
Message-ID: <u2lc115fd3c1004120800y54d09b8bt3e7aeda9509703c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 12 17:01:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1L8r-0003Qw-9d
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 17:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601Ab0DLPBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 11:01:22 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58329 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab0DLPBV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 11:01:21 -0400
Received: by gwj19 with SMTP id 19so1001073gwj.19
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=M8YS4JP9EyAGM1H9ymXnGLpjrPRDLJzTH/MzkQ4vmoE=;
        b=h2C8+kBNtuBYCzSVv7RrBbodspJnJR3IhFAkJAPyvV9cf7BbEdCWVxOhGn+/qf+npc
         0S7OqhILddcYnc3em1H4Lk/WT5l3eII7eLlW8E+r5P2eGQxocO2KwGcT/AYn3Y9AaE1f
         GDRGi3QkHCsT2977KWLYK2KSaAXwnRmsDf9r4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=O5RnPnYcvFkT+ToUarf5P3YcUyrNz+JGfN6CTbEPEqaLRfzQVz8hqMh1cWZqiFXesh
         KbGYrW1iXDhigL17QGbrvEw41dlIisxVYzotYgQJBye/BaOVV6LDVwDERHO9w2LvQNyB
         V+pPiRZFWYrnTHwLpbUNgwAoKEnDAjKSJDcN0=
Received: by 10.100.109.4 with HTTP; Mon, 12 Apr 2010 08:00:52 -0700 (PDT)
Received: by 10.101.6.37 with SMTP id j37mr3536783ani.182.1271084473242; Mon, 
	12 Apr 2010 08:01:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144739>

Hey All,

I'm behind a very aggressive firewall/proxy at work and as far as I
can tell it actually interrupts long connections on purpose.  Most
programs seem to be able to deal with it, although the connection
speed is slower.  Git, however, seems to not be able to deal with it
every once and awhile.

For instance:

    $ g sm update
    Initialized empty Git repository in /home/tim/.emacs.d/site-lisp/ecb/.git/
    error: Unable to get pack file
http://github.com/emacsmirror/ecb.git/objects/pack/pack-364b879fac4ebed663f528dc3ddff99ddd6716e9.pack
    ***emphasis***
    transfer closed with 969832 bytes remaining to read
    ***emphasis***
    error: Unable to find 67861e756712c4e5917461e8b149089dceceec88
under     http://github.com/emacsmirror/ecb.git
    Cannot obtain needed object 67861e756712c4e5917461e8b149089dceceec88
    while processing commit 8043b271a679c7faae65c0d75a73e63bb25d1620.
    error: Fetch failed.
    Clone of 'http://github.com/emacsmirror/ecb.git' into submodule
path     'site-lisp/ecb' failed

It would seem like an interesting idea to be able to download a repo
progressively with interruptions along the lines of `curl -C -` so
that if an interruption happened you can still report the error but
then offer a `--continue` or `--abort` option.  --continue would
obviously attempt to pick up where it left off and --abort would
delete the cache to save the disk space.

Thoughts?

This could also be a problem with GitHub.  I don't know enough about
submodules to make an educated guess there.  I only guess  that it's
the proxy's fault because I only experience this at work.

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
