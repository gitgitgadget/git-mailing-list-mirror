From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: Make Gitweb behave like Apache mod_userdir
Date: Tue, 17 Nov 2009 21:24:54 +0100
Message-ID: <7fce93be0911171224r1cfc438ay7b38b81646154a23@mail.gmail.com>
References: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com>
	 <7vhbssewm7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 21:25:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAUbl-00018D-VS
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 21:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbZKQUYt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2009 15:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbZKQUYt
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 15:24:49 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:54302 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbZKQUYs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2009 15:24:48 -0500
Received: by yxe17 with SMTP id 17so399348yxe.33
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 12:24:54 -0800 (PST)
Received: by 10.101.136.1 with SMTP id o1mr3092650ann.138.1258489494721; Tue, 
	17 Nov 2009 12:24:54 -0800 (PST)
X-Originating-IP: [80.13.22.90]
In-Reply-To: <7vhbssewm7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133101>

On Tue, Nov 17, 2009 at 21:15, Junio C Hamano <gitster@pobox.com> wrote=
:
> Sylvain Rabot <sylvain@abstraction.fr> writes:
>
>> +If you want gitweb to act a bit like UserDir mod in apache, knowing=
, http://<host>/~<user>
>> +will list all git repos of <user> located in a special directory in=
 his home (/home/<user>/gitweb/),
>> +do the following steps :
>> +
>> +Add this to the VirtualHost section of your apache configuration fi=
le :
>> +
>> + =A0 RewriteRule ^/~([^\/]+)/?$ =A0/cgi-bin/gitweb.cgi [QSA,E=3DGIT=
WEB_PROJECTROOT:/home/$1/gitweb/,L,PT]
>> +
>> +Modify your gitweb.conf file, located at /etc/gitweb.conf in this e=
xample, with :
>> +
>> + =A0 $projectroot =3D $ENV{'GITWEB_PROJECTROOT'} || "/path/to/the/d=
efaul/project/root";
>> +
>> +Thus, each user with a gitweb folder in his home will be able to br=
owse it with gitweb.
>> +/!\ The gitweb folder and user's home folder must be readable by th=
e webserver user.
>
> Wouldn't it be a good idea to somehow make this work well together wi=
th
> the --user-path feature of git-daemon?
>
> Perhaps the recommended name given in the example shouldn't be ~/gitw=
eb,
> but more like ~/public_git, as this is like ~/public_html but for git
> repositories. =A0Then the end users will browse

As I said, it's configuration :)

>
> =A0 =A0 =A0 =A0http://my.site/~gitster/public_git/git.git
>

would be http://my.site/~gitster/git.git

> and gitweb can be told to show
>
> =A0 =A0 =A0 =A0clone URL: git://my.site/~gitster/public_git/git.git

and git://my.site/~gitster/git.git

if --user-path of git daemon set to public_git

> on the page. =A0If the site administrator runs git-daemon with --user=
-path
> set to public_git, everything will work seamlessly, no?
>

Yes :)
