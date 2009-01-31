From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: "git svn fetch" slow
Date: Sat, 31 Jan 2009 18:01:55 +0100
Message-ID: <200901311801.56130.markus.heidelberg@web.de>
References: <200901311414.58205.markus.heidelberg@web.de> <bd6139dc0901310823lcced62frd61445cb80d56fca@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 18:03:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTJFb-0000xL-T5
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 18:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbZAaRB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 12:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbZAaRB6
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 12:01:58 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:47788 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbZAaRB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 12:01:57 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 249D6F74EF77;
	Sat, 31 Jan 2009 18:01:56 +0100 (CET)
Received: from [89.59.86.74] (helo=pluto)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LTJEB-00064T-00; Sat, 31 Jan 2009 18:01:56 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <bd6139dc0901310823lcced62frd61445cb80d56fca@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18/TGR9C9Ac4KoFe8EqRw7SVTMri3bEkVYLdCiR
	oMKDhEQQ+IUhhrNbRChl7CuKOlP0of4GozJ6J1KlLKQPeJ5mBm
	EDAIALgo6/6BmB8Mya/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107932>

Sverre Rabbelier, 31.01.2009:
> On Sat, Jan 31, 2009 at 14:14, Markus Heidelberg
> <markus.heidelberg@web.de> wrote:
> > since several days "git svn fetch" didn't seem to work any more. I
> > bisected it down to
> 
> I noticed it too, it's horribly slow; I can't really revert the patch
> since it conflicts, and I'm not familiar with the code, so I don't
> know how to resolve the conflict :(.

The following should work around it:

diff --git a/git-svn.perl b/git-svn.perl
index 79888a0..bc7bd21 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3255,7 +3255,6 @@ sub new {
 	bless $self, $class;
 	if (exists $git_svn->{last_commit}) {
 		$self->{c} = $git_svn->{last_commit};
-		$self->{empty_symlinks} = _mark_empty_symlinks($git_svn);
 	}
 	$self->{empty} = {};
 	$self->{dir_prop} = {};
