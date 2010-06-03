From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH GSoC 1/3] gitweb: Create Gitweb::Config module
Date: Thu, 3 Jun 2010 21:41:00 +0530
Message-ID: <AANLkTimoA95U0vivTzrc0XZ8i6q-SfCFA6RgMWK67OWl@mail.gmail.com>
References: <1275573356-21466-1-git-send-email-pavan.sss1991@gmail.com>
	<20100603152030.GD20775@machine.or.cz>
	<201006031755.29814.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 18:11:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKD0p-00059p-R0
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 18:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404Ab0FCQLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 12:11:11 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51834 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271Ab0FCQLJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 12:11:09 -0400
Received: by gwaa12 with SMTP id a12so187062gwa.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 09:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UFxt1BGlpI6p7fwSkrWBKFVYTS5rTM35D4vuKRzJ1Sg=;
        b=b2aye2XYm1I2tGxLJJtePFpwZXn+50xWI9i/Lb8C3u90Y+CgxIVAUHVu3ncXQ22d3s
         bylLk6/+9raFT1Qx8t+mrM9emlO4IkzjAne8ISCPfbqadTkgIVWZ2daYBr4rejSG5mMX
         h+C5ihpcugzeydyGO1cl+vJHDgvW1RdPM1wpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DOy4ocJ8hCDQiW7sQVLYV0RuKozOs5+bDjAcSrXH1y6zVDvoT1UPynWV0yPReMP1cz
         P7VGD+JzqAif3ByUA3qaDvLrFQ+r3QdATU0Hfq54y9xm7cNvLp6k5OVxecPg6GM04pvg
         Aoig4LmazjhRVg5jojdkAZSfr6GGJpJPGGpN0=
Received: by 10.101.129.17 with SMTP id g17mr10701929ann.101.1275581461571; 
	Thu, 03 Jun 2010 09:11:01 -0700 (PDT)
Received: by 10.100.126.20 with HTTP; Thu, 3 Jun 2010 09:11:00 -0700 (PDT)
In-Reply-To: <201006031755.29814.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148342>

2010/6/3 Jakub Narebski <jnareb@gmail.com>:
> On Tue, 3 Jun 2010, Petr Baudis wrote:
>>
>> =A0 I have couple of concerns; maybe they were addressed in the prev=
ious
>> discussion which I admit I did not read completely, but in that case
>> they ought to be addressed in the commit message as well.
>>
>> On Thu, Jun 03, 2010 at 07:25:54PM +0530, Pavan Kumar Sunkara wrote:
>> > -our $t0;
>> > -if (eval { require Time::HiRes; 1; }) {
>> > - =A0 $t0 =3D [Time::HiRes::gettimeofday()];
>>
>> Why is this moved to Gitweb::Config? Shouldn't this be rather part o=
f
>> Gitweb::Request?
>
> I also think that this should be either part of Gitweb::Request, oe
> even be left in gitweb.perl. =A0I think having it in Gitweb::Request
> would be a better idea, because it is about time (and number of git
> commands) it took to process request.

Ok. It will be done.


>> > +
>> > +use Gitweb::Config;
>> >
>> > =A0BEGIN {
>> > =A0 =A0 CGI->compile() if $ENV{'MOD_PERL'};
>> > =A0}
>> >
>> > -our $version =3D "++GIT_VERSION++";
>> > +$version =3D "++GIT_VERSION++";
>
> This change is not necessary.
>
> =A0our $version =3D "++GIT_VERSION++";
>
> would keep working even if '$version' is declared in other module and
> exported by this module (is imported into current scope).

Ok. Will change it.

>> >
>> > =A0our ($my_url, $my_uri, $base_url, $path_info, $home_link);
>> > =A0sub evaluate_uri {
>> > @@ -68,402 +71,58 @@ sub evaluate_uri {
>> >
>> > =A0# core git executable to use
>> > =A0# this can just be "git" if your webserver has a sensible PATH
>> > -our $GIT =3D "++GIT_BINDIR++/git";
>> > +$GIT =3D "++GIT_BINDIR++/git";
>>
>> I dislike the new schema in one aspect - the list of configuration
>> variables together with their description is not at a single place
>> anymore: the build-time overridable variables have their description=
s
>> still in gitweb.pl and only very brief mentions in Gitweb::Config, w=
hile
>> the rest has moved fully to Gitweb::Config. I think it would be best=
 to
>> move all descriptions to Gitweb::Config and keep only the override
>> assignments in gitweb.pl. So, Gitweb::Config would have
>>
>> =A0 =A0 =A0 # core git executable to use
>> =A0 =A0 =A0 # this can just be "git" if your webserver has a sensibl=
e PATH
>> =A0 =A0 =A0 our $GIT;
>
> Good idea.
>
> Perhaps we should provide some sane default fallback values, like for
> example
>
> =A0 =A0 =A0 =A0our $GIT =3D "git";
>
>>
>> and gitweb.pl would have _just_
>>
>> =A0 =A0 =A0 $GIT =3D "++GIT_BINDIR++/git";
>
> I would say
>
> =A0 =A0 =A0 =A0our $GIT =3D "++GIT_BINDIR++/git";

But, I think when we start reading the code, it would seem that 'our
$GIT' implies that it is a variable created locally rather than an
exported variable from Gitweb::Config module.

Even though it increases the patch size, I don't think it will be much
of a concern when it comes to good redability of code.

Jakub: Can you reply, what you think about this argument ?

Thanks,
Pavan.
