From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv5 06/12] gitweb: allow extra text after action in page header
Date: Mon, 27 Sep 2010 08:56:20 +0200
Message-ID: <AANLkTinpZ5gusCG4SoKbi54URyn7T4THNp2NeVM6uFL2@mail.gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1285344167-8518-7-git-send-email-giuseppe.bilotta@gmail.com> <201009262011.28211.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 08:57:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P07e6-0006qM-Hl
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 08:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770Ab0I0G4p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 02:56:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46319 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932758Ab0I0G4n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 02:56:43 -0400
Received: by iwn5 with SMTP id 5so4532063iwn.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 23:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Db0ZyGh+GNs2DffK/DuSHwiJYPGbHVY4U6+7MQW1F8E=;
        b=MlEoh/rpOuYfxFOe2qBEcd00Gb9oTXIBC2wTZWjDNZ51W8IdCvHXEOYGkEbzpCBJdG
         MStu33wlPo6HpM/IH7o9muGHzrmHKmyqWIQSMwqzHi9QgwbHBhl4WIq7FG/OAEBhnRN5
         9TibWRZVG0F4awitUdKudTwZFH9/lJ96Xcr8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=islg3/uxcQzuqE6MdKMkOS0VR4tWD0OYtaAdx6MrEOtB8H19HdxmbfBmBKetbk57Az
         I5c7xohaKSvGnR3dRSMx+aRXQ+GH1Dv8tIlLZvDJK2EYvJwO1RpVqImWtncRd8IrT07K
         +9GUAyASfdhl7fyx4LnkThqUy3QEnB8vKqzUg=
Received: by 10.231.14.72 with SMTP id f8mr4289749iba.171.1285570600529; Sun,
 26 Sep 2010 23:56:40 -0700 (PDT)
Received: by 10.231.166.145 with HTTP; Sun, 26 Sep 2010 23:56:20 -0700 (PDT)
In-Reply-To: <201009262011.28211.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157307>

2010/9/26 Jakub Narebski <jnareb@gmail.com>:
> On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:
>
>> This extra text is intended to 'specify' the action. Therefore, if i=
t's
>> present, the action name in the header will be turned into a link to
>> the action itself but without specifying any parameter.
>
> What this feature is intended *for*? =A0I guess it is meant to be use=
d
> in the case where there is additional parameter that specifies action=
,
> like e.g. a single remote view, where $action is 'remotes', but there
> is extra parameter ('hash_base' is (ab)used for this) that specifies
> remote. =A0Then we want to make 'remotes' in "breadcrumbs" navigation=
 at
> top of page to link to generic 'remotes' view. =A0Isn't it?

Yes, this is exactly the intended purpose of this feature. It is of
course possible to extend other views to have a similar behavior (I'm
thinking in particular about log views here).

> But the above is just my guess, covering only case where there is bot=
h
> $action defined, and 'header_extra' option set.
>
> You need to explain this in the commit message.

I will clarify this in the next rehash of the patch.

>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>> =A0gitweb/gitweb.perl | =A0 10 +++++++++-
>> =A01 files changed, 9 insertions(+), 1 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index e70897e..76cf806 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -3514,7 +3514,15 @@ EOF
>> =A0 =A0 =A0 if (defined $project) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 print $cgi->a({-href =3D> href(action=3D=
>"summary")}, esc_html($project));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (defined $action) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print " / $action";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $action_print =3D $acti=
on ;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (defined $opts{'header_=
extra'}) {
>
> We spell optional named parameter with '-' as prefix, for example
> $opts{'-remove_signoff'} in git_print_log(), to be able to use key
> without quoting (bareword-like, autoquoting), like $opts{-nohtml}
> or $opts{-pad_before}, or $opts{-size}, or $opts{-tag}... though
> gitweb is not very consisnte here.
>
> So it should probably be
>
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (defined $opts{'-head=
er_extra'}) {
>
> or even
>
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (defined $opts{-heade=
r_extra}) {
>
>
> I also think that we can think of better name for this option than
> 'header_extra', although what this name could be eludes me.

I will add the dash to the option. Naming it header_extra keeps the
meaning of this extra text generic, but considering that the intended
use is mostly for the single-remote view (or similar, if/when they are
added) we could call it something related (I can only think of
'main_argument' right now but I think this would suck more than
header_extra).

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $action_pr=
int =3D $cgi->a({-href =3D> href(action=3D>$action)},
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 esc_html($action));
>
> I don't think we need to run esc_html on action: it is checked that i=
t
> is one of specified set of possible values, and it can be ensured tha=
t
> it neither contains anything than printable characters, not any HTML
> special characters.

Ok, I will remove it.

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print " / $action_print";
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (defined $opts{'header_extra'}) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print " / $opts{'header_ex=
tra'}";
>
> Hmmm...

You don't sound very convinced. I had some doubts myself about whether
the slash should be inserted autmatically or whether it should be up
to the caller to include it in header_extra, but I'm not sure this is
what you are perplexed about.

--=20
Giuseppe "Oblomov" Bilotta
