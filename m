From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH] instaweb: make the perl path configurable
Date: Wed, 12 Jun 2013 23:03:26 +0200
Message-ID: <CANQwDweOR_wAJh5sitai6yFED4XKrptoBKn0P=PF0zk89ze3fA@mail.gmail.com>
References: <20130611201400.GA28010@compy.Home> <loom.20130612T155755-338@post.gmane.org>
 <51B8C271.9030105@brokenzipper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Charles McGarvey <chazmcgarvey@brokenzipper.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 23:04:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmsDd-0004X3-Rf
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 23:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086Ab3FLVDu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 17:03:50 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:39515 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758106Ab3FLVDr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jun 2013 17:03:47 -0400
Received: by mail-qc0-f181.google.com with SMTP id u12so1666496qcx.12
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 14:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=G58Xiak43lRNuXp+9jmo8pPwPJLjqTQi+O6VzhQb/uw=;
        b=hxX8wJc/dXRsMNV5xP49+3SjMx+38YunjeGs+W/X4brPBm8RXE99KTOuPY+roYSLoA
         F0bVibp4nGEBD7erb+JRQPCo5vlbyQi6BcSso7yBRDWsxQd6DOQ1ejovbaTfDNlw6fCd
         rJs0Y3vuMWuk3nlS+2XAaAubjXf71XmYawAi42XaXJUfugWjgG5FTCyTlSiRXK11WaBS
         uKgLvRPgPq0kiMfl8yUU9jEeuctH9LhkBlW8UckQ442itRrvkSVpuvWsOlU0e79uUID4
         1gHxqQ1CkVhG9ukMDJ210NB38B77NKhd/XFFmq7Du4rN8x3cVZPl0KS79gArTsRswdFe
         dofQ==
X-Received: by 10.224.189.194 with SMTP id df2mr26035884qab.97.1371071026195;
 Wed, 12 Jun 2013 14:03:46 -0700 (PDT)
Received: by 10.49.85.41 with HTTP; Wed, 12 Jun 2013 14:03:26 -0700 (PDT)
In-Reply-To: <51B8C271.9030105@brokenzipper.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227678>

On Wed, Jun 12, 2013 at 8:48 PM, Charles McGarvey
<chazmcgarvey@brokenzipper.com> wrote:
> On 06/12/2013 08:00 AM, Jakub Narebski wrote:
>> Charles McGarvey <chazmcgarvey <at> brokenzipper.com> writes:
>>
>>> It is convenient for the user to be able to customize the path to p=
erl if they
>>> do not want to use the system perl.  This may be the case, for exam=
ple, if the
>>> user wants to use the plackup httpd but its extra dependencies are =
not
>>> installed in the system perl; they can set the perl path to a perl =
that they
>>> install and have control over in their own home directory.
>>
>> Is it really necessary?  There is always PERL5LIB if one wants to us=
e Perl
>> modules installed in one's own home directory.  If one is using loca=
l::lib
>> one has it "for free".
>
> Yes, that's right.  Using PERL5LIB would solve the example problem in=
 the
> commit message, and it would even be pretty simple to set up using lo=
cal::lib.
>  So, no, this isn't strictly necessary.
>
>> If they do not want to use system perl there is always perlbrew.
>
> Well, perlbrew is actually what I had in mind for this patch.  Withou=
t it, it
> seems like the perl path -- which is configured while building git.gi=
t so is
> not easily changed by the user -- is "hard-coded" in the shebang line=
 of the
> plackup script file which is then made executable and exec'd, to star=
t the
> httpd.  Given that process, I don't see how that code allows the user=
 to use
> any other perl, or am I missing something?

I am sorry, this is my mistake.  Of course if one is using perlbrew the=
n
one wants to use perlbrew perl (nb. how does "perlbrew switch" work?),
not necessarily system perl hardcoded during installation time.

> If adding a new config variable seems too heavy-handed for such a tri=
vial
> problem, another approach would be to use the first perl in PATH

Hmmm... git moved out of using first "perl" in PATH...

>                                                                      =
                         and fall back
> on the git.git build system-configured perl if there is no perl in PA=
TH.

How to do this?

[...]
> In short summary, this patch isn't necessary because everyone could u=
se
> local::lib to manage dependencies not installed at the system level, =
but I
> think this patch is desirable for those of us who use perlbrew and no=
t
> local::lib.  Of course, I'm open to alternatives and other suggestion=
s.

One other thing to think about is: why here, and not other places?

Nb. for short Perl scripts not using extra modules we pick first "perl"
in PATH, IIRC...

--=20
Jakub Nar=C4=99bski
