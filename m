From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH 1/3] mergetool--lib: fix startup options for gvimdiff
 tool
Date: Fri, 25 Jan 2013 12:44:40 +0400
Message-ID: <20130125124440.40fc60e0@ashu.dyn1.rarus.ru>
References: <1359011768-7665-1-git-send-email-Alex.Crezoff@gmail.com>
	<CAJDDKr4Zi-pVVtX4LxRv9K7ocjdpLS_5NH5P_wrx0+ZRSwmfFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 09:45:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyeuJ-0000F9-7P
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 09:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767Ab3AYIoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 03:44:46 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63504 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3AYIop (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 03:44:45 -0500
Received: by mail-lb0-f174.google.com with SMTP id l12so284479lbo.33
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 00:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=9Rv5i2ZINyWziVSoEtRCTu9z/qrGO1oW5XxQ9edt54g=;
        b=D82MV3RTj8emukF8YzR3p2hvpeC8GGHKYiFETJouNytUhLEUykDbNSIBtzSWOyM3tF
         Rd12Wd3FELKXD7uVt7EO2PTtx6EKigULwbEjMGJ0FK5/k2fBoXCL/1tvVCtheESGnHOm
         O6uE0cV+pxMLXPHfKhh7kMacajo4DYtRBmTcrcoDzlFd+DYMUeQUWUU18x9ZAXhStBK7
         gWylyyO3AzZn7jrkR1qMBQ08b8tNjRc4wsepuZuOiWlWjL+8TC0EjiVZ+k0gaS4fW+wJ
         OZtvg7TPIQx9575DRFOboAnnHFQAH8/zBvID85ALekHOy0I8unukA9XJfyK4GzhDizdh
         I8xg==
X-Received: by 10.152.144.38 with SMTP id sj6mr4341929lab.48.1359103483193;
        Fri, 25 Jan 2013 00:44:43 -0800 (PST)
Received: from ashu.dyn1.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id bf3sm198929lbb.16.2013.01.25.00.44.42
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 00:44:42 -0800 (PST)
In-Reply-To: <CAJDDKr4Zi-pVVtX4LxRv9K7ocjdpLS_5NH5P_wrx0+ZRSwmfFA@mail.gmail.com>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.13; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214514>

Maybe, some time ;)
Actually, I'm not TCL-programmer. With one of these patches I just have
solved one my problem (to run tortoisemerge with git-gui) when I
was showing to my collegue how to work with Git, and on the side I
fixed another two bugs. So, I decided to sumbit these patches, to avoid
applying them every time after each Git update as I did last 1.5 years
with other patches which still are not submitted, because I'm too lazy
to follow Git development workflow in my free time )

> On Wed, Jan 23, 2013 at 11:16 PM, Alexey Shumkin
> <alex.crezoff@gmail.com> wrote:
> > Options are taken from <Git source>/mergetools/vim
> >
> > Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> > ---
> >  git-gui/lib/mergetool.tcl | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> A better long-term solution might be to teach git gui to use "git
> difftool".
> 
> Would it be better to teach git-gui (and gitk) about
> mergetool/difftool? That would allow us to possibly eliminate this
> duplication.
> 
> We did start towards that path when difftool learned the --extcmd
> option (for use by gitk) but I have not followed through.
> 
> What do you think about trying that approach?
> 
> 
> > diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
> > index 3c8e73b..4fc1cab 100644
> > --- a/git-gui/lib/mergetool.tcl
> > +++ b/git-gui/lib/mergetool.tcl
> > @@ -211,7 +211,13 @@ proc merge_resolve_tool2 {} {
> >                 }
> >         }
> >         gvimdiff {
> > -               set cmdline [list "$merge_tool_path" -f "$LOCAL"
> > "$MERGED" "$REMOTE"]
> > +               if {$base_stage ne {}} {
> > +                       set cmdline [list "$merge_tool_path" -f -d
> > -c "wincmd J" \
> > +                               "$MERGED" "$LOCAL" "$BASE"
> > "$REMOTE"]
> > +               } else {
> > +                       set cmdline [list "$merge_tool_path" -f -d
> > -c "wincmd l" \
> > +                               "$LOCAL" "$MERGED" "$REMOTE"]
> > +               }
> >         }
> >         kdiff3 {
> >                 if {$base_stage ne {}} {
> > --
> > 1.8.1.1.10.g9255f3f
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
