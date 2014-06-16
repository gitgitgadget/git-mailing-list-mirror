From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] doc git: multivar configuration parameters append to existing values
Date: Mon, 16 Jun 2014 20:38:56 +0100
Organization: OPDS
Message-ID: <708AD97F308249A1B61D9348AFE59182@PhilipOakley>
References: <1402922952-172-1-git-send-email-philipoakley@iee.org> <xmqqd2e8r8yz.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "GitList" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	"Robert Clausecker" <fuz@fuz.su>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Tanay Abhra" <tanayabh@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 21:39:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwckD-0004AX-24
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 21:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759AbaFPTjA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jun 2014 15:39:00 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:14139 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753256AbaFPTi7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2014 15:38:59 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkQZAHASn1NZ8Y0l/2dsb2JhbABagw1SiQG6cgEBAgEBgREXdYN+BQEBBAEIAQEoAQUeAQEhBQYCAwUCAQMVDCUUAQQaBgcXBhMIAgECAwGIKQwJuCOXFo4SZIM0gRYEigWGWosnkhWDQTwvAQGBAA
X-IPAS-Result: AkQZAHASn1NZ8Y0l/2dsb2JhbABagw1SiQG6cgEBAgEBgREXdYN+BQEBBAEIAQEoAQUeAQEhBQYCAwUCAQMVDCUUAQQaBgcXBhMIAgECAwGIKQwJuCOXFo4SZIM0gRYEigWGWosnkhWDQTwvAQGBAA
X-IronPort-AV: E=Sophos;i="5.01,489,1400022000"; 
   d="scan'208";a="462759942"
Received: from host-89-241-141-37.as13285.net (HELO PhilipOakley) ([89.241.141.37])
  by out1.ip04ir2.opaltelecom.net with SMTP; 16 Jun 2014 20:38:54 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251806>

=46rom: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> When the '-c' option is used to pass alternate URLs or similar
>> multivar parameters to git commands the effect is not what the user
>> expected [1,2].
>>
>> Clarify that multivar configuration parameters do not supercede
>> previous values. Suggest an alternative style parameter.
>>
>> [1] http://article.gmane.org/gmane.comp.version-control.git/250427
>> [2] http://article.gmane.org/gmane.comp.version-control.git/251529
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>  Documentation/git.txt | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git.txt b/Documentation/git.txt
>> index 3bd68b0..bedbd76 100644
>> --- a/Documentation/git.txt
>> +++ b/Documentation/git.txt
>> @@ -440,7 +440,10 @@ example the following invocations are=20
>> equivalent:
>>
>>  -c <name>=3D<value>::
>>  Pass a configuration parameter to the command. The value
>> - given will override values from configuration files.
>> + given will override single valued variables from configuration
>> + files, and append to multivar variables. Previous multivar values
>> + remain in effect. Use "insteadOf" style config variables when an
>> + over-ride is needed.
>>  The <name> is expected in the same format as listed by
>>  'git config' (subkeys separated by dots).
>
> I have two doubts, while appreciating the overall direction to
> clarify things very much.
>
> * "single overrides, multiple appends" is not a wrong explanation
>   per-se, but sounds like an arbitrary rule that forces people to
>   memorize.
At the time it felt like the most compact method of informing the=20
reader.

>                  I wonder if it makes it less burdensome for readers=20
> if
>   we just said "Git acts as if the given configuration is specified
>   at the very end of the configuration files"
I'd started with something like that..

>                                                                   ---=
once=20
> the reader
>   understands that Git reads all configuration varilables of the
>   same name and the code paths that *use* one of them pick the one
>   defined the last,
It's this step that's a concern. We shouldn't be forcing the reader to=20
implicitly grok that, especially as we don't actually say it elsewhere=20
(in the regular documentation).

>                              it is easy to realize that "single=20
> overrides"
>   is merely a natural consequence of the appending nature of "-c".
Perhaps I should just say that [say it that way].
>
> * The last sentence added, i.e. "insteadof"-style, will not be
>   understood by any reader other than those who tried to use "-c"
>   on remote.*.url variables and does not belong here.  A better
>   way/place to give that information is needed.
I just wanted to indicate that some multivars do have get-out [override=
]=20
config parameters, though we aren't consistent about their names yet,=20
while giving a clue as to a typical name style.

It would also be good to get feedback from Robert and =C6var on whether=
=20
the text would actually be informative to them, as they took the time t=
o=20
report the original 'conceptual breakage'.

Philip=20
