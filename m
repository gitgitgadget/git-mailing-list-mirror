From: roucherj <roucherj@telesun.imag.fr>
Subject: Re: [PATCH/RFC] add git credential login to remote mediawiki
Date: Tue, 12 Jun 2012 17:10:05 +0200
Message-ID: <303c1249341d6f305d315b0a8d9cd20c@telesun.imag.fr>
References: <1339512125-32761-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
 <vpq8vfsoa6x.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <Javier.Roucher-Iglesias@ensimag.imag.fr>, <git@vger.kernel.org>,
	Javier Roucher <jroucher@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 12 17:10:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeSjZ-0006bb-RU
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 17:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab2FLPKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 11:10:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59954 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517Ab2FLPKK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 11:10:10 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5CF19JJ003763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2012 17:01:09 +0200
Received: from web-ensimag.imag.fr (web-ensimag [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5CFA6Od029669;
	Tue, 12 Jun 2012 17:10:06 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id q5CFA6vZ023431;
	Tue, 12 Jun 2012 17:10:06 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id q5CFA5MP023428;
	Tue, 12 Jun 2012 17:10:05 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to roucherj@telesun.imag.fr using -f
In-Reply-To: <vpq8vfsoa6x.fsf@bauges.imag.fr>
X-Sender: roucherj@telesun.imag.fr
User-Agent: Roundcube Webmail/0.5.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Jun 2012 17:01:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5CF19JJ003763
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: roucherj@telesun.imag.fr
MailScanner-NULL-Check: 1340118071.507@N5kG9Dqs1wOKznzHsVNSbQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199800>

On Tue, 12 Jun 2012 16:51:18 +0200, Matthieu Moy wrote:
> Javier.Roucher-Iglesias@ensimag.imag.fr writes:
>
>>  # MediaWiki API instance, created lazily.
>> +sub run_credential {
>
> How is the code related to the comment right above?
>

Sorry a old comment, i think it's a cause of git rebase i will erase.

>> +	my $Prog = "git credential $op";
>> +	open2 (*Reader, *Writer, $Prog);
>> +	print Writer $msg;
>> +	close (Writer);
>
> No space before "(" for function calls (already mentionned twice).
>

sorry but before it's like:
+	my $Prog = "git credential $op";
+	open2(*Reader, *Writer, $Prog);
+	print Writer $msg;
+	close(Writer);

i have add one space, but the have to be like that?:
+	my $Prog = "git credential $op";
+	open2 ( *Reader, *Writer, $Prog );
+	print Writer $msg;
+	close ( Writer );

>>  my $mediawiki;
>
> Didn't I already mention (twice?) that this declaration was meant to
> stay right above mw_connect_maybe?
>

yes but 'ask_credential' used $mediawiki then i think i have to declare 
before 'ask_credential'

>> +			run_credential("reject");
>> +#			exit 1;
>
> Do you, or do you not want to "exit 1". Either remove this, or 
> uncomment
> it.
>

i have comment this line to see the opinion of the community, because i 
ask all the time to authenticate
but there are few operations who we don't have to authenticate it.

now if we comment this line the login will fail but they will continue 
with the operation (like, git clone)
and try to do it, if the wiki need to be authenticate will refuse the 
operation if not they will continue.

>>  sub mw_connect_maybe {
>> +
>>  	if ($mediawiki) {
>
> Why do you add this blank line? (already mentionned)
>

because we need the structure $mediawiki to get the url if is not 
declare it will return with out doing the operation

>> -	if ($wiki_login) {
>> -		if (!$mediawiki->login({
>> -			lgname => $wiki_login,
>> -			lgpassword => $wiki_passwd,
>> -			lgdomain => $wiki_domain,
>> -		})) {
>> -			print STDERR "Failed to log in mediawiki user \"$wiki_login\" on 
>> $url\n";
>> -			print STDERR "(error " .
>> -			    $mediawiki->{error}->{code} . ': ' .
>> -			    $mediawiki->{error}->{details} . ")\n";
>> -			exit 1;
>> -		} else {
>> -			print STDERR "Logged in with user \"$wiki_login\".\n";
>> -		}
>> -	}
>> +	ask_credential();
>
> This means you can't use the wiki anonymously anymore. This is an
> unacceptable regression.

yes you can use anonymously but login will fail and try to the 
operation, this is the reason because i have comment the 'exit 1'.
