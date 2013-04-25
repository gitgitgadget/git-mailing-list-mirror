From: l.stelmach@samsung.com (=?utf-8?Q?=C5=81ukasz?= Stelmach)
Subject: Re: [PATCH] send-email: support NNTP
Date: Thu, 25 Apr 2013 08:56:26 +0200
Message-ID: <87sj2fhzdx.fsf@samsung.com>
References: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
	<7vobd5l277.fsf@alter.siamese.dyndns.org> <87txmw75bb.fsf@samsung.com>
	<7vip3bgax9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 08:56:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVG6j-0006ZI-Sq
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 08:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547Ab3DYG4g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 02:56:36 -0400
Received: from plane.gmane.org ([80.91.229.3]:35735 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046Ab3DYG4f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 02:56:35 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UVG6b-0006Sf-LV
	for git@vger.kernel.org; Thu, 25 Apr 2013 08:56:33 +0200
Received: from 217-67-201-162.itsa.net.pl ([217.67.201.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 08:56:33 +0200
Received: from l.stelmach by 217-67-201-162.itsa.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 08:56:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 217-67-201-162.itsa.net.pl
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Cancel-Lock: sha1:xRBJvL4dFoS7tuVkYH19GkTRumM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222348>

It was <2013-04-24 =C5=9Bro 18:17>, when Junio C Hamano wrote:
> l.stelmach@samsung.com (=C5=81ukasz Stelmach) writes:
>
>> It was <2013-04-23 wto 17:02>, when Junio C Hamano wrote:
>>> =C5=81ukasz Stelmach <l.stelmach@samsung.com> writes:
>>>
>>>> Enable sending patches to NNTP servers (Usenet, Gmane).
>>>> ---
>>>>
>>>> The patch implements support for sending messages to groups on NNT=
P
>>>> serviers.
>>>
>>> Cute.
>>>
>>> A Perl guru might want to encapsulate the differences between $smtp
>>> and $nntp codepaths into two Perl modules, but it looks like a good
>>> starting point.
>>
>> You mean *one* perl module like Git::EmailTransport which hides the
>> differences.
>
> What I meant was one class to handle SMTP and another for NNTP.
>
> You look at the --protocol option, choose one of these classes, and
> initialize an instance of the chosen class.
>
> You can ask the chosen class to instantiate an instance without
> if/else cascade like this:
>
> +
> +# Transport specific setup
> +my ($email_authuser, $email_authpass);
> +if ($email_protocol eq 'nntp') {
> +    $email_authuser =3D $nntp_authuser;
> +    $email_authuser =3D $nntp_authuser;
> +    @initial_to =3D @initial_cc =3D @bcclist =3D ();
> +    $to_cmd =3D $cc_cmd =3D undef;
> +    $no_cc =3D $no_bcc =3D 1;
> +} else {
> +    $email_authuser =3D $smtp_authuser;
> +    $email_authpass =3D $smtp_authpass;
> +    $newsgroups_cmd =3D undef;
> +}
> +

[...]

OK, I see. Good point. Where would you recommend me to put these module=
s
and how to name them? I mean I don't want to make to much mess here (;

--=20
=C5=81ukasz Stelmach
Software wizzard
Samsung Poland R&D Center
