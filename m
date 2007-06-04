From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Show html help with git-help --html
Date: Mon, 4 Jun 2007 19:29:56 -0400
Message-ID: <fcaeb9bf0706041629tfd3c172md8790387493df43c@mail.gmail.com>
References: <20070602015341.GA26520@localhost.myhome.westell.com>
	 <7vps4cjg1w.fsf@assigned-by-dhcp.cox.net>
	 <fcaeb9bf0706040629k489d4818sa291725cbbeead79@mail.gmail.com>
	 <7vvee3ih8s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 01:30:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvM03-00062B-Ua
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 01:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbXFDX35 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 19:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753494AbXFDX35
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 19:29:57 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:10960 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbXFDX35 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 19:29:57 -0400
Received: by an-out-0708.google.com with SMTP id d31so373531and
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 16:29:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PYG9qifv5SvlU7NJmAZImyAivOBiL7n/R+LEKPFUdMNL2pafIynCqB9eXAB6euulyWgmcEYD+VpQ4FuLHQPBq0rhSH4mQpEWqcIdELZVL8ww4CcnOj31cB841l/wSWc/ylsx8DLEPqqxtAkSJ4BfkH0kIXzvOk3BSrEhYO40B2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E0GOnahxHqoc5wGjJ9Iv3Onk6JU4Lbe/gXx6N2WyLOl7c9DB9j7IjpXh3YOiP8dSB2op4xIYHOnY6gvDI47DL3q9r7HPo7zZEQWxvnKEXr+TDhYZIWuaiVXYmky35Nb71y0rNzFwc1P1ooYNpEqkPqpfJgRZKdWmVlDmZukAnlc=
Received: by 10.101.66.11 with SMTP id t11mr2857412ank.1180999796162;
        Mon, 04 Jun 2007 16:29:56 -0700 (PDT)
Received: by 10.100.127.18 with HTTP; Mon, 4 Jun 2007 16:29:56 -0700 (PDT)
In-Reply-To: <7vvee3ih8s.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49139>

On 6/4/07, Junio C Hamano <junkio@cox.net> wrote:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
> > On 6/4/07, Junio C Hamano <gitster@pobox.com> wrote:
> >> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> >> > index 3d8f03d..2ec8545 100644
> >> > --- a/Documentation/config.txt
> >> > +++ b/Documentation/config.txt
> >> > @@ -261,6 +261,18 @@ core.excludeFile::
> >> > ...
> >> > +core.htmlprogram::
> >> > +     Specify the program used to open html help files when 'git-help'
> >> > +     is called with option --html or core.help is other than 'man'.
> >> > +     By default, xdg-open will be used.
> >>
> >> Is the program's calling convention something that needs to be
> >> customizable for this to be useful?
> >
> > At first I thought xdg-open would be flexible enough for most Linux
> > systems because it will choose the best browser you have. But I now
> > recall that Git does not only run on Linux.  Will make it a parameter
> > in config.mak.in
>
> Actually that was not what I meant.  I thought we might need to
> support something like:
>
>         core.htmlprogram = grand-unified-help %b
>
> for a program that knows where in the system the distribution
> keeps help HTML files, and add prefix (/usr/share/html-help/,
> perhaps) and suffix (obviously, .html) to the basename of the
> command (e.g. "grand-unified-help git-rebase" ends up running
> "lynx file:///usr/share/html-help/git-rebase.html"), or perhaps
>
>         core.htmlprogram = firefox /usr/share/html-help/%f
>
> and we substitute '%f' with "git-rebase.html".

Ok. Now I get it.

>
> >> ...
> >> > +     if (prefixcmp(git_cmd, "git"))
> >> > +             strcat(p,"git-");
> >> > +     strcat(p,git_cmd);
> >> > +     strcat(p,".html");
> >> > +
> >> > +     ret = system(p);
> >>
> >> This is sloppy in the presense of potentially unsafe characters...
> >
> > I personally think users will not shoot themselves with "git help
> > --html ';rm -rf'" but again scripts can. Thank you for pointing out.
> > Will add check for file existence before calling system().
>
> File existence?  I am not sure what you mean by that, sorry.

Something like this on top of the last patch.

diff --git a/help.c b/help.c
index e3e705b..6f5c340 100644
--- a/help.c
+++ b/help.c
@@ -191,7 +191,8 @@ static void show_html_page(const char *git_cmd)
 {
        const char *html_dir;
        int i,len,ret;
-       char *p;
+       char *p,*pathname;
+       struct stat html_stat;

        html_dir = HTML_DIR;
        if (!html_help_program)
@@ -203,13 +204,19 @@ static void show_html_page(const char *git_cmd)

        strcpy(p, html_help_program);
        strcat(p," ");
+       pathname = p + strlen(p);
        strcat(p,html_dir);
        if (prefixcmp(git_cmd, "git"))
                strcat(p,"git-");
        strcat(p,git_cmd);
        strcat(p,".html");

-       ret = system(p);
+       if (!stat(pathname, &html_stat))
+               ret = system(p);
+       else {
+               error("%s not found",pathname);
+               ret = -1;
+       }

        /* fallback to man pages */
        if (show_html_help > 1 && (ret == -1 || ret > 0))
-- 
Duy
