From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] Re: fast-import: Allow filemodify to set the root
Date: Sun, 17 Oct 2010 20:00:05 -0500
Message-ID: <20101018010005.GA25524@burratino>
References: <AANLkTinsnMRyoeGzCn1Rkk7tc+zwVa5j3AGqVZCdDGDv@mail.gmail.com>
 <1286681415-1831-1-git-send-email-david.barr@cordelta.com>
 <20101011063429.GA32034@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 03:04:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7e8t-00024v-Dy
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 03:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778Ab0JRBDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 21:03:52 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41408 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab0JRBDv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 21:03:51 -0400
Received: by gyg13 with SMTP id 13so116251gyg.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 18:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6+Fe8dETCOV0TvctnRXdZpnJSZyNH2udN8irrFUiB/0=;
        b=en9Kjd56QlzzP8/C+VjUOMTRkht/VoWp/KOGJcJjWcEsLSSoEaEl5llAqZL91v4uhV
         FuOWfrfUSEzW1rxAVkEXDiRxop4aNwa1rJ0SfF5DPY5tfP4pHU7lgfIgr0QUfm6UIrck
         ssLxY4A5u8bdM0O2dcB+5fi14yfOZGLo9AwvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CQ9rqnPvVrC3ifo+1gMkK9ziOdyHc1gOTLlXOzvVu3Y16fI+5PaP4nJEZZI1T2h4PQ
         3hiXvwGEznlbUnkVTekcBzf4gokh7cG+rP2jupQC1Qbou5sqTGeUuUuzyGM8zwRuHdes
         7KCWBGtdIfkwae/809flE11QmXIG2ubpESk/A=
Received: by 10.101.162.10 with SMTP id p10mr2188653ano.241.1287363823678;
        Sun, 17 Oct 2010 18:03:43 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id d15sm20975435ana.20.2010.10.17.18.03.40
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 18:03:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011063429.GA32034@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159220>

Jonathan Nieder wrote:

> In other words, with this patch, I worry that a
> 
> 	M 040000 ...sha1... "foo/bar/"
> 
> line would be sometimes ignored and sometimes not.  Confusing.

Hey, my worries were unfounded!  Nice when that happens.

Patch 1 is an unrelated bugfix.

> Would it make sense to just handle the empty-path case in the callers
> (file_change_m(), file_change_cr()) to avoid this?

Patch 2 introduces this change anyway, to propose that change, to
avoid unnecessarily introducing a new "foo/bar/" syntax that does not
work with git 1.7.3.

I hope they are not too dull to read.
Jonathan Nieder (2):
  fast-import: filemodify after M 040000 <tree> "" crashes
  fast-import: tighten M 040000 syntax

 fast-import.c          |   54 +++++++++++++++++++++++++++++---------
 t/t9300-fast-import.sh |   68 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 13 deletions(-)

-- 
1.7.2.3
