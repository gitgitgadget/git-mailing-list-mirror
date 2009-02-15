From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Sun, 15 Feb 2009 15:38:06 +0200
Message-ID: <20090215133806.GC13810@annwn>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de> <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com> <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de> <94a0d4530902141231t143067e5n872558a4e515be4a@mail.gmail.com> <alpine.DEB.1.00.0902142328530.10279@pacific.mpi-cbg.de> <94a0d4530902150104n555b845bofc5897230c64a5f2@mail.gmail.com> <alpine.DEB.1.00.0902151224450.10279@pacific.mpi-cbg.de> <94a0d4530902150407u1bc6669cr2584ff8f1a8b47af@mail.gmail.com> <alpine.DEB.1.00.0902151329370.10279@pacific.mpi-cbg.de> <94a0d4530902150451w2467bee2q225643f15ffffac1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 14:39:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYhDg-00025P-1g
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 14:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbZBONiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 08:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbZBONiN
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 08:38:13 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:64774 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888AbZBONiM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 08:38:12 -0500
Received: by bwz5 with SMTP id 5so2590549bwz.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 05:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=U4JzlMMjNkSaGMd09ch0aZPemd46YjZJqtP9ZEqUxFU=;
        b=aKN/vPsYu+ic099sx0C110A+VwJrnZ+T+nNYrhBsY8iAEcnW2HQt8qM3hXWmz6UXqV
         VlDcuesaWAm2UV8HsJbTcmuBvLbt+KJFl9q707vk/cc1FwJE4It7igTjZTPoeBYzlKlY
         K5S5iDECMcFwdcZ89hob3OvnfIzTaTuSOS1dA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kLc20OPfEjyMPb9Q7ZKnBD65f5WqmB4FawcPltrzqpdZiHRuK6FqlekEjd8NhRLijK
         OwoNdIc/ZSnPIEgGuax/7kj63A2gvYCLyQhedb8kxz40qoGEFc7gomGxyVfY0gIilin5
         l9NBOSOvA48NCmehCI2lyW6tXYYwoUe/R8vVA=
Received: by 10.181.144.11 with SMTP id w11mr1558901bkn.27.1234705089630;
        Sun, 15 Feb 2009 05:38:09 -0800 (PST)
Received: from @ (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 21sm3008947fkx.19.2009.02.15.05.38.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Feb 2009 05:38:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <94a0d4530902150451w2467bee2q225643f15ffffac1@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110010>

On Sun, Feb 15, 2009 at 02:51:45PM +0200, Felipe Contreras wrote:
> On Sun, Feb 15, 2009 at 2:33 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Ah, I misremembered.  Your current patch shows this:
> >
> > +       else if (actions & ACTION_EDIT) {
> > +               const char *config_filename;
> > +               if (config_exclusive_filename)
> > +                       config_filename = config_exclusive_filename;
> > +               else
> > +                       config_filename = git_path("config");
> > +               git_config(git_default_config, NULL);
> > +               launch_editor(config_filename, NULL, NULL);
> > +       }
> >
> > ... which makes me believe that the point about moving git_config() before
> > setting config_exclusive_filename is rather weak :-)
> >
> > +       else if (actions & ACTION_EDIT) {
> > +               git_config(git_default_config, NULL);
> > +               launch_editor(config_exclusive_filename ?
> > +                       config_exclusive_filename : git_path("config"),
> > +                       NULL, NULL);
> > +       }
> >
> > (This has whitespace issues, as I copy-pasted it using kterm's clipboard
> > functions.)
> 
> I thought on that before but now it makes more sense to me. Attaching the patch.

Now inlined (sorry):

---
 builtin-config.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 2c1ad71..bd7bac4 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -370,13 +370,10 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 	}
 	else if (actions & ACTION_EDIT) {
 		check_argc(argc, 0, 0);
-		const char *config_filename;
-		if (config_exclusive_filename)
-			config_filename = config_exclusive_filename;
-		else
-			config_filename = git_path("config");
 		git_config(git_default_config, NULL);
-		launch_editor(config_filename, NULL, NULL);
+		launch_editor(config_exclusive_filename ?
+			      config_exclusive_filename : git_path("config"),
+			      NULL, NULL);
 	}
 	else if (actions & ACTION_ADD) {
 		check_argc(argc, 2, 2);
-- 
1.6.1.3

-- 
Felipe Contreras
