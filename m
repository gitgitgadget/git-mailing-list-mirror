From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Static gitweb content when using pathinfo
Date: Tue, 17 Apr 2012 14:30:52 +0200
Message-ID: <201204171430.52650.jnareb@gmail.com>
References: <4F7DA413.2020502@gmail.com> <201204141919.19285.jnareb@gmail.com> <4F8C384C.2040109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-2?q?Jos=E9_Mar=EDa_Escart=EDn_Esteban?= 
	<ripero84@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 14:30:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK7Y9-0005vv-Mw
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 14:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080Ab2DQMaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 08:30:14 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:36984 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605Ab2DQMaN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 08:30:13 -0400
Received: by wejx9 with SMTP id x9so3996371wej.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 05:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=5Y0A+Qk9W5RRag4KHxsoPrJQ7HVYlj4BH1erEs+04SM=;
        b=ougHDvAbyXCOujPyXNeeHNWG+1pqt9go6ns6LrE4z37mjmQa9V5qy2djTmeMmYboLF
         4FkZaa8Y96QkzfqMHpyUZvOJw4YD7tTZQSZWLR20aPqa1x/9pMflT/s3cTYJfYrNJDes
         RhebRiEi+X4Amh3L3BL5OAemJuSKwmyDUrrQ/Idf6pinhFFZLG6Wn34Y1x1dbVdb8UXT
         /SPlEtxMlmWwE5U9Rv2ikbfjPvwCuwu77NCkLfB8etuY3MW6un24IaEky7eoXiTftM35
         jzcsRZSaYvUdtjoebYmiMlMQv7c1GHTsq1+nKMO8YLZ0TKtaNGowtCQSDY9oo5ZCDX56
         80Cw==
Received: by 10.180.88.169 with SMTP id bh9mr28343455wib.5.1334665811584;
        Tue, 17 Apr 2012 05:30:11 -0700 (PDT)
Received: from [192.168.1.13] (epk75.neoplus.adsl.tpnet.pl. [83.20.52.75])
        by mx.google.com with ESMTPS id ex2sm42901856wib.8.2012.04.17.05.30.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 05:30:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4F8C384C.2040109@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195755>

On Mon, 16 Apr 2012, Jos=E9 Mar=EDa Escart=EDn Esteban wrote:
> On 14/04/12 19:19, Jakub Narebski wrote:
>> On Thu, 5 Apr 2012, Jakub Narebski wrote:
>>> On Thu, 5 Apr 2012, Jos=E9 Mar=EDa Escart=EDn Esteban wrote:

>>> There might be problem if you configured your web server to serve g=
itweb
>>> using it as a handler for subdirectory, so the script name does not=
 need
>>> to appear in URL, e.g.
>>>
>>>   http://localhost/cgi-bin/gitweb
>>>
>>> which would require the following base element
>>>
>>>   <base href=3D"http://localhost/cgi-bin/gitweb/" />
>>
>> [...]
>>
>=20
> Yes, that was precisely the problem.

Note that you won't have problem with `http://localhost` as base url
(without any directory), or in more realistic case using virtual host
rather than virtual directory.  The problem is that without '/' the
path part of $base_url is stripped of last element.

Just for completeness.

[...]
> This addition to the man page would of course have been useful, since=
 it took me
> a while to detect that the problem was a missing slash in the base ur=
l.
> However, it would not have solved completely my problem, and for me t=
he best has
> been to add the line of code you proposed in the previous email.

So how about the proposed updated addition at the end of this email?

> I am running a Debian testing (wheezy) server, so the distro gitweb f=
iles are:
>=20
> 	/etc/apache2/conf.d/gitweb
> 	/etc/gitweb.conf
> 	/usr/share/gitweb/gitweb.cgi
> 	/usr/share/gitweb/index.cgi -> /usr/share/gitweb/gitweb.cgi
> 	/usr/share/gitweb/static/*
>=20
> I am using two sets of git repositories, and each of the sets works t=
hrough a
> particular gitolite user:
>=20
> 	user     home
> 	----------------------
> 	git      /srv/project
> 	mygit    /srv/mygit
>=20
> I wanted that different groups of people were able to browse the 'pro=
ject' repos
> (in fact it is a mirror from the main project server) from
> 	http://server.example.com/project/ ,
> and the 'mygit' repos from
> 	http://server.example.com/mygit/ .
> And I wanted to keep urls as short and easy as possible, and to avoid
> proliferation of configs as much as possible.

I think that is this "two sets" that created configuration with a probl=
em.
=20
> The setup I came up with was to link
>=20
> 	/srv/www/project -> /usr/share/gitweb
> 	/srv/www/mygit -> /usr/share/gitweb
>=20
> and to use the following configuration files:
>=20
> ######### /etc/apache2/conf.d/gitweb ##################
> <Directory /srv/www/project>
>         SetEnv  GITWEB_PROJECTROOT      /srv/git/
>         SetEnv  GITWEB_CONFIG           /etc/gitweb.conf
[...]
> #######################################################
>=20
> ######### /etc/gitweb.conf ############################
> $projectroot =3D $ENV{'GITWEB_PROJECTROOT'}."repositories";
> $git_temp =3D "/tmp";
> $projects_list =3D $ENV{'GITWEB_PROJECTROOT'}."projects.list";
> @diff_opts =3D ();
> $feature{'pathinfo'}{'default'} =3D [1];
> $feature{'highlight'}{'default'} =3D [1];
> $projects_list_description_width =3D 50;
> #######################################################

A question: why not have

          SetEnv  GITWEB_PROJECTROOT      /srv/git

and use

  $projectroot =3D "$ENV{'GITWEB_PROJECTROOT'}/repositories";
  $projects_list =3D "$ENV{'GITWEB_PROJECTROOT'}/projects.list";
=20

BTW. what is this $git_temp?  Is it modified gitweb, because core one
doesn't need to use temporary directory for anything nowadays?

A tip: you can use GITWEB_CONFIG_COMMON for the common part of
configuration and separate GITWEB_CONFIG for per-instance configuration=
=2E
Though I am not sure if it would help in your case.  It requires
modern gitweb. though.

> Probably there are better ways to implement this, but at least this s=
eems to
> work, once I have added
>=20
> 	$base_url .=3D '/' unless ($base_url =3D~ m!/$!);
>=20
> to /etc/gitweb.conf .

-- >8 ---------- >8 --
Subject: [PATCH] gitweb.conf(5): When to set $base_url

Add a paragraph to description of $base_url variable in gitweb.conf(5)
manpage explaining when and why one might need to set it, and how.

Based-on-report-by: Jos=E9 Mar=EDa Escart=EDn Esteban <ripero84@gmail.c=
om>
Signed-off-by: Jakub Nar=EAbski <jnareb@gmail.com>
---
 Documentation/gitweb.conf.txt |   24 ++++++++++++++++++++++++
 Documentation/gitweb.txt      |    4 ++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.=
txt
index 7aba497..4716a0f 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -559,6 +559,30 @@ $base_url::
 	PATH_INFO.  Usually gitweb sets its value correctly,
 	and there is no need to set this variable, e.g. to $my_uri or "/".
 	See `$per_request_config` if you need to override it anyway.
++
+You would need to set this variable when using path_info-based URLs
+while using gitweb as a directory handler (which means that full path
+to browse repositories looks like `http://git.example.com/gitweb`
+rather than looking like `http://git.example.com/gitweb/gitweb.cgi`).
+You can find yourself in this situation (gitweb as directory handler)
+when configuring gitweb to use FastCGI interface as shown in
+"Webserver configuration" section on linkgit:gitweb[1] manpage.
++
+If static files are served from 'static' subdirectory of directory
+the gitweb script is handler for, with default URLs of static files
+(e.g. `$logo` is `static/git-logo.png`), then you would need to ensure
+that `$base_url` ends with slash to denote that it is directory, to
+work correctly:
++
+----------------------------------------------------------------------
+$base_url .=3D '/' unless ($base_url =3D~ m!/$!);
+----------------------------------------------------------------------
++
+For example if gitweb URL is `http://git.example.com/gitweb`, and
+static files are available in `http://git.example.com/gitweb/static/`
+then `$base_url` must end up to be `http://git.example.com/gitweb/`
+(with trailing slash) for e.g. `static/git-logo.png` relative link
+to refer to `http://git.example.com/gitweb/static/git-logo.png`.
=20
=20
 CONFIGURING GITWEB FEATURES
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index b394ecc..c3db66a 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -473,6 +473,10 @@ With that configuration the full path to browse re=
positories would be:
=20
   http://server/gitweb
=20
+Note that for this configuration `$base_url` must be set as described
+in linkgit:gitweb.conf[5] for gitweb to correctly serve static files
+with path_info links.
+
 As PSGI using plackup
 ~~~~~~~~~~~~~~~~~~~~~
 Gitweb can run as PSGI app (via emulation with *CGI::Emulate::PSGI*(3p=
m)).
--=20
1.7.9
