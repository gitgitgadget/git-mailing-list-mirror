From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update gitweb.perl to current CGI.pm API
Date: Thu, 16 Oct 2014 13:18:45 -0700
Message-ID: <xmqq1tq7u5sq.fsf@gitster.dls.corp.google.com>
References: <87lhogzeq0.fsf@placard.fr.eu.org>
	<xmqqa94vu7qh.fsf@gitster.dls.corp.google.com>
	<CANQwDwdm6aMVC7U+nbbtS=J8M2fYOk_MECt_1=NX=pXdt06YjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
	Roland Mas <lolando@debian.org>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 22:18:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XerVe-0000qY-1Z
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 22:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbaJPUSu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Oct 2014 16:18:50 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751637AbaJPUSs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Oct 2014 16:18:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C8D516517;
	Thu, 16 Oct 2014 16:18:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=px8qaZuiVIot
	RDiRMkMEvzqZ+1E=; b=LCHSsO6kay3/oCJweNsP8VJ2ET79i57/I5Ljpjgoe8ZW
	kIM70r4mSv28OhOdOvqIBu4qd7MDeVyBngajEXNqg4TsQuPBi7lfvKuVQ96LSnpT
	IV90Ycc0PZqXTkBIaxUV9aV9lJayh6K+DjSyv30bDRo8dQ8UVTiVbrNMWwSoxAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KKlmul
	xUEWHQOSnqFssn86H89RWg8jHdHBdiFeGHOFYaipfPTmyi9iKaCcnoyYN6eyj4dp
	3ZkrsWQAjd3ftUQy3cZ7K7EfebUlmpibdArrZxLoxqiMg2h/zrLJzkLOwfAU4kaC
	oMFyiL30d9dgsMWHzH99hvij9QXEHo/inqOiE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 315F216516;
	Thu, 16 Oct 2014 16:18:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC0EA16514;
	Thu, 16 Oct 2014 16:18:46 -0400 (EDT)
In-Reply-To: <CANQwDwdm6aMVC7U+nbbtS=J8M2fYOk_MECt_1=NX=pXdt06YjQ@mail.gmail.com>
	("Jakub =?utf-8?Q?Nar=C4=99bski=22's?= message of "Thu, 16 Oct 2014
 22:02:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A21877EE-5571-11E4-9E99-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> On Thu, Oct 16, 2014 at 9:36 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>
>> Looks sensible to me; Jakub, ack?
>>
>
> Ack.
>
> Nb. this code follows back to original gitweb.cgi by Kay Sievers, ver=
y
> early in the development (2005)

Thanks.  I realize that Ack sounds as if "Yeah, I acknowledge and
admit I was in the wrong earlier", but I didn't mean "I think this
is your bug---do you think it is a good fix?"  I just meant the
latter half of that sentence.

Here is what I'll queue (note: I've retitled so that an entry in
"git shortlog" would mean something).

Thanks, both.

-- >8 --
=46rom: Roland Mas <lolando@debian.org>
Subject: [PATCH] gitweb: use start_form, not startform that was removed=
 in CGI.pm 4.04

CGI.pm 4.04 removed the startform method, which had previously been
deprecated in favour of start_form.  Changes file for CGI.pm says:

    4.04 2014-09-04
     [ REMOVED / DEPRECATIONS ]
	- startform and endform methods removed (previously deprecated,
	  you should be using the start_form and end_form methods)

Signed-off-by: Roland Mas <lolando@debian.org>
Reviewed-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gitweb/gitweb.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a9f57d6..ccf7516 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4100,7 +4100,7 @@ sub print_search_form {
 	if ($use_pathinfo) {
 		$action .=3D "/".esc_url($project);
 	}
-	print $cgi->startform(-method =3D> "get", -action =3D> $action) .
+	print $cgi->start_form(-method =3D> "get", -action =3D> $action) .
 	      "<div class=3D\"search\">\n" .
 	      (!$use_pathinfo &&
 	      $cgi->input({-name=3D>"p", -value=3D>$project, -type=3D>"hidden=
"}) . "\n") .
@@ -5510,7 +5510,7 @@ sub git_project_search_form {
 	}
=20
 	print "<div class=3D\"projsearch\">\n";
-	print $cgi->startform(-method =3D> 'get', -action =3D> $my_uri) .
+	print $cgi->start_form(-method =3D> 'get', -action =3D> $my_uri) .
 	      $cgi->hidden(-name =3D> 'a', -value =3D> 'project_list')  . "\n=
";
 	print $cgi->hidden(-name =3D> 'pf', -value =3D> $project_filter). "\n=
"
 		if (defined $project_filter);
--=20
2.1.2-561-gc401a55
