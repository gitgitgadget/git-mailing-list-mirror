From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Highlight keyboard shortcuts in git-add--interactive
Date: Thu, 29 Nov 2007 02:08:07 +0100
Message-ID: <9FA2CBB3-DD98-4349-8001-8F6B2E47F0DC@wincent.com>
References: <1195655278-19535-1-git-send-email-win@wincent.com> <7vmysx2ac8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 02:09:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxXtp-00020h-SD
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 02:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760239AbXK2BIq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 20:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754515AbXK2BIq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 20:08:46 -0500
Received: from wincent.com ([72.3.236.74]:46683 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759918AbXK2BIp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 20:08:45 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAT188KD022002;
	Wed, 28 Nov 2007 19:08:09 -0600
In-Reply-To: <7vmysx2ac8.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66487>

El 29/11/2007, a las 0:56, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> @@ -774,14 +774,14 @@ EOF
>> }
>>
>> sub main_loop {
>> -	my @cmd =3D ([ 'status', \&status_cmd, ],
>> -		   [ 'update', \&update_cmd, ],
>> -		   [ 'revert', \&revert_cmd, ],
>> -		   [ 'add untracked', \&add_untracked_cmd, ],
>> -		   [ 'patch', \&patch_update_cmd, ],
>> -		   [ 'diff', \&diff_cmd, ],
>> -		   [ 'quit', \&quit_cmd, ],
>> -		   [ 'help', \&help_cmd, ],
>> +	my @cmd =3D ([ 'status', \&status_cmd, '[s]tatus', ],
>> +		   [ 'update', \&update_cmd, '[u]date', ],
>> +		   [ 'revert', \&revert_cmd, '[r]evert', ],
>> +		   [ 'add untracked', \&add_untracked_cmd, '[a]dd untracked', ],
>> +		   [ 'patch', \&patch_update_cmd, '[p]atch', ],
>> +		   [ 'diff', \&diff_cmd, '[d]iff', ],
>> +		   [ 'quit', \&quit_cmd, '[q]uit', ],
>> +		   [ 'help', \&help_cmd, '[h]elp', ],
>> 	);
>
> I like the general idea of making it more obvious that you can use th=
e
> unique prefix, but I think you should make list_and_choose do this
> automatically without adding a redundant element in the command array=
=2E
>
> If you do so, the same highlighting will automatically appear when yo=
u
> are picking which paths to update in the update subcommand, for =20
> example.


Yes, I did consider that, and it's very easy when all the options have =
=20
a unique, single-letter prefix, as is the case with the main command =20
loop. But what to do if you've got a bunch of paths with lengthy =20
common prefixes? eg. what would you highlight here?

lib/ssl/crypto/foo.c
lib/ssl/crypto/bar.c
lib/ssl/crypto/baz.c

Highlighting "lib/ssl/crypto/f", "lib/ssl/crypto/bar" and "lib/ssl/=20
crypto/baz" doesn't sound like much help... Maybe there should be some =
=20
limit: if you need to go more than 3 characters deep in order to =20
differentiate unique prefixes then perhaps highlighting should be =20
omitted in that case. What do you think of that idea?

Cheers,
Wincent
