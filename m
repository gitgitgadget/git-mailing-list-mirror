From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCHv2 GSoC] git-instaweb: Configure it to work with new gitweb 
	structure
Date: Sat, 22 May 2010 22:27:51 +0530
Message-ID: <AANLkTinbzlRsmQekpLlFQC3xOMB2ZUurLqJoyFCnHZFG@mail.gmail.com>
References: <1274523105-3327-1-git-send-email-pavan.sss1991@gmail.com>
	 <201005221757.38376.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 22 18:58:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFs1Q-0006yF-Gl
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 18:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab0EVQ5x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 May 2010 12:57:53 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34937 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab0EVQ5w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 May 2010 12:57:52 -0400
Received: by gyg13 with SMTP id 13so929910gyg.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OdTjAm6tUK8uYiskV9jnkWN4tYmCCAfFMEIbuXdJLIk=;
        b=FdwEymuSuspTCYv/E93kQWCivGN0qalH5cs+tzXPyb+TGpPesbCl5QlojWHXB2NEs0
         ++BpbThDGYefwElFyRH1buyYNLOWT3JnpEKqxZMc2kFJk0danzhFj/F41MVDBZimfI1y
         nSDZ+Zqb+aeyCaeFPldneYo9XqgXT46TYXMWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Kt2RYGP8evoWrIp5SOxF0CL59xgcixQrPpWZTIWxKybZq/EiDSoBVN/EjFkjWgsJl6
         sbwePQ8ExZ07OH4N5LN1itjKocNHVptTnvgMljCTxarUuP6rxpIKJbDkMLHTRWQS5YAk
         jTfhM8kSeyUlWeiQ5icyMugElbxzqzWa+pU3I=
Received: by 10.90.20.19 with SMTP id 19mr1947964agt.160.1274547471460; Sat, 
	22 May 2010 09:57:51 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Sat, 22 May 2010 09:57:51 -0700 (PDT)
In-Reply-To: <201005221757.38376.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147534>

2010/5/22 Jakub Narebski <jnareb@gmail.com>:
> On Sat, 22 May 2010, Pavan Kumar Sunkara wrote:
>
>> git-instaweb in its current form (re)creates gitweb.cgi and
>> (some of) required static files in $GIT_DIR/gitweb/ directory.
>> Splitting gitweb would make it difficult for git-instaweb to
>> continue with this method.
>>
>> Use the instaweb.gitwebdir config variable to point git-instaweb scr=
ipt
>> to a global directory which contains gitweb files as server root
>> and the httpd.conf along with server logs and pid go into
>> '$(GIT_DIR)/gitweb' directory.
>
> That's not all this patch changes, isn't it?
>
> =A0While at it, change apache2 configuration to use the same access l=
og
> =A0and error log files as the rest of web servers supported by
> =A0git-instaweb.
>
> While it would be better to have it as a separate commit, I think it
> doesn't matter much, and having it in this patch is acceptable as
> "while at it" change.
>
>>
>> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
>
> I like this change, because it simplifies greatly git-instaweb
> generation; besides the fact that it is necessary for future splittin=
g
> gitweb for better maintability, and for write functionality for gitwe=
b.

Thanks.

> Acked-by: Jakub Narebski <jnareb@gmail.com>
>
> _If_ there is no problem with $(gitwebdir) and not $(gitwebdir_SQ),
> see below for details.
>
>> ---
>>
>> This patch is based on commit 'jn/gitweb-install' in the next branch=
=2E
>
> I think it is based on your earlier patches:
>
> * gitweb: Move static files into seperate subdirectory
> =A0http://article.gmane.org/gmane.comp.version-control.git/147321
> * gitweb: Set default destination directory for installing gitweb in =
Makefile
> =A0http://article.gmane.org/gmane.comp.version-control.git/147160
>
> Those are necessary for this patch to be applied. =A0Well, the second=
 is
> necessary for it to make sense...

Yes. They are necessary patches before this patch.
I assume, they are going to be merged before this patch is.

> BTW. which web servers supported by git-instaweb: lighttpd, apache2,
> webrick, mongoose you have tested your change with?

I tested this patch with lighttpd and apache2.
And am sure about mongoose. But don't know the status with webrick.

>> =A0Makefile =A0 =A0 =A0 =A0| =A0 10 +------
>> =A0git-instaweb.sh | =A0 71 ++++++++++++++++++++--------------------=
--------------
>> =A02 files changed, 28 insertions(+), 53 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index caf2f64..91cd726 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1592,15 +1592,8 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.c=
gi gitweb/static/gitweb.css gitweb/
>> =A0 =A0 =A0 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
> [...]
>> + =A0 =A0 =A0 =A0 -e 's|@@GITWEBDIR@@|$(gitwebdir)|g' \
>> =A0 =A0 =A0 =A0 =A0 -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
>> - =A0 =A0 =A0 =A0 =A0 =A0-e 's|@@GITWEB_CSS_NAME@@|$(GITWEB_CSS)|' \
>> - =A0 =A0 =A0 =A0 =A0 =A0-e 's|@@GITWEB_JS_NAME@@|$(GITWEB_JS)|' \
>> =A0 =A0 =A0 =A0 =A0 $@.sh > $@+ && \
>> =A0 =A0 =A0 chmod +x $@+ && \
>> =A0 =A0 =A0 mv $@+ $@
>> @@ -1972,6 +1965,7 @@ install: all
>> =A0 =A0 =A0 $(MAKE) -C templates DESTDIR=3D'$(DESTDIR_SQ)' install
>> =A0ifndef NO_PERL
>> =A0 =A0 =A0 $(MAKE) -C perl prefix=3D'$(prefix_SQ)' DESTDIR=3D'$(DES=
TDIR_SQ)' install
>> + =A0 =A0 $(MAKE) -C gitweb gitwebdir=3D$(gitwebdir) install
>> =A0endif
>
> Have you checked that you can use $(gitwebdir) and don't need
> $(gitwebdir_SQ) here? =A0Does git-instaweb installs and works correct=
ly
> if 'gitwebdir' contains spaces and single or double quote characters?
> But perhaps that doesn't matter in practice, and this is good enough.

Nope. I didn't check it. But you are right.

>
>> diff --git a/git-instaweb.sh b/git-instaweb.sh
>> index f608014..b3e9192 100755
>> --- a/git-instaweb.sh
>> +++ b/git-instaweb.sh
>> @@ -24,6 +24,7 @@ restart =A0 =A0 =A0 =A0restart the web server
>> =A0fqgitdir=3D"$GIT_DIR"
>> =A0local=3D"$(git config --bool --get instaweb.local)"
>> =A0httpd=3D"$(git config --get instaweb.httpd)"
>> +root=3D"$(git config --get instaweb.gitwebdir)"
>> =A0port=3D$(git config --get instaweb.port)
>> =A0module_path=3D"$(git config --get instaweb.modulepath)"
>>
>> @@ -34,6 +35,9 @@ conf=3D"$GIT_DIR/gitweb/httpd.conf"
>> =A0# if installed, it doesn't need further configuration (module_pat=
h)
>> =A0test -z "$httpd" && httpd=3D'lighttpd -f'
>>
>> +# Default is @@GITWEBDIR@@
>> +test -z "$root" && root=3D'@@GITWEBDIR@@'
>> +
>
> Nice.
>
>> @@ -57,7 +61,7 @@ resolve_full_httpd () {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 # these days and those are not in most u=
sers $PATHs
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 # in addition, we may have generated a s=
erver script
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 # in $fqgitdir/gitweb.
>> - =A0 =A0 =A0 =A0 =A0 =A0 for i in /usr/local/sbin /usr/sbin "$fqgit=
dir/gitweb"
>> + =A0 =A0 =A0 =A0 =A0 =A0 for i in /usr/local/sbin /usr/sbin "$root"=
 "$fqgitdir/gitweb"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 do
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test -x "$i/$httpd_on=
ly"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 then
>
> You probably want to update comment above this loop. =A0But this is n=
ot
> something very important.
>
> Alternatively, if e.g. webrick.rb and webrick (shell script) are
> installed in "$fqgitdir/gitweb" directory, there is no need to check
> "$root".
>
>> =A0webrick_conf () {
> [...]
>> -:DocumentRoot: "$fqgitdir/gitweb"
>> +:DocumentRoot: "$root"
>
>> =A0lighttpd_conf () {
>> =A0 =A0 =A0 cat > "$conf" <<EOF
>> -server.document-root =3D "$fqgitdir/gitweb"
>> +server.document-root =3D "$root"
> [...]
>> -setenv.add-environment =3D ( "PATH" =3D> env.PATH )
>> +setenv.add-environment =3D ( "PATH" =3D> env.PATH, "GITWEB_CONFIG" =
=3D> env.GITWEB_CONFIG )
>
>> =A0apache2_conf () {
> [...]
>> -ServerRoot "$fqgitdir/gitweb"
>> -DocumentRoot "$fqgitdir/gitweb"
>> +ServerRoot "$root"
>> +DocumentRoot "$root"
> [...]
>> =A0PerlPassEnv GIT_DIR
>> =A0PerlPassEnv GIT_EXEC_DIR
>> +PerlPassEnv GITWEB_CONFIG
>
>> @@ -353,7 +359,7 @@ mongoose_conf() {
>> =A0# For detailed description of every option, visit
>> =A0# http://code.google.com/p/mongoose/wiki/MongooseManual
>>
>> -root =A0 =A0 =A0 =A0 $fqgitdir/gitweb
>> +root =A0 =A0 =A0 =A0 $root
> [...]
>> -cgi_env =A0 =A0 =A0 =A0 =A0 =A0 =A0PATH=3D$PATH,GIT_DIR=3D$GIT_DIR,=
GIT_EXEC_PATH=3D$GIT_EXEC_PATH
>> +cgi_env =A0 =A0 =A0 =A0 =A0 =A0 =A0PATH=3D$PATH,GIT_DIR=3D$GIT_DIR,=
GIT_EXEC_PATH=3D$GIT_EXEC_PATH,GITWEB_CONFIG=3D$GITWEB_CONFIG
>
> All right, those changes are pretty clear.
>
>> @@ -277,14 +281,15 @@ EOF
>>
>> =A0apache2_conf () {
>> =A0 =A0 =A0 test -z "$module_path" && module_path=3D/usr/lib/apache2=
/modules
>> - =A0 =A0 mkdir -p "$GIT_DIR/gitweb/logs"
>> =A0 =A0 =A0 bind=3D
>> =A0 =A0 =A0 test x"$local" =3D xtrue && bind=3D'127.0.0.1:'
>> =A0 =A0 =A0 echo 'text/css css' > "$fqgitdir/mime.types"
>> =A0 =A0 =A0 cat > "$conf" <<EOF
>> =A0ServerName "git-instaweb"
>> -ServerRoot "$fqgitdir/gitweb"
>> -DocumentRoot "$fqgitdir/gitweb"
>> +ServerRoot "$root"
>> +DocumentRoot "$root"
>> +ErrorLog "$fqgitdir/gitweb/error.log"
>> +CustomLog "$fqgitdir/gitweb/access.log" combined
>> =A0PidFile "$fqgitdir/pid"
>> =A0Listen $bind$port
>> =A0EOF
>
> This is independent change, modifying configuration of apache2 web
> server to use the same files for access log and for error log
> ("$fqgitdir/gitweb/access.log" and "$fqgitdir/gitweb/error.log",
> respectively) as the rest of web servers.
>
> Isn't it?

Yes. But I included it in this commit because, it is not a big change
to be included in another commit.

>> @@ -370,41 +376,16 @@ mime_types =A0 =A0 =A0.gz=3Dapplication/x-gzip=
,.tar.gz=3Dapplication/x-tgz,.tgz=3Dapplication/x-t
>> =A0EOF
>> =A0}
>>
>> -
>> -script=3D'
>> -s#^(my|our) \$projectroot =3D.*#$1 \$projectroot =3D "'$(dirname "$=
fqgitdir")'";#;
>> -s#(my|our) \$gitbin =3D.*#$1 \$gitbin =3D "'$GIT_EXEC_PATH'";#;
>> -s#(my|our) \$projects_list =3D.*#$1 \$projects_list =3D \$projectro=
ot;#;
>> -s#(my|our) \$git_temp =3D.*#$1 \$git_temp =3D "'$fqgitdir/gitweb/tm=
p'";#;'
>> -
>> -gitweb_cgi () {
> [...]
>
>> +gitweb_conf() {
>> + =A0 =A0 cat > "$fqgitdir/gitweb/gitweb_config.perl" <<EOF
>> +#!/usr/bin/perl
>> +our \$projectroot =3D "$(dirname "$fqgitdir")";
>> +our \$git_temp =3D "$fqgitdir/gitweb/tmp";
>> +our \$projects_list =3D \$projectroot;
>> +EOF
>> =A0}
>
> Right, $GIT (formerly $gitbin) is set when generating gitweb.cgi from
> gitweb.perl.
>
> Actually $git_temp is not needed by modern gitweb (from quite some ti=
me,
> since using external /usr/bin/diff was replaced by git-diff-tree), so
> setting it could be removed from gitweb_config.perl. =A0Nevertheless =
it is
> not a problem having it.
>
>> -gitweb_cgi "$GIT_DIR/gitweb/gitweb.cgi"
>> -gitweb_css "$GIT_DIR/@@GITWEB_CSS_NAME@@"
>> -gitweb_js =A0"$GIT_DIR/@@GITWEB_JS_NAME@@"
>> +gitweb_conf
>>
>> =A0case "$httpd" in
>> =A0*lighttpd*)
>> --
>> 1.7.1.18.g74211d.dirty
>
>
> --
> Jakub Narebski
> Poland
>

Thanks
-Pavan
