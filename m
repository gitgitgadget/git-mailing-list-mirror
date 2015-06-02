From: "Gondek, Andreas" <Andreas.Gondek@dwpbank.de>
Subject: AW: Getting the full path of a conflicting file within a custom
 merge driver?
Date: Tue, 2 Jun 2015 10:57:29 +0000
Message-ID: <D8780C527EB1E642B3150E6D705B46D468837AA7@DWPWHMS531.dwpbank.local>
References: <D8780C527EB1E642B3150E6D705B46D468837861@DWPWHMS531.dwpbank.local>
 <xmqqr3pv74ww.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 12:57:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzjt4-0005cF-Uc
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 12:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850AbbFBK5f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2015 06:57:35 -0400
Received: from mail2.dwpbank.de ([145.253.155.115]:27644 "EHLO
	mail2.dwpbank.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbbFBK5d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 06:57:33 -0400
X-IronPort-AV: E=Sophos;i="5.13,539,1427752800"; 
   d="scan'208";a="797491"
Received: from DWPWHMS531.dwpbank.local ([169.254.2.243]) by
 DWPFRMS530.dwpbank.local ([169.254.3.86]) with mapi id 14.03.0195.001; Tue, 2
 Jun 2015 12:57:30 +0200
Thread-Topic: Getting the full path of a conflicting file within a custom
 merge driver?
Thread-Index: AdCcgiEmcewjfbrsSCO3jW4YkOAV1wACGBAaACXhz6A=
In-Reply-To: <xmqqr3pv74ww.fsf@gitster.dls.corp.google.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.101.236.155]
x-c2processedorg: 25ee705c-9766-409d-8ffd-513701a730da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270519>

Hi,

thank you for responding this fast. I would suggest providing this info=
rmation as an additional parameter (like %A %O %B and %L) maybe %P. I t=
hink this would cost about 2 lines of code und wouldn't be any performa=
nce issue I assume. If I got it right in the source code, the informati=
on is present in the place where the parameters for the merge driver ar=
e prepared.

Greetings,

Andreas Gondek
Applications
________________________________

Deutsche WertpapierService Bank AG
ITTAS
Derendorfer Allee 2
40476 D=FCsseldorf
Tel.: +49 69 5099 9503
=46ax: +49 69 5099 85 9503
E-Mail: Andreas.Gondek@dwpbank.de
http://www.dwpbank.de

Deutsche WertpapierService Bank AG | Wildunger Stra=DFe 14 | 60487 Fran=
kfurt am Main=20
Sitz der AG: Frankfurt am Main, HRB 56913 | USt.-ID: DE 813759005=20
Vorstand: Thomas Klanten, Dr. Christian Tonnesen
Aufsichtsrat: Wilfried Groos (Vors.)

-----Urspr=FCngliche Nachricht-----
Von: Junio C Hamano [mailto:jch2355@gmail.com] Im Auftrag von Junio C H=
amano
Gesendet: Montag, 1. Juni 2015 18:46
An: Gondek, Andreas
Cc: git@vger.kernel.org
Betreff: Re: Getting the full path of a conflicting file within a custo=
m merge driver?

"Gondek, Andreas" <Andreas.Gondek@dwpbank.de> writes:

> I'm wondering if there is no option to find out the full path of a=20
> conflicting file from within a custom merge driver? If I understand=20
> this correctly, Git only provides the name of the 3 temporary local=20
> files and the size of the limiter. But is there any possibility to ge=
t=20
> the path of the file via a Git command, that I can run from within th=
e=20
> merge driver? Maybe as part of the repository's status?

Short answer is "no", as the merge driver interface was originally desi=
gned for a backend that can do its job with only the contents of the th=
ree variants without any other information.  Imagine the interface to t=
hings like "merge" from the RCS suite where it takes three variants as =
the input---for them, the same three-tuple of original, mine and theirs=
 contents should merge to identical result no matter where in the worki=
ng tree the conflicts happened.

Having said that, I do not think it is unreasonable to feed more inform=
ation to external merge driver, perhaps by adding a new environment var=
iable GIT_MERGE_CONFLICTED_PATH exported when the driver is run, or som=
ething.
