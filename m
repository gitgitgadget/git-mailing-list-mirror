From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] commit: clarify "could not read 'template'" message
Date: Fri, 19 Aug 2011 00:07:33 -0500
Message-ID: <20110819050714.GA21697@elie.gateway.2wire.net>
References: <1313169225059-6681082.post@n2.nabble.com>
 <CAMOZ1BtxNSnncEJ6frEY0STgfS478krkpxXStP401WLPovb2Gw@mail.gmail.com>
 <CAAC=0R66j43CqpaxXskAwHsitvRFwy7DsjguNPm+sPa4YmTWqw@mail.gmail.com>
 <CAMOZ1Bu3AoQb330hkL+8hDTCvKX+amRfPE3PBxDHUZR17N344Q@mail.gmail.com>
 <20110813211852.GA17228@elie.gateway.2wire.net>
 <CAAC=0R5CpJx1QOKYJDs0_ksEdyYG95fSAo3U3eU536YW=M84MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?RmFicsOtY2lv?= Nascimento <fabricio@tailorbirds.com.br>
X-From: git-owner@vger.kernel.org Fri Aug 19 07:07:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuHJA-0007uZ-PZ
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 07:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828Ab1HSFHr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 01:07:47 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56662 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab1HSFHr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 01:07:47 -0400
Received: by ywf7 with SMTP id 7so1970673ywf.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 22:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RAF/nLbKU92oG8ji2jC8VfQJuuDA2c0E0jg8hiRn2VI=;
        b=uHfnuo88a7t010Lk27h+7aUFBG4hme8XFvm7GPZyTyAYe0j+GyK0jT4ssgwto3w79P
         HU+QowEzis8AeIwY4RtTOoYwf3Tc4niPfbcjVv1wvkjlnoeBbvJvnhGAXZtfsQP3AWSJ
         G15g/yBmZ4AHFUVYAZ9F65THJYa0EeOrUd2po=
Received: by 10.236.177.37 with SMTP id c25mr3597726yhm.123.1313730466314;
        Thu, 18 Aug 2011 22:07:46 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-48-207.dsl.chcgil.ameritech.net [69.209.48.207])
        by mx.google.com with ESMTPS id c63sm2154584yhe.46.2011.08.18.22.07.42
        (version=SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 22:07:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAAC=0R5CpJx1QOKYJDs0_ksEdyYG95fSAo3U3eU536YW=M84MA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179674>

=46abr=C3=ADcio noticed that when the "[commit] template" configuration=
 is
misconfigured to point to a nonexistent file, ever since v1.7.4.2
(see 2140b140, 2011-02-25), "git commit" fails in a seemingly
mysterious way:

	$ git commit
	fatal: could not read 'template': No such file or directory

In olden times, the message instead said

	Commit template file does not exist.

which makes it a little clearer that the --template option or
corresponding configuration item is being misused.  Let's move a
little in that direction, by saying "could not read commit message
template 'template'".

Note that the origin of the setting in the motivating ~/.gitignore is
still unknown.  Depending on the answer, it might be nice to start
ignoring nonexistent commit templates again; if the problem is
widespread, hopefully there will be more reports soon.

Noticed-by: Fabr=C3=ADcio Nascimento <fabriciosn@gmail.com>
Analysis-by: Michael Witten <mfwitten@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi again,

=46abr=C3=ADcio Nascimento wrote:

> I have no idea what could have set the variable. Time Machine tells m=
e the
> only changes on the .gitconfig file happened on August 12th, the day =
I've
> flagged the bug. I know I've made a brew upgrade on all my packages (=
that
> included git) the night before, and then the bug appeared the day aft=
er. I
> should have done only git stats, commit, pull and push.

Thanks for these details.  I looked through the packages in brew, but n=
o
obvious clues.

At least the problem could have been easier to debug.  How about this
patch, to start?

 builtin/commit.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index cb738574..d029ec03 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -703,7 +703,8 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 		hook_arg1 =3D "squash";
 	} else if (template_file) {
 		if (strbuf_read_file(&sb, template_file, 0) < 0)
-			die_errno(_("could not read '%s'"), template_file);
+			die_errno(_("could not read commit message template '%s'"),
+				  template_file);
 		hook_arg1 =3D "template";
 		clean_message_contents =3D 0;
 	}
--=20
1.7.6
