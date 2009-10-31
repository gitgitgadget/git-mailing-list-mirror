From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 0/8] Default pager and editor
Date: Fri, 30 Oct 2009 20:20:50 -0500
Message-ID: <20091031012050.GA5160@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 02:10:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N42UM-0008R3-9c
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 02:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933118AbZJaBKb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 21:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933098AbZJaBKb
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 21:10:31 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:55448 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933093AbZJaBKa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 21:10:30 -0400
Received: by ywh40 with SMTP id 40so3203780ywh.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 18:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0OM5iE7UqRKTdqWmq0EV0xFYjeiPqHEYpv5wvDHSVCQ=;
        b=idighUa+jOmRqK4JHTXkyz3/frb8JnEtZ2Eg+a9W/OexxTYxYdaZzj0cW4mfblhZx/
         NAFsGVafZ3ZDV2+Fe04raGslcQz1Tz0ncfgtkwolztKvXGbs3cgRdqXI/KLqLMMHSG8I
         VxrFGbsoa+EObUB39Pvn4NBRX4H+p2ysfxD3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CG3QMknPyPcF32geE6BLBFkuuIQswz25OyaGX4/4TxcBSzDJocZ0NTd9MnMaDND1rW
         F480l0sA+DlRnFzqH9KFoaBO130oqg4ZkKKsCsk96A7L+3eBnpYrnszJJJG7RHbxkJbt
         wlixwIa99uAnKLeJLA3IPPTa7IKrDo3at+5D8=
Received: by 10.91.28.2 with SMTP id f2mr6018642agj.16.1256951435812;
        Fri, 30 Oct 2009 18:10:35 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 36sm1594119yxh.67.2009.10.30.18.10.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 18:10:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091030101634.GA1610@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131813>

Junio C Hamano wrote:

> I'll queue these for now probably on 'pu', but with the comments we s=
aw on
> the list expect them to be followed up with replacement patches.

Here=E2=80=99s a replacement series.  It omits the longer error message=
 when
TERM=3Ddumb and the git var --run experiment because I was not happy
with where either of those were going.

Thanks for all the comments, everyone.

Johannes Sixt (1):
  Teach git var about GIT_EDITOR

Jonathan Nieder (6):
  Handle more shell metacharacters in editor names
  Do not use VISUAL editor on dumb terminals
  Teach git var about GIT_PAGER
  add -i, send-email, svn, p4, etc: use "git var GIT_EDITOR"
  am -i, git-svn: use "git var GIT_PAGER"
  Provide a build time default-editor setting

Junio C Hamano (1):
  Provide a build time default-pager setting

 Documentation/config.txt         |    4 +---
 Documentation/git-commit.txt     |    2 +-
 Documentation/git-send-email.txt |    4 ++--
 Documentation/git-var.txt        |   14 ++++++++++++++
 Makefile                         |   28 ++++++++++++++++++++++++++++
 cache.h                          |    2 ++
 contrib/fast-import/git-p4       |    5 +----
 editor.c                         |   32 +++++++++++++++++++++++-------=
--
 git-add--interactive.perl        |    3 +--
 git-am.sh                        |    5 ++++-
 git-send-email.perl              |    3 ++-
 git-sh-setup.sh                  |   19 ++++++-------------
 git-svn.perl                     |   11 ++++-------
 pager.c                          |   24 ++++++++++++++++++++----
 t/t7005-editor.sh                |   31 ++++++++++++++++++++++++------=
-
 var.c                            |   31 ++++++++++++++++++++++++++++++=
-
 16 files changed, 163 insertions(+), 55 deletions(-)
