From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [PATCH/RFC v3 6/8] Add case insensitivity support when using
 git ls-files
Date: Mon, 04 Oct 2010 10:49:28 -0600
Message-ID: <4CAA0598.9080409@workspacewhiz.com>
References: <4CA847D5.4000903@workspacewhiz.com> <1286099806-25774-7-git-send-email-avarab@gmail.com> <201010041802.57398.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Brandon Casey <drafnel@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 18:49:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2oEW-0003QG-5w
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 18:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756604Ab0JDQtn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 12:49:43 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:39420 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab0JDQtm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 12:49:42 -0400
Received: (qmail 28009 invoked by uid 399); 4 Oct 2010 10:49:37 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.220.144.122)
  by hsmail.qwknetllc.com with ESMTPAM; 4 Oct 2010 10:49:37 -0600
X-Originating-IP: 75.220.144.122
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <201010041802.57398.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158065>

  ----- Original Message -----
=46rom: Robin Rosenberg
Date: 10/4/2010 10:02 AM
> s=F6ndagen den 3 oktober 2010 11.56.44 skrev  =C6var Arnfj=F6r=F0 Bja=
rmason:
>> From: Joshua Jensen<jjensen@workspacewhiz.com>
>>
>> When mydir/filea.txt is added, mydir/ is renamed to MyDir/, and
>> MyDir/fileb.txt is added, running git ls-files mydir only shows
>> mydir/filea.txt. Running git ls-files MyDir shows MyDir/fileb.txt.
>> Running git ls-files mYdIR shows nothing.
>>
>> With this patch running git ls-files for mydir, MyDir, and mYdIR sho=
ws
>> mydir/filea.txt and MyDir/fileb.txt.
>> ---
>>   dir.c |   38 ++++++++++++++++++++++++++------------
>>   1 files changed, 26 insertions(+), 12 deletions(-)
>>
>> diff --git a/dir.c b/dir.c
>> index cf8f65c..53aa4f3 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -107,16 +107,30 @@ static int match_one(const char *match, const =
char
>> +	if (ignore_case) {
>> +		for (;;) {
>> +			unsigned char c1 =3D tolower(*match);
>> +			unsigned char c2 =3D tolower(*name);
> Is anyone thinking "unicode" around here?
On Windows, Unicode filenames are 16-bit wide characters.  The current=20
code doesn't handle them at all.

I do not know about other file systems and what Git actually handles.  =
I=20
was under the impression it didn't handle Unicode filenames well in=20
general... ?

Josh
