From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: allow extra breadcrumbs to prefix the trail
Date: Thu, 4 Jul 2013 18:32:26 +0200
Message-ID: <CANQwDwfNrqZvLNYS6kqZdgX-ab5fK3RmQqAN3qKTW2TGnaDaUg@mail.gmail.com>
References: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk> <20130703215930.GT408@google.com>
 <CANQwDwcneUzzXS-Du-3Aca3-Vp8ycSzVqUv1rVRVhaNUWfeokw@mail.gmail.com>
 <alpine.LSU.2.00.1307040940400.26246@hermes-2.csi.cam.ac.uk>
 <CANQwDwd9siyeu5xqS5Un+=8ioEaDbpT30vBpgJCVNUEcszcv1g@mail.gmail.com>
 <alpine.LSU.2.00.1307041559140.26246@hermes-2.csi.cam.ac.uk>
 <CANQwDwfCYPBjGfmKOLju-Zey4WrVrXfaymJtu9g1OYvOUfBTcw@mail.gmail.com> <alpine.LSU.2.00.1307041646250.26246@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Thu Jul 04 18:32:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UumSi-0005mW-9J
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 18:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab3GDQcs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jul 2013 12:32:48 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:55507 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756525Ab3GDQcr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jul 2013 12:32:47 -0400
Received: by mail-qc0-f171.google.com with SMTP id n1so860727qcw.30
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZYwnfmXRnRWUGB5C65Q/tjOFIbMn8hkv6WLOxhfHaLc=;
        b=b+TnFs8bVlOxy7xqLB0PmuevujNYjW0GNm0xUHsW/H/P29Cea6bXQy7nf4rsNptogl
         heeV4FZajlSVDiCLXAaMFFvZmUjjq0rZkmiK6P1Q/dk4fdS7tAvyo4R0P6uKFknAS+/9
         5JG+vnLfVH1lQp7k4Zh/HtnQ0OezN6Z99CNACZx+ht7BpZyQFxPkF0tX789MpsDLtihU
         unrvxfc1x2c9B2W481CMZQaFnoNQtRbarxTqFY8W5M/co+IC36Y9arYJ1B0kDWO2QfX6
         u06XBOLhnj8ZEvqyC4vkQMjR7Sld+KkzH9UYLGPdxHgs81804aS2UfJHHjNCXaeZsG31
         y/Gw==
X-Received: by 10.49.38.105 with SMTP id f9mr5157098qek.63.1372955566713; Thu,
 04 Jul 2013 09:32:46 -0700 (PDT)
Received: by 10.49.75.169 with HTTP; Thu, 4 Jul 2013 09:32:26 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.00.1307041646250.26246@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229595>

On Thu, Jul 4, 2013 at 5:56 PM, Tony Finch <dot@dotat.at> wrote:
> Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
>>
>> First, do I understand correctly that @extra_breadcrumbs are rendere=
d *after*
>> $home_link*, and in exactly the same manner?
>
> Before the home link, and yes, in the same manner. The extra breadcru=
mbs
> are for links to parent pages above gitweb in some hierarchy.

Hmmm... I would have thought that they were after home link. I wonder
if leaving it up to user to configure @extra_breadcrumbs to include $ho=
me_link
in appropriate place (the unshift / push solution to adding to
@extra_breadcrumbs,
starting with $home_link) would be good idea, or over-engineering.

In what situation do you need those extra breadcrumbs useful? What
necessity / itch to scratch is behind idea of this patch?

>> But now I think that we can do better, simply put $home_link_str and=
 $home_link
>> in @extra_breadcrumbs / @top_level_breadcrumbs / @nav_breadcrumbs be=
fore
>> using it,
>
> We could save a line that way:
>
> -       print $cgi->a({-href =3D> esc_url($home_link)}, $home_link_st=
r) . " / ";
> +       for my $crumb (@extra_breadcrumbs, [ $home_link_str =3D> $hom=
e_link ]) {
> +               print $cgi->a({-href =3D> esc_url($crumb->[1])}, $cru=
mb->[0]) . " / ";
> +       }

And avoid a bit of code duplication; now we are sure that both
@extra_breadcrumbs and $home_link are rendered in the same way.

>> P.S. It is a bit late, but wouldn't { name =3D> $link_name, href =3D=
> $link_url }
>> (like %features hash) be a better solution than [ $link_name, $link_=
url ],
>> i.e. hashref (named parameters) instead of arrayref (positional para=
meters).
>> You wouldn't have to remember which is first: text or URL.
>
> I thought the fat arrow would be mnemonic enough, and less verbose.

Yes, hashref solution is a bit verbose. I don't like abusing fat arrow =
notation,
but here it gives nice mnemonic (hopefully explained in documentation).

--=20
Jakub Narebski
