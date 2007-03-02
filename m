From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] defaults for where to merge from (take 3, inline)
Date: Fri, 02 Mar 2007 15:10:09 +0100
Organization: At home
Message-ID: <es9b3k$9u1$1@sea.gmane.org>
References: <es450f$d58$1@sea.gmane.org> <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com> <45E68897.8000607@lu.unisi.ch> <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com> <45E68EDE.2090405@lu.unisi.ch> <81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com> <45E69297.8070001@lu.unisi.ch> <81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com> <45E69EEE.8070905@lu.unisi.ch> <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com> <7vvehls1h9.fsf@assigned-by-dhcp.cox.net> <45E70041.1030705@lu.unisi.ch> <Pine.LNX.4.63.0703012240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 15:08:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN8QZ-0004xn-5e
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 15:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992463AbXCBOIE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 2 Mar 2007 09:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992461AbXCBOIE
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 09:08:04 -0500
Received: from main.gmane.org ([80.91.229.2]:54645 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992459AbXCBOIB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 09:08:01 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HN8QP-0005Mm-Tj
	for git@vger.kernel.org; Fri, 02 Mar 2007 15:07:57 +0100
Received: from host-81-190-24-11.torun.mm.pl ([81.190.24.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 15:07:57 +0100
Received: from jnareb by host-81-190-24-11.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 15:07:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-11.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41207>

Johannes Schindelin wrote:
>On Thu, 1 Mar 2007, Paolo Bonzini wrote:

>> =A0
>> +static void register_branch_pull (const char *name, const char
*remote_name)
>=20
> It is not yet remote_name, right? it is branch_name. You extract the=20
> remote_name by finding the first slash.

I'm bit reluctant about this, as it is not required that remote
names cannot contain slashes. But remotes with slashes would make
separation into remote and tracking branch part more difficult.

>> +{
>> +=A0=A0=A0=A0=A0char *slash =3D strchr(remote_name, '/');
>> +
>> +=A0=A0=A0=A0=A0char *config_key =3D xmalloc(strlen(name) + 15);
>> +=A0=A0=A0=A0=A0char *merge_value =3D xmalloc(strlen(remote_name) + =
10);
>> +
>> +=A0=A0=A0=A0=A0char *remote_value =3D xstrdup(remote_name);
>=20
> I'd use "char key[1024], value[1024]" instead, erroring out if one of=
 the=20
> buffers are too small. It's not like you have to be memory efficient,=
 and=20
> it is easier to read.

The config parser has lengths limits on fully qualified key name (with
section name and subsection name) _and_ on value name. Use them, please=
,
instead of dynamic allocation and troubles with those.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
