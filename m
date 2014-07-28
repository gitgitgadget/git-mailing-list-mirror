From: David Braden <David.Braden@softwire.com>
Subject: =?Windows-1252?Q?git-svn_authors_file_and_SVN_users_with_=91=3D=92_in_the?=
 =?Windows-1252?Q?_username?=
Date: Mon, 28 Jul 2014 11:33:23 +0000
Message-ID: <dc3fda62c3e94eba9d29fd4b34f2e7cc@EXCHLONDON2013.zoo.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 13:33:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBjBR-0007lo-1e
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 13:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbaG1Ldd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 07:33:33 -0400
Received: from eu-smtp-delivery-179.mimecast.com ([207.82.80.179]:31005 "EHLO
	eu-smtp-delivery-179.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751940AbaG1Ldc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 07:33:32 -0400
Received: from smtp.softwire.com (31.221.86.188 [31.221.86.188]) (Using TLS)
 by uk-mta-10.uk.mimecast.lan; Mon, 28 Jul 2014 12:33:30 +0100
Received: from EXCHLONDON2013.zoo.lan (10.210.10.43) by EXCHLONDON2013.zoo.lan
 (10.210.10.43) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 28 Jul
 2014 12:33:29 +0100
Received: from EXCHLONDON2013.zoo.lan ([10.210.10.43]) by
 EXCHLONDON2013.zoo.lan ([10.210.10.43]) with mapi id 15.00.0847.030; Mon, 28
 Jul 2014 12:33:23 +0100
Thread-Topic: =?Windows-1252?Q?git-svn_authors_file_and_SVN_users_with_=91=3D=92_in_the?=
 =?Windows-1252?Q?_username?=
Thread-Index: Ac+qT4BAEiiNLVa0Q+6wF2/MtvAhegACC38g
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.210.11.235]
X-MC-Unique: PTVj1jovRxaKsKyBC0qkqQ-1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254312>

I=92m creating a git clone of a svn repository and am trying to set up =
an authors file to map between the svn users and our git usernames. The=
 svn repository uses the full subject line of a ssl certificate for the=
 user id and so it contains =91=3D=92 which causes the authors file to =
be parsed incorrectly as it splits on the first equals.

The code that does the parsing is:

# '<svn username> =3D real-name <email address>' mapping based on git-s=
vnimport:
sub load_authors {
                open my $authors, '<', $_authors or die "Can't open $_a=
uthors $!\n";
                my $log =3D $cmd eq 'log';
                while (<$authors>) {
                                chomp;
                                next unless /^(.+?|\(no author\))\s*=3D=
\s*(.+?)\s*<(.+)>\s*$/;
                                my ($user, $name, $email) =3D ($1, $2, =
$3);
                                if ($log) {
                                                $Git::SVN::Log::rusers{=
"$name <$email>"} =3D $user;
                                } else {
                                                $users{$user} =3D [$nam=
e, $email];
                                }
                }
                close $authors or croak $!;
}


How can I work around this limitation?

Thanks

David
David Braden
Tel : 020 7485 7500 ext 3199 | Fax : 020 7485 7575

softwire
Sunday Times Best Small Companies - UK top 25 four years running
Web : www.softwire.com<http://www.softwire.com/> | Addr : 325 Highgate =
Studios, 53-79 Highgate Road, London NW5 1TL
Softwire Technology Limited. Registered in England no. 3824658. Registe=
red Office : 13 Station Road, London N3 2SB
